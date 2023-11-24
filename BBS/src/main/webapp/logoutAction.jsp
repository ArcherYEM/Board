<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그아웃 하였습니다')");
		script.println("history.href = 'main.jsp'");
		script.println("</script>");
		session.invalidate(); // 세션을 빼앗음
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>