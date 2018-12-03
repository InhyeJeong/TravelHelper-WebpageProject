<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>
<link rel="stylesheet" href="${context}/resources/css/main.css"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UPDATE REVIEW</title>
</head>
<body>
	<div class="row">
		<div class="col-md-8 offset-md-2">
			<h1 class="my-5" style="font-style:italic; color: gray;">
				<i class="fas fa-plus"></i> EDIT REVIEW
			</h1>
			
			<form:form commandName="review">
			
				<!-- 방법 1: id도 hidden처리 -->
				<form:hidden path="reviewId"/>
				<form:hidden path="owner"/>
				
			<!-- 방법2: login한 사용자만 submit할 수 있도록 hidden으로 처리 -->
		<%-- <input type="hidden" name="owner" value="${gallery.owner}"> --%>
		
				<div class="md-form">
					<label for="title"> Title</label>
					<form:input path="title" class="form-control"/>
					<form:errors path="title" element="div" cssClass="errer"/>
				</div>
				
				<div class="md-form">
					<label for="description"> Description</label>
					<form:textarea path="description" class="form-control" rows="4" />
				</div>
				
				<p>
					<button type="submit" class="btn btn-unique">
						<i class="fas fa-check"></i> Check
					</button>
					<button type="submit" class="btn btn-unique">
						<i class="fas fa-undo"></i> Cancel
					</button>
				</p>
			</form:form>
			<br><br>
			
			<!-- 파일 업로드 FORM 구성 : Binary data처리 (form태그 라이브러리 이후에 구성, 일반 form으로 구성) -->
			<!-- http는 문자열만 가능, 문자열로 변환처리는 알아서 해줌, 우리는 아래의 사진 파일 제출 폼 구성 -->
				<h3 style="font-style: italic; color:gray;">
					<i class="fas fa-images"></i> IMAGE FILE UPLOAD
				</h3>
				
				<!--enctype:인코딩타입 (a=b&c=d&...) -->
				<form action="add_images" method="post"
					enctype="multipart/form-data">
					<!-- galleryId를 hidden으로 넘기기 -->
					<input type="hidden" name="reviewId" value="${review.reviewId}">
					
					<div class="md-form">
						<label> TITLE</label>
						<input type="text" name="title" class="form-control">
					</div>
					
					<div class="md-form">
						<label> Source</label>
						<input type="text" name="source" class="form-control">
					</div>
					
					<!-- 다중 파일 업로드 -->
					<input type="file" name="files"
					multiple="multiple" accept="image/*" required>
					
					<p>
						<button type="submit" class="btn btn-unique">
							<i class="fas fa-check"></i> CHECK
						</button>
						<button type="reset" class="btn btn-unique">
							<i class="fas fa-check"></i> CANCEL
						</button>
					</p>
					
					<br>
					
					<!-- 이미지 파일 목록 보여주기 -->
					<h4 class="my-5" style="font-style:italic; color: gray;">
						<i class="fas fa-list-ol"></i> IMAGE FILE LIST
					</h4>
					<ul>
						<c:forEach var="image" items="${review.list}">
							<li>${image.fileName}(${image.imageId})</li>
						</c:forEach>
					</ul>
					
				</form>
	
		</div>
	</div>
</body>
</html>


