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
  
  function pageLoad(){
    sessionCheck(memberId, memberAuth, 'myfunding');
    
    getMyFundingList();
    
  }

  //내 프로젝트 조회
function getMyFundingList(type){
	var param = {
			memberId 	: memberId
			, chSeq : ''
		};
		
	var innerHtml = '';
	$.ajax({
        type : 'POST',
		     url : '/funding/getMyFundingList',
		     dataType : null,
		     data : param,
		     success : function(result) {
		     	console.log("getMyFundingList success");
		     	
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

     		//더보기 활성화
     		if(viewCount+pageCount >= result.length){
     			$('#addViewBtn').hide();
     		}else{
     			$('#addViewBtn').show();
     		}
     		
     		//더보기이면 리스트 추가, 일반조회일 경우 리스트 교체
     		if(type == 'add'){
     			$('#myFunding').append(innerHtml);
     		}else{
     			$('#myFunding').html(innerHtml);
     		}
     		
          }else{
        	  //내 펀딩이 없을 경우
        	  innerHtml = '<p class="no-gallery">참여한 펀딩이 없습니다.</p>';	
        	  $('#myFunding').html(innerHtml);
        	  $('#addViewBtn').hide();
          }
     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function addViewProject(){
	getMyFundingList('add');
	viewCount += pageCount;
}

function moveProjectDtl(pjSeq){
	location.href="/project/project?pjSeq="+pjSeq;
}

</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="section03 sub myfunding">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 펀딩 관리</p>
      </div>
    </div>
    <div class="my_funding">
      <div class="inner">
        <div id="myFunding" class="flex_wrap gallery gall03"></div>
        <a id="addViewBtn" href="javascript:void(0);" class="btn_style01 more" onClick="addViewProject();">프로젝트 더보기</a>
    </div>
  </div>
</div>  
	<%@ include file="../include/footer.jsp" %>


</body>
</html>
