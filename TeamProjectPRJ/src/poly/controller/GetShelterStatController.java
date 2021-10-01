package poly.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.GetShelterStatDTO;
import poly.service.IGetShelterStatService;
import poly.util.CmmUtil;

@Controller
public class GetShelterStatController {

	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직
	 */
	@Resource(name = "GetShelterStatService")
	private IGetShelterStatService getShelterStatService;
	
	/**
	 * JSON 결과를 받아오기 위한 함수
	 * 
	 * ResponseBody 어노테이션은 JSP로 값을 전달하지 않고, 바로 결과를 제공할때 사용한다.
	 * 일반적으로 Map 객체를 통해 return을 하면, JSON 형태로 변형되서 출력한다.
	 * ResponseBody를 사용하면, ModelMap 객체를 사용할 필요가 없다.
	 * 따라서 getShelterInfo 함수의 파라미터에서 ModelMap을 제외시킨다.
	 */
	@RequestMapping(value = "mainMap/getShelterStatForJSON")
	@ResponseBody
	public Map<String, Object> getShelterStatForJSON(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		log.info(this.getClass().getName() + ".getShelterStatForJSON start");
		
		// OpenAPI url
		String url = "http://localhost:9080/shelterInfo/getShelterInfo.do?1=1";
		
		// OpenAPI용 파라미터 받아오기
		String ctprvn_nm_code = CmmUtil.nvl(request.getParameter("ctprvn_nm_code")); // 시도명
		
		// ctprvn_nm_code에 값이 있다면
		if(ctprvn_nm_code.length() > 0) {
			url += "&ctprvn_nm_code=" + ctprvn_nm_code;
		}
		
		log.info("url : " + url);
		
		// OpenAPI 호출을 위한 파라미터 저장하기
		GetShelterStatDTO pDTO = new GetShelterStatDTO();
		pDTO.setUrl(url);
		
		// JSON으로부터 받은 결과를 자바에서 처리가능한 데이터 구조로 변경
		Map<String, Object> rMap = getShelterStatService.getShelterStatForJSON(pDTO);

		
		log.info(this.getClass().getName() + ".getShelterStatForJSON end");
		
		return rMap;
	}
	
	@RequestMapping(value = "mainMap/home")
	public String home(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		return "/mainMap/home";

	}
	
	
}