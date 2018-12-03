package edu.iot.travelhelper.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import edu.iot.common.exception.PasswordMissmatchException;
import edu.iot.common.model.Attachment;
import edu.iot.common.model.Board;
import edu.iot.common.service.BoardService;
import edu.iot.common.util.Util;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	@Autowired
	BoardService service;
	
	@Autowired
	ServletContext context;
	
	
	@RequestMapping("list")
	public void list(
					@RequestParam(value="page", defaultValue="1")int page,
					Model model)throws Exception {
		
	//	model.addAttribute("today", Util.getToday());	// 오늘날짜
		model.addAllAttributes(service.getPage(page));		
		
	}
	
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	 public void createForm(Board board) throws Exception{
		 
	 }
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String createSubmit(
					@Valid Board board, BindingResult result,
					MultipartHttpServletRequest request)throws Exception {
		
		if(result.hasErrors()) return "board/create";
		
		List<Attachment> list = upload(request);
		board.setAttachList(list);
		
		service.create(board);
		
		return "redirect:list";
		
	}
	
	@RequestMapping(value = "/view/{boardId}", method = RequestMethod.GET)
	public String view(@PathVariable long boardId, Model model) throws Exception {
		Board board = service.findById(boardId);
		model.addAttribute("board", board);
		return "board/view";
	}

	// 단일 파일 업로드 처리
	Attachment upload(MultipartFile file) throws Exception {
		String fname= file.getOriginalFilename();
		long timestamp = System.currentTimeMillis();
		String location = timestamp + "_" + fname;
		File dest = new File("c:/temp/upload/" + location);
		file.transferTo(dest);
		return new Attachment(fname, location);
	}
	
	// createSubmit에서 쓰이는 메서드 : 다중 파일 업로드 처리
	// 업로드된 정보를 가지는 Attachment의 리스트 생성/반환
	private List<Attachment> upload(MultipartHttpServletRequest request)throws Exception {
		//fileName과 location 생성됨 boardId는 비어있음
		List<Attachment> list = new ArrayList<>();
		
		List<MultipartFile> files = request.getFiles("files");
		for(MultipartFile file : files) {
			if(!file.isEmpty()) {
				Attachment attachment = upload(file);
				list.add(attachment);
			}
		}
		return list;
	}
	
	@RequestMapping(value = "/download/{attachmentId}", method = RequestMethod.GET)
	public String download(@PathVariable long attachmentId,
						Model model) throws Exception {
		Attachment attachment = service.getAttachment(attachmentId);
		String path = "c:/temp/upload/" + attachment.getLocation();
		String fileName = attachment.getFileName();
		String type = context.getMimeType(path);
		model.addAttribute("path", path);
		model.addAttribute("fileName", fileName);
		model.addAttribute("type", type);
		return "download";// 사용자 정의 뷰
	}

	@RequestMapping(value = "/edit/{boardId}", method = RequestMethod.GET)
	public String editForm(@PathVariable int boardId, Model model) throws Exception {
		Board board = service.findById(boardId);
		model.addAttribute("board", board);
		return "board/edit";
	}

	@RequestMapping(value = "/edit/{boardId}", method = RequestMethod.POST)
	public String editSubmit(@Valid Board board, BindingResult result, @RequestParam("page") int page,
			MultipartHttpServletRequest request) throws Exception {
		if (result.hasErrors())
			return "board/edit";
		List<Attachment> list = upload(request);
		board.setAttachList(list);
		try {
			service.update(board);
		} catch (PasswordMissmatchException e) {
			result.reject("updateFail", e.getMessage());
			board.setAttachList(service.getAttachList(board.getBoardId()));
			return "board/edit";
		}

		return "redirect:/board/view/" + board.getBoardId();
	}
	
	
	@ResponseBody //리턴값을 url로 받지 않고 Json문자열로 변환해줌
	@RequestMapping(value="/delete_attachment",
					method=RequestMethod.GET,
					produces = "text/plain; charset=utf8")
	public String deleteAttachment(
						@RequestParam("boardId") long boardId,
						@RequestParam("password") String password,
						@RequestParam("attachmentId") long attachmentId) {
		try {
			service.deleteAttachment(boardId, password, attachmentId);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="delete",
					method=RequestMethod.GET,
					produces = "text/plain; charset=utf8")
	public String delete(Board board) {
		try {
			service.delete(board);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
}
