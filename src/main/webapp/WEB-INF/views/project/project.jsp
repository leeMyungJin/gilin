<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
  <script src="../ckeditor5/build/ckeditor.js"></script>
  <link rel="stylesheet" type="text/css" href="../ckeditor5/sample/styles.css">

  <style>
        /*html, body, div, span, applet, object, iframe,*/
        /*h1, h2, h3, h4, h5, h6, p, blockquote, pre,*/
        /*a, abbr, acronym, address, big, cite, code,*/
        /*del, dfn, em, img, ins, kbd, q, s, samp,*/
        /*small, strike, strong, sub, sup, tt, var,*/
        /*b, u, i, center,*/
        /*dl, dt, dd, ol, ul, li,*/
        /*fieldset, form, label, legend,*/
        /*table, caption, tbody, tfoot, thead, tr, th, td,*/
        /*article, aside, canvas, details, embed, */
        /*figure, figcaption, footer, header, hgroup, */
        /*menu, nav, output, ruby, section, summary,*/
        /*time, mark, audio, video {*/
        /*    margin: 0;*/
        /*    padding: 0;*/
        /*    border: 0;*/
        /*    box-sizing: border-box;*/
        /*}*/
        /*body{width:100%; line-height: 1.4; color:#333; overflow-x:hidden;}*/
        /*ol,ul,li{list-style:none;}*/
        /*article{padding:25px; font-size:14px;}*/
        /*p{padding:8px 0;}*/
        /*h1{margin:-25px -25px 20px; padding:14px 25px; background-color:#eee;}*/
        /*section{margin:30px 0; padding:12px;}*/
        /*h2{margin:15px 0;padding-top:30px; font-size:1.25em; border-top:1px solid #ddd;}*/
        /*h3{padding:12px 0; font-size:1.15em;}*/
        /*h4{padding:6px 0;font-weight:500;}*/
        /*strong{display:inline-block; margin-top:12px;}*/
        /*li{margin-top:10px;}*/
        /*ul,ol{margin-left:8px;}*/
        /*table{margin-bottom:15px; width:100%; border-collapse: collapse;}*/
        /*table th,td{border:solid #ddd; border-width:1px 0; padding:6px 10px;}*/
        /*table th{width:30%; background-color:#f5f5f5;}*/
        .ck.ck-editor__main>.ck-editor__editable:not(.ck-focused){border:none;padding:0;}
        .ck.ck-editor *{line-height:1.5;}
        @media screen and (max-width:360px){
            .terms_wrp{padding:15px;}
            .terms_tit{margin:-15px -15px 15px; padding:10px 15px;}
        }
        
    </style>
</head>

<script type="text/javascript">

var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

var pjSeq = "${pjSeq}";
var fdYn = "${projectVo.fdYn}"; //?????? ????????????
var finYn = "${projectVo.finYn}"; //?????? ???????????? 
var pjContent = '${projectVo.pjContent}';

var totalData = 0;    // ??? ????????? ???
var totalPage = 0;	// ??? ????????? ???
var dataPerPage = 3;    // ??? ???????????? ????????? ????????? ???
var pageCount = 5;        // ??? ????????? ????????? ????????? ???


function pageLoad(){
	sessionCheck(memberId, memberAuth, 'project');
	
	getFundingCommentPageInfo();
	setProjectContent();
	
}

function getFundingCommentPageInfo(){
	var params = {
			pjSeq : pjSeq
			, pageUnit : dataPerPage
     	};
  		
  		$.ajax({
   	           url : "/funding/getFundingCommentPageInfo",
   	           type : 'POST',
   	           cache : false,
   	           dataType : null,
   	           data : params,
   	           success : function(result) {
   	        		totalData = Number(result.totcnt);
   	        		totalPage = Number(result.totpage);
   	        		paging(1);
   	        		getFundingCommentList(1);
   	           },
   	           error : function(request,status,error) {
   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   	           }
     	});
}

