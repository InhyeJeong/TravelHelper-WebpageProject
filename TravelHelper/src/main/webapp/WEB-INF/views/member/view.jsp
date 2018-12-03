<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>
<link rel="stylesheet" href="${context}/resources/css/main.css"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIEW</title>
</head>
<script type="text/javascript">


</script>
<body>


<div class="container">
		<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
		<iot:page-animate-header  title=" User Info"/>
		
		<div class="row">
			<div class="col-md-2"> USER ID</div>
			<div class="col-md-10">
				<img src="avata/${USER.userId}"
					class="rounded-circle avata-sm">
				${USER.userId }
			</div>
		</div>
		<div class="row">
			<div class="col-md-2"> Name</div>
			<div class="col-md-2"> ${USER.name }</div>
		</div>
		<div class="row">
			<div class="col-md-2"> level</div>
			<div class="col-md-2"> ${USER.userLevel }</div>
		</div>
		<div class="row">
			<div class="col-md-2"> Nickname</div>
			<div class="col-md-2"> ${USER.nickName }</div>
		</div>
		<div class="row">
			<div class="col-md-2"> Phone Number</div>
			<div class="col-md-2"> ${USER.phoneNumber }</div>
		</div>
		<div class="row">
			<div class="col-md-2"> Email</div>
			<div class="col-md-2"> ${USER.email }</div>
		</div>
		<div class="row">
			<div class="col-md-2"> Address</div>
			<div class="col-md-2"> ${USER.address }</div>
		</div>
		<div class="row">
			
				<div class="col-md-2"> reg Date</div>

				<div class="col-md-10"><fmt:formatDate value="${USER.regDate}" pattern="yyyy-MM-dd"/></div>
			
		</div>
		<div class="row">
			<div class="col-md-2"> update Date</div>
			
			<div class="col-md-10"><fmt:formatDate value="${USER.updateDate}" pattern="yyyy-MM-dd"/></div>
		</div>
		
		<div class="row mt-3">
			<div class="col-md-2"></div>
			<div class="col-md-10">
			<a href="edit" class="btn btn-unique btn-sm"> EDIT</a> 
			<a href="${context}" class="btn btn-unique btn-sm">BACK</a>
			</div>
		</div>
	
	</div>


</body>
</html>


