<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script>
	$(function() {/**edit의 첨부파일 삭제랑 거의 비슷*/
		
		//삭제눌렀을때 보여주기
		$('#delete-btn').click(function(e) {
			e.preventDefault();
			$('.password-panel').show()
			
			
		});
		//취소버튼 눌렀을때 가리기
		$('#delete-cancel').click(function() {
			$('#password').val('');
			$('.password-panel').hide()
		
		});
		//
		$('#delete-confirm').click(function() {
			var password=$('#password').val(); //input에 있음
			var planboardId= $(this).data('target');
			
			if(password=='') {
				alert("비밀번호를 입력하세요");
				$('#password').focus();
				return;
			}
			console.log(password, planboardId);
			
			var result = confirm("게시글을 삭제할까요?");
			if(!result) return;
			
			var url = '../delete';
			var params = {
					planboardId : planboardId,
					password : password,
			};
			
			/**Ajax 호출*/
			$.get(url, params, function(result) {
				// 결과 응답 데이터는 result로 전달됨
				// 이곳에서 this는 Ajax핸들러이므로(더 이상 a태그가 아님) this 사용불가
				if(result == 'ok') {
					//어디로 어떻게 이동?:javascript로 페이지 이동 location
					location = '../list';
				} else {
					alert('삭제 실패 : '+ result);
				}
			});
		})
		$('.submit_comment').click(function(e){
			submitComment(e);
		});
		
		$('#comment').keydown(function(e){
			if(e.keyCode == 13)	submitComment(e);
		});
		
		$('.erase_comment').click(function(e){
			var commentId = $(this).data('target');
			var t = $(this);
			eraseComment(e, commentId, t);
		});
		
		function eraseComment(e, commentId, t){
			var result = confirm("댓글을 삭제할까요?");
			if(!result) return;
			
			var url='eraseComment';
			var params={
					commentId : commentId
			};
			
			$.get(url, params, function(result){
				if(result=='ok'){
					alert('댓글을 삭제했습니다.');
					// 화면에서 댓글 삭제
					t.parent().text("");
				}else{
					alert('삭제 실패 : ' + result);
				}
			});
		}
		
		function submitComment(e){
			e.preventDefault();
			var parent = $(this).parent();
			
		
			var planWriterId = "${plan.writer}";
			var commentWriterId = "${USER.userId}";
			var commentContent = $('#comment').val();
			var planboardId = ${plan.planboardId};
			

			var result = confirm("댓글을 작성할까요?");
			if(!result) return;

			var url='writeComment';
			var params={
				planWriterId : planWriterId,
				commentWriterId : commentWriterId,
				commentContent : commentContent,
				planboardId : planboardId
			};
			
			$.get(url, params, function(result){
				// 결과 응답 데이터는 result로 전달됨.
				if(result == 'ok'){
					alert('댓글을 작성했습니다..');
					//추가로 해야할 일?
					$('#comment').val("");
					$('#comments').append(`<div> <img src=" ${context}/member/avata/`+commentWriterId +`"` + 
						`class="rounded-circle avata-small avata-sm">` +
						commentWriterId + ` : ` + commentContent + `</div><br>`);
				}else{
					alert('댓글 작성 실패 : ' + result);
				}
			});
		}
	});
</script>

<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
		<iot:page-animate-header  title="VIEW POSTING"/>

<div class="row">
	<div class="col-md-2">제목</div>
	<div class="col-md-10">${plan.title}</div>
</div>
<div class="row">
	<div class="col-md-2">작성자</div>
	<div class="col-md-10">${plan.writer}</div>
</div>
<div class="row">
	<div class="col-md-2">조회수</div>
	<div class="col-md-10">${plan.readCnt}</div>
</div>
<div class="row">
	<div class="col-md-2">첨부파일</div>
	<div class="col-md-10">
		<c:forEach var="file" items="${plan.attachList}">
			<div>
				<a href="../download/${file.attachmentId}"> 
					<i class="fas fa-download"></i> ${file.fileName}
				</a>
			</div>
		</c:forEach>
	</div>
</div>
<div class="row">
	<div class="col-md-2">작성일</div>
	<div class="col-md-10">
		<fmt:formatDate value="${plan.regDate}" pattern="yyyy-MM-dd" />
	</div>
</div>
<div class="row">
	<div class="col-md-2">수정일</div>
	<div class="col-md-10">
		<fmt:formatDate value="${plan.updateDate}" pattern="yyyy-MM-dd" />
	</div>
</div>
<hr />
<div>${plan.content}</div>


<div id = "comments">
<c:forEach var="comment" items="${plan.commentList}">
<div> <img src="${context}/member/avata/${comment.commentWriterId}"
							class="rounded-circle avata-small avata-sm"> 
			${comment.commentWriterId} : ${comment.commentContent}
			<c:if test="${USER.userId == comment.commentWriterId}">
				<a href="#" class="erase_comment" data-target="${comment.commentId}">
					<i class="fas fa-eraser"></i>
				</a>
			</c:if>
			</div>
			<br>
</c:forEach>
</div>

<form>
  댓글 : <input type="text" id="comment"/>
	<a href="#" class="submit_comment"> 
		<i class="far fa-comment-dots"></i>
	</a>
</form>

<div class="text-center" >
	<c:if test="${USER.userId == plan.writer }">
		<a href="../edit/${plan.planboardId}?page=${param.page}" class="mr-4" style="color:gray;"> 
			<i style="color:gray;" class="fas fa-edit mr-2"></i> EDIT
		</a>
		<a href="#" id = "delete-btn" class="mr-4" style="color:gray;"> 
		<i class="fas fa-trash mr-2" style="color:gray;"></i> DELETE
		</a>
	</c:if>
	<a href="../list?page=${param.page}" style="color:gray;"> <i class="fas fa-undo mr-2" style="color:gray;"></i>
		BACK
	</a>
</div>

<div class="password-panel text-center my-3" style="display:none">
	삭제 비밀번호 : <input type="password" id ="password">
	<button type="button" id="delete-confirm" data-target="${plan.planboardId}"> OK </button>
	<button type="button" id="delete-cancel"> CANCEL </button>
</div>




