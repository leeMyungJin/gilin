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

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'mychannel');
	
	getMyChannelList();
	
}

//내 체널 조회
function getMyChannelList(type){
	var param = {
		memberId 	: memberId
		, name : ''
	};
	
	var innerHtml = '';
	$.ajax({
     type : 'POST',
     url : '/channel/getMyChannelList',
     dataType : null,
     data : param,
     success : function(result) {
     	console.log("getMyChannelList success");
     	console.log(viewCount);
     	
     	if(result.length > 0){
   			var maxLength = (viewCount+pageCount < result.length ? viewCount+pageCount : result.length);
   			for(var i=viewCount; i< maxLength ; i++){
          innerHtml += (result[i].finYn == 'Y' ? '<div class="flex_box expired">' : '<div class="flex_box">')+
		   								'<div class="img_wrap">'+
                            '<img src="'+result[i].chImg+'" alt="">'+
                            '<div class="btn_wrap">'+
                              '<button type="button" class="gall_hover_btn" onClick="moveChannelDtl('+result[i].chSeq+');">채널 바로가기</button>'+
                              '<button type="button" class="gall_hover_btn" onClick="moveChannelReport('+result[i].chSeq+');">결과 보고서</button>'+
                              '<button type="button" class="gall_hover_btn" onClick="moveChannelUpdate('+result[i].chSeq+');">수정/삭제</button>'+
                            '</div>'+
                          '</div>'+
                        '<div class="txt_wrap" onClick="moveChannelDtl('+result[i].chSeq+');">'+
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
     			$('#myChannel').append(innerHtml);
     		}else{
     			$('#myChannel').html(innerHtml);
     		}
     		
          }else{
        	  //내 채널이 없을 경우
        	  innerHtml = '<p class="no-gallery">참여한 채널이 없습니다.</p>';	
        	  $('#myChannel').html(innerHtml);
        	  $('#addViewBtn').hide();
          }
     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function addViewChannel(){
	getMyChannelList('add');
	viewCount += pageCount;
}

function moveChannelDtl(chSeq){
	location.href="/channel/channel?chSeq="+chSeq;
}

function moveChannelReport(chSeq){
	location.href="/report/myreport?chSeq="+chSeq;
}

function moveChannelUpdate(chSeq){
	location.href="/channel/mychannelModi?chSeq="+chSeq;
}

</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="section03 sub mychannel">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 채널 관리</p>
      </div>
    </div>

    <div class="mypage_cont">
      <div class="inner">
        <div  id="myChannel" class="flex_wrap gallery gall03"></div>
        <a id="addViewBtn" href="javascript:void(0);" class="btn_style01 more" onClick="addViewChannel();">채널 더보기</a>
    </div>
  </div>
 </div>
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
