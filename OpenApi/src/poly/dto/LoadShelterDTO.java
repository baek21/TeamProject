package poly.dto;

public class LoadShelterDTO {

	private String seq; // 순번
	private String ctprvn_nm; // 시도명
	private String sgg_nm; // 시군구명
	private String vt_acmdfclty_nm; // 시설명
	private String dtl_adres; // 상세주소
	private String xcord; // 경도
	private String ycord; // 위도
	private String reg_id; // 최초등록자
	private String reg_dt; // 최최등록일
	private String chg_id; // 최근수정자
	private String chg_dt; // 최근수정일
	private String ctprvn_nm_code; // 시도명 영문코드
	private String fclty_ar; // 시설면적(제곱미터)
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCtprvn_nm() {
		return ctprvn_nm;
	}
	public void setCtprvn_nm(String ctprvn_nm) {
		this.ctprvn_nm = ctprvn_nm;
	}
	public String getSgg_nm() {
		return sgg_nm;
	}
	public void setSgg_nm(String sgg_nm) {
		this.sgg_nm = sgg_nm;
	}
	public String getVt_acmdfclty_nm() {
		return vt_acmdfclty_nm;
	}
	public void setVt_acmdfclty_nm(String vt_acmdfclty_nm) {
		this.vt_acmdfclty_nm = vt_acmdfclty_nm;
	}
	public String getDtl_adres() {
		return dtl_adres;
	}
	public void setDtl_adres(String dtl_adres) {
		this.dtl_adres = dtl_adres;
	}
	public String getXcord() {
		return xcord;
	}
	public void setXcord(String xcord) {
		this.xcord = xcord;
	}
	public String getYcord() {
		return ycord;
	}
	public void setYcord(String ycord) {
		this.ycord = ycord;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getChg_id() {
		return chg_id;
	}
	public void setChg_id(String chg_id) {
		this.chg_id = chg_id;
	}
	public String getChg_dt() {
		return chg_dt;
	}
	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}
	public String getCtprvn_nm_code() {
		return ctprvn_nm_code;
	}
	public void setCtprvn_nm_code(String ctprvn_nm_code) {
		this.ctprvn_nm_code = ctprvn_nm_code;
	}
	public String getFclty_ar() {
		return fclty_ar;
	}
	public void setFclty_ar(String fclty_ar) {
		this.fclty_ar = fclty_ar;
	}
		
}
