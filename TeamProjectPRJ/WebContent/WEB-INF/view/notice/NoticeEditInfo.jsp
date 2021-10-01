<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%
NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");

//공지글 정보를 못불러왔다면, 객체 생성
if (rDTO==null){
	rDTO = new NoticeDTO();

}

int access = 1; //(작성자 : 2 / 다른 사용자: 1) 

if (CmmUtil.nvl((String)session.getAttribute("SS_USER_ID")).equals(
		CmmUtil.nvl(rDTO.getUser_id()))){
	access = 2;
}
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap core CSS -->
	<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/vendor/bootstrap/css/home.css" rel="stylesheet">

	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<title>게시판 글쓰기</title>
<%@include file="/WEB-INF/view/header.jsp" %>
<script type="text/javascript">

//작성자 여부체크
function doOnload(){
	
	if ("<%=access%>"=="1"){
		alert("작성자만 수정할 수 있습니다.");
		location.href="/notice/NoticeList.do";
		
	}
}

//전송시 유효성 체크
function doSubmit(f){
	if(f.title.value == ""){
		alert("제목을 입력하시기 바랍니다.");
		f.title.focus();
		return false;
	}
	
	if(calBytes(f.title.value) > 200){
		alert("최대 200Bytes까지 입력 가능합니다.");
		f.title.focus();
		return false;
	}	
	
	var noticeCheck = false; //체크 여부 확인 변수
	for(var i=0;i<f.noticeYn.length;i++){
		if (f.noticeYn[i].checked){
			noticeCheck = true;
		}
	}
	
	if(noticeCheck==false){
		alert("공지글 여부를 선택하시기 바랍니다.");
		f.noticeYn[0].focus();
		return false;
	}	
	
	if(f.contents.value == ""){
		alert("내용을 입력하시기 바랍니다.");
		f.contents.focus();
		return false;
	}	
	
	if(calBytes(f.contents.value) > 4000){
		alert("최대 4000Bytes까지 입력 가능합니다.");
		f.contents.focus();
		return false;
	}
	
	/* Checked Values */
	var noticeYn_value = $('input[name="noticeYn"]:checked').val();
	var user_id = "<%=CmmUtil.nvl(rDTO.getUser_id())%>";
	if(noticeYn_value == "1"){
		if(user_id != "admin"){
			alert("공지글 등록에 대한 권한이 없습니다.");
			return false;
		}

	}
	
}

//글자 길이 바이트 단위로 체크하기(바이트값 전달)
function calBytes(str){
	
	var tcount = 0;
	var tmpStr = new String(str);
	var strCnt = tmpStr.length;

	var onechar;
	for (i=0;i<strCnt;i++){
		onechar = tmpStr.charAt(i);
		
		if (escape(onechar).length > 4){
			tcount += 2;
		}else{
			tcount += 1;
		}
	}
	
	return tcount;
}


</script>	
</head>
<body onload="doOnload();">

<form name="f" method="post" action="/notice/NoticeUpdate.do" onsubmit="return doSubmit(this);">

<input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
	<div class="container" style="text-align:center; margin-top: 20px; margin-bottom: 20px;">
      <div class="row">
        <div class="col-12">
	        <ul class="list-group list-group-horizontal-sm">
				  <li class="list-group-item" style="width:12.5%; background-color:#E5F6FD;">제목</li>
				  <li class="list-group-item" style="width:87.5%; text-align:left;"><input type="text" name="title" maxlength="100" value="<%=CmmUtil.nvl(rDTO.getTitle()) %>" style="width: 100%; height: auto;"/></li>
				  
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
			
			<ul class="list-group list-group-horizontal">
				<li class="list-group-item" style="width: 12.5%; background-color:#E5F6FD;">공지글 여부</li>
				<li class="list-group-item" style="width: 25%;">
					예<input type="radio" id="noticeYn_y" name="noticeYn" value="1" />
					아니오<input type="radio" id="noticeYn_n" name="noticeYn" value="2" checked="checked"/>
				</li>
			</ul>
			
			<ul class="list-group list-group-horizontal-sm">
				<li class="list-group-item" style="width:100%; height: 600px">
					<textarea name="contents" style="width: 100%; height: 100%; resize:none;overflow:auto;"><%=CmmUtil.nvl(rDTO.getContents()) %></textarea>
				</li>
			</ul>
        </div>
      </div>
    </div>
    <div class="container" style="text-align:center; margin-top: 20px; margin-bottom: 20px;">
      <div class="row">
        <div class="col-12">
          <div>
            <button type="submit" class="btn btn-outline-dark" >수정</button>
			<button type="reset" class="btn btn-outline-dark">다시작성</button>
			
          </div>
        </div>
      </div>
    </div>
   
</form>	
</body>
</html>