<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:forEach var="reply" items="${replies}">
	<div class="media my-3" style="margin-left:${50*(reply.level-1)}px"
		data-reply-id="${reply.replyId}"
		data-review-id="${reply.reviewId}"
		data-parent="${reply.replyId}"
		data-level="${reply.level}">
		<img src="${context}/member/avata/${reply.writer}" 
			class="rounded-circle avata-md">
		
		<div class="media-body ml-3">
			<div class="button-group float-right">
				작성일 : 
				<span class="update-date">
					<fmt:formatDate value="${reply.updateDate}" pattern="yyyy-MM-dd"/>
				</span> 
				<c:if test="${reply.deleted != 1}">				
					<c:if test="${not empty USER}">
						<button class="reply-add-show"><i class="fa fa-reply"></i></button>
						<c:if test="${reply.writer == USER.userId}">
							<button class="reply-edit-show"><i class="fa fa-edit"></i></button>
							<button class="reply-delete-show"><i class="fa fa-trash"></i></button>
						</c:if>
					</c:if>
				</c:if>
			</div>
			<h5>${reply.writer}</h5>
			<div class="reply-content">
				${reply.content}
			</div>
			<div class="reply-work"></div>
		</div>
	</div>
</c:forEach>	