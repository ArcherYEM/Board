<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Dev.Yem</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 게시글 입니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}

	Bbs bbs = new BbsDAO().getBbs(bbsID);

	String userName = null;
	if (userID != null) {
		UserDAO userDAO = new UserDAO();
		userName = userDAO.name(userID);
	}

	User user = new UserDAO().getUser(userID);

	int commentNo = 0;
	if (request.getParameter("commentNo") != null) {
		commentNo = Integer.parseInt(request.getParameter("commentNo"));
	}

	Comment comment = new CommentDAO().getComment(commentNo);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp" style="font-size: 25px;"> Dev.YEM </a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">HOME</a></li>
				<li><a class="active" href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%=(userName != null) ? userName + " 님" : "MyPage"%><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a onclick="return confirm('로그아웃 하시겠습니까?')" href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
		+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="text-align: left;">
							<div style="min-height: 200px;">
								<%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n",
		"<br>")%>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
			if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a> <a onclick="return confirm('해당 게시글을 삭제합니다')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
			<%
			}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<br />

	<!-- 댓글 쓰기 -->
	<div class="container">
		<div class="row">
			<form method="post" action="commentAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">댓글 작성</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><textarea class="form-control" placeholder="댓글 내용" name="content" maxlength="2048" style="height: 100px; resize: none;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="등록"> <input type="hidden" name="bbsID" value="<%=bbsID%>">
			</form>
		</div>
	</div>
	<br />

	<!-- 댓글 보기 -->
	<div class="container">
		<div class="row">
			<br />
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
				</thead>
				<tbody>
					<%
					CommentDAO commentDAO = new CommentDAO();
					ArrayList<Comment> list = commentDAO.getList(bbsID);
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td colspan="1" style="text-align: left;"><%=list.get(i).getCommentNo()%></td>
						<td colspan="1" style="text-align: left;"><%=list.get(i).getUserID()%></td>
						<td colspan="1" style="text-align: right;"><%=list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13) + ":"
		+ list.get(i).getDate().substring(14, 16)%></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: left;">
							<div style="min-height: 50px;">
								<%=list.get(i).getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt")
		.replaceAll("\n", "<br>")%>
							</div>
							<div>
								<a onclick="return confirm('해당 댓글을 삭제합니다')" href="commentDeleteAction.jsp?commentNo=<%=list.get(i).getCommentNo()%>" class="btn btn-primary pull-right">삭제</a>
							</div>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<br />
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
