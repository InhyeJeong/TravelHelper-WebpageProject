package edu.iot.travelhelper.controller;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

/** 관리자 회원관리 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.iot.common.model.Member;
import edu.iot.common.model.Search;
import edu.iot.common.model.UserLevel;
import edu.iot.common.sec.SHA256Util;
import edu.iot.common.service.MemberService;
import edu.iot.common.util.Util;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/member")
public class AdminMemberController {
	@Autowired
	MemberService service;
	
	/**목록보기 /list*/
	@RequestMapping("/list")
	public void list(@RequestParam(value="page", defaultValue="1") int page,
						Model model) throws Exception{
		// 목록 및 페이지 정보 추출
		model.addAllAttributes(service.getPage(page));
		model.addAttribute("today", Util.getToday());
	}
	
	/**path상의 변수하고 매개변수하고 매핑하겠다. path상의 변수 ==매개변수의 이름이 일치해야한다.*/
	@RequestMapping(value="/view/{userId}", method=RequestMethod.GET)
	public String view (@PathVariable String userId, Model model) throws Exception {
		Member member = service.findById(userId);
		model.addAttribute("member", member);
		return "admin/member/view";
				
	}
	
	/**회원 정보 수정/edit/{userId}*/
	@RequestMapping(value="/edit/{userId}", method=RequestMethod.GET)
	public String editForm(@PathVariable String userId, Model model) throws Exception {
		Member member = service.findById(userId);
		model.addAttribute("userLevels", UserLevel.values());//enum의 값을 배열로 리턴
		model.addAttribute("member", member);
		return "admin/member/edit";
	}
	
	//post 유효성 검사  통과하면 uopdatebyadmin호출해서 검사
	@RequestMapping(value="/edit/{userId}", method=RequestMethod.POST)
	public String editSubmit(
						@Valid Member member,
						BindingResult result,
						HttpSession session,// 관리자 비밀번호 얻기 위해
						@RequestParam(value="page", defaultValue="1") int page,
						Model model) throws Exception {
		
		if(result.hasErrors()) {// 유효성 검사 실패
			model.addAttribute("userLevels", UserLevel.values());
			return "admin/member/edit";
		}
		Member admin = (Member) session.getAttribute("USER");
		String encPassword =SHA256Util.getEncrypt(member.getPassword(), admin.getSalt());
		
		if(encPassword.equals(admin.getPassword())) {
			service.updateByAdmin(member);
		}else {
			model.addAttribute("userLevels", UserLevel.values());
			result.reject("fail", "비밀번호가 일치하지 않습니다.");// 전역 에러 메세지 :유효성 검사와 상관 없는 에러메세지이라는 표시의 reject
			return "admin/member/edit";
			
		}
		
		//유효성 검사 통과
		return "redirect:/admin/member/view/" + member.getUserId() + "?page="+page;
		
	}
	
	
	
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public void search(Search search, Model model)throws Exception{

		model.addAttribute("today", Util.getToday());
		model.addAttribute("list", service.search(search));
		model.addAttribute("total", service.search(search).size());
	}
	
	
	
	
	/**delete*/
	@RequestMapping(value="/delete/{userId}", method=RequestMethod.GET)
	public String delete(@PathVariable String userId) throws Exception {
		service.delete(userId);
		service.deleteAvata(userId);
		return "redirect:/admin/member/list";
	}
	
	@ResponseBody
	@RequestMapping(value="/updatePoint",
					method=RequestMethod.GET,
					produces="text/plain; charset=utf8")
	public String updatePoint(
			@RequestParam("userId") String userId,
			@RequestParam("pointVal") int pointVal){
		try {
			service.updatePoint(userId, pointVal);
			return "ok";
		}catch (Exception e) {
			return e.getMessage();
		}
	}
}
