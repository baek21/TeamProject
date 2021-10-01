package poly.persistance.mapper;

import config.Mapper;
import poly.dto.LoadShelterDTO;

@Mapper("LoadShelterMapper")
public interface ILoadShelterMapper {
	
	// 수집된 내용 DB에 등록
	int insertShelterInfo(LoadShelterDTO pDTO) throws Exception;
	
}
