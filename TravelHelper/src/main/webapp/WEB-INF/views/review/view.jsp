<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="context" value="${pageContext.request.contextPath}"
	scope="request" />



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REVIEW : IMAGE FILE LIST</title>

<link rel="stylesheet" href="${context}/resources/css/main.css" />
<script src="${context}/resources/js/reply.js"></script>
<script>
	//전역 변수
	var context = '${context}'; // 자바스크립트에서 사용할 컨텍스트 경로명
	var user = '${USER.userId}'; // 현재 사용자 ID
	$(function(){
	// 기존 코드 아래 추가하기
		
		$('#reply-form').replyForm($('#reply-list'));
		$('#reply-list').replyList(${review.reviewId});
	});
</script>



</head>
<body>
	<h1 class="my-5 text-center" style="color: black; font-style: italic;">
		<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
		<iot:page-animate-header title=" ${review.title}" />
	</h1>
	<hr>
	<p style="font-style: italic; color: gray;">
		<i class="fas fa-pencil-alt"></i> <br> ${review.description} <br>

	</p>
	<hr>
	<h1 style="font-style: italic; color: gray;">
		<i class="fas fa-list-ul"></i> IMAGE FILE LIST
	</h1>
	<br>

	<!--원본이미지
			../ : pathvariable이포함된 url에서 경로지정할때는 주의! or 절대경로로 구성  -->
	<%-- <img src="../image/${image.imageId}" alt="${image.fileName}"> --%>
	<!-- src="../thumb/${image.imageId}" -->

	<!-- MDB부트스트랩4 carousel -->

	<div id="carousel-example-2" class="carousel slide carousel-fade"
		data-ride="carousel">

		<!-- Indicators -->
		<ol class="carousel-indicators">
			<c:forEach var="image" items="${review.list}" varStatus="status">
				<li data-target="#carousel-example-2" data-slide-to="${staus.index}"
					<c:if test="${status.first}">class="active"</c:if>></li>
			</c:forEach>
		</ol>

		<!-- The slideshow -->
		<div class="carousel-inner" role="lightbox">
			<c:forEach var="image" items="${review.list}" varStatus="status">
				<div
					class="carousel-item <c:if test="${status.first}">active</c:if>">
					<!-- 썸네일 이미지 -->
					<div class="view">
						<img class=" w-100" src="../image/${image.imageId}"
							alt="${image.fileName} / ${image.title }">
						<div class="mask rgba-black-light"></div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- Left and right controls -->
		<a class="carousel-control-prev" href="#carousel-example-2"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span>
		</a> <a class="carousel-control-next" href="#carousel-example-2"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span>
		</a>

	</div>


	<br>
	<!-- 이미지 다운로드를 위한 추가 -->



	<c:forEach var="image" items="${review.list}" varStatus="status">
		<a style="color: pink;" href="../download/${image.imageId}"> <i
			class="fas fa-download" style="color: pink;"></i> Download Image
			${image.fileName}
		</a>
		<br>
	</c:forEach>

	<!-- 댓글쓰기 영역 : 로그인 사용자만 활성화 -->
	<%-- <c:if test="${not empty USER}">
		<jsp:include page="reply-form.jsp" />
	</c:if>

	<div id="reply-list" class="mt-5">
		<jsp:include page="reply-list.jsp" />
	</div> --%>



</body>
</html>


