package poly.service;

import java.util.List;

import poly.dto.ApiShelterDTO;

public interface IApiShelterService {
	
	// 조회할 지진 옥외대피장소 정보
	List<ApiShelterDTO> getShelterInfo(ApiShelterDTO pDTO) throws Exception;
	
}
