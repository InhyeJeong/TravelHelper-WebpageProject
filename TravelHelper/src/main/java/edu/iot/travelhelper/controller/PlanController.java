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


import edu.iot.common.model.Plan;
import edu.iot.common.model.PlanAttachment;
import edu.iot.common.service.PlanService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/plan")
@Slf4j
public class PlanController {
	@Autowired
	PlanService service;
	
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
	 public void createForm(Plan plan) throws Exception{
		 
	 }
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String createSubmit(
					@Valid Plan plan, BindingResult result,
					MultipartHttpServletRequest request)throws Exception {
		
		if(result.hasErrors()) return "plan/create";
		
		List<PlanAttachment> list = upload(request);
		plan.setAttachList(list);
		
		service.create(plan);
		
		return "redirect:list";
		
	}
	
	@RequestMapping(value = "/view/{planboardId}", method = RequestMethod.GET)
	public String view(@PathVariable long planboardId, Model model) throws Exception {
		Plan plan = service.findById(planboardId);
		model.addAttribute("plan", plan);
		return "plan/view";
	}

	// 단일 파일 업로드 처리
	PlanAttachment upload(MultipartFile file) throws Exception {
		String fname= file.getOriginalFilename();
		long timestamp = System.currentTimeMillis();
		String location = timestamp + "_" + fname;
		File dest = new File("c:/temp/upload/" + location);
		file.transferTo(dest);
		return new PlanAttachment(fname, location);
	}
	
	// createSubmit에서 쓰이는 메서드 : 다중 파일 업로드 처리
	// 업로드된 정보를 가지는 Attachment의 리스트 생성/반환
	private List<PlanAttachment> upload(MultipartHttpServletRequest request)throws Exception {
		//fileName과 location 생성됨 boardId는 비어있음
		List<PlanAttachment> list = new ArrayList<>();
		
		List<MultipartFile> files = request.getFiles("files");
		for(MultipartFile file : files) {
			if(!file.isEmpty()) {
				PlanAttachment attachment = upload(file);
				list.add(attachment);
			}
		}
		return list;
	}
	
	@RequestMapping(value = "/download/{attachmentId}", method = RequestMethod.GET)
	public String download(@PathVariable long attachmentId,
						Model model) throws Exception {
		PlanAttachment attachment = service.getAttachment(attachmentId);
		String path = "c:/temp/upload/" + attachment.getLocation();
		String fileName = attachment.getFileName();
		String type = context.getMimeType(path);
		model.addAttribute("path", path);
		model.addAttribute("fileName", fileName);
		model.addAttribute("type", type);
		return "download";// 사용자 정의 뷰
	}

	@RequestMapping(value = "/edit/{planboardId}", method = RequestMethod.GET)
	public String editForm(@PathVariable int planboardId, Model model) throws Exception {
		Plan plan = service.findById(planboardId);
		model.addAttribute("plan", plan);
		return "plan/edit";
	}

	@RequestMapping(value = "/edit/{planboardId}", method = RequestMethod.POST)
	public String editSubmit(@Valid Plan plan, BindingResult result, @RequestParam("page") int page,
			MultipartHttpServletRequest request) throws Exception {
		if (result.hasErrors())
			return "plan/edit";
		List<PlanAttachment> list = upload(request);
		plan.setAttachList(list);
		try {
			service.update(plan);
		} catch (PasswordMissmatchException e) {
			result.reject("updateFail", e.getMessage());
			plan.setAttachList(service.getAttachList(plan.getPlanboardId()));
			return "board/edit";
		}

		return "redirect:/plan/view/" + plan.getPlanboardId();
	}
	
	
	@ResponseBody //리턴값을 url로 받지 않고 Json문자열로 변환해줌
	@RequestMapping(value="/delete_attachment",
					method=RequestMethod.GET,
					produces = "text/plain; charset=utf8")
	public String deleteAttachment(
						@RequestParam("planboardId") long planboardId,
						@RequestParam("password") String password,
						@RequestParam("attachmentId") long attachmentId) {
		try {
			service.deleteAttachment(planboardId, password, attachmentId);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="delete",
					method=RequestMethod.GET,
					produces = "text/plain; charset=utf8")
	public String delete(Plan plan) {
		try {
			service.delete(plan);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/view/writeComment",
					method=RequestMethod.GET,
					produces="text/plain; charset=utf8")
	public String writeComment(
			@RequestParam("planWriterId") String planWriterId,
			@RequestParam("commentWriterId") String commentWriterId,
			@RequestParam("commentContent") String commentContent,
			@RequestParam("planboardId") long planboardId)
	{
		try {
			System.out.println(planWriterId + commentWriterId + commentContent + planboardId);
			service.writeComment(planWriterId, commentWriterId, commentContent, planboardId);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/view/eraseComment",
					method=RequestMethod.GET,
					produces="text/plain; charset=utf8")
	public String eraseComment(
			@RequestParam("commentId") long commentId)
	{
		System.out.println("실행됨");
		try {
			service.deleteComment(commentId);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
}