function paging(currentPage){
	  if(totalPage<pageCount){
	    pageCount=totalPage;
	  }
	  
	  let pageGroup = Math.ceil(currentPage / pageCount); //????????? ??????
	  let last = pageGroup * pageCount; //????????? ????????? ????????? ????????? ??????
	  
	  if (last > totalPage) {
	    last = totalPage;
	  }

	  let first = last - (pageCount - 1); //????????? ????????? ????????? ????????? ??????
	  let next = last + 1;
	  let prev = first - 1;

	  let pageHtml = "";

	  if (prev > 0) {
	    pageHtml += "<li><a id='prev' href='#'><</a></li>";
	  }

	 //????????? ?????? ?????? 
	  for (var i = first; i <= last; i++) {
	    if (currentPage == i) {
	      pageHtml += "<li class='current'><a href='#' id='" + i + "'>" + i + "</a></li>";
	      
	    } else {
	      pageHtml += "<li><a href='#' id='" + i + "'>" + i + "</a></li>";
	    }
	  }

	  if (last < totalPage) {
	    pageHtml += "<li><a href='#' id='next'>></a></li>";
	  }

	  $("#paging").html(pageHtml);

	  //????????? ?????? ?????? ????????? 
	  $("#paging li a").click(function (e) {
		 e.preventDefault(); 
		  
	    let $id = $(this).attr("id");
	    selectedPage = $(this).text();

	    if ($id == "next") selectedPage = next;
	    if ($id == "prev") selectedPage = prev;
	    
	    //????????? ?????? ?????????
	    paging(selectedPage);
	    //??? ?????? ?????? ?????????
	    getFundingCommentList(selectedPage);
	  });
}


function getFundingCommentList(currentPage){
	var params = {
			pjSeq : pjSeq
			, pageUnit : dataPerPage
			, sPage : dataPerPage * (currentPage-1)
			, memberId : memberId
     	};
  		
  		$.ajax({
   	           url : "/funding/getFundingCommentList",
   	           type : 'POST',
   	           cache : false,
   	           dataType : null,
   	           data : params,
   	           success : function(result) {
   	        	   console.log(result);
   	        	   
   	        	   var innerHtml = '';
	   	           if(result.length > 0){
		   	        	for(var i=0; i< result.length ; i++){
		   	        		innerHtml += '<div class="comment_item">'+
							                '<div class="profile_img">'+
							                  '<img src="'+result[i].profilePic+'" alt="" class="default">'+
							                '</div>'+
							                '<div class="profile_txt">'+
							                  '<p class="nick">'+result[i].nickname+'</p>';       
							                  
								if( (result[i].cretId == memberId || memberAuth == "t") && result[i].delYn == 'N'){
									innerHtml += '<input type="text" maxlength="120" id="commentTxt'+result[i].rownum+'" class="comment_txt" value="'+result[i].fdComment+'" style="height:20; padding:0px; margin-top:-10px; border:0px;"></input>'+
												'<div class="btn_wrap">'+
													'<button class="btn_style01" onClick="updateComment('+result[i].cretId+','+result[i].rownum+')">??????</button>'+
								                    '<button class="btn_style01" onClick="deleteComment('+result[i].cretId+','+result[i].rownum+')">??????</button>'+
							                    '</div>';
								}else{
									innerHtml += '<input type="text" maxlength="120" readOnly id="commentTxt'+result[i].rownum+'" class="comment_txt" value="'+result[i].fdComment+'" style="height:20; padding:0px; margin-top:-10px; border:0px;"></input>';
								}
							
								innerHtml += '</div>'+
								           '</div>';
								           
								console.log(innerHtml);
		   	        	}
		   	        	
		   	        	$('#commentList').html(innerHtml);
	   	           }
   	           },
   	           error : function(request,status,error) {
   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   	           }
     	});
}

