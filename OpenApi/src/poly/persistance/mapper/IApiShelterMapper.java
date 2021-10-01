package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.ApiShelterDTO;

@Mapper("ApiShelterMapper")
public interface IApiShelterMapper {
	
	// 조회할 지진 옥외대피장소 정보
	List<ApiShelterDTO> getShelterInfo(ApiShelterDTO pDTO) throws Exception;

}
