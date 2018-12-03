<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}" scope="request"/>
<style>
	.avata-sm {
		width: 25px;
		height: 25px;
	}
	
	.avata-md {
		width: 50px;
		height: 50px;
	}
	
	.avata-lg {
		width: 75px;
		height: 75px;
	}
	.edit_avata {
		font-style: italic;
		color: pink;
		font-weight: bolder;
	}
</style>

<link rel="stylesheet" href="${context}/resources/css/main.css"/>


<!--Navbar-->

<nav class="navbar navbar-expand-lg navbar-dark " style="background-color: #880e4fcf">
	
	<!-- Navbar brand -->
	<a class="navbar-brand" href="${context}/"><i class="fas fa-map"></i> TravelHelper</a>
	
	<!-- Collapse button : 축소되었을 때 overflow 버튼 -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#basicExampleNav" aria-controls="basicExampleNav"
		aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
	<!-- Collapsible content -->
		<div class="collapse navbar-collapse" id="basicExampleNav">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="${context}/">Home <span class="sr-only">(current)</span> </a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${context}/plan/list">
							Travel Plan
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${context}/review/list">
							Travel Review
						</a>
					</li>
					<!-- Dropdown -->
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Travel Info
						</a>
							<div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
								<a class="dropdown-item" href="${context}/festival_info/list">Festival Info</a>
								<a class="dropdown-item" href="#">Top 100</a>
							</div>
					</li>
					
						<!-- 관리자일 때만 나타나는 메뉴 추가 -->
					<c:if test="${USER.userLevel=='ADMIN'}">
						<li class="nav-item">
							<a class="nav-link" href="${context}/admin/member/list">
								USER MANAGEMENT
							</a>
						</li>
						
						
					</c:if>
			</ul>
			
			
			<ul class="navbar-nav">
				<!-- 로그인 사용자 -->
				<c:if test="${not empty USER}">
				
				<!--아바타  -->
					<li class="nav-item">
						<a class="nav-link" href="${context}/member/view">
							<img src="${context}/member/avata/${USER.userId}"
								class="rounded-circle avata-sm" >
								${USER.userId}
						</a>
					</li>
				
					<li class="nav-item">
						<a class="nav-link" href="${context}/account/logout">LOGOUT</a>
					</li>
				</c:if>
				<!-- 로그인 안한 사용자 -->
				<c:if test="${empty USER}">
					<li class="nav-item">
						<a class="nav-link" href="${context}/account/login"> <i class="fas fa-sign-out-alt"></i> LOGIN</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${context}/account/join"><i class="fas fa-user-plus"></i> SIGN UP</a>
					</li>
				</c:if>
				
				
				
			</ul>
		</div>
		<!-- Collapsible content -->
	</nav>
	