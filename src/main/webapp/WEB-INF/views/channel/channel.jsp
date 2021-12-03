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
var chkPjSeq = ''; //선택 된 프로젝트

var chSeq = "${chSeq}"; //채널
var chFinYn = "${channelVo.finYn}"

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'channel');
	
	console.log("${channelVo}");
	console.log("${channelVo.dDayPercent}");
	
	//getChannelInfo();
	getMyProjectList();
	getAllProjectList();
	insertChannerVisitHist();
}

//체널방문 히스토리 저장
function insertChannerVisitHist(){
	console.log("memberId : "+memberId);
	
	var params = {
			chSeq : chSeq
			, cretId : (memberId == 'null' ? 'notLoginUser' : memberId)
	     	};
	  		
	$.ajax({
           url : '/channel/insertChannerVisitHist',
           async : false, // 비동기모드 : true, 동기식모드 : false
           type : 'POST',
           cache : false,
           dataType : null,
           data : params,
           success : function(data) {
        	   console.log(data);
           },
           error : function(request,status,error) {
             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
  	});
}

//전체 프로젝트 조회
function getAllProjectList(type){
	var param = {
			state : $("#projectState option:selected").val()
			, memberId 	: memberId
			, chSeq : chSeq
		};
		
	var innerHtml = '';
	$.ajax({
     type : 'POST',
     url : '/project/getAllProjectList',
     dataType : null,
     data : param,
     success : function(result) {
     	console.log("getAllProjectList success");
     	console.log(viewCount);
     	
     	if(result.length > 0){
   			var maxLength = (viewCount+pageCount < result.length ? viewCount+pageCount : result.length);
   			for(var i=viewCount; i< maxLength ; i++){
   				innerHtml += (result[i].fdYn == "Y" ? '<div class="flex_box complite" onClick="moveProjectDtl('+result[i].pjSeq+');">' : '<div class="flex_box" onClick="moveProjectDtl('+result[i].pjSeq+');">')+
			   				'<div class="img_wrap">'+
				              '<img src="'+result[i].pjImg+'" alt="">'+
				              '</div>'+
				              '<div class="txt_wrap">'+
				                '<p class="chn_tit">'+result[i].pjName+'</p>'+
				                '<p class="chn_txt">'+result[i].pjMemo+'</p>'+
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
     			$('#allProject').append(innerHtml);
     		}else{
     			$('#allProject').html(innerHtml);
     		}
     		
          }else{
        	  //내 채널이 없을 경우
        	  innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
        	  $('#allProject').html(innerHtml);
        	  $('#addViewBtn').hide();
          }
     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function addViewProject(){
	getAllProjectList('add');
	viewCount += pageCount;
}

//내 체널 조회
function getMyProjectList(){
	var param = {
		memberId 	: memberId
		, chSeq : chSeq
	};
	
	var innerHtml = '';
	if(memberId != null){
		$.ajax({
		     type : 'POST',
		     url : '/project/getMyProjectList',
		     dataType : null,
		     data : param,
		     success : function(result) {
		     	console.log("getMyProjectList success");
		     	
		     	if(result.length > 0){
		          	for(var i =0; i<result.length; i++){
		   				innerHtml += (result[i].fdYn == "Y" ? '<div class="flex_box complite" onClick="moveProjectDtl('+result[i].pjSeq+');">' : '<div class="flex_box" onClick="moveProjectDtl('+result[i].pjSeq+');">')+
		   								'<div class="img_wrap">'+
						                  '<img src="'+result[i].pjImg+'" alt="">'+
						                '</div>'+
						                '<div class="txt_wrap">'+
						                  '<p class="chn_tit">'+result[i].pjName+'</p>'+
						                  '<p class="chn_txt">'+result[i].pjMemo+'</p>'+
						                  '<div class="detail_info">'+
						                    '<p class="budget">'+Number(result[i].fdSumAmt).toLocaleString('ko-KR')+'</p>'+
						                    '<p class="dday">'+result[i].dDay+'</p>'+
						                  '</div>'+
						                '</div>'+
						              '</div>';
						              
		          	}
		          	
		          }else{
		        	  //내 채널이 없을 경우
		        	  innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
		          }
		     	
		    	$('#myProject').html(innerHtml);
		     	
		     },
		     error: function(request, status, error) {
		     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		     }
		 }); 
		
	}else{
		innerHtml = '<p class="no-gallery">참여한 채널이 없습니다.</p>';	
		$('#myProject').html(innerHtml);
	}

}


function moveProjectOpen(){
	if(chFinYn == "Y"){
		alert("마감 된 프로젝트입니다.");
		return false;	
	}
	
	if(sessionCheck(memberId, memberAuth, 'main') && memberId != 'null'){
		location.href="/project/projectOpen?chSeq="+chSeq;
	}else{
		alert("로그인이 필요한 서비스입니다.");
	}
}

function moveProjectDtl(pjSeq){
	location.href="/project/project?pjSeq="+pjSeq;
}

function showPop(chSeq){
	chkChSeq = chSeq;
	$('#passError').hide();
	$('#popChkPass').addClass('active');
}

//팝업 종료
function closePop(){
	$('.model').removeClass('active');
}

function enterkey(type) {
    if (window.event.keyCode == 13) {
    	if(type == 'mainSearch'){
    		getMyProjectList();
    		getAllProjectList();
    	}
    }
}
</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="sub channel">

    <div class="sub_header">
      <div class="bg"></div>
      <div class="inner">
        <p class="tit">${channelVo.chName}</p>
      </div>
    </div>

    <div class="detail_info_wrap">
      <div class="inner">
        <div class="flex_wrap">
          <div class="img_wrap">
            <img src="${channelVo.chImg}" alt="">
          </div>
          <div class="detail_info">
            <div class="item">
              <p id="dDay" class="dday">${channelVo.dDay}</p>
              <div id="dDayBarWrap" class="dday_bar_wrap" data-dday="${channelVo.dDayPercent}">
                <div class="dday_bar"></div>
              </div>
            </div>
            <div class="item">
              <p class="item_tit">채널 설명</p>
              <p id="chMemo" class="item_exp">${channelVo.chMemo}</p>
            </div>
            <div class="item">
              <p class="item_tit budget">총 펀딩금액</p>
              <p id="fdSumAmt" class="item_txt">${channelVo.fdSumAmtChar}원</p>
            </div>
            <div class="item">
              <p class="item_tit">프로젝트 수</p>
              <p id="pjCnt" class="item_txt">${channelVo.pjCnt}개</p>
            </div>
            <div class="item">
              <p class="item_tit">채널기간</p>
              <p id="pjDtFromTo" class="item_txt">${channelVo.chStDt}~${channelVo.chEndDt}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <section class="section02">
      <div class="inner">
        <div class="tit_wrap">
          <h3 class="tit">내가 개설한 프로젝트</h3>
          <a href="javascript:void(0);" class="btn_style01" onClick="moveProjectOpen();"><span class="material-icons-outlined">add</span>프로젝트 개설하기</a>
        </div>
        <div id="myProject" class="flex_wrap gallery gall03">
          
        </div>
      </div>
    </section>

    <section class="section03">
      <div class="inner">
        <div class="tit_wrap">
          <h3 class="tit">채널 내 프로젝트</h3>
          <select id="projectState"  onChange="viewCount=0;getAllProjectList();">
            <option value="orderName">이름순(기본)</option>
            <option value="orderMaxAmt">펀딩 금액 높은순</option>
            <option value="orderMinAmt">펀딩 금액 낮은순</option>
            <option value="latest">최신순</option>
          </select>
        </div>
        <div id="allProject" class="flex_wrap gallery gall04">
        </div>
        <a id="addViewBtn" href="javascript:void(0);" class="btn_style01 more" onClick="addViewProject();">프로젝트 더보기</a>
    </section>

  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
