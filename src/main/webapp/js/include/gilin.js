$(document).ready(function() {

  // 헤더
  // $(window).scroll(function() {
  //   if ($(window).scrollTop() > 0) {
  //     $('.header').addClass('active');
  //   } else {
  //     $('.header').removeClass('active');
  //   }
  // });


var options = {
  offset: 300,
  offsetSide: 'top',
  classes: {
      clone:   'banner--clone',
      stick:   'banner--stick',
      unstick: 'banner--unstick'
  }
};

var banner = new Headhesive('.header', options);

  $('.header .search .search_icon').click(function() {
    $('.header .search').addClass('expand');
  });

  $('.header .search .close').click(function() {
    $('.header .search').removeClass('expand');
  });

  $('.header .mypage_wrap .mypage_btn').click(function() {
    $('.mypage_menu').toggleClass('active');
  });


  // 사이드 버튼
  $(function() {
      $(window).scroll(function() {
          if ($(this).scrollTop() > 500) {
              $('.side_btn_wrap .top').show(350);
          } else {
              $('.side_btn_wrap .top').hide(350);
          }
      });

      $(".side_btn_wrap .top").click(function() {
          $('html, body').animate({
              scrollTop : 0
          }, 400);
          return false;
      });
    });


  // 로그인 모달창
  $(function() {
    $('.modal_btn').on('click', function() {
      let modalTarget = $(this).data('modal-link');
      let modal = document.querySelector('.' + modalTarget);
      $(modal).toggleClass('active');
    });

    $('.modal_bg').on('click', function() {
      $(this).parents('.modal').toggleClass('active');
    });
    $('.modal .close_btn').on('click', function() {
      $(this).parents('.modal').toggleClass('active');
    });
  });

  // 파일업로드
  var inputs = document.querySelectorAll('.file_input')
  for (var i = 0, len = inputs.length; i < len; i++) {
    customInput(inputs[i])
  }

  function customInput(el) {
    const fileInput = el.querySelector('[type="file"]')
    const label = el.querySelector('[data-js-label]')

    fileInput.onchange =
      fileInput.onmouseout = function() {
        if (!fileInput.value) return

        var value = fileInput.value.replace(/^.*[\\\/]/, '')
        el.className += ' -chosen'
        label.innerText = value
      }
  }


  // 서브
  // 서브헤더
  let chn_img = $('.sub .detail_info_wrap .img_wrap img').attr('src');
  $('.sub .sub_header .bg').css('background-image', `url(${chn_img})`);

  // 서브헤더2
  $(window).scroll(function() {
    if ($(window).scrollTop() > 400) {
      $('.sub_header02').addClass('active');
    } else {
      $('.sub_header02').removeClass('active');
    }
  });

  // 프로젝트 dday_bar
  let dday_data = $('.detail_info .dday_bar_wrap').data('dday');
  $('.detail_info .dday_bar_wrap .dday_bar').css('width', `${dday_data}px`);

  // pjt_count
  let pjt_count = $('.channel_open .pjt_count .chk_btn');
  $(pjt_count).click(function() {
    if ($(pjt_count).find('input#chk01').attr('checked')) {
      $('.channel_open .pjt_count .showbox').removeClass('active');
    } else {
      $('.channel_open .pjt_count .showbox').addClass('active');
    }
  });


  // 채널 오픈
  $('.chk_wrap').click(function() {
    if ($('.channel_open input[name="radio"]:checked').val() == 'public') {
      $('.channel_open .chk_wrap .showbox').removeClass('active');
    } else {
      $('.channel_open .chk_wrap .showbox').addClass('active');
    }
  });

  $('.chk_wrap').click(function() {
    if ($('.mychannel_modi input[name="radio"]:checked').val() == 'public') {
      $('.mychannel_modi .chk_wrap .showbox').removeClass('active');
    } else {
      $('.mychannel_modi .chk_wrap .showbox').addClass('active');
    }
  });


});
