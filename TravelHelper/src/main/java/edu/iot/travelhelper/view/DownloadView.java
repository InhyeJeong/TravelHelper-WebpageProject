package edu.iot.travelhelper.view;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.propertyeditors.URLEditor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import edu.iot.common.util.FileUtil;


/**사용자 정의 뷰*/
@Component("download")
public class DownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> model,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String path = (String) model.get("path");
		String type = (String) model.get("type");
		String fileName =(String) model.get("fileName");
		fileName = URLEncoder.encode(fileName, "utf-8");//한글 처리
		
		File file = new File(path);
		
		// 응답 헤더 설정
		response.setContentType(type);
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition",
				"attachment; filename=\"" + fileName + "\";");// 키, 값(디폴트 파일명)
		
		// FileUtil에 copy메서드
		// 파일 경로를 복사해서 응답보내라는것.
		FileUtil.copy(path, response.getOutputStream());
	}
	
}
