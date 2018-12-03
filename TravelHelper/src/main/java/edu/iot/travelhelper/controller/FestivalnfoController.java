package edu.iot.travelhelper.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.iot.common.service.ApiDataService;
import edu.iot.common.service.FestivalInfoService;
import edu.iot.common.util.Util;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/festival_info")
@Slf4j
public class FestivalnfoController {
	@Autowired
	ApiDataService service;
	
	//**목록보기 list*//*
	@RequestMapping(value="list")
	public void list(
					@RequestParam(value="page", defaultValue="1") int page,
					@RequestParam(value="arrange", defaultValue="A") String arrange,
					@RequestParam(value="eventstartdate", defaultValue="2018-10-01") String startDate,
					@RequestParam(value="eventenddate", defaultValue="2018-12-31") String endDate,
					@RequestParam(value="areaCode", defaultValue="1") String areaCode,
					Model model)throws Exception {
		// 목록 및 페이지 정보 추출
		System.out.println("컨트롤러 실행됨");
		model.addAllAttributes(service.getPage(page, arrange, startDate, endDate, areaCode));
		model.addAttribute("arrange", arrange);
		model.addAttribute("eventstartdate", startDate);
		model.addAttribute("eventenddate", endDate);
		model.addAttribute("areacode", areaCode);

	}

}
