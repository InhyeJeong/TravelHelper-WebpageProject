<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>


<link rel="stylesheet" href="${context}/resources/css/main.css"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member List</title>
</head>
<script>
$(function() {
		$('.plus').click(function(e){
			e.preventDefault();
			var parent = $(this).parent();
			var userId = $(this).data('target');
			var pointVal = 10;
			var result = confirm("포인트를 지급할까요?");
			if(!result) return;

			var url='updatePoint';
			var params={
				userId : userId,
				pointVal : pointVal
			};
			
			$.get(url, params, function(result){
				// 결과 응답 데이터는 result로 전달됨.
				if(result == 'ok'){
					alert('포인트를 지급했습니다.');
					//추가로 해야할 일?
				}else{
					alert('지급 실패 : ' + result);
				}
			});
			
			var point = parseInt($(this).prev().text()) + 10;
			$(this).prev().text(point);
		});
		
		$('.minus').click(function(e){
			e.preventDefault();
			var parent = $(this).parent();
			var userId = $(this).data('target');
			var pointVal = -10;
			var result = confirm("포인트를 차감할까요?");
			if(!result) return;

			var url='updatePoint';
			var params={
				userId : userId,
				pointVal : pointVal
			};
			
			$.get(url, params, function(result){
				// 결과 응답 데이터는 result로 전달됨.
				if(result == 'ok'){
					alert('포인트를 차갑했습니다.');
					//추가로 해야할 일?
				}else{
					alert('차감 실패 : ' + result);
				}
			});
			
			var point = parseInt($(this).prev().prev().text()) - 10;
			$(this).prev().prev().text(point);
		});
	})
</script>
<body>
<div class="container">
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
<iot:page-animate-header  title="  Member List"/>

	<div class="my-3 text-right">
		
		[ Total : ${pagination.total} ]
	</div>
	
	<table class="table table-striped ">
		<thead>
			<tr>
				<th>No</th>
				<th>ID</th>
				<th>Name</th>
				<th>PhoneNumber</th>
				<th>Email</th>
				<th>Point</th>
				<th>Date</th>
			</tr>
		</thead>
	
		<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
				<fmt:formatDate var="regDate" value="${item.regDate}" pattern="yyyy-MM-dd"/>
				<tr>
					<td>${pagination.total - item.seq +1}</td>
					<td>
						<a href="view/${item.userId}?page=${page}">${item.userId }</a>
							<c:if test="${today==regDate}">
								<span class="badge badge-pill badge-danger">
									<i class="fas fa-tag"></i> New
								</span>
							</c:if>
					</td>
					
					<td>${item.name }</td>
					<td>${item.phoneNumber }</td>
					<td>${item.email }</td>
					<td>
						<div id = "pointVal">${item.point }</div> 
						<a href="#" data-target="${item.userId}"
								class="plus"> 
							<i class="fa fa-plus"></i>
						</a>

						<a href="#" data-target="${item.userId}"
								class="minus"> 
							<i class="fa fa-minus"></i>
						</a>
					</td>
					<td>${regDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
		
		
	<jsp:include page="/WEB-INF/views/common/pagination2.jsp"/>
</div>

	<div class="text-center">
			<form action="search">
				Search:
				<select name="category">
					<option value="user_id">User ID</option>
					<option value="name">name</option>
					<option value="email">email</option>
				</select>
			
				<input type="text" name="keyword" required>
				<button type="submit"><i class="fas fa-search"></i></button>
			</form>
		</div>

</body>
</html>


