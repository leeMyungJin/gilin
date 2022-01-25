<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
    Kakao.init('968d0faff8cf6b9a122fd3245d712fbf'); //카카오 javascript키
    //console.log(Kakao.isInitialized()); // sdk초기화여부판단

    function enterkeyHeader(type) {
        if (window.event.keyCode == 13) {
            if(type == 'search'){
                moveChannelSearch();
            }
        }
    }
    function moveChannelSearch() {
        location.href="/search?topSearch="+$('#topSearch').val();
    }
    //카카오로그인
    function kakaoLogin(){
        Kakao.Auth.login({
            success: function (response) {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response) {
                        var params = {
                            id : response.id
                            , email : ( response.kakao_account.email != 'null'? response.kakao_account.email : '-' )
                            , gender : ( response.kakao_account.gender != 'null'? response.kakao_account.gender : '-' )
                            , age : ( response.kakao_account.age_range != 'null'? response.kakao_account.age_range : '-' )
                            , nickname : ( response.kakao_account.profile.nickname != 'null'? response.kakao_account.profile.nickname : '-' )
                            , profilePic : ( response.kakao_account.profile.thumbnail_image_url != 'null'? response.kakao_account.profile.thumbnail_image_url : '-' )
                        }
                        webLogin(params);
                    },
                    fail: function (error) {
                        console.log(error)
                        alert('카카오 로그인에 실패하였습니다.');
                    },
                })
            },
            fail: function (error) {
                console.log(error)
            },
        })
    }
    //로그아웃
    function logout(){
        console.log(Kakao.Auth.getAccessToken());

        if (Kakao.Auth.getAccessToken() != "") {
            Kakao.Auth.logout(function() {
                $.ajax({
                    type : 'POST',
                    url : '/login/logout',
                    async : false, // 비동기모드 : true, 동기식모드 : false
                    dataType : null,
                    success : function(result) {
                        console.log("logout success");
                        location.href="/";
                    },
                    error: function(request, status, error) {
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

                    }
                });
            })

        }else{
            $.ajax({
                type : 'POST',
                url : '/login/logout',
                async : false, // 비동기모드 : true, 동기식모드 : false
                dataType : null,
                success : function(result) {
                    console.log("logout success");
                    location.href="/";
                },
                error: function(request, status, error) {
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

                }
            });
            //location.href="/";
        }
    }

    //카카오 계정 연결끊기
    function kakaoUnlink() {
        if (Kakao.Auth.getAccessToken() != "") {
            Kakao.API.request({
                url: '/v1/user/unlink',
                success: function (response) {
                    console.log(response)
                },
                fail: function (error) {
                    console.log(error)
                },
            })
            Kakao.Auth.setAccessToken(undefined)
        }
    }
    function webLogin(params){
        console.log("params : ");
        console.log(params);

        $.ajax({
            type : 'POST',
            url : '/login/login',
            async : false, // 비동기모드 : true, 동기식모드 : false
            dataType : null,
            data : params,
            success : function(result) {
                console.log("login success");
                location.reload();
            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

    }
    function moveMypage(){
        if(memberId != ""){
            location.href="/member/mypage";
        }
    }
    function moveAdminPage(){
        if (memberAuth == 't') {
            location.href="/cms/user";
        }
    }

    function moveNotice(){
        location.href="/notice";
    }
    function loginInit(){
        AppleID.auth.init({
            clientId : 'kr.co.gilin.gilin001',
            scope : 'name email',
            redirectURI: 'https://gilin.co.kr/',
            state : 'gilinAppleLogin',
            usePopup : true
        });
    }
    function appleLogin(){

        //애플로 로그인 성공 시.
        document.addEventListener('AppleIDSignInOnSuccess', (data) => {
            /* //테스트 유저 정보 (로컬에서는 애플 로그인 테스트가 불가하기에 아래 셈플 데이터로 확인)
            var detail = JSON.parse('{"authorization": {"code": "c5dc09c3c45a04e88a4dfb02b1f2cebb3.0.rywy.gFoM2VQZm4dXuv1zgtGy7w","id_token": "eyJraWQiOiJZdXlYb1kiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoia3IuY28uZ2lsaW4uZ2lsaW4wMDEiLCJleHAiOjE2MzgxODc3NDcsImlhdCI6MTYzODEwMTM0Nywic3ViIjoiMDAwODY4LmE2ZmUzMGUzZGMzYzRkMmZiNjU3NGI4NjcwMzNlYWY2LjExMjQiLCJjX2hhc2giOiJrTHlmMHUyZm1tLU5TMkZZR1FZdzRBIiwiZW1haWwiOiJ3aGl0YWtlcmNvbXBhbnlAbmF2ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiYXV0aF90aW1lIjoxNjM4MTAxMzQ3LCJub25jZV9zdXBwb3J0ZWQiOnRydWV9.L3l0S23MmAZMuZoMI7N9JGGF-Ke0h0I9RujvKjSsyEqTIgqQSIuX48qdvb2XJdEW4AWTZWJCS0yp3HJdeB23AK2p0xtV008jrMCyy5YnMBxMvA6bskr5aFE5-3qawVJGilbG8GeMvf2_WJhcKjTnXh48f46GFb6DLFK7nOlvcT3sXBp7wLJ3Dm88907bArZPh18AGKEEgVDVO6TM9_wYyGUmIPIHWxnL7jFkwlqQ2wokRVMtATgVj8zy8JI6bXVODSbv-0avzIkutjA4WIGa_NYVVd9zCYXsup-Ix0cq_jpbhZP0xwc6yMaqyQOimZAA1u-x0eOAhs6grHdnvuDD2Q","state": "gilinAppleLogin"},"user": {"name": {"firstName": "휘테커","lastName": "벤"},"email": "whitakercompany@naver.com"}}');
             var id_token = detail.authorization.id_token;
             var name = detail.user.name.lastName+detail.user.name.firstName;
             console.log("name : " + name); */


            /*//이름은 항상 Gilin 으로 셋팅하기로 함.
            var name = '';
             if(data.detail.user != undefined){
                 console.log(data.detail.user.name.firstName+data.detail.name.user.lastName);
                 name = data.detail.user.name.firstName + data.detail.name.user.lastName;
             }
             console.log("name : " + name); */

            var id_token = data.detail.authorization.id_token;
            var id_token_str = id_token.split('.');
            var id_token_decode = JSON.parse(atob(id_token_str[1]));

            var params = {
                id : id_token_decode.sub
                , email : id_token_decode.email
                , gender : '-'
                , age : '-'
                , nickname : 'Gilin'
                , profilePic : 'https://gilin.co.kr/img/basedprofile/icon_my_avatar.png'
            }

            webLogin(params);
        });

        //애플로 로그인 실패 시.
        document.addEventListener('AppleIDSignInOnFailure', (error) => {
            //handle error.
            alert("애플로그인에 실패하였습니다.");
            //todo fail logic
        });

    }
</script>

<header class="header">
    <div class="inner">
        <a href="/" class="logo">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 132.76 57.5"><defs><style>.cls-1,.cls-5{fill:#f1b418;}.cls-2{fill:#8c653b;}.cls-10,.cls-2,.cls-3,.cls-4,.cls-5,.cls-6,.cls-7,.cls-8,.cls-9{fill-rule:evenodd;}.cls-3{fill:#f1b51a;}.cls-4{fill:#8d653b;}.cls-6{fill:#f1b61d;}.cls-7{fill:#f1b519;}.cls-8{fill:#8d663c;}.cls-9{fill:#8e673d;}.cls-10{fill:#8e663b;}</style></defs><path class="cls-1" d="M113.61,29.11c3.14-3.25,6.82-4.9,11.32-4.13s7.44,3.58,9,7.79c1.53,4,1.73,8.3,1.66,12.57a32.34,32.34,0,0,1-1.17,9.54,10.51,10.51,0,0,1-.77,1.87c-.84,1.57-2.07,2.68-4,2.52s-3.69-1-4.45-3a11.91,11.91,0,0,1-.67-4.34c.08-3.29.19-6.59.27-9.89a9,9,0,0,0-.57-3.51,4.7,4.7,0,0,0-7.46-2.07,7.2,7.2,0,0,0-2.85,5.9c0,3.15.5,6.26.49,9.4a13.47,13.47,0,0,1-.52,3.89c-.78,2.48-2.32,3.83-4.52,3.94-3.15.15-5.09-1-6.14-3.51a16.23,16.23,0,0,1-.82-7.28A123.36,123.36,0,0,0,102.28,34c-.15-2.83.26-5.49,2.77-7.35,2.85-2.12,5.84-1.63,7.84,1.3C113.14,28.31,113.35,28.69,113.61,29.11Z" transform="translate(-2.88 -3.14)"/><path class="cls-2" d="M97.59,8.36c0,2.89-2.61,5.22-5.83,5.22s-5.82-2.33-5.82-5.22,2.6-5.22,5.82-5.22S97.59,5.47,97.59,8.36Z" transform="translate(-2.88 -3.14)"/><path class="cls-2" d="M61.46,8.36c0,2.89-2.61,5.22-5.83,5.22s-5.82-2.33-5.82-5.22,2.61-5.22,5.82-5.22S61.46,5.47,61.46,8.36Z" transform="translate(-2.88 -3.14)"/><path class="cls-3" d="M45.09,49.39c-.6,3.15-1.72,6-4.22,8.23a7.63,7.63,0,0,1-3.32,1.79,7,7,0,0,0-1.67-1.71c-1.87-1.45-3.94-2.15-6.24-1.13a8.84,8.84,0,0,0-4.2,3.77A8.62,8.62,0,0,1,24,60.22l-1.42-.14c-.93-.11-1.85-.24-2.77-.43A22.69,22.69,0,0,1,14.67,58a20.58,20.58,0,0,1-4.53-2.82,16.91,16.91,0,0,1-3.69-4.39,27.82,27.82,0,0,1-3.09-7A12.27,12.27,0,0,1,3,41.84a5.17,5.17,0,0,1,0-1.4c2.19.94,3,.76,4.59-1.14a8.75,8.75,0,0,0,1.17-1.79,22.9,22.9,0,0,0,2.39-11.44c-.12-2.39-.86-3.4-2.92-4.1a15.71,15.71,0,0,1,5.1-4.6,23.17,23.17,0,0,1,6.51-2.89A22,22,0,0,0,22.66,18c3.12,2.9,6.48,2.91,9.55,0a20,20,0,0,0,3.62-4.9c3.19.25,5.94,2.33,6.54,4.93A3.76,3.76,0,0,1,39,22.69a14.48,14.48,0,0,1-3.35-.15c-6.31-1.06-12.09.11-17.06,4.3-3.73,3.15-5.14,7.28-4.7,12.09.32,3.55,1.26,6.87,4,9.36,4,3.66,8.74,4.22,13.75,2.66,2.47-.77,3.53-3,3-5.56s-2.25-3.87-5-3.71c-.95,0-1.91.19-2.86.16a3.54,3.54,0,0,1-3.55-2.69c-.64-2.11-.25-4.45,1.21-5.25A16.2,16.2,0,0,1,36.09,32a5.3,5.3,0,0,0-1.27,4.76A18.33,18.33,0,0,0,40,46.19,9.82,9.82,0,0,0,45.09,49.39ZM16.26,50.63a4.47,4.47,0,0,0-.67-2.39,2.08,2.08,0,0,0-2.47-1,2.14,2.14,0,0,0-1.56,2.16,4.58,4.58,0,0,0,1.61,3.48,1.66,1.66,0,0,0,1.81.6,1.89,1.89,0,0,0,1.2-1.78C16.21,51.34,16.23,51,16.26,50.63Z" transform="translate(-2.88 -3.14)"/><path class="cls-4" d="M8.19,22c2.06.7,2.8,1.72,2.92,4.13A23.24,23.24,0,0,1,8.72,37.63a8.56,8.56,0,0,1-1.17,1.8C5.93,41.35,4.66,41.54,3,40.58c-.13-.07-.07-.45-.06-.58.07-1.56,0-3.11.11-4.67a18.26,18.26,0,0,1,.39-2.85c.12-.5.14-1,.27-1.51A20.8,20.8,0,0,1,8.19,22Z" transform="translate(-2.88 -3.14)"/><path class="cls-5" d="M79.07,31.68V52.55a8.43,8.43,0,0,1-1.15,4.58,4.41,4.41,0,0,1-7.58.27A7.48,7.48,0,0,1,69,52.88q0-20.75,0-41.51a15.36,15.36,0,0,1,.22-2.62c.53-3,2.75-4.88,5.44-4.59a4.11,4.11,0,0,1,3,1.79,8.06,8.06,0,0,1,1.43,5Z" transform="translate(-2.88 -3.14)"/><path class="cls-6" d="M50.57,38.54c0-5.16,0-10.31,0-15.47a5,5,0,0,1,6.8-4.95c2.08.65,3.31,2.49,3.32,5.14,0,6.24,0,12.47,0,18.71,0,4,0,8.07,0,12.11s-3.08,6.17-6.7,5.1c-2.16-.65-3.42-2.48-3.42-5C50.56,48.93,50.57,43.74,50.57,38.54Z" transform="translate(-2.88 -3.14)"/><path class="cls-7" d="M96.8,38.59c0,5.19,0,10.39,0,15.58,0,3.17-2,5.21-5,5.23s-5.1-2-5.1-5.25q0-15.52,0-31a4.84,4.84,0,0,1,5.12-5.22c3,0,5,2.06,5,5.24C96.81,28.28,96.8,33.43,96.8,38.59Z" transform="translate(-2.88 -3.14)"/><path class="cls-4" d="M45.09,49.39A9.82,9.82,0,0,1,40,46.19a18.33,18.33,0,0,1-5.19-9.39A5.3,5.3,0,0,1,36.09,32,10.6,10.6,0,0,1,44,38.43,16.93,16.93,0,0,1,45.09,49.39Z" transform="translate(-2.88 -3.14)"/><path class="cls-8" d="M35.83,13.1A20,20,0,0,1,32.21,18c-3.07,2.92-6.43,2.91-9.55,0a22,22,0,0,1-2.86-3.53A30.4,30.4,0,0,1,35.83,13.1Z" transform="translate(-2.88 -3.14)"/><path class="cls-9" d="M25.44,60.34a8.84,8.84,0,0,1,4.2-3.77c2.3-1,4.37-.32,6.24,1.13a7,7,0,0,1,1.67,1.71,14.16,14.16,0,0,1-5.44,1.12A29.77,29.77,0,0,1,25.44,60.34Z" transform="translate(-2.88 -3.14)"/><path class="cls-10" d="M16.26,50.63c0,.35-.05.71-.08,1.06A1.89,1.89,0,0,1,15,53.47a1.66,1.66,0,0,1-1.81-.6,4.58,4.58,0,0,1-1.61-3.48,2.14,2.14,0,0,1,1.56-2.16,2.08,2.08,0,0,1,2.47,1A4.47,4.47,0,0,1,16.26,50.63Z" transform="translate(-2.88 -3.14)"/></svg>
        </a>
        <div class="nav_wrap login">
            <div id="topSearchDiv" class="search">
                <input id="topSearch" type="text" name="input" class="input" placeholder="채널명만 검색 가능합니다." onkeyup="enterkeyHeader('search');">
                <span class="material-icons-outlined search_icon" onClick="">search</span>
                <div class="close"></div>
            </div>

            <!-- 로그인 전 -->
            <div id="b_login" class="b_login">
                <a href="javascript:void(0);" onClick="loginInit()" class="login_btn modal_btn" data-modal-link="login_modal">LOGIN</a>
            </div>

            <!-- 로그인 완료 -->
            <div class="mypage_wrap a_login" id="a_login" style="display:none;">
                <span class="material-icons-round mypage_btn">person</span>
                <ul class="mypage_menu">
                    <li><a href="javascript:void(0);" onClick="moveMypage()">Mypage</a></li>
                    <li><a href="javascript:void(0);" onClick="logout()">Logout</a></li>
                    <li id="btnMoveAdmin"><a href="javascript:void(0);" onClick="moveAdminPage()">Admin</a></li>
                </ul>
            </div>

            <a class="kakao modal_login_btn" href="javascript:void(0);" onClick="kakaoUnlink()" style="display:none;">카카오 연결끊기</a>


        </div>
    </div>
</header>

<div class="modal login_modal">
    <div class="modal_bg"></div>
    <div class="modal_cont flex_wrap">
        <span class="material-icons-outlined close_btn">close</span>
        <div class="txt_wrap">
            <img src="../img/gilin_app_logo.svg" alt="" class="logo">
            <p class="maintxt">프로젝트의 시작은<br>기린에서<i>!</i></p>
            <p class="subtxt">기린에서 성공적인 프로젝트를 만들어보세요.</p>
        </div>

        <div class="login_cont">
            <h2>로그인</h2>
            <p>간편로그인으로 기린 시작하기</p>
            <a class="kakao modal_login_btn" href="javascript:void(0);" onClick="kakaoLogin()"><img src="../img/icon_kakao.svg">카카오로 로그인</a>
            <div class="apple-login-wrap" style="position: relative">
                <a class="apple modal_login_btn" style="position:absolute; opacity: 0" href="javascript:void(0);" onClick="appleLogin()" id="appleid-signin"><img src="../img/icon_apple.svg">Apple로 로그인</a>
                <!-- 수정추가 -->
                <a class="apple modal_login_btn" href="javascript:void(0);" ><img src="img/icon_apple.svg" alt="">Apple로 로그인</a>
                <!-- 수정끝 -->
            </div>


        </div>
    </div>
</div>

<!-- 수정추가 -->
<div class="side_btn_wrap">
    <a href="javascript:void(0);" onClick="moveNotice()" class="notice"><span class="material-icons-outlined">chat</span>공지사항</a>
    <a href="" class="top">TOP</a>
</div>
<!-- 수정추가 끝 -->

<style>
    #appleid-signin > div > div:nth-child(1) > svg > g > svg > text {
        font-size: 11px;
    }
</style>