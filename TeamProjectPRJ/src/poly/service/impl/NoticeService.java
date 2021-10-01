package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.INoticeMapper;
import poly.service.INoticeService;

//@Service 반드기 기입.
@Service("NoticeService")
public class NoticeService implements INoticeService {
/*
 *Service는 Controller에서 자신을 찾을 수 있도록 반드시 자신의 이름을 기입함.
 *또한 반드시 자기이름 앞에 I(인터페이스의 약자)를 붙인 인터페이스를 생성하고 구현(implements)를 함.
 */
	
	@Resource(name="NoticeMapper")
	private INoticeMapper noticeMapper;
	//Service에서 Mapper 호출을 위한 객체를 '인터페이스'로 메모리에 생성.

	
	@Override
	public List<NoticeDTO> getNoticeList() throws Exception {
		return noticeMapper.getNoticeList();
		
	}//게시판 리스트 가져오는 URL 호출과 같이 결과 값을 가져오는 경우 List<DTO> 형태로 결과 받음.


	@Override
	public void InsertNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.InsertNoticeInfo(pDTO);
		
	}//게시판 등록, 수정, 삭제와 같이 결과 값이 없는 경우는 void 선언.

	@Override
	public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {
		return noticeMapper.getNoticeInfo(pDTO);
		
	}//게시판 상세 정보를 가져오는 URL 호출과 같이 결과 값을 가져오는 경우 DTO 형태로 결과 받음.


	@Override
	public void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception {
		noticeMapper.updateNoticeReadCnt(pDTO);
		
	}

	@Override
	public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.updateNoticeInfo(pDTO);
		
	}

	@Override
	public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.deleteNoticeInfo(pDTO);
		
	}

}