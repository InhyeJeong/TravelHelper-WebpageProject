<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>

<link rel="stylesheet" href="yourpath/magic.css">

<script
	src="${context}/resources/bower_components/tinymce/tinymce.min.js">
</script>
<script>
	$(function() {
		tinymce.init({
			selector : 'textarea',
			height : "300"
		});
		
		$('.delete-attachment').click(function(e) {
			e.preventDefault();
			var parent = $(this).parent();//Ajax처리 이후 사용할 부모 div태그를 변수에 미리 저장해놓기
			var planboardId = $('#planboardId').val();
			var password= $('#password').val();
			var attachmentId=$(this).data('target');//this로 a태그 선택
			
			if(password =='') {
				alert('비밀번호를 입력하세요');
				$('#password').focus();
				return;
			}
			
			console.log(planboardId, password, attachmentId);
			
			var result = confirm("첨부파일을 삭제할까요?");
			
			var url = '../delete_attachment';
			var params = {
					planboardId : planboardId,
					password : password,
					attachmentId : attachmentId
			};
			/**Ajax 호출*/
			$.get(url, params, function(result) {
				// 결과 응답 데이터는 result로 전달됨
				// 이곳에서 this는 Ajax핸들러이므로(더 이상 a태그가 아님) this 사용불가
				if(result == 'ok') {
					alert('첨부파일을 삭제 했습니다.');
					// 추가로 해야할일?
					// 내부 스코프에서 바깥 스코프 사용가능 closure 변수이기 때문에 위의 parent변수 사용가능
					parent.remove();//DOM에서 element 제거
				} else {
					alert('삭제 실패 : '+ result);
				}
			});
		});
		
		
		
		
		
	})
</script>
<!-- <h2 class="mt-5 mb-4">게시글 수정</h2> -->

<iot:page-header icon="edit" title="EDIT POSTING"/>

<form:form commandName="plan" enctype="multipart/form-data">
	<form:hidden path="planboardId" />
	<form:hidden path="writer" />
	<div class="md-form">
		<label>제목</label>
		<form:input path="title" class="form-controll" required="required" />
		<form:errors path="title" />
	</div>
	<div class="mb-3">
		<label>작성자 : ${plan.writer}</label>
	</div>
	<div class="md-form">
		<label>비밀번호</label>
		<form:password path="password" class="form-controll"
			required="required" />
		<form:errors />
	</div>
	<div class="row">
		<div class="col-md-2">첨부파일</div>
		<div class="col-md-10">
			<c:forEach var="file" items="${plan.attachList}">
				<div>
					<i class="fa fa-file"></i> ${file.fileName}
					<a href="#" data-target="${file.attachmentId}"
								class="delete-attachment">
						<i class="fa fa-trash"></i>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<div>
		<label>파일첨부</label> <input type="file" name="files"
			multiple="multiple">
	</div>
	
	<form:textarea path="content" />

	<div class="text-center mt-3">
		<button type="submit" class="btn btn-unique btn-md">
			<i class="fa fa-check mr-2"></i> OK
		</button>
		<a href="../view/${plan.planboardId}?page=${param.page}" class="btn btn-unique btn-md">
			<i class="fa fa-undo mr-2"></i> BACK
		</a>
	</div>
</form:form>