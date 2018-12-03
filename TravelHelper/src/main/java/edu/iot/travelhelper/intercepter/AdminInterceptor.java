package edu.iot.travelhelper.intercepter;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;

/** 인터셉터를 이용한 관리자 권한 처리 */

@Component
public class AdminInterceptor extends BaseIntercepter {

	// base에서 context autowired

	// 통과하면 null 안하면 문자열로 이유 리턴
	@Override
	public String check(HttpServletRequest request) {
		if (!isAdmin(request)) {
			return "관리자 권한 확인이 필요합니다.";
		}
		return null;
	}

}
