<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<script type="text/javascript">

var memberId = "<%=session.getAttribute("id")%>";
var memberAuth = "<%=session.getAttribute("adminYn")%>";

var chSeq = "${chSeq}"; //채널

function pageLoad(){
	sessionCheck(memberId, memberAuth, 'myreport');
	
	console.log("${channelVo}");
	console.log("${channelVo.dDayPercent}");
	
	getTotReportInfo();
	getReportChart('totPjtCntChart', '프로젝트 수');
	getReportChart('totFdAmtChart', '펀딩금액');
	getReportChart('totChVisitCntChart', '채널 방문자 수');
	getReportChart('totCmtCntChart', '댓글 수');
	
}

function getReportChart(type, chartNm){
	var param = {
			chSeq 	: chSeq
			, type : type
		};
	
	$.ajax({
	      type : 'POST',
	      url : '/report/getReportChart',
	      dataType : null,
	      data : param,
	      success : function(result) {
	      	createChart(result, type, chartNm);
	       
	      },
	      error: function(request, status, error) {
	      	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	  });
}

function createChart(result, chartId, chartNm){
	let linechart = new wijmo.chart.FlexChart('#'+chartId, {
	   // header: chartNm,
	    legend: {
	      position: wijmo.chart.Position.Bottom
	    },
	    chartType: wijmo.chart.ChartType.Line,
	    bindingX: 'date',
	    series: [{
	      binding: 'val',
	      //ame: chartNm
	    }],
	    //axisLine:false,
	    itemsSource: result,
	    palette: ['#577590', '#F8961E', '#F94144', '#90BE6D', '#F9C74F', '#43AA8B', ]
	  });
	  
	  linechart.dataLabel.content = "{y}";
	  linechart.plotMargin = '50 50 50 *';
	  let ani = new wijmo.chart.animation.ChartAnimation(linechart);
	  ani.animationMode = wijmo.chart.animation.AnimationMode.Point;
}

function getTotReportInfo(){
	var param = {
			chSeq 	: chSeq
		};
	
	$.ajax({
	      type : 'POST',
	      url : '/report/getTotReportInfo',
	      dataType : null,
	      data : param,
	      success : function(result) {
	      	$("#totPjtCnt").text(Number(result.totpjtcnt).toLocaleString('ko-KR'));
	        $("#totFdAmt").text(Number(result.totfdamt).toLocaleString('ko-KR'));
	        $("#totChVisitCnt").text(Number(result.totchvisitcnt).toLocaleString('ko-KR'));
	        $("#totCmtCnt").text(Number(result.totcmtcnt).toLocaleString('ko-KR'));
	       
	      },
	      error: function(request, status, error) {
	      	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	  });
}

</script>

<body onLoad='pageLoad()' class="project">
  <%@ include file="../include/header.jsp" %>

  <div class="sub myreport">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">결과 보고서</p>
      </div>
    </div>

    <div class="detail_info_wrap pjt">
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

    <div class="report_wrap">
      <div class="inner">
        <div class="report_item">
          <h3>1. 프로젝트 개수 <span>(참가 팀 수)</span></h3>
          <p class="result_txt">총 <span id="totPjtCnt">0</span>개의 프로젝트 등록</p>
          <div id="totPjtCntChart" class="grid_box" style="height:300px;">

          </div>
        </div>

        <div class="report_item">
          <h3>2. 총 펀딩 금액 <span>(참가 팀 수)</span></h3>
          <p class="result_txt">총 <span id="totFdAmt">0</span>원의 펀딩 완료</p>
          <div id="totFdAmtChart" class="grid_box" style="height:300px;">

          </div>
        </div>

        <div class="report_item">
          <h3>3. 채널 방문자 수</h3>
          <p class="result_txt">총 <span id="totChVisitCnt">0</span>회의 방문 기록</p>
          <div id="totChVisitCntChart" class="grid_box" style="height:300px;">

          </div>
        </div>

        <div class="report_item">
          <h3>4. 총 댓글 수<span>(펀딩 인원 수)</span></h3>
          <p class="result_txt">총 <span id="totCmtCnt">0</span>개의 응원 댓글</p>
          <div id="totCmtCntChart" class="grid_box" style="height:300px;">

          </div>
        </div>

      </div>
    </div>

  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
