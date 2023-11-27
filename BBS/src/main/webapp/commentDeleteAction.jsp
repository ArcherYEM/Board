<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

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
	}

	int commentNo = 0;
	if (request.getParameter("commentNo") != null) {
		commentNo = Integer.parseInt(request.getParameter("commentNo"));
	} else {
		commentNo = -1;
	}

	if (commentNo == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 댓글 입니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		CommentDAO commentDAO = new CommentDAO();
		Comment comment = commentDAO.getComment(commentNo);

		if (comment == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 댓글이 존재하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (!userID.equals(comment.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			// 이후의 로직 계속 진행
			int result = commentDAO.deleteComment(commentNo);
			if (-1 == result) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 삭제 실패')");
		script.println("history.back()");
		script.println("</script>");
			} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글이 정상적으로 삭제되었습니다')");
		script.println("history.back()");
		script.println("</script>");
			}
		}
	}
	%>
</body>
</html>
