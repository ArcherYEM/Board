<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

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
	} 
	
	int bbsID = 0;
	if (request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	if (bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 게시글 입니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	} else {
		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsTitle").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력 해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else if(request.getParameter("bbsContent") == null || request.getParameter("bbsContent").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력 해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
			if (-1 == result) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정 실패')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정상적으로 수정되었습니다')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>