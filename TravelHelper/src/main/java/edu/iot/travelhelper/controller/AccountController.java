package edu.iot.travelhelper.controller;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.iot.common.exception.LoginFailException;
import edu.iot.common.model.Avata;
import edu.iot.common.model.Login;
import edu.iot.common.model.Member;
import edu.iot.common.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/account")
public class AccountController {
	
	@Autowired
	MemberService service;

	/**로그인 모델 추가 후, 인터셉터를 이용한 로그인 처리*/
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginForm(Login login,
						@ModelAttribute("url") String url,
						@ModelAttribute("reason") String reason){
		login.setUrl(url);
		login.setReason(reason);
		return "account/login";
	}
		
	/**로그인 모델 추가 후, 인터셉터를 이용한 로그인 처리*/
	@RequestMapping(value="/login", method=RequestMethod.POST)// 주로 post에서 service이용하여 로직처리함
	public String loginSubmit(Login login, HttpSession session,//submit하면 userId,password
					Model model)throws Exception { // Model이 필요해서 매개변수로 받아버림
		
		try {
			Member member = service.login(login.getUserId(), login.getPassword());//member로 받아서 (admin인지 등등 구별하려고)
			//성공하면 세션에 정보를 추가하고, 리다이렉트
			session.setAttribute("USER", member);
			
			String url = login.getUrl();
			if(url!=null && !url.isEmpty()) return "redirect:" + url;
			
			return "redirect:/";
		} catch (LoginFailException e) {
			//실패하면 포워드 // 실패해서 되돌아왔을 때 다시 채워지는 문자열은 login.jsp의 ${}부분
			model.addAttribute("error", e.getMessage());
			return "account/login";
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET) // view 이름은 account/join
	public void joinForm(Member member) { // 파라미터에 잇는 내용을 setting하라는 내용.
		//joinSubmit의 member는 파라미터가 존재함.
		//여기는 존재만하고 null, 커맨드객체는 자동으로 req 스코프에 담김
		// > (join.jsp)form태그 사용할 때는 get에도 모델객체 추가해줘야 nullpointEx발생안함
	
	}
	/**@valid 유효성검사 > result에 담긴다.*/
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinSubmit(@Valid Member member, BindingResult result,
							@RequestParam("avata") MultipartFile mFile,
							RedirectAttributes ra)throws Exception {
		
		//log.info(member.toString());
		if(result.hasErrors()) {	// 유효성 검사 실패
			return "account/join";// 포워드로 돌아감 리퀘스트 스코프가 공유됨 member와 result 모두 넘어가서 에러 메세지가 출력됨
		}
		service.join(member);
		
		
		//유효성 검사 통과
		
			//아바타 저장
		if(mFile != null && !mFile.isEmpty()) {
			service.insertAvata(new Avata(member.getUserId(), mFile.getBytes()));
		}
		ra.addFlashAttribute("member", member);//session에 저장되었다가 다음 req에서 세션에서 제거되고 req의 모델에 들어감
		return "redirect:/account/join_success";
	}
	
	/**ID 중복 검사*/
	// json 자동 변환 - gson 의존성 추가하면 json문자열로 자동변환함
	@RequestMapping(value="/idcheck", method=RequestMethod.GET)
	@ResponseBody // 문자열 return 값을 view 로 보지 않고 response의 body파트로 본다.
	public String checkUserId(@RequestParam("userId") String userId)throws Exception{
		return service.idCheck(userId);
		//MemberServiceImpl의 ok or fail의 문자열 결과를 view이름이 아닌 json문자열로 자동변환
	}
	
	
	/**아바타를 위한 로그인 성공 페이지*/
	@RequestMapping(value="/join_success", method=RequestMethod.GET)
	public void checkUserId() throws Exception {
		
	}
}
