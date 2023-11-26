<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="user.UserDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="content" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dev.Yem</title>
</head>
<body>
    <%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 하세요')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    } else {
        String bbsID = request.getParameter("bbsID"); // 게시물 ID를 요청 파라미터에서 가져옴
        if (bbsID == null || bbsID.isEmpty()) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('게시물을 선택하세요')");
            script.println("history.back()");
            script.println("</script>");
        } else if (comment.getContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 내용을 입력해주세요')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            CommentDAO commentDAO = new CommentDAO();
            int result = commentDAO.addComment(Integer.parseInt(bbsID), comment.getContent(), userID);
            if (-1 == result) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글 작성 실패')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('작성하신 댓글이 등록되었습니다')");
                script.println("location.href = 'bbs.jsp'");
                script.println("</script>");
            }
        }
    }
    %>

    <!-- 댓글 내용 출력 -->
    <%
    String commentContent = comment.getContent();
    if (commentContent == null) {
        out.println("댓글 내용이 null입니다.");
    } else {
        out.println("댓글 내용: " + commentContent);
    }
    %>
</body>
</html>
