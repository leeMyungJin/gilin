<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<script type="text/javascript">
var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'mypage');
	
	//getChannelInfo();
	getMyProjectList();
	getMyChannelList();
	getMyFundingList();
}


//내 프로젝트 조회
function getMyProjectList(){
	var param = {
		memberId 	: memberId
		, chSeq : ''
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
		innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
		$('#myProject').html(innerHtml);
	}

}

//내 펀딩 조회
function getMyFundingList(){
	var param = {
		memberId 	: memberId
		, chSeq : ''
	};
	
	var innerHtml = '';
	if(memberId != null){
		$.ajax({
		     type : 'POST',
		     url : '/funding/getMyFundingList',
		     dataType : null,
		     data : param,
		     success : function(result) {
		     	console.log("getMyFundingList success");
		     	
		     	if(result.length > 0){
		          	for(var i =0; i<result.length; i++){
		   				innerHtml += (result[i].fdYn == "Y" ? '<div class="flex_box complite" onClick="moveFundingDtl('+result[i].pjSeq+');">' : '<div class="flex_box" onClick="moveProjectDtl('+result[i].pjSeq+');">')+
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
		        	  //내 펀딩이 없을 경우
		        	  innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
		          }
		     	
		    	$('#myFunding').html(innerHtml);
		     	
		     },
		     error: function(request, status, error) {
		     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		     }
		 }); 
		
	}else{
		innerHtml = '<p class="no-gallery">참여한 프로젝트가 없습니다.</p>';	
		$('#myProject').html(innerHtml);
	}

}

//내 체널 조회
function getMyChannelList(){
	var param = {
		memberId 	: memberId
		, name : ''
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

function updateNick(){
	var param = {
			nickname : $('#nickname').val()
			, memberId : memberId
		};
		
	var innerHtml = '';
	$.ajax({
	     type : 'POST',
	     url : '/member/updateNickname',
	     dataType : null,
	     data : param,
	     success : function(result) {
	     	alert("닉네임이 변경되었습니다.");
	     },
	     error: function(request, status, error) {
	     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	
	     }
	 }); 
}

function updateBaseImg(imgUrl){
	var param = {
			profilePic : imgUrl
			, memberId : memberId
		};
		
	var innerHtml = '';
	$.ajax({
	     type : 'POST',
	     url : '/member/updateBaseImg',
	     dataType : null,
	     data : param,
	     success : function(result) {
	     	alert("프로필이 변경되었습니다.");
	     	//location.reload();
	     	$('#profilePic').attr('src', imgUrl);
	     	console.log("<%=session.getAttribute("profilePic")%>");
	     },
	     error: function(request, status, error) {
	     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	
	     }
	 }); 
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

function moveProjectDtl(pjSeq){
	location.href="/project/project?pjSeq="+pjSeq;
}

function moveProjectUpdate(pjSeq){
	location.href="/project/myprojectModi?pjSeq="+pjSeq;
}

function moveFundingDtl(pjSeq){
	location.href="/funding/funding?pjSeq="+pjSeq;
}

function clickFile(){
	$('#file').trigger("click");
}

function changeFile(){
	
	//기본이미지, 카톡기본프로필이 아닌 경우 이전프로필 이미지 서버에서 삭제
	var oldPicSrc = $('#profilePic').attr("src");
	var oldPicSrcArr = oldPicSrc.split('/');
	if(oldPicSrc.indexOf("basedprofile") == -1 && oldPicSrc.indexOf("kakaocdn") == -1){
		var param = {
				filePath : '/img/profile'
				, fileName : oldPicSrcArr[oldPicSrcArr.length-1]
			};
			
		var innerHtml = '';
		$.ajax({
		     type : 'POST',
		     url : '/file/deleteFile',
		     dataType : null,
		     data : param,
		     success : function(result) {
		    	 console.log(result);
		     },
		     error: function(request, status, error) {
		     	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		
		     }
		 }); 
		
	}
	
	// 프로필 등록
	var imgUpload = $("#file")[0];
	var chImg = '';
	
	if($("#file").val() != ''){
		const date = new Date(+new Date() + 3240 * 10000).toISOString().split("T")[0];
		const time = new Date().toTimeString().split(" ")[0];
		console.log("imgUpload.files.name: ", imgUpload.files[0].name);
		
		let fileNameLength = imgUpload.files[0].name.length;
		let fileDot = imgUpload.files[0].name.lastIndexOf(".");
		let fileType = imgUpload.files[0].name.substring(fileDot+1, fileNameLength);
		  
		chImg = 'https://gilin.co.kr/img/profile/'+ date + '_' + time + "." + fileType;
		$('#filePath').val('/img/profile');
		$('#fileName').val(date + '_' + time + "." + fileType);
		$("#imgForm").submit();
		
		updateBaseImg(chImg);
		$('#imgForm')[0].reset();
	}
}


function deleteMember(){
	var param = {
			id : memberId
		};
		
	var innerHtml = '';
	$.ajax({
	     type : 'POST',
	     url : '/login/deleteMember',
	     dataType : null,
	     data : param,
	     success : function(result) {
	     	alert("회원탈퇴 되었습니다.");
	     	logout();
	     },
	     error: function(request, status, error) {
	     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	
	     }
	 }); 
}

</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="sub mypage mychannel">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">마이페이지</p>
      </div>
    </div>

    <div class="mypage_cont">
      <div class="inner">
        <div class="my_info">
          <p class="tit">회원정보</p>
          <div class="flex_wrap">
            <div class="profile_wrap">
              <div class="profile_img">
                <img id="profilePic" src="<%=session.getAttribute("profilePic")%>" alt="" class="default">
              </div>
              <div class="btn_wrap">
                <form id="imgForm" action="https://gilin.co.kr/file/uploadFile" method="post" enctype="multipart/form-data" target="imgIframe">
	             	<button type="button" onClick="clickFile();">사진 수정 <span class="material-icons">chevron_right</span></button>
	                <input style="display:none;" type='file' name="file" id="file" onchange="changeFile()" accept=".gif, .jpeg, .jpg, .png">
	                <input type="hidden" name="filePath" id="filePath" value= "" >
        			<input type="hidden" name="fileName" id="fileName" value = "" >
	            </form>
	            <button onClick="updateBaseImg('https://gilin.co.kr/img/basedprofile/icon_my_avatar.png')">기본 이미지로 변경 <span class="material-icons" >chevron_right</span></button>
              </div>
            </div>
            <div class="my_info_txt">
              <ul>
                <li><span>닉네임</span> <input type="text" id="nickname" value="<%=session.getAttribute("nickname")%>" class="nick"> <button class="btn_style02 nick_chg" onClick="updateNick()">수정</button></li>
                <li><span>계정</span> <%=session.getAttribute("email")%> </li>
              </ul>
              <a href="javascript:void(0);" onClick="deleteMember();" class="del_account">회원탈퇴</a>
            </div>
            
          </div>

        </div>

        <div class="my_funding">
          <div class="tit_wrap">
            <h3 class="tit">MY 펀딩 관리</h3>
            <a href="/funding/myfunding" class="btn_style01">전체보기</a>
          </div>
          <div id="myFunding" class="flex_wrap gallery gall03"></div>
        </div>

        <div class="line"></div>

        <div class="my_channel">
          <div class="tit_wrap">
            <h3 class="tit">MY 채널 관리</h3>
            <a href="/channel/mychannel" class="btn_style01">전체보기</a>
          </div>
          <div id="myChannel" class="flex_wrap gallery gall03"></div>
        </div>

        <div class="line"></div>

        <div class="my_project">
          <div class="tit_wrap">
            <h3 class="tit">MY 프로젝트 관리</h3>
            <a href="/project/myproject" class="btn_style01">전체보기</a>
          </div>
          <div id="myProject" class="flex_wrap gallery gall03"></div>
        </div>


      </div>
    </div>

	<iframe id="imgIframe" name="imgIframe" style="display:none"></iframe>
  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
