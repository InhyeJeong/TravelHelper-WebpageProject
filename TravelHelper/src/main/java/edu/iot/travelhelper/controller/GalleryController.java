package edu.iot.travelhelper.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import edu.iot.common.model.Gallery;
import edu.iot.common.model.GalleryImage;
import edu.iot.common.service.GalleryService;
import edu.iot.common.util.ImageUtil;
import edu.iot.common.util.Util;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/gallery")
@Slf4j
public class GalleryController {
	
	@Autowired
	GalleryService service;
	
	// JSP에서는 req.getServletContext 로 얻음
	// 스프링응 @이용 어플리케이션 객체(빈에 자동등록되어 있다.). 아래의 image 메서드에서 사용됨
	@Autowired
	ServletContext context;
	
	
	/**목록보기 /list*/
	@RequestMapping(value="list")
	public void list(
					@RequestParam(value="page", defaultValue="1") int page,
					@RequestParam(value="orderBy", defaultValue="gallery_id") String orderBy,
					Model model) throws Exception {
		
		// 목록 및 페이지 정보 추출
		model.addAllAttributes(service.getPage(page, orderBy));
		model.addAttribute("today", Util.getToday());
		
	}
	/** 새로운 data 추가할 때의 기본 골격 : 갤러리 추가하는 메서드 create*/
	@RequestMapping(value="create", method=RequestMethod.GET)
	public void createForm(Gallery gallery)throws Exception {
		
	}
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String createSubmit(@Valid Gallery gallery,
							BindingResult result)throws Exception {
		if(result.hasErrors()) {// 유효성 검사 실패
			return "gallery/create";
		}
		//유효성 검사 통과
		
		service.create(gallery);
		log.info(gallery.toString());//galleryId가 지정되어 있지 않다 seq를 통해 지정된다.

		return "redirect:/gallery/update/" + gallery.getGalleryId();
		
		// 리다이렉트 : 어디로 이동? 보통은 list로 이동.
		// gallery는 어디로? 이미지 추가 페이지로 이동
		// gallery id가 반드시 필요한데 현재는 알 수 없음(크기제한이 없기 때문에 따로 등록했음 SpringCommon의 gallery-mapper 참조)
		// mybatis-confing : jdbc의 기능 - userGeneratedKeys 자동으로 생성되는 key를 얻을 수 있도록 허용하겠다는 설정
		// gallery-mapper의 insert 부분 수정
	}
	
	/** update */
	@RequestMapping(value="/update/{galleryId}", method=RequestMethod.GET)
	public String updateForm(
			@PathVariable long galleryId, Model model, GalleryImage image) throws Exception {
		// gallery_id로 꺼내서 model에 담고 update.jsp에서 수정화면 만들기
		Gallery gallery = service.findById(galleryId);
		log.info(image.toString());
		model.addAttribute("gallery", gallery);
		
		return "gallery/update";
		
	}
	// {galleryId}는 url에서 받아온다. update.jsp에서 action 파트가 빠져있다.
	// 이 때문에 get과 post는 같은 url을 사용한다.
	// form의 action태그 :폼 데이터가 전송되는 백엔드 url
	/**form라이브러리의 action 파트에 url을 지정하지 않으면 form태그라이브러리에서 자동으로 현재 url을 action파트에 지정해준다.
	 * 이미 gallery에 galleryId가 폼태그에 의해 저장되어 있으므로 따로 @PathVarialble 을 사용할 필요가 없다.
	 * 위의 updatForm에는 어노테이션을 사용하여 변수로 받아줘야한다.*/
	@RequestMapping(value="/update/{galleryId}", method=RequestMethod.POST)
	public String updateSubmit(@Valid Gallery gallery,
								BindingResult result) throws Exception {
		if(result.hasErrors()) {// 유효성검사실패
			return "gallery/update";
		}
		
		//유효성 검사 통과
		service.update(gallery);
		return "redirect:/gallery/update/" + gallery.getGalleryId();
	}
	
	/**add_image*/
	@RequestMapping(value="/update/add_image", method=RequestMethod.POST)
	public String addImageSubmit(GalleryImage image,
			// 업로드된 정보가 imageFile객체에 담기게 되고 이것을 가지고 업로드된 파일을 조작할 수 있음
			@RequestParam("file") MultipartFile imageFile) throws Exception {
		//log.info(image.toString());
		
		// 파일업로드
		uploadImage(image, imageFile);
		
		/**gallery-mapper> GalleryDao >GalleryService & Impl 등록하고 addImage사용*/
		service.addImage(image);
		//db저장
		return "redirect:/gallery/update/" + image.getGalleryId();
		
	}
	
