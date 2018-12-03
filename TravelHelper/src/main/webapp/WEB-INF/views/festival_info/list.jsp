<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${context}/resources/css/main.css"/>
<meta charset="UTF-8">
<title>FESTIVAL LIST</title>
</head>
<body>


<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
<iot:page-animate-header  title=" FESTIVAL LIST"/>

	<div>
		<div class="float-left">
			<form action="list">
				Order By
				<select name="arrange" value="arrange" >
					<option value=" " selected> ----select---- </option>
					<option value="A"
					<c:if test="${arrange=='A'}">selected</c:if>
					>제목</option>
					<option value="B"
					<c:if test="${arrange=='B'}">selected</c:if>
					>조회</option>
					<option value="C"
					<c:if test="${arrange=='C'}">selected</c:if>
					>수정일</option>
					<option value="D"
					<c:if test="${arrange=='D'}">selected</c:if>
					>인기</option>
				</select>
			
				City
				<select name="areaCode" value=${areacode}>
					<option value=" " selected> ----select---- </option>
					<option value="1"
					<c:if test="${areacode=='1'}">selected</c:if>
					>서울</option>
					<option value="2"
					<c:if test="${areacode=='2'}">selected</c:if>
					>인천</option>
					<option value="3"
					<c:if test="${areacode=='3'}">selected</c:if>
					>대전</option>
					<option value="4"
					<c:if test="${areacode=='4'}">selected</c:if>
					>대구</option>
					<option value="5"
					<c:if test="${areacode=='5'}">selected</c:if>
					>광주</option>
					<option value="6"
					<c:if test="${areacode=='6'}">selected</c:if>
					>부산</option>
					<option value="7"
					<c:if test="${areacode=='7'}">selected</c:if>
					>울산</option>
					<option value="8"
					<c:if test="${areacode=='8'}">selected</c:if>
					>세종</option>
				
				</select>
				Start Date
				<input type="date" name="eventstartdate" value="${eventstartdate}"/>
				
				End Date
				<input type="date" name="eventenddate" value="${eventenddate}"/>
			
				

				<button type="submit"
					class="btn btn-unique btn-sm"
				><i class="fas fa-share-square"></i></button>
			</form>
		</div>
	
		<div class="float-right">
			 Total : ${pagination.total}
		</div>
	</div>
		
	<p style="height:50px"></p>	
	
<!--사진  -->
<div >

	<div class="row">

		<!--Grid column-->
	
		<c:forEach var="festivalInfo" items="${list}" varStatus="status" >
		<div class="col-lg-4 col-md-6" style="margin: 10px 0 10px 0">

			<div class="card">
				<div class="view overlay">
					<img src="${festivalInfo.firstimage}" class="card-img-top" alt="">
					<a href="#">
						<div class="mask rgba-white-slight"></div>
					</a>
					
					
				</div>
				<div class="card-body">
					<h4 class="card-title">${festivalInfo.title}</h4>
					<p class="card-text">
						주소 ▶ ${festivalInfo.addr1} <br>
						시작일  ▶ ${festivalInfo.eventstartdate} <br>
						종료일  ▶ ${festivalInfo.eventenddate} <br>
						전화번호  ▶ ${festivalInfo.tel} <br>
					</p>
					
					<a href="https://www.google.co.kr/maps/dir//${festivalInfo.mapy},${festivalInfo.mapx}/@${festivalInfo.mapy},${festivalInfo.mapx},17z?hl=ko" class="btn btn-unique" target="_blank">MAP</a>
							
				
				</div>
			</div>
		</div>

		</c:forEach>	
	</div>

</div>

	
	
	
	<jsp:include page="/WEB-INF/views/common/pagination3.jsp"/>
</body>
</html>


