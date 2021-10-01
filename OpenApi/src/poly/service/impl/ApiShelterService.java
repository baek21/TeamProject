package poly.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.ApiShelterDTO;
import poly.persistance.mapper.IApiShelterMapper;
import poly.service.IApiShelterService;

@Service("ApiShelterService")
public class ApiShelterService implements IApiShelterService {
	
	@Resource(name="ApiShelterMapper")
	private IApiShelterMapper apiShelterMapper;
	
	//로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * 지진 옥외대피장소 정보 가져오기
	 */
	@Override
	public List<ApiShelterDTO> getShelterInfo(ApiShelterDTO pDTO) throws Exception {
		
		// 로그 찍기
		log.info(this.getClass().getName() + ".getShelterInfo start");
		
		// 데이터 조회
		List<ApiShelterDTO> rList = apiShelterMapper.getShelterInfo(pDTO);
		
		// 참조형 변수는 무조건 오류 방지를 위해 널처리를 한다.
		if(rList == null) {
			rList = new ArrayList<ApiShelterDTO>();
		}
		
		// 로그 찍기
		log.info(this.getClass().getName() + ".getShelterInfo end");
		
		return rList;
	}


}
