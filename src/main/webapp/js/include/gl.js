$(document).ready(function() {

  // 풀페이지
  $('#fullpage').fullpage({
    // responsiveWidth: 3000,
    verticalCentered: true,
    anchors: ['anchor1', 'anchor2', 'anchor3', 'anchor4', 'anchor5'],
    menu: '#menu',
    'afterLoad': function(anchorLink, index) {
      if (anchorLink == 'anchor1') {
        $('.header .logo img').attr('src', 'https://gilin.co.kr/img/landing/logo.svg');
      } else {
        $('.header .logo img').attr('src', 'https://gilin.co.kr/img/landing/logo02.svg');
      }
      if (anchorLink == 'anchor3') {
        $('.header').addClass('active');
      } else {
        $('.header').removeClass('active');
      }
    }
  });


  // // top_btn
  // $(".top_btn").click(function() {
  //   fullpage_api.moveTo('anchor1', 1);
  // });

  // Splitting({ target: '.spl' });

  var swiper = new Swiper('.slider', {
    autoplay: {
      delay: 5000,
      autoplayDisableOnInteraction: false
    },
    speed: 500,
    slidesPerView: 1,
    spaceBetween: 0,
    shortSwipes: true,
    longSwipes: true,
    grabCursor: true,
    loop: true,
    mousewheel: false,
    keyboard: {
      enabled: true
    },
    // direction: 'vertical',
  });

  function slideOneActive() {
    $(".s-1").addClass("active");
    $(".s-2, .s-3").removeClass("active");
    $(".s-1 .p-holder").slideDown(300);
    $(".s-2 .p-holder, .s-3 .p-holder").slideUp(300);
    swiper.autoplay.start();
  }

  function slideTwoActive() {
    $(".s-2").addClass("active");
    $(".s-1, .s-3").removeClass("active");
    $(".s-2 .p-holder").slideDown(300);
    $(".s-1 .p-holder, .s-3 .p-holder").slideUp(300);
    swiper.autoplay.start();
  }

  function slideThreeActive() {
    $(".s-3").addClass("active");
    $(".s-1, .s-2").removeClass("active");
    $(".s-3 .p-holder").slideDown(300);
    $(".s-1 .p-holder, .s-2 .p-holder").slideUp(300);
    swiper.autoplay.start();
  }

  swiper.on('slideChangeTransitionStart', function() {
    if ($(".one").hasClass("swiper-slide-active")) {
      slideOneActive();
    }
    if ($(".two").hasClass("swiper-slide-active")) {
      slideTwoActive();
    }
    if ($(".three").hasClass("swiper-slide-active")) {
      slideThreeActive();
    }
  });


  $(".s-1").click(function() {
    swiper.slideTo($('.one').index());
    slideOneActive();
  });
  $(".s-2").click(function() {
    swiper.slideTo($('.two').index());
    slideTwoActive();
  });
  $(".s-3").click(function() {
    swiper.slideTo($('.three').index());
    slideThreeActive();
  });

  slideOneActive();



});
