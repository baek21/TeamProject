package poly.service.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;

import poly.dto.LoadShelterDTO;
import poly.persistance.mapper.ILoadShelterMapper;
import poly.service.ILoadShelterService;
import poly.util.CmmUtil;
import poly.util.DateUtil;

@Service("LoadShelterService")
public class LoadShelterService implements ILoadShelterService {
		
	//로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="LoadShelterMapper")
	private ILoadShelterMapper loadShelterMapper;

	/**
	 * 공공데이터API에서 지진 옥외대피장소 정보 가져와서 저장하기
	 */
	@Override
	public int insertShelterInfo() throws Exception {
		
		// 로그 찍기
		log.info(this.getClass().getName() + ".insertShelterInfo start!");
		
		int res = 0; // API 정보 얻어오기 결과(0보다 크면 성공)
				
		int i = 0;
		while(true){
			
			// 공공데이터API 지진 옥외대피장소 정보 가져오기
		    HttpResponse<String> apiData = Unirest.get("http://apis.data.go.kr/1741000/EmergencyAssemblyArea_Earthquake/getAreaList?serviceKey=-------------&type=json&flag=Y&pageNo="+(i+1)+"&numOfRows=1000")
		    		.asString();
		    
		    JsonObject result_object = (JsonObject) JsonParser.parseString(apiData.getBody());
		    
		    // API 총 결과 수(head부분. 옥외대피장소 정보의 총 개수.)
		    int totalCount = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(0).getAsJsonObject().get("head").getAsJsonArray().get(0).getAsJsonObject().get("totalCount").getAsInt();
		    log.info("API 총 결과 수 : " + totalCount);
		    
		    // 요청한 페이지의 결과 수 (head부분. API요청할 때 입력한 한 페이지 결과 수.)
		    int numOfRows = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(0).getAsJsonObject().get("head").getAsJsonArray().get(1).getAsJsonObject().get("numOfRows").getAsInt();
		    log.info("요청한 페이지 결과 수 : " + numOfRows);
		    
		    // 불러온 페이지의 실제 결과 수(.size())(API에서 불러온 EarthquakeOutdoorsShelter의 row 실제 개수. numOfRows와 다른 것임.)
		    int rowCount = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().size();
		    log.info("불러온 페이지 결과 수 : " + rowCount);
		    
		    LoadShelterDTO pDTO = null;
		    
		    // 시도명 영문코드 입력을 위한 함수
		    String ctprvn_nm_code = null;
		    
		    int k = 0;
			while(k<rowCount) {
				
				// 경도
				String xcord = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("xcord").getAsString();
				// 위도
				String ycord = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("ycord").getAsString();
				// 시도명
				String ctprvn_nm = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("ctprvn_nm").getAsString();
				// 시군구명
				String sgg_nm = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("sgg_nm").getAsString();
				// 시설명
				String vt_acmdfclty_nm = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("vt_acmdfclty_nm").getAsString();
				// 상세주소
				String dtl_adres = result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("dtl_adres").getAsString();
				// 시설면적(제곱미터)
				String fclty_ar = Integer.toString(result_object.get("EarthquakeOutdoorsShelter").getAsJsonArray().get(1).getAsJsonObject().get("row").getAsJsonArray().get(k).getAsJsonObject().get("fclty_ar").getAsInt());
				// 시도명 영문코드 입력
				switch(ctprvn_nm) {
				case "강원도" : ctprvn_nm_code = "gwn"; break;
				case "경기도" : ctprvn_nm_code = "gyg"; break;
				case "경상남도" : ctprvn_nm_code = "gyn"; break;
				case "경상북도" : ctprvn_nm_code = "gyb"; break;
				case "광주광역시" : ctprvn_nm_code = "gwj"; break;
				case "대구광역시" : ctprvn_nm_code = "dgu"; break;
				case "대전광역시" : ctprvn_nm_code = "djn"; break;
				case "부산광역시" : ctprvn_nm_code = "bsn"; break;
				case "서울특별시" : ctprvn_nm_code = "seo"; break;
				case "세종특별자치시" : ctprvn_nm_code = "sej"; break;
				case "울산광역시" : ctprvn_nm_code = "uls"; break;
				case "인천광역시" : ctprvn_nm_code = "ich"; break;
				case "전라남도" : ctprvn_nm_code = "jnm"; break;
				case "전라북도" : ctprvn_nm_code = "jbk"; break;
				case "제주특별자치도" : ctprvn_nm_code = "jej"; break;
				case "충청남도" : ctprvn_nm_code = "chn"; break;
				case "충청북도" : ctprvn_nm_code = "chb"; break;
				default: ctprvn_nm_code = "exs";
				}
								
				// 수집한 정보를 DTO에 저장하기 위해 메모리에 올리기
				pDTO = new LoadShelterDTO();
				
				pDTO.setXcord(CmmUtil.nvl(xcord));
				pDTO.setYcord(CmmUtil.nvl(ycord));
				pDTO.setCtprvn_nm(CmmUtil.nvl(ctprvn_nm));
				pDTO.setCtprvn_nm_code(CmmUtil.nvl(ctprvn_nm_code));
				pDTO.setSgg_nm(CmmUtil.nvl(sgg_nm));
				pDTO.setVt_acmdfclty_nm(CmmUtil.nvl(vt_acmdfclty_nm));
				pDTO.setDtl_adres(CmmUtil.nvl(dtl_adres));
				pDTO.setReg_id("admin");
				pDTO.setFclty_ar(CmmUtil.nvl(fclty_ar));
				
				res += loadShelterMapper.insertShelterInfo(pDTO);
				
				log.info("데이터 저장 완료 : " + (i+1) + "페이지" + (k+1) + "번째값");
				
				k++;
				
			}
				
			i++;
				
			if(numOfRows*i >= totalCount) {
				pDTO = null; // 사용이 끝난 pDTO 메모리에서 정리
				break;
			}
		}
		
		// Unirest 종료
		Unirest.shutdown();
		
		// 로그 찍기
		log.info(this.getClass().getName() + ".insertShelterInfo end!");
		
		return res;
	}
	
}
