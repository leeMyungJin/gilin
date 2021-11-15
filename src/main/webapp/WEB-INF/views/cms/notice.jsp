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

    <div class="cms_cont cms_channel">
        <h1 class="cms_tit"><span class="material-icons-round">campaign</span> 공지관리</h1>

        <div class="overview_area flex_wrap fb4">
            <div class="item">
                <p class="over_tit">공지수</p>
                <p class="over_txt">${count.totalcount}</p>
            </div>
            <div class="item">
                <p class="over_tit">필독공지</p>
                <p class="over_txt">${count.mustcount}</p>
            </div>
            <div class="item btn_wrap">
                <button class="btn modal_btn" data-modal-link="notice_edit_modal" onclick="createNoticeModal('modalNotice')">공지추가 <span class="material-icons">add_circle</span></button>
            </div>
            <div class="item btn_wrap">
                <button class="btn modal_btn" data-modal-link="push_edit_modal" onclick="modalToggle('modalPush')">푸쉬보내기 <span class="material-icons">add_circle</span></button>
            </div>
        </div>

        <ul class="tab">
            <li class="current" data-type="notice"><a href="">공지관리</a></li>
            <li data-type="push"><a href="">푸쉬히스토리</a></li>
        </ul>




        <div id="noticeArea" class="cms_filter_cont">
            <!-- 필터 영역 -->

            <form action="" name="searchForm" onsubmit="return getNoticeList(this)">

                <input type="hidden" name="page" value="1">

                <div class="filter_area flex_wrap">
                    <div class="item">
                        <label for="from1" class="mr">조회일</label>
                        <input type="text" id="from1" name="from" value="" placeholder="" class="search">
                        <span class="to">-</span>
                        <input type="text" id="to1" name="to" value="" placeholder="" class="search mr">

                        <button class="btn mr">조회</button>
                        <button class="btn">테스트</button>
                    </div>
                </div>

            </form>


            <!-- 보드 버튼 영역 시작 -->
            <div class="dashboard_btn_area layout02">

                <div class="flex_box">
                    <select id="setGridPageCount" onchange="perPage(this.value)">
                        <option value="30" selected="selected">30</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>

                <div class="flex_box">

                    <button class="dash_btn" onclick="_getUserGridLayout('noticeLayout', setGrid);">
                        <span class="material-icons-outlined">view_list</span>
                        칼럼 위치 저장
                    </button>
                    <button class="dash_btn" onclick="_resetUserGridLayout('noticeLayout', setGrid, gridBindings)">
                        <span class="material-icons-outlined">refresh</span>
                        칼럼 초기화
                    </button>
                    <button class="dash_btn" onclick="exportExcel('notice_list');">
                        <span class="material-icons-outlined">file_download</span>
                        엑셀 다운로드
                    </button>

                </div>

            </div>
            <!-- 보드 버튼 영역 끝 -->

            <!-- 보드영역 시작 -->
            <div class="dashboard_area">

                <div id="setGrid" class="setGrid"></div>
                <div id="setGridPager" class="pager setGridPager"></div>
                <div class="sub_cont">
                    <div class="btn_wrap">
                        <div class="btn_wrap">
                        </div>
                    </div>
                </div>

            </div>

        </div>



        <div id="pushArea" class="cms_filter_cont" style="display: none;">
            <!-- 필터 영역 -->

            <form action="" name="pushSearchForm" onsubmit="return getPushList(this)">

                <input type="hidden" name="page" value="1">

                <div class="filter_area flex_wrap">
                    <div class="item">
                        <label for="from2" class="mr">조회일</label>
                        <input type="text" id="from2" name="from" value="" placeholder="" class="search">
                        <span class="to">-</span>
                        <input type="text" id="to2" name="to" value="" placeholder="" class="search mr">

                        <button class="btn mr">조회</button>
                        <button class="btn">테스트</button>
                    </div>
                </div>

            </form>


            <!-- 보드 버튼 영역 시작 -->
            <div class="dashboard_btn_area layout02">

                <div class="flex_box">
                    <select id="setGridPageCount2" onchange="perPage(this.value)">
                        <option value="30" selected="selected">30</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>

                <div class="flex_box">

                    <button class="dash_btn" onclick="_getUserGridLayout('pushLayout', setGrid);">
                        <span class="material-icons-outlined">view_list</span>
                        칼럼 위치 저장
                    </button>
                    <button class="dash_btn" onclick="_resetUserGridLayout('pushLayout', setGrid, gridBindings)">
                        <span class="material-icons-outlined">refresh</span>
                        칼럼 초기화
                    </button>
                    <button class="dash_btn" onclick="exportExcel('push_list');">
                        <span class="material-icons-outlined">file_download</span>
                        엑셀 다운로드
                    </button>

                </div>

            </div>
            <!-- 보드 버튼 영역 끝 -->

            <!-- 보드영역 시작 -->
            <div class="dashboard_area">

                <div id="setGrid2" class="setGrid"></div>
                <div id="setGrid2Pager" class="pager setGridPager"></div>
                <div class="sub_cont">
                    <div class="btn_wrap">
                        <div class="btn_wrap">
                        </div>
                    </div>
                </div>

            </div>


        </div>

        <!-- 보드영역 끝 -->


        <!-- 공지추가 모달 -->
        <div id="modalNotice" class="modal edit_modal notice_edit_modal">
            <div class="modal_bg"></div>
            <div class="modal_cont">
                <span class="material-icons-outlined close_btn" onclick="modalToggle('modalNotice')">close</span>

                <form action="" name="modifyForm" onsubmit="return noticeModify(this)" enctype="multipart/form-data">

                    <input type="hidden" name="ntSeq" value="">
                    <input type="hidden" name="cretDt" value="">
                    <input type="hidden" name="cretId" value="">
                    <input type="hidden" name="updtDt" value="">
                    <input type="hidden" name="updtId" value="">
                    <input type="hidden" name="submitType" value="">

                    <h2>공지추가</h2>
                    <p class="required_wrap">필수항목</p>
                    <table class="modal_table">
                        <tr>
                            <th>필독 활성화</th>
                            <td>
                                <select name="mustYn" title="" style="min-width:72px;">
                                    <option value="true" selected="selected">Y</option>
                                    <option value="false">N</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>활성화</th>
                            <td>
                                <select name="activeYn" title="" style="min-width:72px;">
                                    <option value="true" selected="selected">Y</option>
                                    <option value="false">N</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>제목 <span>*</span></th>
                            <td><input type="text" name="ntTitle" value="" placeholder="" class="search" style="width:100%;"></td>
                        </tr>
                        <tr>
                            <th>내용 <span>*</span></th>
                            <td>
                                <textarea name="content" id="content"></textarea>
                            </td>
                        </tr>
                    </table>

                    <div class="btn_wrap">
                        <button class="btn_style01 create" onclick="document.modifyForm.submitType.value='생성'">생성</button>
                        <button class="btn_style01 update" onclick="document.modifyForm.submitType.value='수정'">수정</button>
                        <button class="btn_style01 del update" onclick="document.modifyForm.submitType.value='삭제'">삭제</button>
                    </div>
                </form>

            </div>
        </div>



        <!-- 푸쉬보내기 모달 -->
        <div id="modalPush" class="modal edit_modal push_edit_modal">
            <div class="modal_bg"></div>
            <div class="modal_cont">
                <span class="material-icons-outlined close_btn" onclick="modalToggle('modalPush')">close</span>

                <h2>푸쉬보내기</h2>
                <p class="required_wrap">필수항목</p>
                <table class="modal_table">
                    <tr>
                        <th></th>
                        <td>
                            <div class="chk_wrap">
                                <div class="chk_btn" style="margin-right:12px;">
                                    <input id="public" name="radio" type="radio" value="public">
                                    <label for="public">일반</label>
                                    <div class="chk_btn_circle"></div>
                                </div>
                                <div class="chk_btn">
                                    <input id="private" name="radio" type="radio" value="private" checked>
                                    <label for="private">공지</label>
                                    <div class="chk_btn_circle"></div>
                                </div>
                                <div class="showbox active">

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="showbox active">
                        <th>공지번호 <span>*</span></th>
                        <td><input type="text" id="search" name="search" value="" placeholder="" class="search"></td>
                    </tr>
                    <tr>
                        <th>제목 <span>*</span></th>
                        <td><input type="text" id="search" name="search" value="" placeholder="" class="search"></td>
                    </tr>
                    <tr>
                        <th>내용 <span>*</span></th>
                        <td>
                            <textarea name="name" rows="8" cols="80"></textarea>
                        </td>
                    </tr>
                </table>

                <div class="btn_wrap">
                    <button class="btn_style01">보내기</button>
                </div>

            </div>
        </div>


    </div>

