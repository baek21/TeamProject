package poly.util;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateUtil {

	/**
	 * 날짜, 시간 출력하기
	 * @param fm 날짜 출력 형식
	 * @return
	 */
	public static String getDateTime(String fm){
		
		Date today = new Date();
		System.out.println(today);
		
		SimpleDateFormat date = new SimpleDateFormat(fm);
		
		return date.format(today);
		
	}
	/**
	 * 날짜, 시간 출력하기
	 * @return 기본값은 년.월.일
	 */
	public static String getDateTime() {
		return getDateTime("yyyy.MM.dd");
	}
	
	/**
	 * 현재시스템 날짜 가져오기(String으로)
	 * java.time패키지
	 */
	public static String getDate() {
		LocalDate today = LocalDate.now();
		DateTimeFormatter dtfm = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		return today.format(dtfm);
	}
}
