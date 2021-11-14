<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<body class="project">
  <%@ include file="../include/header.jsp" %>

  <div class="sub project">

    <div class="sub_header">
      <div class="bg"></div>
      <div class="inner">
        <p class="tit">프로젝트 이름</p>
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
              <p class="item_tit">응원댓글</p>
              <p class="item_txt">25개</p>
            </div>
            <div class="item">
              <p class="item_tit">펀딩기간</p>
              <p class="item_txt">2021.09.01~10.07</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="pjt_detail_wrap">
      <div class="inner">
        <div class="cont">
          상세페이지
        </div>
        <aside class="funding_aside sticky">
          <div class="item_wrap">
            <div class="item budget">
              <p class="tit">펀딩금액</p>
              <div class="funding_budget_wrap">
                <input type="text" placeholder="최대 5,000,000" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                <p class="notice">
                  *프로젝트 당 최대 펀딩 금액 : 5,000,000 원<br>
                  *채널 당 최대 펀딩 금액 : 10,000,000 원<br>
                  *펀딩은 1회 한정이며 수정이 불가능합니다.
                </p>
              </div>
            </div>
            <div class="item comment_list">
              <p class="tit">응원 댓글</p>
              <textarea id="story" rows="3" minlength="5" maxlength="200" resize="none"></textarea>
              <button class="btn_style01">펀딩하기</button>
            </div>

            <div class="item comment">
              <p class="tit">응원 댓글</p>
              <div class="comment_item">
                <div class="profile_img">
                  <img src="img/myprofile.svg" alt="" class="default">
                </div>
                <div class="profile_txt">
                  <p class="nick">Nickname</p>
                  <p class="comment_txt">코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트</p>
                  <div class="btn_wrap">
                    <button class="btn_style01">수정</button>
                    <button class="btn_style01">삭제</button>
                  </div>
                </div>
              </div>
              <div class="comment_item">
                <div class="profile_img">
                  <img src="img/myprofile.svg" alt="" class="default">
                </div>
                <div class="profile_txt">
                  <p class="nick">Nickname</p>
                  <p class="comment_txt">코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트</p>
                </div>
              </div>
              <div class="comment_item">
                <div class="profile_img">
                  <img src="img/myprofile.svg" alt="" class="default">
                </div>
                <div class="profile_txt">
                  <p class="nick">Nickname</p>
                  <p class="comment_txt">코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트 코멘트</p>
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


            <div class="invite_wrap">
              <a href="" ><span class="material-icons-outlined">attach_email</span> 프로젝트 초대하기</a>
            </div>
          </div>
        </aside>

      </div>
    </div>



  </div>
  
	<%@ include file="../include/footer.jsp" %>

  <script>
  var aside = $('.pjt_detail_wrap .funding_aside');
  $('.pjt_detail_wrap .cont').css({
    height: aside.height() + 300,
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
  </script>
</body>
</html>
