<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>
<link rel="stylesheet" href="${context}/resources/css/main.css"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CREATE</title>

<script src="${context}/resources/bower_components/tinymce/tinymce.min.js"></script>

<script>
	$(function(){
		tinymce.init({
			selector:'textarea',
			height : "300"
		});
	})
</script>
</head>
<body>

	<h2 class="mt-5 mb-4"> POSTING </h2>
	
	<form:form commandName="plan" enctype="multipart/form-data">
		<input type="hidden" name="writer" value="${USER.userId}"/>
		<div class="md-form">
			<label> Title</label>
			<form:input path="title" class="form-control"/>
			<form:errors path="title"/>
		</div>
		
		<div class="mb-3">
			<label>WRITER : ${USER.userId}</label>
		</div>
		<div class="md-form">
			<label>PW</label>
			<form:password path="password" class="form-control"/>
			<form:errors path="password"/>
		</div>
		
		<div>
			<label> FILE </label>
			<input type="file" name="files" multiple="multiple">
		</div>
		
		<form:textarea path="content"/>
		
		<div class="text-center mt-3">
			<button type="submit" class="btn btn-unique btn-md">
				<i class="fas fa-check mr-2"></i> CHECH</button>
			<a href="list" class="btn btn-unique btn-md">
				<i class="fas fa-undo mr-2"></i> BACK</a>

		</div>
		
	</form:form>

</body>
</html>


