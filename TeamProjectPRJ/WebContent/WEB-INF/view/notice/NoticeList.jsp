<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.NoticeDTO" %>
<%@ page import="java.util.List"%>   
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.HashMap"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<%		
		session.getAttribute("SS_USER_ID");
    	List<NoticeDTO> rList = (List<NoticeDTO>)request.getAttribute("rList");
		if(rList==null){
			rList = new ArrayList<NoticeDTO>();
		}
    	String pageName = "NoticeList";
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

<title>글쓰기</title>
<%@include file="/WEB-INF/view/header.jsp" %>
<script type="text/javascript">

//상세보기 이동
function doDetail(seq){
	location.href="/notice/NoticeInfo.do?nSeq="+ seq;
}
</script>	
</head>

<body>
	<div class="container" style="text-align:center; margin-top: 20px; margin-bottom: 20px;">
      <div class="row">
        <div class="col-12">
			<ul class="list-group list-group-horizontal" style="font-family: 'Noto Sans KR', sans-serif;">
				<li class="list-group-item" style="width:15%; background-color:#E5F6FD;">순번</li>
				<li class="list-group-item" style="width:40%; background-color:#E5F6FD;">제목</li>
				<li class="list-group-item" style="width:15%; background-color:#E5F6FD;">조회수</li>
				<li class="list-group-item" style="width:15%; background-color:#E5F6FD;">등록자</li>
		        <li class="list-group-item" style="width:15%; background-color:#E5F6FD;">등록일</li>
		    </ul>
			<%
				for (int i=0;i<rList.size();i++){
					NoticeDTO rDTO = rList.get(i);
				
					if (rDTO==null){
						rDTO = new NoticeDTO();
					}
				%>	
					
					<ul class="list-group list-group-horizontal">
					    <li class="list-group-item" style="width:15%;">
						    <%
								//공지글이라면, [공지]표시 
								if (CmmUtil.nvl(rDTO.getNotice_yn()).equals("1")){
									out.print("[공지]");
									
								//공지글이 아니라면, 글번호 보여주기 		
								}else{
									out.print(CmmUtil.nvl(rDTO.getNotice_seq()));
								}
							%>
						</li>
					    <li class="list-group-item" style="width:40%;">
					    	<a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getNotice_seq())%>');"><%=CmmUtil.nvl(rDTO.getTitle()) %></a>
					    </li>
					    <li class="list-group-item" style="width:15%;"><%=CmmUtil.nvl(rDTO.getRead_cnt()) %></li>
					    <li class="list-group-item" style="width:15%;"><%=CmmUtil.nvl(rDTO.getUser_id()) %></li>
					    <li class="list-group-item" style="width:15%;"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></li>
				 	</ul>
				<%
				}
			%>
        </div>
      </div>
    </div>

<center>
<a href="/notice/NoticeReg.do"><button type="button" class="btn btn-outline-dark">글쓰기</button></a>
</center>
</body>
</html>