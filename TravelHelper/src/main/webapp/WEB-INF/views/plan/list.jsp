<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>
<link rel="stylesheet" href="${context}/resources/css/main.css"/>

<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
<iot:page-animate-header  title=" TOUR PLAN LIST"/>


<div class="text-right">
	(Total ${pagination.total} /
	 <a href="create"><i class="fas fa-plus"></i> PLUS</a>)
</div>
	
	
	
	<table class="table table-stripped">
		<thead>
			<tr>
				<th style="width:60px">No</th>
				<th> Plan Title </th>
				<th style="width:100px"> WRITER </th>
				<th style="width:90px"> VIEWS </th>
				<th style="width:120px"> WRITE DATE </th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="plan" items="${list}" varStatus="status">
			<fmt:formatDate var="regDate" value="${plan.regDate}" pattern="yyyy-MM-dd"
			scope="request"/><!-- request스코프로 수정 -->
				<tr>
					<td>${plan.planboardId}</td>
					<td>
						<a href="view/${plan.planboardId}?page=${pagination.page}">
						<!--게시물수정 > 확인 > 여기서 historyback쓰면 수정페이지로 넘어간다.
						list로 넘어가기 위해서 페이지 번호를 넘겨준다.  -->
							${plan.title}
							<iot:new-item date="${regDate}"/> <!-- taglib 활용 -->
						</a>
					</td>
					<td>
						<img src="${context}/member/avata/${plan.writer}"
							class="rounded-circle avata-sm">
						${plan.writer }</td>
					<td>${plan.readCnt }</td>
					<td>${regDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<iot:pagination/>

</body>
</html>


