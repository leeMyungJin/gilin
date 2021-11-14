<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<body class="project">
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
            <img src="img/sample.png" alt="">
          </div>
          <div class="detail_info">
            <div class="item">
              <p class="dday">D-16</p>
              <div class="dday_bar_wrap" data-dday="16">
                <div class="dday_bar"></div>
              </div>
            </div>
            <div class="item">
              <p class="item_tit">프로젝트 설명</p>
              <p class="item_exp">120자 글자 제한</p>
            </div>
            <div class="item">
              <p class="item_tit budget">총 펀딩금액</p>
              <p class="item_txt">2,000,000,000</p>
            </div>
            <div class="item">
              <p class="item_tit">프로젝트 수</p>
              <p class="item_txt">25개</p>
            </div>
            <div class="item">
              <p class="item_tit">채널기간</p>
              <p class="item_txt">2021.09.01~10.07</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="report_wrap">
      <div class="inner">
        <div class="report_item">
          <h3>1. 프로젝트 개수 <span>(참가 팀 수)</span></h3>
          <p class="result_txt">총 <span>30</span>개의 프로젝트 등록</p>
          <div class="grid_box">

          </div>
        </div>

        <div class="report_item">
          <h3>2. 총 펀딩 금액 <span>(참가 팀 수)</span></h3>
          <p class="result_txt">총 <span>200,000,000</span>원의 펀딩 완료</p>
          <div class="grid_box">

          </div>
        </div>

        <div class="report_item">
          <h3>3. 채널 방문자 수</h3>
          <p class="result_txt">총 <span>100</span>회의 방문 기록</p>
          <div class="grid_box">

          </div>
        </div>

        <div class="report_item">
          <h3>4. 총 댓글 수<span>(펀딩 인원 수)</span></h3>
          <p class="result_txt">총 <span>200</span>개의 응원 댓글</p>
          <div class="grid_box">

          </div>
        </div>

      </div>
    </div>

  </div>
  
	<%@ include file="../include/footer.jsp" %>

</body>
</html>
