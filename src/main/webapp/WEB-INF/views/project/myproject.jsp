<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>


<body>
  <%@ include file="../include/header.jsp" %>

  <div class="sub mychannel">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 프로젝트 관리</p>
      </div>
    </div>

    <div class="mypage_cont">
      <div class="inner">


            <div class="flex_wrap gallery gall03">

              <!-- 펀딩이 없을때 -->
              <!-- <p class="no-gallery">참여한 펀딩이 없습니다.</p> -->

              <div class="flex_box" onclick="location.href=''">
                <div class="img_wrap">
                  <img src="img/sample.png" alt="">
                  <div class="btn_wrap">
                    <button class="gall_hover_btn">프로젝트 바로가기</button>
                    <button class="gall_hover_btn">수정/삭제</button>
                  </div>
                </div>
                <div class="txt_wrap">
                  <p class="chn_tit">채널 이름</p>
                  <p class="chn_txt">채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름</p>
                  <div class="detail_info">
                    <p class="budget">2,000,000</p>
                    <p class="dday">D-20</p>
                  </div>
                </div>
              </div>
              <div class="flex_box" onclick="location.href=''">
                <div class="img_wrap">
                  <img src="img/sample.png" alt="">
                  <div class="btn_wrap">
                    <button class="gall_hover_btn">프로젝트 바로가기</button>
                    <button class="gall_hover_btn">수정/삭제</button>
                  </div>
                </div>
                <div class="txt_wrap">
                  <p class="chn_tit">채널 이름</p>
                  <p class="chn_txt">채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름</p>
                  <div class="detail_info">
                    <p class="budget">2,000,000</p>
                    <p class="dday">D-20</p>
                  </div>
                </div>
              </div>
              <div class="flex_box" onclick="location.href=''">
                <div class="img_wrap">
                  <img src="img/sample.png" alt="">
                  <div class="btn_wrap">
                    <button class="gall_hover_btn">프로젝트 바로가기</button>
                    <button class="gall_hover_btn">수정/삭제</button>
                  </div>
                </div>
                <div class="txt_wrap">
                  <p class="chn_tit">채널 이름</p>
                  <p class="chn_txt">채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름 채널 이름</p>
                  <div class="detail_info">
                    <p class="budget">2,000,000</p>
                    <p class="dday">D-20</p>
                  </div>
                </div>
              </div>
            </div>




        <div class="pagination">
          <ul>
            <li><a href=""><</a></li>
            <li class="current"><a href="">1</a></li>
            <li><a href="">2</a></li>
            <li><a href="">3</a></li>
            <li><a href="">4</a></li>
            <li><a href="">5</a></li>
            <li><a href="">></a></li>
          </ul>
        </div>

      </div>
    </div>



  </div>
  
	<%@ include file="../include/footer.jsp" %>


</body>
</html>