</div>



<style>
    .setGrid.wj-flexgrid .wj-cell {
        padding: 12px;
    }

    .setGrid > div {
        height: auto !important;
    }

    .setGridPager {
        text-align: center;
    }

    .setGridPager .selectPage {
        color: #ddd;
    }
</style>

<script>


    $("ul.tab li").on("click", function (e) {

        e.preventDefault()
        $("ul.tab li.current").removeClass("current")
        $(this).addClass("current")
        $(".cms_filter_cont").css("display", "none");
        const type = $(this).data("type");
        const targetView = $("#" + type + "Area");
        targetView.css("display", "block")

    })


    var _from1 = new wijmo.input.InputDate("#from1", {
        isRequired: false,
        format: 'yyyy-MM-dd',
    });	//시작 일자

    var _to1 = new wijmo.input.InputDate("#to1", {
        isRequired: false,
        format: 'yyyy-MM-dd',
    });	//종료 일자

    var _from2 = new wijmo.input.InputDate("#from2", {
        isRequired: false,
        format: 'yyyy-MM-dd',
    });	//시작 일자

    var _to2 = new wijmo.input.InputDate("#to2", {
        isRequired: false,
        format: 'yyyy-MM-dd',
    });	//종료 일자



    var editor1;
    document.addEventListener("DOMContentLoaded", async function () {
        $('#terms').addClass("current");
        editor1 = await setEditor();
    })

    var $from = $("input[name='from']");
    var $to = $("input[name='to']");
    $from.val('');
    $to.val('');

    _from1.valueChanged.addHandler(function (s, e) {
        if (_to1.value <= s.value && _to1.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_to1.value);
            s.value = new Date(_date.setDate(_date.getDate() - 1));
            return false;
        }
    })

    _to1.valueChanged.addHandler(function (s, e) {
        if (_from1.value >= s.value && _from1.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_from1.value);
            s.value = new Date(_date.setDate(_date.getDate() + 1));
            return false;
        }
    })



    _from2.valueChanged.addHandler(function (s, e) {
        if (_to2.value <= s.value && _to2.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_to2.value);
            s.value = new Date(_date.setDate(_date.getDate() - 1));
            return false;
        }
    })

    _to2.valueChanged.addHandler(function (s, e) {
        if (_from2.value >= s.value && _from2.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_from2.value);
            s.value = new Date(_date.setDate(_date.getDate() + 1));
            return false;
        }
    })


    var gridView, setGridPager, gridBindings, setGrid, targetFocus1;
    var gridView2, setGridPager2, gridBindings2, setGrid2, targetFocus2;

    gridBindings = [
        {binding: 'ntSeq', header: '번호', isReadOnly: true, width: 100, align: "center"},
        {binding: 'ntTitle', header: '제목', isReadOnly: true, width: '*', align: "center"},
        {binding: 'cretDt', header: '작성 날짜', isReadOnly: true, width: 200, align: "center"},
        {binding: 'updtDt', header: '수정 날짜', isReadOnly: true, width: 200, align: "center"},
        {binding: 'mustBool', header: '필독 활성화', isReadOnly: false, width: 100, align: "center", dataMap: ["Y", "N"]},
        {binding: 'activeBool', header: '공지 활성화', isReadOnly: false, width: 100, align: "center", dataMap: ["Y", "N"]},
        {binding: 'modify', header: '정보수정',  width: 100, align: "center",
            cellTemplate: wijmo.grid.cellmaker.CellMaker.makeButton({
                text: '<b>수정</b>',
                click: (e, ctx) => {
                    modalPop(ctx, $("#modalNotice"))
                    $("#modalPush").css("display", "none")
                    editor1.setData(ctx.item.content)
                },
            })
        },
    ];


    targetFocus1 = {
        setGridPager : "#setGridPager",
        setGrid: "#setGrid"
    }

    var gridOption = loadGridUserListTargetFocus(gridBindings, 'noticeLayout', targetFocus1);
    setGrid = gridOption.setGrid;
    setGridPager = gridOption.setGridPager;
    gridView = gridOption.gridView;

    gridBindings2 = [
        {binding: 'pushTitle', header: '제목', isReadOnly: true, width: 150, align: "center"},
        {binding: 'pushBody', header: '내용', isReadOnly: true, width: 300, align: "center"},
        {binding: 'pushNoticeIdx', header: '공지번호', isReadOnly: true, width: 100, align: "center"},
        {binding: 'pushImg', header: '푸쉬이미지', isReadOnly: true, width: 200, align: "center"},
        {binding: 'appSender', header: 'APP발송자', isReadOnly: true, width: 150, align: "center"},
        {binding: 'appSender', header: '닉네임', isReadOnly: true, width: 150, align: "center"},
        {binding: 'webSender', header: 'WEB발송자', isReadOnly: true, width: 150, align: "center"},
        {binding: 'webSender', header: '이름', isReadOnly: true, width: 150, align: "center"},
        {binding: 'sendDt', header: '발송일', isReadOnly: true, width: 150, align: "center"},
    ]

    targetFocus2 = {
        setGridPager : "#setGrid2Pager",
        setGrid: "#setGrid2"
    }

    var gridOption2 = loadGridUserListTargetFocus(gridBindings2, 'pushLayout', targetFocus2);
    setGrid2 = gridOption2.setGrid;
    setGridPager2 = gridOption2.setGridPager;
    gridView2 = gridOption2.gridView;


    function getNoticeList(f=document.searchForm) {

        $.ajax({
            type : 'GET',
            url : '/cms/notice/more',
            data : {
                page: f.page.value,
                from: f.from.value,
                to: f.to.value
            },
            success : function(result) {

                gridView = new wijmo.collections.CollectionView(result, {
                    pageSize: Number($('#setGridPageCount').val())
                });
                setGridPager.cv = gridView;
                setGrid.itemsSource = gridView;
                refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, 'setGrid');  // 페이징 초기 셋팅

            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

        return false;
    }



    function getPushList(f=document.pushSearchForm) {

        $.ajax({
            type : 'GET',
            url : '/cms/push/more',
            data : {
                page: f.page.value,
                from: f.from.value,
                to: f.to.value
            },
            success : function(result) {

                gridView2 = new wijmo.collections.CollectionView(result, {
                    pageSize: Number($('#setGridPageCount2').val())
                });
                setGridPager2.cv = gridView2;
                setGrid2.itemsSource = gridView2;
                refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid2, 'setGrid2');  // 페이징 초기 셋팅

            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

        return false;
    }


    function modalToggle(_target) {

        const el = document.getElementById(_target);
        const opacity = el.style.opacity;
        if (opacity == 1) {
            el.style.opacity = 0;
            el.style.visibility = "hidden";
        } else {
            el.style.opacity = 1;
            el.style.visibility = "visible";
        }

    }

    function createNoticeModal(el) {

        var modal = $("#" + el);
        var opacity = modal.css("opacity");

        modal.css("display", "block");
        $("#modalPush").css("display", "none")
        $(".btn_style01.create").css("display", "inline-block");
        $(".btn_style01.update").css("display", "none");

        var f = document.modifyForm;
        var fInput = f.querySelectorAll("input");
        var fSelect = f.querySelectorAll("select");
        $(".modal-form-title.create").css("display", "block");
        $(".modal-form-title.modify").css("display", "none");

        editor1.setData('');

        fInput.forEach((el) => {
            el.value = '';
        })

        fSelect.forEach((el) => {
            el.value = 'true';
        })

        if (opacity == "1") {

            modal.css({
                opacity: 0,
                visibility: "hidden"
            })

        } else {

            modal.css({
                opacity: 1,
                visibility: "visible"
            })


        }
    }

    function noticeModify(f) {

        var submitType = f.submitType.value;

        if (!confirm(submitType + "하시겠습니까?")) {
            return false;
        }

        let today = new Date();

        let year = today.getFullYear(); // 년도
        let month = today.getMonth() + 1;  // 월
        let day = today.getDate();  // 날짜

        f.updtDt.value = year + "-" + month + "-" + day

        var url = '';

        switch (f.submitType.value)
        {
            case "수정":
                url = "/cms/notice/update";
                break;
            case "삭제":
                url = "/cms/notice/delete"
                break;
            case "생성":
                url = "/cms/notice/create"
                f.cretDt.value = f.updtDt.value;
                break;
        }

        f.content.value = editor1.getData();
        var formData = new FormData(f);


        $.ajax({
            type : 'post',
            url : url,
            data : formData,
            async: false,
            processData : false,
            contentType : false,
            success : function(result) {
                alert(submitType + '했습니다');
                getNoticeList();
                clickPager(document.searchForm.page.value, setGrid, 'setGrid')
            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });


        if (submitType == "삭제") {
            modalPop();
        }

        return false;

    }




</script>
</body>
</html>