function saveFunding(){
	if( memberId == "null" || memberId == null || memberId == "" ){
		alert("???????????? ????????? ??????????????????.");
		return;
		
	}else if( fdYn == "Y" ){
		alert("?????? ?????? ?????? ??? ?????????????????????. ????????? 1?????? ???????????????.");
		return;
		
	}else if( finYn == "Y" ){
		alert("?????? ??? ????????? ????????? ??????????????????.");
		return;
		
	}else if($('#fdAmt').val() == "" ){
		alert("?????? ????????? ?????? ?????????????????????.");
		return;
		
	}else if($('#fdComment').val() == "" ){
		alert("??????????????? ?????? ?????????????????????.");
		return;
		
	}else if( Number(uncomma($('#fdAmt').val())) > 5000000 ){
		alert("???????????? ??? ?????? ?????? ????????? 5,000,000 ??? ?????????.");
		return;
		
	}
	
	if(confirm("?????????????????????????")){
		var params = {
			pjSeq : pjSeq
			, fdAmt : uncomma($('#fdAmt').val())
		    , fdComment : $('#fdComment').val()
			, cretId : memberId
			, updtId : memberId
     	};
  		
  		$.ajax({
   	           url : "/funding/saveFunding",
   	           type : 'POST',
   	           cache : false,
   	           dataType : null,
   	           data : params,
   	           success : function(data) {
   	           	alert("????????? ?????????????????????.");
   	         	fdYn = 'Y';
   	         	$("#fdComment").val("");
   	         	$("#fdAmt").val("");
   	         	getFundingCommentPageInfo();
   	           },
   	           error : function(request,status,error) {
   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   	           }
     	});
	}
	
}

function updateComment(cretId, rownum){
	if($('#commentTxt'+rownum).val() == ''){
		alert("?????? ????????? ???????????????.");
	}
	
	if(confirm("????????? ?????????????????????????")){
		var params = {
			pjSeq : pjSeq
		    , fdComment : $('#commentTxt'+rownum).val()
			, commentId : cretId
			, updtId : memberId
     	};
  		
  		$.ajax({
   	           url : "/funding/updateComment",
   	           type : 'POST',
   	           cache : false,
   	           dataType : null,
   	           data : params,
   	           success : function(data) {
   	           	alert("????????? ?????????????????????.");
   	         	getFundingCommentPageInfo();
   	           },
   	           error : function(request,status,error) {
   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   	           }
     	});
	}
}


function deleteComment(cretId, rownum){
	if(confirm("????????? ?????????????????????????")){
		var params = {
			pjSeq : pjSeq
			, commentId : cretId
			, updtId : memberId
     	};
  		
  		$.ajax({
   	           url : "/funding/deleteComment",
   	           type : 'POST',
   	           cache : false,
   	           dataType : null,
   	           data : params,
   	           success : function(data) {
   	           	alert("????????? ?????????????????????.");
   	         	getFundingCommentPageInfo();
   	           },
   	           error : function(request,status,error) {
   	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   	           }
     	});
	}
}


function inviteProject(){
	alert("APP ????????? ???????????????.");
}

function setProjectContent(){
	ClassicEditor
	.create( document.querySelector( '#editor' ), {
        language: 'ko',
	} )
	.then( editor => {
		editor.plugins.get('FileRepository').createUploadAdapter = (loader)=>{
            return new UploadAdapter(loader);
        };
        
        const toolbarElement = editor.ui.view.toolbar.element;
        toolbarElement.style.display = 'none';
        
        editor.isReadOnly = true;
		editor.setData(pjContent);
	} )
	.catch( error => {
		console.error( 'Oops, something went wrong!' );
		console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
		console.warn( 'Build id: eed83e2ex4oz-pejoxvy7ffif' );
		console.error( error );
	} );
}

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

</script>

