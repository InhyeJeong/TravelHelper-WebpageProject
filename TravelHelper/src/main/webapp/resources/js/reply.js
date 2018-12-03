// 날짜 출력
Date.prototype.formatDate= function() {
	var year = this.getFullYear();
	var month = this.getMonth()+1;
	var date = this.getDate();
	month = (month < 10) ? '0' + month : month;
	date = (date < 10) ? '0' + date : date;
	return `${year}-${month}-${date}`;
}
// 폼 데이터를 JS 객체로 변환
function formToObject(form) {
	var arr = $(form).serializeArray();
	var obj = {}
	for(entry of arr) {
		obj[entry.name] = entry.value;
	}
	return obj;
}

// ajax 에러 처리 핸들러
function error(xhr){
	alert(`요청 처리 실패(${xhr.status}) : ${xhr.responseText}`);
}
// ajax 호출 메서드
function replyAjax(obj) {
	$.ajax({
		url : obj.url, // ajax 요청 url
		type : obj.type, // ajax 요청 HTTP 메서드
		contentType: 'application/json', // 전송 컨텐츠 인코딩 타입
		data : obj.data, // 전송 데이터
		dataType : 'json', // 결과 포맷
		success : obj.success, // 성공 시 콜백
		error : error // 에러 시 콜백
	});
}


// 댓글 템플릿 생성 함수
function addReply(reply) {
	return `
		<div class="media my-3" style="margin-left:${50*(reply.level-1)}px"
			data-reply-id="${reply.replyId}"
			data-review-id="${reply.reviewId}"
			data-writer="${user}"
			data-parent="${reply.replyId}"
			data-level="${reply.level}">
			
			<img src="${context}/member/avata/${reply.writer}"
			class="rounded-circle avata-md">
				reply.js : 최상위 댓글 추가
				<div class="media-body ml-3">
					<div class="button-group float-right">
						작성일 :
							<span class="update-date">
								${reply.updateDate.formatDate()}
							</span>
							<button class="reply-add-show">
								<i class="fa fa-reply"></i>
							</button>
							<button class="reply-edit-show">
								<i class="fa fa-edit"></i>
							</button>
							<button class="reply-delete-show">
								<i class="fa fa-trash"></i>
							</button>
					</div>
					<h5>${reply.writer}</h5>
					<div class="reply-content">
						${reply.content}
					</div>
					<div class="reply-work"></div>
				</div>
		</div>`;
}



$.fn.replyForm = function(listPanel) {
	var self = this;
	self.submit(function(e) {
		e.preventDefault(); // submit 기본 행동 막기
		var reply = formToObject(this); // 폼 데이터를 JS 객체로 변홖
		replyAjax({
			url : $(this).attr("action"),
			type : 'post',
			data : JSON.stringify(reply),
			success : function(result) { // 처리 성공
				result.updateDate = new Date(result.updateDate);
				result.level = 1; // 최상위 댓글 수준
				listPanel.prepend(addReply(result)); // 댓글을 맨 앞에 추가
				self[0].reset(); // 폼 내용 지우기
			}
		});
	});
	return self;
}


