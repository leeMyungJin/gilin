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
    <div id="imgPath" onmousedown="closePop();">

    </div>
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

    .popup {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        font-size: 0.9em;
        visibility: hidden;
        background-color: rgba(0, 0, 0, 0.5);
    }
    .popup_container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 620px;
        min-height: 300px;
        max-height: calc(100% - 120px);
        background-color: #fff;
        box-shadow: 3px 3px 12px rgba(44, 44, 44, 0.2);
        overflow: auto;
    }
    .popup_head {
        padding: 0 30px;
        height: 60px;
        color: #fff;
        font-size: 1.5em;
        font-weight: bold;
        line-height: 60px;
        background-color: #E98B73;
    }
    .popup_head .popup_close {
        position: absolute;
        top: 0;
        right: 0;
        width: 65px;
        height: 65px;
        font-size: 0;
    }
    .popup_head .popup_close:before, .popup_head .popup_close:after {
        display: inline-block;
        width: 1px;
        height: 19px;
        transform: rotate(45deg);
        background-color: #fff;
        content: "";
    }
    .popup_head .popup_close:after {
        position: relative;
        top: -9px;
        left: -10px;
        width: 19px;
        height: 1px;
    }
    .popup_inner {
        padding: 15px 30px;
    }
    .popup_inner dfn {
        display: block;
        padding: 8px 0;
        color: #E98B73;
        text-align: right;
    }
    .popup_inner table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }
    .popup_inner tr {
        border-top: 1px solid #ddd;
    }
    .popup_inner tr:first-of-type {
        border-top: 3px solid #E98B73;
    }
    .popup_inner th {
        width: 130px;
        text-align: left;
        font-weight: 500;
    }
    .popup_inner td {
        display: inline-block;
        padding: 10px 6px 10px 0;
    }
    .popup_inner i {
        color: #E98B73;
    }
    .popup_inner input, .popup_inner select, .popup_inner textarea {
        border-radius: 3px;
        border-color:transparent;
        padding: 10px 12px;
        min-width: 100px;
        max-width: 300px;
    }
    .popup_inner textarea {
        background-color: #f5f5f5;
    }
    .popup_inner .opt_img {
        display: block;
        width: 100px;
        height: 100px;
        border: 1px solid #ddd;
        overflow: hidden;
    }
    .popup_inner .type_img {
        display: block;
        width: 100px;
        height: 100px;
        border: 1px solid #ddd;
        overflow: hidden;
    }
    .popup_inner input {
        background-color: #f5f5f5;
    }
    .popup_inner input.wide {
        width: 560px;
    }
    .popup_inner input:-moz-read-only {
        background-color: #e6e1e1;
    }
    .popup_inner input:read-only {
        background-color: #dfdfdf;
    }
    .popup_inner input[type=radio], .popup_inner input[type=checkbox] {
        display: none;
    }
    .popup_inner input[type=radio] + label, .popup_inner input[type=checkbox] + label {
        display: inline-block;
        position: relative;
        margin-right: 10px;
        vertical-align: middle;
        cursor: pointer;
    }
    .popup_inner input[type=radio] + label:before, .popup_inner input[type=checkbox] + label:before {
        display: inline-block;
        margin-right: 5px;
        border: 2px solid #b1b1b1;
        border-radius: 3px;
        width: 14px;
        height: 14px;
        vertical-align: middle;
        content: "";
    }
    .popup_inner input[type=radio] + label:after, .popup_inner input[type=checkbox] + label:after {
        display: inline-block;
        position: absolute;
        top: 6px;
        left: 3px;
        border: solid #fff;
        border-width: 2px 2px 0 0;
        width: 9px;
        height: 4px;
        transform: rotate(135deg);
        content: "";
    }
    .popup_inner input[type=radio]:checked + label:before, .popup_inner input[type=checkbox]:checked + label:before {
        background-color: #E98B73;
        border-color: #E98B73;
    }
    .popup_grid {
        margin: 12px 0;
    }
    .popup_grid_area .btn {
        display: inline-block;
        margin: 5px 0;
        border: 1px solid #a8a8a8;
        border-radius: 30px;
        padding: 5px 12px;
    }
    .popup .btn{
        margin:0;
    }

    .popup .btn.confirm, .popup .btn.fill {
        width: 100%;
        color: #fff;
        background-color: #E98B73;
        margin-top: 25px;
    }
    .popup .btn.stroke, .popup .btn.fill {
        width: calc(50% - 10px); margin:0 4px;
    }


    /* 추가 */
    .popup.is-visible {
        opacity: 1;
        visibility: visible;
        transition: opacity 0.3s 0s, visibility 0s 0s;
    }

    #imgPath {
        position: absolute;
        top: 50%;
        left: 50%;
        text-align: center;
        transform: translate(-50%, -50%);
        width: 620px;
        min-height: 300px;
        max-height: calc(100% - 120px);
        box-shadow: 3px 3px 12px rgba(44, 44, 44, 0.2);
    }

    .comment_img {
        max-width: 70%;
    }


</style>

<script>

    var gridView, setGridPager, gridBindings, setGrid;

    gridBindings = [
        {binding: 'id', header: 'ID', isReadOnly: true, width: 100, align: "center"},
        {binding: 'nickname', header: '닉네임', isReadOnly: true, width: 100, align: "center"},
        {
            binding: 'profilePic', header: '프로필사진', isReadOnly: true, width: 300, align: "center",
            cellTemplate: wijmo.grid.cellmaker.CellMaker.makeImage({
                click: (e, ctx) => showPop("image", ctx.item),
                attributes: {
                    // onerror:
                    //     "this.onerror=null; this.src='https://willchair.co.kr/img/icon_my_avatar.png';"
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
        {binding: 'cretDt', header: '가입일', isReadOnly: true, width: 200, align: "center"},
        {binding: 'lateassDt', header: '마지막 접속일', isReadOnly: true, width: 200, align: "center"},
    ];

    var gridOption = loadGridUserList(gridBindings, 'userLayout');
    setGrid = gridOption.setGrid;
    setGridPager = gridOption.setGridPager;
    gridView = gridOption.gridView;

    setGrid.cellEditEnded.addHandler((s, e) => {

        let col = s.columns[e.col]
        if (col.binding == 'adminFlag') {
            if (!confirm("관리자 여부를 변경하시겠습니까?")) {
                e.cancel = true;
            }

            let id = s.selectedItems[0].id;
            let adminFlag = s.selectedItems[0].adminFlag == "Y" ? "true" : "false";

            $.ajax({
                type : 'post',
                url : "/cms/user/adminFlagChange",
                data : {
                    id: id,
                    adminFlag: adminFlag
                },
                success : function(result) {
                    console.log(result);
                    alert('관리자 권한을 변경했습니다.');
                },
                error: function(request, status, error) {
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }

    })

    //팝업 오픈
    function showPop(pop, item){
        var imgPath = setGrid.collectionView.currentItem["profile_pic"]
        var img = '<img class="comment_img" src="'+item.profilePic+'"alt="이미지">';
        $('#imgPath').append(img)

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
