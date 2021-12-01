<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
  <script src="../ckeditor5/build/ckeditor.js"></script>
  <link rel="stylesheet" type="text/css" href="../ckeditor5/sample/styles.css">
  <style type="text/css">
        .ck-content {height: 80vh;}
  </style>
</head>

<script type="text/javascript">

var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

var pageType = "${pageType}"; //프로젝트 개설 : project_open , 프로젝트 수정 : myproject_modi
var pjSeq = "${pjSeq}"; 
var chSeq = "${chSeq}"; 
var fileChange = false;

console.log(pjSeq);

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'projectOpen');
	
	if(pageType == "project_open"){
		$('#insertC').show();
		$('#updateC').hide();
		$('#deleteC').hide();
	}else{
		$('#insertC').hide();
		$('#updateC').show();
		$('#deleteC').show();
	}
	
	if(pjSeq != ''){
		getProjectInfo();
		$('#pageTitle').text('MY 프로젝트관리');
		
	}else{
		setProjectContent('');
	}
}

function getProjectInfo(){
	var params = {
			   pjSeq : pjSeq
	     	};
	  		
	$.ajax({
           url : '/project/getProjectInfo',
           async : false, // 비동기모드 : true, 동기식모드 : false
           type : 'POST',
           cache : false,
           dataType : null,
           data : params,
           success : function(data) {
           		console.log(data);
           		$('#pjName').val(data.pjName);
   				$('#pjImg').text(data.pjImg);
   				$('#pjMemo').val(data.pjMemo);
   				$('#chSeq').val(data.chSeq);
   				setProjectContent(data.pjContent);
           },
           error : function(request,status,error) {
             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
  	});
}

var editor1;
function setProjectContent(pjContent){
	ClassicEditor
	.create( document.querySelector( '#editor' ), {
		
		toolbar: {
            items: [
                'heading',
                '|',
                'bold',
                'italic',
                'link',
                'bulletedList',
                'numberedList',
                '|',
                'outdent',
                'indent',
                '|',
                'imageUpload',
                'blockQuote',
                'insertTable',
                'mediaEmbed',
                'undo',
                'redo',
                'htmlEmbed',
                'horizontalLine',
                'fontSize',
                'fontColor',
                'fontBackgroundColor',
                'alignment',
            ],
            shouldNotGroupWhenFull: true
        },
        language: 'ko',
        image: {
            toolbar: [
                'imageTextAlternative',
                'imageStyle:inline',
                'imageStyle:block',
                'imageStyle:side'
            ]
        },
        table: {
            contentToolbar: [
                'tableColumn',
                'tableRow',
                'mergeTableCells'
            ]
        },
        extraPlugins: [MyCustomUploadAdapterPlugin],
        licenseKey: '',
		
	} )
	.then( editor => {
		editor.plugins.get('FileRepository').createUploadAdapter = (loader)=>{
            return new UploadAdapter(loader);
        };
		editor1 = editor;
		editor1.setData(pjContent);
	} )
	.catch( error => {
		console.error( 'Oops, something went wrong!' );
		console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
		console.warn( 'Build id: eed83e2ex4oz-pejoxvy7ffif' );
		console.error( error );
	} );
}

function MyCustomUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        return new UploadAdapter(loader)
    }
}

//이미지업로드
class UploadAdapter {
    constructor(loader) {
        this.loader = loader;
    }

    upload() {
        return this.loader.file.then( file => new Promise((async (resolve, reject) => {
            await this._initRequest();
            await this._initListeners(resolve, reject, file);
            await this._sendRequest(file);
        })))
    }

    abort() {
        if ( this.xhr ) { this.xhr.abort(); }
    }

    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();
        xhr.open('POST', '/project/contentImgUpload', true);
        xhr.responseType = 'json';
    }

    async _initListeners(resolve, reject, file) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = '파일을 업로드 할 수 없습니다. \n파일용량은 3MB를 초과할수 없습니다.'

        await xhr.addEventListener('error', () => {reject(genericErrorText)})
        await xhr.addEventListener('abort', () => reject())
        await xhr.addEventListener('load', () => {
            const maxSize = 3500000;
            const response = xhr.response

            if(!response || response.error ||file.size > maxSize) {
                return reject( response && response.error ? response.error.message : genericErrorText );
            }

            resolve({
                default: response.url //업로드된 파일 주소
            })
        })
    }

    _sendRequest(file) {
        const data = new FormData()
        data.append('file', file);
        this.xhr.send(data)
    }
}


