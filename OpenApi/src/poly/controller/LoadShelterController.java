package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.service.ILoadShelterService;

@Controller
public class LoadShelterController {

	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직
	 */
	@Resource(name = "LoadShelterService")
	private ILoadShelterService loadShelterService;

	/**
	 * 공공데이터api에서 지진 옥외대피장소 정보를 가져와서 저장하기 위한 URL 호출
	 */
	@RequestMapping(value = "loadShelter/loadShelterResult")
	public String apiShelterDataGet(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info(this.getClass().getName() + ".loadShelterInfo start!");

		int res = loadShelterService.insertShelterInfo();
		model.addAttribute("res", String.valueOf(res));

		log.info(this.getClass().getName() + ".loadShelterInfo end!");

		return "/loadShelter/loadShelterResult";

	}
	
}
