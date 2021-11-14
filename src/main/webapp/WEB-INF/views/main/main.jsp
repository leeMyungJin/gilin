<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<script type="text/javascript">

var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

var viewCount = 0; //전체 리스트 조회 카운팅
var pageCount = 12; //1페이지 단위
var chkChSeq = '';
var topSearch = "${topSearch}"; //Top 검색창으로 검색되어왔을경우

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'main');
	
	if(topSearch != ''){
		$('#topSearch').val(topSearch);
		$('#myChannelSection').hide();
		$('#topSearchDiv').addClass('expand');
		getAllChannelList();
		
	}else{
		getMyChannelList();
		getAllChannelList();
	}
	
}

//전체 체널 조회
function getAllChannelList(type){
	var search;
	if($("#mainSearch").val() == null || $("#mainSearch").val() == ''){
		search = $("#topSearch").val();
	}else{
		search = $("#mainSearch").val();
	}
	
	var param = {
			state : $("#channelState option:selected").val()
			, name : search
		};
		
	var innerHtml = '';
	$.ajax({
     type : 'POST',
     url : '/channel/getAllChannelList',
     dataType : null,
     data : param,
     success : function(result) {
     	console.log("getAllChannelList success");
     	console.log(viewCount);
     	
     	if(result.length > 0){
   			var maxLength = (viewCount+pageCount < result.length ? viewCount+pageCount : result.length);
   			for(var i=viewCount; i< maxLength ; i++){
   				if(result[i].finYn == 'Y'){
          			innerHtml +=(result[i].chOpenYn ? '<div class="flex_box expired" onClick="moveChannelDtl('+result[i].chSeq+');">' : '<div class="flex_box expired" onClick="showPop('+result[i].chSeq+');">');
          		}else{
          			innerHtml +=(result[i].chOpenYn ? '<div class="flex_box" onClick="moveChannelDtl('+result[i].chSeq+');">' : '<div class="flex_box" onClick="showPop('+result[i].chSeq+');">');
          		}
          			
   				innerHtml += '<div class="img_wrap">'+
   							'<img src="'+result[i].chImg+'" alt="">'+
  				                '</div>'+
  				                '<div class="txt_wrap">'+
  				                  '<p class="chn_tit">'+result[i].chName+'</p>'+
  				                  '<p class="chn_txt">'+result[i].chMemo+'</p>'+
  				                  '<div class="detail_info">'+
  				                    '<p class="budget">'+Number(result[i].fdSumAmt).toLocaleString('ko-KR')+'</p>'+
  				                    '<p class="dday">'+result[i].dDay+'</p>'+
  				                  '</div>'+
  				                '</div>'+
  				              '</div>';
            }

     		//더보기 활성화
     		if(viewCount+pageCount >= result.length){
     			$('#addViewBtn').hide();
     		}else{
     			$('#addViewBtn').show();
     		}
     		
     		//더보기이면 리스트 추가, 일반조회일 경우 리스트 교체
     		if(type == 'add'){
     			$('#allChannel').append(innerHtml);
     		}else{
     			$('#allChannel').html(innerHtml);
     		}
     		
          }else{
        	  //내 채널이 없을 경우
        	  innerHtml = '<p class="no-gallery">참여한 채널이 없습니다.</p>';	
        	  $('#allChannel').html(innerHtml);
        	  $('#addViewBtn').hide();
          }
     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function addViewChannel(){
	getAllChannelList('add');
	viewCount += pageCount;
}

//내 체널 조회
function getMyChannelList(){
	var param = {
		memberId 	: memberId
		, name : $("#mainSearch").val()
	};
	
	var innerHtml = '';
	if(memberId != null){
		$.ajax({
		     type : 'POST',
		     url : '/channel/getMyChannelList',
		     dataType : null,
		     data : param,
		     success : function(result) {
		     	console.log("getMyChannelList success");
		     	
		     	if(result.length > 0){
		          	for(var i =0; i<result.length; i++){
		          		if(result[i].finYn == 'Y'){
		          			innerHtml +=(result[i].chOpenYn ? '<div class="flex_box expired" onClick="moveChannelDtl('+result[i].chSeq+');">' : '<div class="flex_box expired" onClick="showPop('+result[i].chSeq+');">');
		          		}else{
		          			innerHtml +=(result[i].chOpenYn ? '<div class="flex_box" onClick="moveChannelDtl('+result[i].chSeq+');">' : '<div class="flex_box" onClick="showPop('+result[i].chSeq+');">');
		          		}
		          			
		   				innerHtml += '<div class="img_wrap">'+
						                  '<img src="'+result[i].chImg+'" alt="">'+
						                '</div>'+
						                '<div class="txt_wrap">'+
						                  '<p class="chn_tit">'+result[i].chName+'</p>'+
						                  '<p class="chn_txt">'+result[i].chMemo+'</p>'+
						                  '<div class="detail_info">'+
						                    '<p class="budget">'+Number(result[i].fdSumAmt).toLocaleString('ko-KR')+'</p>'+
						                    '<p class="dday">'+result[i].dDay+'</p>'+
						                  '</div>'+
						                '</div>'+
						              '</div>';
		          	}
		          	
		          }else{
		        	  //내 채널이 없을 경우
		        	  innerHtml = '<p class="no-gallery">참여한 채널이 없습니다.</p>';	
		          }
		     	
		    	$('#myChannel').html(innerHtml);
		     	
		     },
		     error: function(request, status, error) {
		     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		     }
		 }); 
		
	}else{
		innerHtml = '<p class="no-gallery">참여한 채널이 없습니다.</p>';	
		$('#myChannel').html(innerHtml);
	}

}


function moveChannelOpen(){
	if(sessionCheck(memberId, memberAuth, 'main') && memberId != 'null'){
		location.href="/channel/channelOpen";
	}else{
		alert("로그인이 필요한 서비스입니다.");
	}
}

function moveChannelDtl(chSeq){
	location.href="/channel/channel?chSeq="+chSeq;
}

function showPop(chSeq){
	$('#pass').val('');
	chkChSeq = chSeq;
	$('#passError').hide();
	$('#popChkPass').addClass('active');
}

//팝업 종료
function closePop(){
	$('.model').removeClass('active');
}

function chkPass(){
	var param = {
			chSeq : chkChSeq
			, pass : $('#pass').val()
		};
		
	var innerHtml = '';
	$.ajax({
     type : 'POST',
     url : '/channel/getChannelPassChk',
     dataType : null,
     data : param,
     success : function(result) {
     	console.log("getChannelPassChk success");
     	if(result == 'Y'){
     		moveChannelDtl(chkChSeq);
     	}else{
     		$('#passError').show();
     	}

     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function enterkey(type) {
    if (window.event.keyCode == 13) {
    	if(type == 'mainSearch'){
    		getMyChannelList();
    		getAllChannelList();
    		
    	}else if(type == 'chkPass'){
    		chkPass();
    	}
    }
}

</script>


<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>
  
  <div class="main">

  <section class="section01">
    <div class="inner">
      <h2>대학생 창업교육 개발 및 진행</h2>
      <div class="search">
        <input id="mainSearch" type="text" name="input" class="input" placeholder="채널 검색" onkeyup="enterkey('mainSearch');">
        <span class="material-icons-outlined search_icon" onClick="viewCount=0;getMyChannelList();getAllChannelList();">search</span>
        <div class="close"></div>
      </div>
    </div>

    <!-- section01 이미지 -->
    <img src="../img/section01_main_img.svg" alt="" class="section01_main_img"/>
    <img src="../img/section01_wheel_img.svg" alt="" class="section01_wheel_img wheel_img01">
    <img src="../img/section01_wheel_img.svg" alt="" class="section01_wheel_img wheel_img02">
    <img src="../img/section01_wheel_img.svg" alt="" class="section01_wheel_img wheel_img03">
    <img src="../img/section01_wheel_img.svg" alt="" class="section01_wheel_img wheel_img04">
  </section>

  <section id="myChannelSection" class="section02">
    <div class="inner">

      <div class="tit_wrap">
        <h3 class="tit">내가 참여한 채널</h3>
        <a href="javascript:void(0);" class="btn_style01" onClick="moveChannelOpen();"><span class="material-icons-outlined add">add</span>채널개설하기</a>
      </div>
      <div id="myChannel" class="flex_wrap gallery gall03">
      </div>
  </section>

  <section class="section03 whole_chn">
    <div class="inner">
      <div class="tit_wrap">
        <h3 class="tit">모든 채널</h3>
        <select id="channelState" onChange="viewCount=0;getAllChannelList();">
          <option value="all">전체</option>
          <option value="latest">최신순</option>
          <option value="open">진행중</option>
          <option value="fin">종료</option>
        </select>
      </div>
      <div id="allChannel" class="flex_wrap gallery gall04"></div>
      <a id="addViewBtn" href="javascript:void(0);" class="btn_style01 more" onClick="addViewChannel();">채널 더보기</a>

    <!-- 프로젝트 패스워드 모달 -->
    <div id="popChkPass" class="modal chn_pw_modal">
      <div class="modal_bg"></div>
      <div class="modal_cont flex_wrap">
        <span class="material-icons-outlined close_btn" onClick="closePop();">close</span>
        <p class="tit">채널 비밀번호 입력</p>
        <div class="input_wrap">
          <input id="pass" type="password" placeholder="숫자 4자리" maxlength="4" class="alert" onkeyup="enterkey('chkPass');">
          <p id="passError" class="input_alert">잘못된 비밀번호입니다</p>
        </div>

        <button class="btn_style01" onClick="chkPass();">채널입장</button>
      </div>
    </div>
  </section>
  </div>

	<%@ include file="../include/footer.jsp" %>



  <script>
    $(document).ready(function(){
      // section03 모달창 띄우기
      const sect03_gall = $('.section03.whole_chn .gallery .flex_box');
      for(let i=0;i<sect03_gall.length;i++){
        $(sect03_gall).attr('data-modal-link', `chn_pw_modal`).addClass('modal_btn');
      }
    });
  </script>

</body>
</html>
