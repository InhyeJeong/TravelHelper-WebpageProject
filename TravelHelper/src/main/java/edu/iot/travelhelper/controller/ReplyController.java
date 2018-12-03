package edu.iot.travelhelper.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import edu.iot.common.exception.PasswordMissmatchException;
import edu.iot.common.model.Reply;
import edu.iot.common.service.ReplyService;

@RestController
@RequestMapping("/review/reply/{reviewId}")
public class ReplyController {
	@Autowired
	ReplyService service;

	// 정상 처리 응답
	public <T> ResponseEntity<T> getResult(T t) {
		final HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json;charset=UTF-8");
		return new ResponseEntity<T>(t, headers, HttpStatus.OK);
	}

	// 에러 처리 응답
	public <T> ResponseEntity<T> handleError(Exception e) {
		e.printStackTrace();
		final HttpHeaders headers = new HttpHeaders();
		//headers.add("Content-Type", "application/json;charset=UTF-8");
		headers.setContentType(MediaType.APPLICATION_JSON);
		return new ResponseEntity<T>(null, headers, HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<List<Reply>> list(@PathVariable long reviewId)throws Exception {
		List<Reply> list = service.getList(reviewId);
		return getResult(list);
	}

	@RequestMapping(value = "/{replyId}", method = RequestMethod.GET)
	public ResponseEntity<Reply> replyId(@PathVariable long replyId)throws Exception {
		Reply reply = service.findById(replyId);
		return getResult(reply);
	}

	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Reply> create(@RequestBody Reply reply)throws Exception {
		// 데이터가 json으로 전송되므로 @RequestBody 사용
		Reply r = service.create(reply);
		return getResult(r);
	}

	@RequestMapping(value = "/{replyId}", method = RequestMethod.PUT)
	public ResponseEntity<Reply> update(@RequestBody Reply reply)throws Exception {
		// 데이터가 json으로 전송되므로 @RequestBody 사용
		//System.out.println(reply);
		Reply r = service.update(reply);
		return getResult(r);
	}

	@RequestMapping(value = "/{replyId}", method = RequestMethod.DELETE)
	public ResponseEntity<Reply> delete(Reply reply)throws Exception {
		// password가 쿼리 파라미터로 전송됨
		// @RequestBody 사용하지 않음
		service.delete(reply);
		return getResult(reply);
	}
	
	// password 틀ㄹ렸을때
	@ExceptionHandler(PasswordMissmatchException.class)
	public ResponseEntity handlePasswordMissmatchException(PasswordMissmatchException e) {
		return ResponseEntity
				.status(HttpStatus.UNAUTHORIZED)
				.body(e.getMessage());
	}
	// 그 외의 에러메시지
	@ExceptionHandler(Exception.class)
	public ResponseEntity handleException(Exception e) {
		return ResponseEntity
				.status(HttpStatus.INTERNAL_SERVER_ERROR)
				.body("서버에서 일시적인 장애가 발생했습니다."); // ct에게는 에러메세지 노출x
				//.body(e.getMessage());
	}
}
