package poly.service;

import java.util.Map;

import poly.dto.GetShelterStatDTO;

public interface IGetShelterStatService {

	/**
	 * openAPI 서버로부터 전달 받은 jSON 데이터
	 * 지진 옥외대피장소 정보 가져오기
	 */
	Map<String, Object> getShelterStatForJSON(GetShelterStatDTO pDTO) throws Exception;
	
}
