package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.ApiShelterDTO;
import poly.service.IApiShelterService;
import poly.util.CmmUtil;

@Controller
public class ApiShelterController {

	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직
	 */
	@Resource(name = "ApiShelterService")
	private IApiShelterService apiShelterService;

	/**
	 * 지진 옥외대피장소 정보 조회를 위한 api
	 * 
	 * ResponseBody 어노테이션은 JSP로 값을 전달하지 않고, 바로 결과를 제공할때 사용한다.
	 * 일반적으로 Map 객체를 통해 return을 하면, JSON 형태로 변형되서 출력한다.
	 * ResponseBody를 사용하면, ModelMap 객체를 사용할 필요가 없다.
	 * 따라서 getShelterInfo 함수의 파라미터에서 ModelMap을 제외시킨다.
	 */
	@RequestMapping(value = "shelterInfo/getShelterInfo")
	@ResponseBody
	public Map<String, Object> getShelterInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info(this.getClass().getName() + ".getShelterInfo start!");
		
		// 처리 결과를 전달하기 위한 변수
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		// 시도명 영문코드
		String ctprvn_nm_code = CmmUtil.nvl(request.getParameter("ctprvn_nm_code"));
		
		// 지진 옥외대피장소 정보를 저장하기 위한 파라미터 저장하기
		ApiShelterDTO pDTO = new ApiShelterDTO();
		
		// 파라미터 없이 호출 → 전체 정보 전달
		// 파라미터 입력 후 호출 → 해당하는 정보 전달
		pDTO.setCtprvn_nm_code(ctprvn_nm_code);
		
		// 지진 옥외대피장소 정보 조회
		List<ApiShelterDTO> rList = apiShelterService.getShelterInfo(pDTO);
		
		// 참조형 변수는 무조건 오류 방지를 위해 널처리를 한다.
		if(rList == null) {
			rList = new ArrayList<ApiShelterDTO>();
			
		}
		
		rMap.put("reqCTPRVN_NM_CODE", ctprvn_nm_code); // 호출한 파라미터 : ctprvn_nm_code
		rMap.put("recordCNT", rList.size()); // 조회된 지진 옥외대피장소 정보 건수
		rMap.put("result", rList); // 조회된 지진 옥외대피장소 정보
		
		log.info("reqCTPRVN_NM_CODE : " + ctprvn_nm_code);
		log.info("recordCNT : " + rList.size());
		
		rList = null; // 사용이 끝난 rList 메모리에서 정리
		
		log.info(this.getClass().getName() + ".getShelterInfo end!");
		
		return rMap;
	}
	
	@RequestMapping(value = "index")
	public String index(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		return "index";
	}
}
