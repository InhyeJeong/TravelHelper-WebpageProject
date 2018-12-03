<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>


<!DOCTYPE html>
<html>

<head>

	<link rel="stylesheet" href="${context}/resources/css/main.css"/>
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo&amp;subset=korean" rel="stylesheet">
	
<style type="text/css">
* {
font-family: 'Nanum Myeongjo', serif;
}
</style>

<meta charset="UTF-8">
<title>TravelHelper-Main</title>


	<!-- 경로설정 !!!! -->

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<!-- Bootstrap core CSS -->
	<link href="${context}/resources/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="${context}/resources/bower_components/MDBootstrap/css/mdb.min.css" rel="stylesheet">
	
	<!-- Your custom styles (optional) -->
	<link href="${context}/resources/css/main.css" rel="stylesheet">
	
	<!-- JQuery -->
	<script type="text/javascript" src="${context}/resources/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="${context}/resources/bower_components/popper.js/dist/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="${context}/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	
	
</head>
<body>



								<!--★★★기본골격★★★  -->

<!--★Main Navigation★-->
<header>
	
	<tiles:insertAttribute name="menu"/>
	
</header>
<!--Main Navigation-->
	
	
	
<!--★Main layout★-->
<main>
	<div class="container">
		<tiles:insertAttribute name="body"/>
	</div>
</main>
<!--Main layout-->
	
	
	
<!--★Footer★-->
<footer class="page-footer text-center text-md-left font-small pt-4 mt-4" style="background-color: rgba(62, 69, 81, 0.3) rgba-stylish-light;">
			
			<tiles:insertAttribute name="footer"/>
			
</footer>
<!--Footer-->

	</body>
<!-- MDB core JavaScript : 반드시 body태그 뒤에 위치해야함!!! -->
<script type="text/javascript" src="${context}/resources/bower_components/MDBootstrap/js/mdb.min.js"></script>
</html>


