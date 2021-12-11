<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>


<script type="text/javascript">

var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

var pageType = "${pageType}"; //채널개설 : channel_open , 채널수정 : mychannel_modi
var chSeq = "${chSeq}"; 
var fileChange = false;

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'channelOpen');
	
	console.log(pageType);
	
	if(pageType == "channel_open"){
		$('#insertC').show();
		$('#updateC').hide();
		$('#deleteC').hide();
	}else{
		$('#insertC').hide();
		$('#updateC').show();
		$('#deleteC').show();
	}
	
	if(chSeq != ''){
		getChannelInfo();
		$('#pageTitle').text('MY 채널관리');
	}
}

function getChannelInfo(){
	var params = {
			   chSeq : chSeq
	     	};
	  		
	$.ajax({
           url : '/channel/getChannelInfo',
           async : false, // 비동기모드 : true, 동기식모드 : false
           type : 'POST',
           cache : false,
           dataType : null,
           data : params,
           success : function(data) {
           		console.log(data);
           		
           		$('#chName').val(data.chName);
   				$('#chImg').text(data.chImg);
   				$('#chMemo').val(data.chMemo);
   				$('#chStDt').val(data.chStDt);
   				$('#chEndDt').val(data.chEndDt);
   				$("input:radio[name='chOpenYn']:radio[value='"+( data.chOpenYn ? 'Y' : 'N' )+"']").prop('checked', true); 
   				$('#chPass').val(data.chPass);
   				if(!data.chOpenYn){
   					changeChOpenYn('N');
   				}
           },
           error : function(request,status,error) {
             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
  	});
}

function saveChannel(type){
	var url;
	var msg;
	var msgA;
	var locationUrl;
	
	if(type == "insert"){
		msg = "개설하시겠습니까?";
		url = "/channel/insertChannel";
		msgA = "정상적으로 개설되었습니다.";
		locationUrl = "/";
		
	}else if(type == "update"){
		msg = "수정하시겠습니까?";
		url = "/channel/updateChannel";
		msgA = "정상적으로 수정되었습니다.";
		locationUrl = "/member/mypage";
	}
	
	//필수값 체크
	if($('#chName').val() == '' || $('#chMemo').val() == '' 
			|| $('#chStDt').val() == '' || $('#chEndDt').val() == ''
			|| ($("input[name='chOpenYn']:checked").val() == 'N' && $('#chPass').val() == '' ) ){
		alert("모든 항목을 입력해야합니다.");
		return;
	}
	
	//날짜 벨리데이션 체크
	if( $('#chStDt').val() > $('#chEndDt').val() ){
		alert("채널 시작일은 종료일보다 빨리야합니다.");
		return;
		
	}
	
	var inputDate = new Date($('#chStDt').val());
    var curtDate = new Date();
    curtDate.setDate(curtDate.getDate() - 1)
    console.log(curtDate);
    if (curtDate-1 > inputDate) {
        alert("과거일자를 입력하셨습니다. \n과거일자는 채널 개설이 불가합니다.");
        return false;
    }
	
	if(confirm(msg)){
		
		//이미지 업로드
		 var imgUpload = $("#file")[0];
		 var chImg = '';
		 
		 if(type == "insert"){
			 if(imgUpload.files.length === 0){
			    alert("채널이미지를 선택해주세요");
			    return;
			  }
		 }
		 

		  if($("#file").val() != ''){
		     const date = new Date(+new Date() + 3240 * 10000).toISOString().split("T")[0];
			 const time = new Date().toTimeString().split(" ")[0];
			 console.log("imgUpload.files.name: ", imgUpload.files[0].name);
			 
			 let fileNameLength = imgUpload.files[0].name.length;
			 let fileDot = imgUpload.files[0].name.lastIndexOf(".");
			 let fileType = imgUpload.files[0].name.substring(fileDot+1, fileNameLength);
			  
			 chImg = 'https://gilin.co.kr/img/channel/'+ date + '_' + time + "." + fileType;
			 //chImg = 'https://gilin.co.kr/img/channel/'+ date + '_' + time + '_' +imgUpload.files[0].name;
			 
			 $('#filePath').val('/img/channel');
			 $('#fileName').val(date + '_' + time + "." + fileType);
			 $("#imgForm").submit();
			 
		  }else{
			  chImg = $('#chImg').text();
		  }

		  // 채널 insert or update
		  var params = {
   			   chName : $('#chName').val()
   				, chImg : chImg  //window.location.origin+'/img/'+imgUpload.files[0].name
   				, chMemo : $('#chMemo').val()
   				, chStDt :  $('#chStDt').val()
   				, chEndDt : $('#chEndDt').val()
   				, chPass : ( $("input[name='chOpenYn']:checked").val() == 'Y' ? '' : $('#chPass').val() )
   				, chOpenYn : ( $("input[name='chOpenYn']:checked").val() == 'Y' ? true : false )
   				, cretId : memberId
   				, updtId : memberId
   				, chSeq : chSeq
   	     	};
   	  		
   	  		$.ajax({
	   	           url : url,
	   	           type : 'POST',
	   	           cache : false,
	   	           dataType : null,
	   	           data : params,
	   	           success : function(data) {
	   	           	alert(msgA);
	   	         	location.href = locationUrl;
	   	           },
	   	           error : function(request,status,error) {
	   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	   	           }
   	     	});
		
  	}
}

function deleteChannel(){
	if(confirm("삭제하시겠습니까?")){
  		var params = {
         	chSeq : chSeq
     	};
  		
  		$.ajax({
           url : '/channel/deleteChannel',
           async : false, // 비동기모드 : true, 동기식모드 : false
           type : 'POST',
           cache : false,
           dataType : null,
           data : params,
           success : function(data) {
           	alert('정상적으로 삭제되었습니다.');
           	location.href="/member/mypage";
           },
           error : function(request,status,error) {
             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
     });
  	}
}

function changeFile(){
	fileChange = true;
	console.log(fileChange);
}

function changeChOpenYn(type){
	if(type == 'Y'){
		$('#chPassShowbox').removeClass('active');
		
	}else{
		$('#chPassShowbox').addClass('active');
		
	}
}

</script>


<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="sub channel_open">

    <div class="sub_header02">
      <div class="inner">
        <p id="pageTitle" class="tit">채널 개설</p>
      </div>
    </div>

    <div class="board board_write">
      <div class="inner">

        <table class="board_table">
          <tr>
            <th>채널명</th>
            <td><input id="chName" type="text" class="w100"></td>
          </tr>
          <tr>
            <th>채널 이미지</th>
            <td>
            	<form id="imgForm" action="https://gilin.co.kr/file/uploadFile" method="post" enctype="multipart/form-data" target="imgIframe">
	              <div class='file_input'>
	                <input class="btn" type='file' name="file" id="file" onchange="changeFile()">
	                <div class="btn">파일선택</div>
	                <input type="hidden" name="filePath" id="filePath" value= "" >
        			<input type="hidden" name="fileName" id="fileName" value = "" >
	                <p data-js-label id="chImg">No file selected</p>
	              </div>
	            </form>
            </td>
          </tr>
          <tr>
            <th>채널 요약 설명</th>
            <td><textarea id="chMemo" rows="3" resize="none" style="height:360px;"></textarea></td>
          </tr>
          <tr>
            <th>채널 공개 여부</th>
            <td>
              <div class="chk_wrap">
                <div class="chk_btn">
                  <input id="public" name="chOpenYn" type="radio" value="Y" checked onChange="changeChOpenYn('Y')">
                  <label for="public">공개</label>
                  <div class="chk_btn_circle"></div>
                </div>
                <div class="chk_btn">
                  <input id="private" name="chOpenYn" type="radio" value="N" onChange="changeChOpenYn('N')">
                  <label for="private">비공개</label>
                  <div class="chk_btn_circle"></div>
                </div>
                <div id="chPassShowbox" class="showbox">
                  <input id="chPass" type="text" placeholder="4자리 비밀번호" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <th>채널 기간</th>
            <td>
              <input id="chStDt" type="date" class="datepicker" onfocusout="_fnisDate(this.value, this.id);">
              <span class="to">-</span>
              <input id="chEndDt" type="date" class="datepicker" onfocusout="_fnisDate(this.value, this.id);">
            </td>
          </tr>
        </table>

        <div class="btn_wrap bottom">
          <button id="insertC" class="btn_style01" onClick="saveChannel('insert');" >개설</button>
          <button id="updateC" class="btn_style01" onClick="saveChannel('update');" >수정</button>
          <button id="deleteC" class="btn_style01" onClick="deleteChannel();">삭제</button>
        </div>
      </div>
    </div>

	<iframe id="imgIframe" name="imgIframe" style="display:none"></iframe>
  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
