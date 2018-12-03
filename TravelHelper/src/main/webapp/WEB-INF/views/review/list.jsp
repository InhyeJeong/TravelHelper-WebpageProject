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
<title>REVIEW List</title>
</head>
<body>


<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
<iot:page-animate-header  title=" TOUR REVIEW"/>

	<div>
		<div class="float-left">
			<form action="list">
				ORDER BY
				<select name="orderBy">
					<option value="review_id"
						<c:if test="${orderBy=='review_id'}">selected</c:if>
					> Date </option>
					<option value="read_cnt"
						<c:if test="${orderBy=='read_cnt'}">selected</c:if>
					> Views </option>
				</select>
				<button type="submit"
					class="btn btn-unique btn-sm"
				><i class="fas fa-share-square"></i></button>
			</form>
		</div>
	
		<div class="float-right">
			<a href="create"><i class="fas fa-plus"></i> Plus</a>
			/ Total : ${pagination.total}
		</div>
	</div>
		


	<table class="table table-striped ">
		<thead>
			<tr>
				<th> No </th>
				<th> Title </th>
				<th> Owner </th>
				<th> Review Num </th>
				<th><a href="?orderBy=reg_date"> Date </a></th>
				<th><a href="?orderBy=read_cnt"> Total Views </a></th>	
		</thead>
		<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
				<fmt:formatDate var="regDate" value="${item.regDate }"
								pattern="yyyy-MM-dd"/>
				<tr>
					<td>${item.reviewId}</td>
					<td>
						<a href="view/${item.reviewId}?page=${pagination.page}">
							${item.title}
						</a>
						<c:if test="${today==regDate}">
							<span class="badge badge-pill badge-danger">
								<i class="fas fa-tag"></i> New</span>
						</c:if>
						<c:if test="${not empty item.list[0]}">
							<img src="thumb/${item.list[0].imageId}" width="30">
						</c:if>
					
					</td>
					<td>${item.owner}</td>
					<td>
						
					
						${item.list[0].imageId}/
						${item.list.size()}</td>
					<td>${regDate}</td>
					<td>${item.readCnt}</td>
			
			</c:forEach>
		</tbody>
	</table>
	
	
	<jsp:include page="/WEB-INF/views/common/pagination2.jsp"/>

</body>
</html>


