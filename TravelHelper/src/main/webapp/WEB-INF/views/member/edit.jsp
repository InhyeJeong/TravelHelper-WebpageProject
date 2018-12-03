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
<title>EDIT AVATA</title>
</head>
<body>

<div class="container">
	<form:form commandName="member" enctype="multipart/form-data">
		<form:hidden path="userId"/>
		<form:hidden path="name"/>
		<div>
			<label class="edit_avata"> USER ID</label>
			<p><img src="avata/${USER.userId}"
				class="rounded-circle avata-sm">
				${member.userId}</p>
		</div>
		
		<div>
			<label for="name" class="edit_avata"> NAME</label>
			<p>${member.name}</p>
		</div>
		
		<div>
			<label class="edit_avata">AVATA</label>
			<p><input type="file" name="avata"/></p>
		</div>
		
		<div>
			<label for="userLevel" class="edit_avata"> USER LEVEL</label>
			<p>${member.userLevel}</p>
		</div>
		
		<div class="md-form">
			<label for="nickName" class="edit_avata"> Nickname</label>
			<form:input path="nickName" class="form-control"/>
		</div>
		
		<div class="md-form">
			<label for="PhoneNumber" class="edit_avata"> Phone Number</label>
			<form:input path="phoneNumber" class="form-control"/>
		</div>
		
		<div class="md-form">
			<label for="email" class="edit_avata"> Email</label>
			<form:input path="email" class="form-control"/>
		</div>
		
		<div class="md-form">
			<label for="address" class="edit_avata"> Address</label>
			<form:input path="address" class="form-control"/>
		</div>
		
		<div class="md-form">
			<label for="password" class="edit_avata"> PW</label>
			<form:password path="password" class="form-control"/>
			<form:errors path="password" element="div" cssClass="error"/>
		</div>
		
		<div class="row mt-3">
			<div class="col-md-2"></div>
			<div class="col-md-10">
				<button type="submit" class="btn btn-unique"> CHECK</button>
				<a href="view" class="btn btn-unique"> BACK</a>
			</div>
		
		</div>
	</form:form>
</div>

</body>
</html>


