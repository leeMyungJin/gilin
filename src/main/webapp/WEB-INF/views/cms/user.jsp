<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>기린</title>
    <%@ include file="./include/header.jsp" %>
</head>
<body>

<div id="cms" class="main_dashboard">
    <%@ include file="./include/aside.jsp" %>

    <div class="cms_cont cms_cust">

        <h1 class="cms_tit"><span class="material-icons-round">groups</span> 회원관리</h1>
        <div class="overview_area flex_wrap fb2">
            <div class="item">
                <p class="over_tit">일반회원수</p>
                <p class="over_txt">${count.user_count}</p>
            </div>
            <div class="item">
                <p class="over_tit">관리자 수</p>
                <p class="over_txt">${count.admin_count}</p>
            </div>
        </div>


        <div class="cms_filter_cont">
            <div class="filter_area flex_wrap">
                <div class="item">
                    <form id="search_form" name="search_form" onsubmit="return getUserList(this)">
                        <label for="con" class="mr">검색조건</label>
                        <select id="con" name="con" title="" class="mr">
                            <option value="" selected="selected">전체</option>
                            <option value="nickname">닉네임</option>
                        </select>

                        <input type="text" id="search" name="inq" value="" placeholder=",로 다중검색 가능" class="search mr">
                        <button class="btn">조회</button>
                    </form>
                </div>

                <div class="item">
                    <form action="" onsubmit="return updateAppVersion(this);">
                        <label for="Appversion" class="mr">APP 버전</label>
                        <input type="text" id="Appversion" name="version" value="${version}" placeholder="" class="search mr">
                        <button class="btn">수정</button>
                    </form>
                </div>

            </div>

            <div class="dashboard-wrap" style="overflow: hidden;">
                <div class="btn_wrap" style="float:left;">
                    <select id="setGridPageCount" onchange="perPage(this.value)" >
                        <option value="30" selected="selected">30</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>

                <div class="dashboard_btn_area cust">

                    <button class="dash_btn" onclick="_getUserGridLayout('userLayout', setGrid);">
                        <span class="material-icons-outlined">view_list</span>
                        칼럼 위치 저장
                    </button>
                    <button class="dash_btn" onclick="_resetUserGridLayout('userLayout', setGrid, gridBindings)">
                        <span class="material-icons-outlined">refresh</span>
                        칼럼 초기화
                    </button>
                    <button class="dash_btn" onclick="exportExcel('memberList');">
                        <span class="material-icons-outlined">file_download</span>
                        엑셀 다운로드
                    </button>

                </div>

                <div class="dashboard_area">
                    <div id="setGrid"></div>
                    <div id="setGridPager" class="pager"></div>
                    <div class="sub_cont">
                        <div class="btn_wrap">
                            <div class="btn_wrap">
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</div>


<div class="popup" id="image">
    <div id="imgPath" onmousedown="closePop();"></div>
</div>

<style>
    #setGrid.wj-flexgrid .wj-cell {
        padding: 12px;
    }

    #setGrid > div {
        height: auto !important;
    }

    #setGridPager {
        text-align: center;
    }

    #setGridPager .selectPage {
        color: #ddd;
    }
</style>

<script>

    var gridView, setGridPager, gridBindings, setGrid;
    gridBindings = [
        {binding: 'id', header: 'ID', isReadOnly: true, width: 100, align: "center"},
        {binding: 'nickname', header: '닉네임', isReadOnly: true, width: 100, align: "center"},
        {
            binding: 'profile_pic', header: '프로필사진', isReadOnly: true, width: 300, align: "center",
            cellTemplate: wijmo.grid.cellmaker.CellMaker.makeImage({
                click: (e, ctx) => showPop("image"),
                attributes: {
                    onerror:
                        "this.onerror=null; this.src='https://willchair.co.kr/img/icon_my_avatar.png';"
                }
            })
        },
        {binding: 'age', header: '연령대', isReadOnly: false, width: 200, align: "center"},
        {binding: 'gender', header: '성별', isReadOnly: false, width: 150, align: "center"},
        {binding: 'email', header: '이메일', isReadOnly: false, width: 200, align: "center"},
        {binding: 'adminFlag', header: '관리자 여부', width:200, align: "center", dataMap: "N,Y".split(",")},
        {binding: 'appversion', header: '앱버전', isReadOnly: true, width: 150, align: "center"},
        {binding: 'mos', header: '모바일OS', isReadOnly: true, width: 200, align: "center"},
        {binding: 'minfo', header: '모바일정보', isReadOnly: true, width: 300, align: "center"},
        {binding: 'cret_dt', header: '가입일', isReadOnly: true, width: 200, align: "center"},
        {binding: 'cret_dt', header: '마지막 접속일', isReadOnly: true, width: 200, align: "center"},
    ];

    var gridOption = loadGridUserList(gridBindings, 'userLayout');
    setGrid = gridOption.setGrid;
    setGridPager = gridOption.setGridPager;
    gridView = gridOption.gridView;



    //팝업 오픈
    function showPop(pop){

        if(pop == "new_staff"){


        }else if(pop == "modify_staff"){



        }else if(pop == "image"){

            var imgPath = setGrid.collectionView.currentItem["idprofile"]
            var img = '<img class="comment_img" src="'+imgPath+'"alt="이미지">';
            $('#imgPath').append(img)

        }

        $('#'+pop).addClass('is-visible');
    }


    //회원 리스트 조회
    function getUserList(f){

        $.ajax({
            type : 'GET',
            url : '/getListSearch',
            data : {
                con: f.con.value,
                inq: f.inq.value
            },
            success : function(result) {

                gridView = new wijmo.collections.CollectionView(result, {
                    pageSize: Number($('#setGridPageCount').val())
                });
                setGridPager.cv = gridView;
                setGrid.itemsSource = gridView;
                refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, 'setGrid');  // 페이징 초기 셋팅
                makeUrlHistoryPoint({path: "con=" + f.con.value + "&inq=" + f.inq.value})
            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

        return false;
    }

    //팝업 종료
    function closePop(){
        $('#imgPath').empty();
        $('.popup').removeClass('is-visible');
    }


    function updateAppVersion(f) {

        $.ajax({
            url : "/appversion/update",
            type : 'POST',
            cache : false,
            data : {
                version: f.version.value,
            },
            success : function(data) {
                alert('앱버전을 수정했습니다')
            },
            error : function(request,status,error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

        return false;

    }



</script>
</body>
</html>
