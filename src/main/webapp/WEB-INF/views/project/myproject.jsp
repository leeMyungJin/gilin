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
    sessionCheck(memberId, memberAuth, 'myproject');
    
    getMyProjectList();
    
  }

//내 프로젝트 조회
function getMyProjectList(type){
	var param = {
			memberId 	: memberId
			, chSeq : ''
		};
		
	var innerHtml = '';
	$.ajax({
     type : 'POST',
     url : '/project/getMyProjectList',
     dataType : null,
     data : param,
     success : function(result) {
     	console.log("getMyProjectList success");
     	console.log(viewCount);
     	
     	if(result.length > 0){
   			var maxLength = (viewCount+pageCount < result.length ? viewCount+pageCount : result.length);
   			for(var i=viewCount; i< maxLength ; i++){
          innerHtml += (result[i].fdYn == "Y" ? '<div class="flex_box complite">' : '<div class="flex_box">')+
		   								'<div class="img_wrap">'+
						                  '<img src="'+result[i].pjImg+'" alt="">'+
						                  '<div class="btn_wrap">'+
						                    '<button class="gall_hover_btn" onClick="moveProjectDtl('+result[i].pjSeq+');">프로젝트 바로가기</button>'+
						                    '<button class="gall_hover_btn" onClick="moveProjectUpdate('+result[i].pjSeq+');">수정/삭제</button>'+
						                  '</div>'+
						                '</div>'+
						                '<div class="txt_wrap" onClick="moveProjectDtl('+result[i].pjSeq+');">'+
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
     			$('#myProject').append(innerHtml);
     		}else{
     			$('#myProject').html(innerHtml);
     		}
     		
          }else{
        	  //내 채널이 없을 경우
        	  innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
        	  $('#myProject').html(innerHtml);
        	  $('#addViewBtn').hide();
          }
     },
     error: function(request, status, error) {
     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

     }
 }); 
}

function addViewProject(){
	getMyProjectList('add');
	viewCount += pageCount;
}

function moveProjectDtl(pjSeq){
	location.href="/project/project?pjSeq="+pjSeq;
}

function moveProjectUpdate(pjSeq){
	location.href="/project/myprojectModi?pjSeq="+pjSeq;
}


</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="sub mychannel">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 프로젝트 관리</p>
      </div>
    </div>

    <div class="mypage_cont">
      <div class="inner">
         <div id="myProject" class="flex_wrap gallery gall03"></div>
         <a id="addViewBtn" href="javascript:void(0);" class="btn_style01 more" onClick="addViewProject();">프로젝트 더보기</a>
    </div>
  </div>
  
	<%@ include file="../include/footer.jsp" %>


</body>
</html>
