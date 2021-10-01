<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@include file="/WEB-INF/view/user/session.jsp" %>
<%
NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");

//공지글 정보를 못불러왔다면, 객체 생성
if (rDTO==null){
	rDTO = new NoticeDTO();

}

String SS_USER_ID = CmmUtil.nvl((String)session.getAttribute("SS_USER_ID"));

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
int edit = 1;

//로그인 안했다면....
if (SS_USER_ID.equals("")){
	edit = 3;
	
//본인이 작성한 글이면 2가 되도록 변경
}else if (SS_USER_ID.equals(CmmUtil.nvl(rDTO.getUser_id()))){
	edit = 2;
	
}

System.out.println("user_id : "+ CmmUtil.nvl(rDTO.getUser_id()));
System.out.println("SS_USER_ID : "+SS_USER_ID);

%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Bootstrap core CSS -->
	<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/vendor/bootstrap/css/home.css" rel="stylesheet">

	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글보기</title>
<%@include file="/WEB-INF/view/header.jsp" %>
<script type="text/javascript">

//수정하기
function doEdit(){
	if ("<%=edit%>"==2){
		location.href="/notice/NoticeEditInfo.do?nSeq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>";
		
	}else if ("<%=edit%>"==3){
		alert("로그인 하시길 바랍니다.");
		
	}else {
		alert("본인이 작성한 글만 수정 가능합니다.");
		
	}
}


//삭제하기
function doDelete(){
	if ("<%=edit%>"==2){
		if(confirm("작성한 글을 삭제하시겠습니까?")){
			location.href="/notice/NoticeDelete.do?nSeq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>";
			
		}
		
	}else if ("<%=edit%>"==3){
		alert("로그인 하시길 바랍니다.");
		
	}else {
		alert("본인이 작성한 글만 삭제 가능합니다.");
		
	}
}
//목록으로 이동
function doList(){
	location.href="/notice/NoticeList.do";
		
}

</script>	
</head>
<body>
	<div class="container" style="text-align:center; margin-top: 20px; margin-bottom: 20px;">
      <div class="row">
        <div class="col-12">
	        <ul class="list-group list-group-horizontal-sm">
				  <li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">제목</li>
				  <li class="list-group-item" style="width:87.5%; text-align:left;"><%=CmmUtil.nvl(rDTO.getTitle())%></li>
				  
			</ul>
			<ul class="list-group list-group-horizontal">
				<li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">작성자</li>
				<li class="list-group-item" style="width:12.5%;"><%=CmmUtil.nvl(rDTO.getUser_id())%></li>
				<li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">등록일</li>
				<li class="list-group-item" style="width:12.5%;"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></li>
				<li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">수정일</li>
				<li class="list-group-item" style="width:12.5%;"><%=CmmUtil.nvl(rDTO.getChg_dt()) %></li>
				<li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">조회수</li>
				<li class="list-group-item" style="width:12.5%;"><%=CmmUtil.nvl(rDTO.getRead_cnt())%></li>
			</ul>
			<ul class="list-group list-group-horizontal-sm">
			<li class="list-group-item" style="text-align:left; width:100%; height: 600px">
				<%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
			</li>
			</ul>
        </div>
      </div>
    </div>
    <div class="container" style="text-align:center; margin-top: 20px; margin-bottom: 20px;">
      <div class="row">
        <div class="col-12">
          <div>
            <a href="javascript:doEdit();"><button type="submit" class="btn btn-outline-dark">수정</button></a>
			<a href="javascript:doDelete();"><button type="reset" class="btn btn-outline-dark">삭제</button></a>
			<a href="javascript:doList();"><button type="reset" class="btn btn-outline-dark">목록</button></a>
          </div>
        </div>
      </div>
    </div>
</body>
</html>