package poly.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import poly.dto.GetShelterStatDTO;
import poly.service.IGetShelterStatService;
import poly.util.CmmUtil;
import poly.util.DateUtil;

@Service("GetShelterStatService")
public class GetShelterStatService implements IGetShelterStatService {
		
	//로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());

	/**
	 * JSON 결과를 받아오기 위한 함수
	 * URL을 파라미터로 전달하면, 자동으로 JSON 결과를 String 변수에 저장하고 결과값 반환
	 *
	 * @param 호출URL
	 * @return JSON 결과
	 */
	private String getUrlForJSON(String callUrl) {
				
		log.info(this.getClass().getName() + ".getUrlForJSON start");
		log.info("Requested URL : " + callUrl);
		
		StringBuilder sb = new StringBuilder();
		URLConnection urlConn = null;
		InputStreamReader in = null;
		
		// json 결과값이 저장되는 변수
		String json = "";
		
		// SSL 적용된 사이트일 경우, 데이터 증명을 위해 사용
		HostnameVerifier allHostsValid = new HostnameVerifier() {
			@Override
			public boolean verify(String hostname, SSLSession session) {
				return true;
			}
		};
		HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
		
		try {
			
			// 웹 사이트 접속을 위한 URL 파싱
			URL url = new URL(callUrl);
			
			// 접속
			urlConn = url.openConnection();
			
			// 접속하면, 응답을 60초(60 * 1000ms)동안 기다림
			if(urlConn != null) {
				urlConn.setReadTimeout(60 * 1000);
			}
			if(urlConn != null && urlConn.getInputStream() != null) {
				in = new InputStreamReader(urlConn.getInputStream(), Charset.forName("UTF-8"));
				
				BufferedReader bufferedReader = new BufferedReader(in);
				
				// 주어진 문자 입력 스트림 inputStream에 대해 기본 크기의 버퍼를 갖는 객체를 생성.
				if(bufferedReader != null) {
					int cp;
					while((cp = bufferedReader.read()) != -1) {
						sb.append((char) cp);
					}
					bufferedReader.close();
				}
						
			}
			in.close();
		} catch(Exception e) {
			throw new RuntimeException("Exception URL : " + callUrl, e);
		}
		
		json = sb.toString(); // json 결과 저장
		
		log.info(this.getClass().getName() + ".getUrlForJSON end!");
		
		return json;
	}
	
	/**
	 * 지진 옥외대피장소 정보 가져오기
	 * @param pDTO 지진 옥외대피장소 정보 가져오기 위한 파라미터들
	 * @return json 결과를 Map 형태로 변환 결과
	 */
	@Override
	public Map<String, Object> getShelterStatForJSON(GetShelterStatDTO pDTO) throws Exception {
		// 로그 찍기
		log.info(this.getClass().getName() + ".getShelterStatForJSON start!");
		
		// JSON 읽은 값을 Controller에 전달하기 위한 결과 변수
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		// JSON 결과 받아오기
		String json = getUrlForJSON(CmmUtil.nvl(pDTO.getUrl()));
		
		pDTO = null; // 사용이 끝난 pDTO 메모리에서 정리
		
		// String 변수의 문자열을 json 형태의 데이터 구조로 변경하기 위한 객체를 메모리에 올림
		JSONParser parser = new JSONParser();
		
		// String 변수의 문자열을 json 형태의 데이터 구조로 변경하기 위해 자바 최상위 Object 변화
		Object obj = parser.parse(json);
		
		// 변환된 Object 객체를 json 데이터 구조로 변경
		JSONObject jsonObject = (JSONObject) obj;
		
		// 요청한 파라미터 가져오기
		String reqCTPRVN_NM_CODE = CmmUtil.nvl((String) jsonObject.get("reqCTPRVN_NM_CODE"));
		log.info("reqCTPRVN_NM_CODE : " + reqCTPRVN_NM_CODE);
		
		rMap.put("reqCTPRVN_NM_CODE", reqCTPRVN_NM_CODE); // 데이터 저장
		
		// 요청한 파라미터 가져오기
		String recordCNT = CmmUtil.nvl((String) jsonObject.get("recordCNT").toString());
		log.info("recordCNT : " + recordCNT);
		
		rMap.put("recordCNT", recordCNT); // 데이터 저장
		
		// json에 저장된 배열형태 데이터
		JSONArray resArr = (JSONArray) jsonObject.get("result");
		
		// JSON 배열에 저장된 데이터를 List<GetShelterStatDTO> 구조로 변경하기 위해 메모리에 올림
		List<GetShelterStatDTO> rList = new ArrayList<GetShelterStatDTO>();
		
		// 각 레코드마다 DTO로 저장
		GetShelterStatDTO rDTO = null;
		
		int i = 0;
		while(i<resArr.size()) {
			JSONObject result = (JSONObject) resArr.get(i);
			
			rDTO = new GetShelterStatDTO(); // 데이터 저장을 위해 메모리 올림
		
			// json 데이터를 dto에 저장
			rDTO.setUrl("");
			rDTO.setCtprvn_nm(CmmUtil.nvl((String)result.get("ctprvn_nm")));
			rDTO.setSgg_nm(CmmUtil.nvl((String)result.get("sgg_nm")));
			rDTO.setVt_acmdfclty_nm(CmmUtil.nvl((String)result.get("vt_acmdfclty_nm")));
			rDTO.setDtl_adres(CmmUtil.nvl((String)result.get("dtl_adres")));
			rDTO.setXcord(CmmUtil.nvl((String)result.get("xcord")));
			rDTO.setYcord(CmmUtil.nvl((String)result.get("ycord")));
			rDTO.setChg_dt(CmmUtil.nvl((String) result.get("chg_dt")).substring(0, 10));
			rDTO.setCtprvn_nm_code(CmmUtil.nvl((String)result.get("ctprvn_nm_code")));
			rDTO.setFclty_ar(CmmUtil.nvl((String)result.get("fclty_ar")));
			
			// 저장된 DTO를 list에 저장
			rList.add(rDTO);
			
			rDTO = null; // 사용이 끝난 rDTO 메모리에서 정리
			
			i++;
		}
		log.info("rDTO를 rList에 저장 : 총 " + resArr.size() + "개 값 중 " + rList.size() + "개 값 저장 완료");
		
		// rList를 rMap에 넣어주기
		rMap.put("res", rList);
		
		rList = null; // 사용이 끝난 rList 메모리에서 정리
		
		// 로그
		log.info(this.getClass().getName() + ".getShelterStatForJSON end!");

		return rMap;
	}
	
}