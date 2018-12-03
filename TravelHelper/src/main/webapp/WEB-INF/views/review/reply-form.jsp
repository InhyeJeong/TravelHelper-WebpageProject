<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card card-body mp-3">
	<form id="reply-form" 
		action="${context}/review/reply/${reviewId}" method="post">
		<input type="hidden" name="reviewId" value="${reviewId}">
		<input type="hidden" name="writer" value="${USER.userId}">
		<div class="mb-2">
			<strong>[댓글 달기] </strong>
			작성자 : ${USER.userId}
		</div>		 
		<textarea name="content" required 
				style="width:100%"></textarea>
		<div class="text-right">
			비밀번호 : <input type="password" name="password" required>
			<button type="submit">등록</button>
			<button type="reset">취소</button>
		</div>
	</form>
</div>