function saveProject(type){
	var url;
	var msg;
	var msgA;
	var locationUrl;
	
	if(type == "insert"){
		msg = "개설하시겠습니까?";
		url = "/project/insertProject";
		msgA = "정상적으로 개설되었습니다.";
		locationUrl = "/channel/channel?chSeq="+(chSeq == "" ? $('#chSeq').val() : chSeq);
		
	}else if(type == "update"){
		msg = "수정하시겠습니까?";
		url = "/project/updateProject";
		msgA = "정상적으로 수정되었습니다.";
		locationUrl = "/member/mypage";
	}
	
	if(confirm(msg)){
		
		console.log("$('#pjImg').text() : "+ $('#pjImg').text());
		
		//필수값 체크
		if($('#pjName').val() == '' || $('#pjMemo').val() == '' ){
			alert("모든 항목을 입력해야합니다.");
			return;
		}
		
		//이미지 업로드
		 var imgUpload = $("#file")[0];
		 var pjImg = '';
		 
		 if(type == "insert"){
			 if(imgUpload.files.length === 0){
			    alert("프로젝트이미지를 선택해주세요");
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
			  
			 //pjImg = 'https://gilin.co.kr/img/project/'+ date + '_' + time + '_' +imgUpload.files[0].name;
			 pjImg = 'https://gilin.co.kr/img/project/'+ date + '_' + time + "." + fileType;
			 $('#filePath').val('/img/project');
			 $('#fileName').val(date + '_' + time + "." + fileType);
			 $("#imgForm").submit();
			 
		  }else{
			  pjImg = $('#pjImg').text()
		  }

		  
		  console.log(chSeq);
		  console.log(editor1.getData());
		  // 프로젝트 insert or update
		  var params = {
				 chSeq : (chSeq == "" ? $('#chSeq').val() : chSeq)
	   			, pjSeq : pjSeq
   			    , pjName : $('#pjName').val()
   				, pjImg : pjImg  //window.location.origin+'/img/'+imgUpload.files[0].name
   				, pjMemo : $('#pjMemo').val()
   				, pjContent : editor1.getData()
   				, cretId : memberId
   				, updtId : memberId
   	     	};
		  
		  console.log(params);
   	  		
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

function deleteProject(){
	if(confirm("삭제하시겠습니까?")){
  		var params = {
         	pjSeq : pjSeq
     	};
  		
  		$.ajax({
           url : '/project/deleteProject',
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
        <p id="pageTitle" class="tit">프로젝트 개설</p>
      </div>
    </div>

    <div class="board board_write">
      <div class="inner">

        <table class="board_table">
          <tr>
            <th>프로젝트 명</th>
            <td><input id="pjName" type="text" class="w100">
            	<input type="hidden" id="chSeq" class="w100">
            </td>
          </tr>
          <tr>
            <th>프로젝트 이미지</th>
            <td>
              <form id="imgForm" action="https://211.37.179.144/file/uploadFile" method="post" enctype="multipart/form-data" target="imgIframe">
	              <div class='file_input'>
	                <input class="btn" type='file' name="file" id="file" onchange="changeFile()">
	                <div class="btn">파일선택</div>
	                <input type="hidden" name="filePath" id="filePath" value= "" >
        			<input type="hidden" name="fileName" id="fileName" value = "" >
	                <p data-js-label id="pjImg">No file selected</p>
	              </div>
	           </form>
            </td>
          </tr>
          <tr>
            <th>프로젝트 요약 설명</th>
            <td><textarea id="pjMemo" rows="3" resize="none" style="height:360px;"></textarea></td>
          </tr>
          <tr>
            <th colspan="2">상세페이지 작성</th>
          </tr>
          <tr>
            <td colspan="2">
              <div class="editor">
                <textarea name="editor" id="editor"></textarea>
              </div>

            </td>
          </tr>

        </table>

        <div class="btn_wrap bottom">
          <button id="insertC" class="btn_style01" onClick="saveProject('insert');" >개설</button>
          <button id="updateC" class="btn_style01" onClick="saveProject('update');" >수정</button>
          <button id="deleteC" class="btn_style01" onClick="deleteProject();">삭제</button>
        </div>
      </div>
    </div>

	<iframe id="imgIframe" name="imgIframe" style="display:none"></iframe>
  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