$.fn.replyList = function(reviewId) {
	var self = this; // 이벤트 핸들러에서 사용할 클로저 변수
	// ajax 처리 기본 url
	var baseurl = context + "/review/reply/" + reviewId;
	// 댓글 추가, 수정, 삭제 버튼 이벤트 핸들러 설정
	// 각각의 작업 영역 출력

	
	
	self.on('click', '.reply-add-show', e=>setReplyWork.call(e.target, 'post'));
	self.on('click', '.reply-edit-show', e=>setReplyWork.call(e.target, 'put', getContent(e.target)));
	self.on('click', '.reply-delete-show', e=>setReplyWork.call(e.target, 'delete'));
	// 작업 영역의 취소 버튼 이벤트 핸들러 설정
	self.on('click', '.reply-cancel', function(){
		// 취소 버튼이 속한 .media-body 찾기
		var body = $(this).closest('.media-body')
		body.find('.reply-work').empty(); // 작업 영역 제거
		body.find('.reply-content').show(); // 컨텐츠 영역 복원
		
		enableButtons(body);	//버튼 그룹 활성화
		});
	// 작업 영역의 확인(추가, 수정, 삭제) 버튼 이벤트 핸들러 설정
	// 댓글추가
	self.on('click', '.reply-post',  function () {
		var reply = checkReply(this, true);
		if(!reply) return;
		
		var media =$(this).closest('.media');
		var body = $(this).closest('.media-body');
		console.log(reply)
		replyAjax({
			url : baseurl,
			type : 'post',
			data : JSON.stringify(reply),
			success : function(result) {
					body.find('.reply-work').empty(); // 작업영역 제거
					result.updateDate = new Date(result.updateDate);
					result.level = reply.level + 1; // 댓글 수준 증가
					media.after(addReply(result));
					enableButtons(body);	//버튼 그룹 활성화
			}
		});
	});
	// 댓글수정
	self.on('click', '.reply-put', function () {
		var reply = checkReply(this, true);
		if(!reply) return;
		
		var body = $(this).closest('.media-body');
		replyAjax({
			url : baseurl + "/" + reply.replyId,
			type : 'put',
			data : JSON.stringify(reply),
			success : function(result) {
				body.find('.reply-work').empty(); // 작업영역 제거
				result.updateDate = new Date(result.updateDate);
				body.find('.update-date') // 수정일 갱신
					.text(result.updateDate.formatDate());
				body.find('.reply-content').text(result.content); // 내용
				body.find('.reply-content').show();
				enableButtons(body);	//버튼 그룹 활성화
			}
		});
	});
																																																																												// 제거
	// 댓글 삭제																																																																									// });
	self.on('click', '.reply-delete', function () {
		var reply = checkReply(this);
		if(!reply) return;
		if(!confirm('해당 댓글을 삭제할까요?')) return;
		var body = $(this).closest('.media-body');
		var url = baseurl + "/" + reply.replyId + "?password=" + reply.password;
		replyAjax({
			url : url,
			type : 'delete',
			success : function(result) {
				body.find('.reply-content').text('삭제된 글입니다.');
				body.find('.reply-work').empty();	
				body.find('.button-group').empty();
				body.find('.reply-content').show();
				enableButtons(body);	//버튼 그룹 활성화
			}
		});
	});
	
	
}


/** 댓글 추가/수정/삭제 작업 영역 템플릿 생성*/
function replyForm(method, content) {
	var template =` 
		<div class="card card-body mp-3">`;
	
	if(method != 'delete') { // 추가/수정 작업 시 textarea 추가
		template += ` 
			<textarea class="reply-edit-content" required
				style="width:100%">${content?content:''}</textarea>`;
 
	}
	
	template += `
		<div class="text-right mt-2">
			비밀번호 :
			<input type="password" name="password" required>
			<button type="button" class="reply-${method}">
				확인
			</button>
			<button type="button" class="reply-cancel">
				취소
			</button>
		</div>
	</div>`;
	return template;
}
/////////////////////////////////////////////////////////////////////////////////////////
function disableButtons(parent) {
	parent.find('.button-group button')	// 작업 영역 부모 찾기
			.prop("disabled", true);
	
}

function enableButtons(parent) {
	parent.find('.button-group button')	// 작업 영역 부모 찾기
			.prop("disabled", false);
	
}


/**댓글 작업 UI 생성 및 화면에 보이기*/
function setReplyWork(method, content) {
	// 댓글 추가 UI 생성
	var form = replyForm(method, content);
	// 댓글 수정 UI를 .reply-work에 추가 하기
	var body = $(this).closest('.media-body'); // 작업 영역 부모 찾기
	body.find('.reply-work') // .reply-work 찾기
			.append(form); // 댓글 수정 UI를 .reply-work에 추가
	
	disableButtons(body);
}
// 현재 댓글 내용 얻기 - 댓글 수정 시 사용
function getContent(target) {
	return $(target).closest('.media-body')
					.find('.reply-content')
					.hide()
					.text().trim();
}

/** 댓글의 정보 추출*/
function getReply(target) {
	// 정보 추출을 위해 대상 .media 선택
	var media = $(target).closest('.media');
	return {
			replyId : media.data('reply-id'), // replyId 추출(수정,삭제 시)
			reviewId : media.data('review-id'), // reviewId 추출
			writer : user, // user 전역변수로 작성자 추출
			parent : media.data('parent'), // 상위 댓글 번호 추출
			level : media.data('level'), // 댓글 수준 (추가 시)
			password : media.find(':password').val(), // 비밀번호 추출
			content : media.find('textarea').val() // 댓글 내용 추출
	}
}

/**댓글의 유효성 검사*/
// 비밀번호와 내용 입력 여부 검사
// 정상인 경우 reply 객체 리턴
// 아닌 경우 undefiend 리턴
function checkReply(target, contentCheck) {
	var reply = getReply(target); // reply 객체 추출
	if(reply.password =='') {
		return alert('비밀번호를 입력하세요');
	}
	if(contentCheck && reply.content =='') {
		return alert('내용을 입력하세요');
	}
	return reply;
}