<body onload="pageLoad();" id="project_page" class="project">
  <%@ include file="../include/header.jsp" %>

  <div class="sub project">

    <div class="sub_header">
      <div class="bg"></div>
      <div class="inner">
        <p class="tit">${projectVo.pjName}</p>
      </div>
    </div>

    <div class="detail_info_wrap pjt">
      <div class="inner">
        <div class="flex_wrap">
          <div class="img_wrap">
            <img src="${projectVo.pjImg}" alt="">
          </div>
          <div class="detail_info">
            <div class="item">
              <p id="dDay" class="dday">${projectVo.dDay}</p>
              <div id="dDayBarWrap" class="dday_bar_wrap" data-dday="${projectVo.dDayPercent}">
                <div class="dday_bar"></div>
              </div>
            </div>
            <div class="item">
              <p class="item_tit">???????????? ??????</p>
              <p id="pjMemo" class="item_exp">${projectVo.pjMemo}</p>
            </div>
            <div class="item">
              <p class="item_tit budget">??? ????????????</p>
              <p class="item_txt">${projectVo.fdSumAmt}???</p>
            </div>
            <div class="item">
              <p class="item_tit">????????????</p>
              <p class="item_txt">${projectVo.fdCnt}???</p>
            </div>
            <div class="item">
              <p class="item_tit">????????????</p>
              <p class="item_txt">${projectVo.chStDt}~${projectVo.chEndDt}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="pjt_detail_wrap">
      <div class="inner">
        <div id="pjContent" class="cont">
          <textarea name="editor" id="editor"></textarea>
        </div>
        <aside class="funding_aside sticky">
          <div class="item_wrap">
			<div class="invite_wrap" onClick="inviteProject();">
				<a href="" ><span class="material-icons-outlined">attach_email</span> ???????????? ????????????</a>
			  </div>
			  
            <div class="item budget">
              <p class="tit">????????????</p>
              <div class="funding_budget_wrap">
                <input id="fdAmt" type="text"  placeholder="?????? 5,000,000" maxlength="9"  onkeyup="inputNumberFormat(this)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                <p class="notice">
                  *???????????? ??? ?????? ?????? ?????? : 5,000,000 ???<br>
                  *????????? 1??? ???????????? ????????? ??????????????????.
                </p>
              </div>
            </div>
            <div class="item comment_list">
              <p class="tit">?????? ??????</p>
              <textarea id="fdComment" rows="3" minlength="5" maxlength="200" resize="none"></textarea>
              <button class="btn_style01" onClick="saveFunding()">????????????</button>
            </div>

            <div class="item comment">
              <p class="tit">?????? ??????</p>
              <div id="commentList"></div>
              <div class="pagination">
                <ul id="paging">
                  <!-- <li><a href=""><</a></li>
                  <li class="current"><a href="">1</a></li>
                  <li><a href="">2</a></li>
                  <li><a href="">3</a></li>
                  <li><a href="">4</a></li>
                  <li><a href="">5</a></li>
                  <li><a href="">></a></li> -->
                </ul>
              </div>
            </div>

          </div>
        </aside>

      </div>
    </div>



  </div>
  
	<%@ include file="../include/footer.jsp" %>

  <!-- <script>
    $(window).resize(function(){
      if (window.innerWidth > 750) {
        var aside = $('.pjt_detail_wrap .funding_aside');
        $('.pjt_detail_wrap .cont').css({
          'min-height': aside.height() + 300,
        });


        var stickEl = $('.sticky'),
                stickyElTop = stickEl.offset().top,
                stickyLeft = $('.pjt_detail_wrap .cont').width(),
                stickyPosi = $('.pjt_detail_wrap .inner').offset().left;

        var sticky = function(){
          var scrollTop = $(window).scrollTop();

          if (stickyElTop < scrollTop+96) {
            stickEl.addClass('is-fixed');
            stickEl.css('left', stickyPosi + stickyLeft + 36);
          } else {
            stickEl.removeClass('is-fixed');
            stickEl.css({
              left:'auto',
              right:0,
            });
          }

        };
        $(window).scroll(function() {
          sticky();
        });
      }
    }).resize();
  </script> -->
</body>
</html>