	/**단일 파일 업로드 처리시 사용 // MultipartFile 사용*/
	
	private void uploadImage(GalleryImage image, MultipartFile imageFile) throws Exception {
		//원본 이미지 파일명
		String fname = imageFile.getOriginalFilename();
		//서버에서의 이미지 파일명 (타임스탬프 추가)
		long timestamp=System.currentTimeMillis();
		String serverFileName =  timestamp + "_" + fname;
		
		//업로드 파일 재배치
		File dest =  new File("c:/temp/upload/" + serverFileName);
		imageFile.transferTo(dest);//내가원하는 위치로 파일 이동하는 MultipartFile의 메서드
		
		// 썸네일 이미지 생성 : SpringCommon프로젝트 >util패키지
		ImageUtil.saveThumb(dest);
		
		//GalleryImage 정보 설정
		image.setFileName(fname);
		image.setServerFileName(serverFileName);
	}
	
	/**다중파일 업로드 : add_images // MultipartHttpServletRequest 사용*/
	@RequestMapping(value="/update/add_images", method=RequestMethod.POST)
	public String addImagesSubmit(GalleryImage image,
				MultipartHttpServletRequest request) throws Exception {
		// 여기서 request는 MultipartHttpServletRequest의 req임
		List<MultipartFile> fileList = request.getFiles("files");
		
		for(MultipartFile imageFile : fileList) {
			uploadImage(image, imageFile); service.addImage(image);
		}
		return "redirect:/gallery/update/" + image.getGalleryId();
	}
	
	
	//view는 post가 없다 보여주기만 하면됨 위의 updateForm과 updateSubmit과의 차이점!
	/**gallery view*/
	@RequestMapping(value="/view/{galleryId}", method=RequestMethod.GET)
	public String view (
						@PathVariable long galleryId,
						@RequestParam(value="page", defaultValue="1") int page,
						Model model) throws Exception {
		
		//gallery 찾기
		Gallery gallery = service.findById(galleryId);
		//모델에 gallery, page라는 키값으로 gallery, page 저장
		model.addAttribute("gallery", gallery);
		model.addAttribute("page", page);
		
		return "gallery/view";
	}
	
	// a태그, 일반적인 것은 (GET) / 자바스크립트,폼(POST)
	/**image 보여줌 : 원본 추출 + 썸네일 추출 mode로 받아서 둘다 처리하기*/
	@RequestMapping(value="/{mode}/{imageId}", method=RequestMethod.GET)
	public String image (
						@PathVariable String mode,
						@PathVariable long imageId,
						Model model) throws Exception {
		// galleryImage 필요(mapper에 만들기 : getImage )
		GalleryImage image = service.getImage(imageId);
		
		// 서버의 파일명 
		String path = "c:/temp/upload/";
		if(mode.equals("thumb")) {
			path+="thumb/";
			
		}
		path+=image.getServerFileName();
		/**위에서 @Autowired 로 context를 얻고 어플리케이션 객체의getMimeType메서드를 이용*/
		String type = context.getMimeType(path);	// 파일의 Mimetype(컨텐트에 대한 정보ex. byte, jpg, png 등등) 문자열
		
		// 모델에 받기
		model.addAttribute("path", path);
		model.addAttribute("type", type);
		
		return "fileView";// 컨트롤러의 역할: 필요한 정보를 찾아내서 뷰로 넘김
		// 여기서 return 값은 jsp의 이름이 아니라 사용자 정의 뷰의 이름임
		
		}
	
	/**파일 다운로드*/
	@RequestMapping(value="/download/{imageId}", method=RequestMethod.GET)
	public String download(@PathVariable long imageId,
							Model model) throws Exception {
		
		GalleryImage image = service.getImage(imageId);
		String path = "c:/temp/upload/" + image.getServerFileName();
		String fileName = image.getFileName();
		String type = context.getMimeType(path);
		// 파일명이 이미 정해져있음 (서버와 원본의 파일명이 모두 필요함)
		model.addAttribute("path", path);
		model.addAttribute("fileName", fileName);
		model.addAttribute("type", type); //컨텐트 타입으로 설정
		
		return "download"; // 사용자 정의 view만들기
		}

}
