package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;


public interface INoticeService {
//Service 자바파일명 앞에 I를 붙여서 새로 만듬.
	
	List<NoticeDTO> getNoticeList() throws Exception;
	
	void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;
	
	void updateNoticeInfo(NoticeDTO pDTO) throws Exception;
	
	void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

}
/*
 * Service에 생성된 함수 이름들이 모두 다 기입. Controller는 인터페이스에 있는 함수 명을 기반으로 실행됨.
 */
