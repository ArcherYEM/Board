<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
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
		if (bbs.getBbsTitle() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력 해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else if(bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력 해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if (-1 == result) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 실패')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('작성하신 글이 등록되었습니다')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>