<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
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
	if (session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	
	String userName = null;
    if (userID != null) {
        UserDAO userDAO = new UserDAO();
        userName = userDAO.name(userID);
    }
%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp" style="font-size:25px;">
            	Dev.YEM
        	</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a class="active" href="main.jsp">HOME</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			if (userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%	
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><%= (userName != null) ? userName + " 님" : "MyPage" %><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a onclick="return confirm('로그아웃 하시겠습니까?')" href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%	
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="continer">
				<h1>웹 사이트 소개</h1>
				<p>이 사이트는 부트스트랩을 이용하여 제작하였습니다.<br/>
				최종적인 커스터마이징은 Dev.Yem 이 완료하였습니다.</p>
				<p><a class="btn btn-primary btn-pull" href="https://github.com/ArcherYEM" target="_blank" role="button">Dev.Yem Git-Hub</a></p>
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner" >
				<div class="item active">
					<img src="images/html_css.jpg">
				</div>
				<div class="item">
					<img src="images/js.jpg">
				</div>
				<div class="item">
					<img src="images/jquery.jpg">
				</div>
				<div class="item">
					<img src="images/java.jpg">
				</div>
				<div class="item">
					<img src="images/mysql.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>