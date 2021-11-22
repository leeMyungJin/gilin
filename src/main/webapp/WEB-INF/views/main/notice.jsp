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
	sessionCheck(memberId, memberAuth, 'notice');
	
	getNoticeList();
	
}

function getNoticeList(){
	var innerHtml = "";
	
	$.ajax({
	     type : 'POST',
	     url : '/getNoticeList',
	     dataType : null,
	     success : function(result) {
	     	console.log("getNoticeList success");
	     	
	     	if(result.length > 0){
	          	for(var i =0; i<result.length; i++){	
	   				innerHtml += '<div class="accordion-wrap" onClick="clickAcco(this);">'+
					   		        '<div class="accordion-item">'+
					   		        '<div class="accordion-header">'+
					   		         '<p>'+result[i].ntTitle+' <span class="date">'+result[i].cretDt+'</span></p> <span class="material-icons-outlined arrow_icon">expand_more</span>'+
					   		        '</div>'+
					   		        '</div>'+
					   		        '<div class="accordion-text">'+
					   		        '<p>'+result[i].content+'</p>'+
					   		        '</div>'+
					   		        '</div>';
	          	}
	          	
	          }else{
	        	  //내 채널이 없을 경우
	        	  innerHtml = '<p class="no-gallery">공지사항이 없습니다.</p>';	
	          }
	     	
	    	$('#notice').html(innerHtml);
	     	
	     },
	     error: function(request, status, error) {
	     	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	     }
	 }); 
}

function clickAcco(id){
	$(id).children().eq(1).slideToggle(300);
    $(id).children().eq(0).toggleClass("accordion-no-bar");
    $(id).siblings().find(".accordion-header").removeClass("active");
    $(id).siblings().find(".accordion-header .arrow_icon").removeClass("rotate");
    $(id).find(".accordion-header").toggleClass("active");
    $(id).find(".arrow_icon").toggleClass("rotate");

    $(".accordion-wrap .accordion-text").not($(id).children().eq(1)).slideUp(300);
	
}

</script>

<body onload="pageLoad();">
  <%@ include file="../include/header.jsp" %>

  <div class="sub notice">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">공지사항</p>
      </div>
    </div>

    <div class="notice">
      <div id="notice" class="inner"></div>
    </div>
  </div>


  <%@ include file="../include/footer.jsp" %>

</body>
</html>
