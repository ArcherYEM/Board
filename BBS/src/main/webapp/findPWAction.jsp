<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
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

	String userPassword = null;
	if (session.getAttribute("userPassword") != null) {
		userPassword = (String) session.getAttribute("userPassword");
	}

	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		String findedPW = userDAO.findPW(user.getUserID(), user.getUserName(), user.getUserEmail());
		if (findedPW != null) {
			session.setAttribute("userPassword", findedPW);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('PW : " + findedPW + "   ※ 메모해두세요 ※')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다. (관리자문의)')");
			script.println("history.back()");
			System.out.println("findedID : " + findedPW);
			script.println("</script>");
		}
	}
	%>

</body>
</html>
