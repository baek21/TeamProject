<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/WEB-INF/view/user/session.jsp" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지진 옥외대피장소 지도</title>

	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<!-- Bootstrap core CSS -->
	<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/vendor/bootstrap/css/home.css" rel="stylesheet">

	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<!-- Bootstrap Navigation -->
	<%@include file="/WEB-INF/view/header.jsp" %>
	
	<!-- 지도 영역 생성 및 ajax로 정보 불러오기 시작-->
	<div id="map" style="position: relative; z-index:1; top: 0px; width: 100%; height: 824px; ">
		<div class="map_option" style="font-family: 'Noto Sans KR', sans-serif;">
			<!-- 옵션 -->
			<div class="container" style="position:absolute; z-index:2; top: 5px; left: 5px;">
				<div class="row">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						<input type="text" class="btn btn-light" value="" id="keyword" size="22" placeholder="키워드를 입력하세요"> 
						<button type="submit" class="btn btn-primary">검색</button>
					</form>
				</div>
				
				<div style="background-color:white; height:38px; border-radius: 5px; margin-left:5px;">
					<div class="btn outline">마커 표시 지역</div>					 
					<!-- 시도명 선택창 -->
					<select id="select_ctprvn_nm" class="btn btn-link" onchange="change_ctprvn_nm(this)">
						<option value="nodata">지역선택안함</option>
						<option value="">전국</option>
						<option value="gwn">강원도</option>
						<option value="gyg">경기도</option>
						<option value="gyn">경상남도</option>
						<option value="gyb">경상북도</option>
						<option value="gwj">광주광역시</option>
						<option value="dgu">대구광역시</option>
						<option value="djn">대전광역시</option>
						<option value="bsn">부산광역시</option>
						<option value="seo">서울특별시</option>
						<option value="sej">세종특별자치</option>
						<option value="uls">울산광역시</option>
						<option value="ich">인천광역시</option>
						<option value="jnm">전라남도</option>
						<option value="jbk">전라북도</option>
						<option value="jej">제주특별자치</option>
						<option value="chn">충청남도</option>
						<option value="chb">충청북도</option>
					</select>
					<div class="btn btn-outline">
					지형정보 보기 <input type="checkbox" id="chkTerrain" onclick="setOverlayMapTypeId()"/>
					</div>
				</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- 카카오 지도 API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=--------------&libraries=services,clusterer"></script>
	
	<script>
		var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center : new kakao.maps.LatLng(36.054722, 126.970833), // 지도의 중심좌표
	        level : 13 // 지도의 확대 레벨
	    });
		
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

		      	// 지도 중심을 이동 시킵니다
		        map.setCenter(locPosition);
		        // 지도를 1레벨 올립니다 (지도가 축소됩니다)
		        map.setLevel(4);
  
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
			alert('브라우저가 내 위치 찾기 기능을 지원하지 않습니다.');
		
		}
		
		var imageSrc = "/img/maker_image.png"; // 마커이미지의 주소입니다
		var imageSize = new kakao.maps.Size(40, 49.74); // 마커이미지의 크기입니다
		var imageOption = {offset: new kakao.maps.Point(21, 51)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 지도 타입 정보를 가지고 있을 객체입니다
		// map.addOverlayMapTypeId 함수로 추가된 지도 타입은 지형정보, 교통정보
		// 가장 나중에 추가된 지도 타입이 가장 앞에 표시됩니다
		var mapTypes = {
		    terrain : kakao.maps.MapTypeId.TERRAIN,   //지형정보
		    traffic :  kakao.maps.MapTypeId.TRAFFIC   //교통정보
		};

		// 체크 박스를 선택하면 호출되는 함수입니다
		function setOverlayMapTypeId() {
		    var chkTerrain = document.getElementById('chkTerrain');   
		    
		    // 지도 타입을 제거합니다
		    for (var type in mapTypes) {
		        map.removeOverlayMapTypeId(mapTypes[type]);    
		    }
		    
		    // 지형정보 체크박스가 체크되어있으면 지도에 지형정보 지도타입을 추가합니다
		    if (chkTerrain.checked) {
		        map.addOverlayMapTypeId(mapTypes.terrain);    
		    }		    
		}
		
		/* 키워드로 장소 검색하기 */
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
				
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

		    var keyword = document.getElementById('keyword').value;

		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch(keyword, placesSearchCB); 
		}

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === kakao.maps.services.Status.ERROR) {

		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}		
				
	    // 마커 클러스터러를 생성합니다
	    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
	    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다
	    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
	    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
	        minLevel: 3, // 클러스터 할 최소 지도 레벨
	        calculator: [10, 100, 1000, 10000], //클러스터 크기를 구분하는 값을 가진 배열 또는 구분값 생성함수
	        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
	    });
	    
	    // 마커 클러스터러에 클릭이벤트를 등록합니다
	    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
	    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
	    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
	
	        // 현재 지도 레벨에서 1레벨 확대한 레벨
	        var level = map.getLevel()-1;
	
	        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
	        map.setLevel(level, {anchor: cluster.getCenter()});
	    });

	    
		// select id="select_ctprvn_nm"에서 시도명을 선택했을 경우(onchange), change_ctprvn_nm 함수 실행
		// this값를 name값에 대입
		// value는 시도명의 3자리 영문코드
		function change_ctprvn_nm(name){
			
			if(name.value != ""){ // name의 value값이 공백(전국)이 아니라면			
				var codeRes = name.value; // value값을 ctprvn_code에 입력
			   	clusterer.clear(); // 기존 마커 제거
			} else{ // name의 value값이 공백(전국)이라면		
				var result = confirm("마커 클러스터의 생성 속도가 느려질 수 있습니다.\n계속 하시겠습니까?")
				if(result){
					var codeRes = name.value; // 가져오려는 API의 파라미터 ctprvn_nm_code에 공백을 넣으면 모든 데이터를 받음
				   	clusterer.clear(); // 기존 마커 제거
				} else{
					var codeRes = "nodata"; // 가져오려는 API의 파라미터 ctprvn_nm_code에 nodata라는 값은 없으므로 0건의 데이터를 받음
				}
			}
	
			// API에서 json형태의 데이터 받아오기
			$.ajax({
				url : "http://localhost:8090/mainMap/getShelterStatForJSON.do?",
				type : "GET",
				data : {ctprvn_nm_code: codeRes}, // API에 파라미터 ctprvn_nm_code의 특정 값(codeRes) 요청
				dataType : "json",
				success : function(data){
					console.log("불러온 정보 : " + data.res.length + "개");
					// 요청에 성공하면 DB에서 꺼낸 데이터를 json 형식으로 응답 받는다.
					// 마커들을 저장할 변수
					var markers = $(data.res).map(function(i, position) {
						
						// 데이터에서 좌표 값을 가지고 마커를 표시
				        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
						var marker = new kakao.maps.Marker({
							position : new kakao.maps.LatLng(position.ycord, position.xcord),
							image: markerImage
							
						});

						// 커스텀 오버레이에 표시할 컨텐츠 입니다
						var content = document.createElement('div');
						content.innerHTML =	'<div class="wrap">' +
												'<div class="info">' +
													'<div class="title" style="background-color:#94F8DE;">' +
														'상세정보'  +
													'</div>' +
													'<div class="body">' + 
										            	'<div class="desc">' + 
											            	'<div class="ellipsis">' +
											            	'주소 : ' + position.dtl_adres +
											            	'</div>' +
											            	'<div class="ellipsis">' +
											            		'시설명 : ' + position.vt_acmdfclty_nm +
											            	'</div>' +
											            	'<div class="ellipsis">' +
											            		'시설면적 : ' + position.fclty_ar + '㎡' +
											            	'</div>' +
											            	'<div style=" font-size: 10px; text-align: right; padding-right: 10px;">' +
											            		'정보 갱신일 : ' + position.chg_dt +
											            	'</div>' +
														'</div>' +
													'</div>'+
												'</div>' +    
											'</div>';
											
						// 마커 위에 커스텀오버레이를 표시합니다
						// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
						var overlay = new kakao.maps.CustomOverlay({
							content : content,
							clickable: true,
						    position : marker.getPosition()       
						});
						
						// 마커를 클릭했을 때 이벤트 등록
						kakao.maps.event.addListener(marker, 'click', function () {
							// 오버레이 표시
							overlay.setMap(map); 
							// 지도 중심을 부드럽게 이동시킵니다
						    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
						    var moveLatLon = new kakao.maps.LatLng(position.ycord, position.xcord);
						    map.panTo(moveLatLon);
						});
						
						// 커스텀오버레이를 클릭하면 오버레이가 제거됩니다
						content.onclick = function () {
							overlay.setMap(null);
						};
						
						return marker;
					});
					
					// 클러스터에 마커들을 저장합니다.
					clusterer.addMarkers(markers);
					console.log("마커 생성 완료");
										
				}, error : function(xhr, status, error){
					//요청에 실패하면 에러코드 출력  
					alert("에러코드 : " + xhr.status);
				}
			}); // ajax 끝
	    } // function change_ctprvn_nm(name) 끝
	</script>
	<!-- 지도 영역 생성 및 ajax로 정보 불러오기 끝 -->
	<footer style="position: relative; z-index:1; top: 13px; width:100%;">
		<div style="font-size: 11px; font-family: 'Noto Sans KR'; text-align:center;">
			이 사이트에서 사용된 이미지는 행정안전부에서 작성하여 공공누리 제 1유형으로 개방하였으며, 공공데이터포털(www.data.go.kr)에서 무료로 다운받으실 수 있습니다.
		</div>
	</footer>
</body>
</html>