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
        <h1 class="cms_tit"><span class="material-icons-round">grid_view</span> 채널관리</h1>

        <div class="overview_area flex_wrap fb3">
            <div class="item">
                <p class="over_tit">전체 채널 개수</p>
                <p class="over_txt">${count.totalcount}</p>
            </div>
            <div class="item">
                <p class="over_tit">진행중인 채널</p>
                <p class="over_txt">${count.activecount}</p>
            </div>
            <div class="item">
                <p class="over_tit">마감된 채널</p>
                <p class="over_txt">${count.totalcount - count.activecount}</p>
            </div>
            <div class="item btn_wrap">
                <button class="btn modal_btn" data-modal-link="create_modal" onclick="createChannelModal()">채널생성 <span class="material-icons">add_circle</span></button>
            </div>
        </div>



        <div class="cms_filter_cont">
            <!-- 필터 영역 -->

            <form action="" name="searchForm" onsubmit="return getChannelList(this)">

                <input type="hidden" name="page" value="1">
                <input type="hidden" name="limit" value="">
                <input type="hidden" name="active" value="">

                <div class="filter_area flex_wrap">
                    <div class="item">
                        <label for="con" class="mr">검색조건</label>
                        <select id="con" name="con" title="" class="mr">
                            <option value="" selected="selected">전체</option>
                            <option value="ch_name">채널명</option>
                            <option value="nickname">개설자 닉네임</option>
                        </select>

                        <input type="text" id="inq" name="inq" value="" placeholder=",로 다중검색 가능" class="search mr">
                        <button class="btn">조회</button>
                    </div>

                    <div class="item">
                        <label for="from" class="mr">기간 조회</label>
                        <input type="text" id="from" name="from" value="" placeholder="" class="search">
                        <span class="to">-</span>
                        <input type="text" id="to" name="to" value="" placeholder="" class="search mr">
                        <button class="btn">조회</button>
                    </div>
                </div>

            </form>


            <!-- 보드 버튼 영역 시작 -->
            <div class="dashboard_btn_area layout02">
                <div class="flex_box">
                    <select id="channelType" title="" onchange="processTypeChanger(this.value, getChannelList)">
                        <option value="" selected="selected">전체</option>
                        <option value="active">진행중</option>
                        <option value="inactive">종료</option>
                    </select>
                    <select id="setGridPageCount" onchange="perPage(this.value)">
                        <option value="30" selected="selected">30</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>
                <div class="flex_box">

                    <button class="dash_btn" onclick="_getUserGridLayout('channelLayout', setGrid);">
                        <span class="material-icons-outlined">view_list</span>
                        칼럼 위치 저장
                    </button>
                    <button class="dash_btn" onclick="_resetUserGridLayout('channelLayout', setGrid, gridBindings)">
                        <span class="material-icons-outlined">refresh</span>
                        칼럼 초기화
                    </button>
                    <button class="dash_btn" onclick="exportExcel('channel_list');">
                        <span class="material-icons-outlined">file_download</span>
                        엑셀 다운로드
                    </button>

                </div>

            </div>
            <!-- 보드 버튼 영역 끝 -->

                <!-- 보드영역 시작 -->
            <div class="dashboard_area">
<%--                <button class="btn_style01 modal_btn" data-modal-link="edit_modal">수정</button>--%>

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
        <!-- 보드영역 끝 -->

        <!-- 채널 정보 수정 모달 -->
        <div class="modal edit_modal">
            <div class="modal_bg"></div>
            <div class="modal_cont">
                <form action="" name="modifyForm" onsubmit="return channelModify(this)" enctype="multipart/form-data">
                    <input type="hidden" name="chSeq">
                    <input type="hidden" name="chStDt">
                    <input type="hidden" name="chEndDt">
                    <input type="hidden" name="chFdStDt">
                    <input type="hidden" name="chFdEndDt">
                    <input type="hidden" name="chOpenYn">

                    <input type="hidden" name="cretId">
                    <input type="hidden" name="updtDt">
                    <input type="hidden" name="updtId">

                    <input type="hidden" name="submitType">

                    <span class="material-icons-outlined close_btn" onclick="modalPop()">close</span>

                    <h2 class="modal-form-title modify">채널 정보 수정</h2>
                    <h2 class="modal-form-title create">채널 생성</h2>

                    <table class="modal_table">
                        <tr>
                            <th>활성화</th>
                            <td>
                                <select id="" name="chActiveYn" title="" style="min-width:72px;">
                                    <option value="true" selected="selected">Y</option>
                                    <option value="false">N</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>등록일자</th>
                            <td><input type="text" readonly name="cretDt" value="" placeholder="" class="search input-disabled"></td>
                        </tr>
                        <tr>
                            <th>개설자 닉네임</th>
                            <td><input type="text" name="nickname" value="" placeholder="" class="search input-disabled" readonly></td>
                        </tr>
                        <tr>
                            <th>채널명</th>
                            <td><input type="text" name="chName" value="" placeholder="" class="search"></td>
                        </tr>
                        <tr>
                            <th>채널 대표 이미지</th>
                            <td class="flex_wrap">
                                <input type="text" name="chImg" value="" placeholder="" class="search">
                                <button type="button" class="btn jeon" onclick="$('input[name=chImgFileUpload]').trigger('click')">
                                    찾기
                                </button>
                                <input type="file" name="chImgFileUpload" style="display: none;" accept="image/*">
                            </td>
                        </tr>
                        <tr>
                            <th>채널 요약 설명</th>
                            <td><input type="text" name="chMemo" value="" placeholder="" class="search"></td>
                        </tr>
                        <tr>
                            <th>채널 기간</th>
                            <td><input type="text" name="chDateRange" value="" placeholder="" class="search date-range"></td>
                        </tr>
                        <!-- <tr>
                            <th>펀딩 기간</th>
                            <td><input type="text" name="fundingDateRange" value="" placeholder="" class="search"></td>
                        </tr> -->
                        <tr>
                            <th>프로젝트 개수</th>
                            <td><input type="text" name="projectCount" readonly value="" placeholder="" class="search input-disabled"></td>
                        </tr>
                        <tr>
                            <th>전체 펀딩 금액</th>
                            <td><input type="text" name="fundingTotalPrice" readonly value="" placeholder="" class="search input-disabled"></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="text" name="chPass" value="" placeholder="" class="search"></td>
                        </tr>
                    </table>

                    <div class="btn_wrap">
                        <button id="channelCreateButton" class="btn_style01 create" onclick="document.modifyForm.submitType.value='생성'">생성</button>
                        <button id="channelSubmitButton" class="btn_style01 update" onclick="document.modifyForm.submitType.value='수정'">수정</button>
                        <button id="channelDeleteButton" class="btn_style01 del update" onclick="document.modifyForm.submitType.value='삭제'">삭제</button>
                    </div>
                </form>
            </div>
        </div>

    </div>

</div>


<img src="https://gilin.co.kr/img/common/mask.gif" alt="로더" id="gridLoader">

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

    .input-disabled {
        background-color: #dedede !important;
    }

    .date-range {
        width: 100%;
    }

    #gridLoader {
        display: none;
        position: absolute;
        top: 50%;
        left: 50%;
    }
</style>

</body>
</html>


<script>

    var _from = new wijmo.input.InputDate("#from");	//시작 일자
    var _to = new wijmo.input.InputDate("#to");	//종료 일자

    var $from = $("input[name='from']");
    var $to = $("input[name='to']");

    $from.val("").attr("required", false)
    $to.val("").attr("required", false)


    _from.valueChanged.addHandler(function (s, e) {
        if (_to.value <= s.value && _to.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_to.value);
            s.value = new Date(_date.setDate(_date.getDate() - 1));
            return false;
        }
    })

    _to.valueChanged.addHandler(function (s, e) {
        if (_from.value >= s.value && _from.value != '' && s.value != null) {
            alert('날짜를 다시 선택하세요');
            const _date = new Date(_from.value);
            s.value = new Date(_date.setDate(_date.getDate() + 1));
            return false;
        }
    })


    new wijmo.input.InputDateRange("input[name='chDateRange']", {
        alwaysShowCalendar: true,
        predefinedRanges: getPredefinedRanges(),
        valueChanged: s => showDateRange(s, "input[name='chDateRange']"),
        rangeEndChanged: s => showDateRange(s, "input[name='chDateRange']"),
        value: new Date(),
        rangeEnd: wijmo.DateTime.addDays(new Date(), 2),
        closeOnSelection: true,
        handleWheel: false,
        monthCount: 2,
        weeksBefore: 0,
        weeksAfter: 0,
        separator: "~"
    });



    var gridBindings = [
        {binding: 'cretDt', header: '등록일자', isReadOnly: true, width: 200, align: "center", format: '' },
        {binding: 'nickname', header: '개설자 닉네임', isReadOnly: true, width: 150, align: "center"},
        {binding: 'chName', header: '채널명', isReadOnly: true, width: 200, align: "center"},
        {binding: 'chImg', header: '채널대표이미지', isReadOnly: true, width: 250, align: "center"},
        {binding: 'chMemo', header: '채널 요약 설명', isReadOnly: true, width: 300, align: "center"},
        {binding: 'active', header: '활성화',  width: 100, align: "center", dataMap: ["Y", "N"]},
        {binding: 'chDateRange', header: '채널 기간',  width: 350, align: "center"},
        {binding: 'fundingDateRange', header: '펀딩 기간',  width: 350, align: "center"},
        {binding: 'projectCount', header: '프로젝트 개수',  width: 100, align: "center", cssClass: 'number-format'},
        {binding: 'sumFunding', header: '전체 펀딩 금액',  width: 100, align: "center", cssClass: 'number-format'},
        {binding: 'chPass', header: '비밀번호',  width: 100, align: "center"},
        {binding: 'report', header: '결과 보고서', width: 100, align:"center",
            cellTemplate: wijmo.grid.cellmaker.CellMaker.makeButton({
                text: '<b>보기</b>',
                click: (e, ctx) => {
                    modalPop(ctx);
                },
            })
        },
        { binding: 'edit', header: '정보수정', width: 100, align:"center",
            cellTemplate: wijmo.grid.cellmaker.CellMaker.makeButton({
                text: '<b>수정</b>',
                click: (e, ctx) => {
                    modalPop(ctx);
                },
            })
        },
    ];

    var setGrid, setGridPager, gridView;
    var gridOption = loadGridUserList(gridBindings, 'channelLayout');

    setGrid = gridOption.setGrid;
    setGridPager = gridOption.setGridPager;
    gridView = gridOption.gridView;


    /* 활성화 비활성화 변경하기 */
    setGrid.cellEditEnded.addHandler((s, e) => {

        let col = s.columns[e.col]
        if (col.binding == 'active') {
            if (!confirm("활성화 여부를 변경하시겠습니까?")) {
                e.cancel = true;
                return false;
            }

            let id = s.selectedItems[0].chSeq;
            let chActiveYn = s.selectedItems[0].active == "Y" ? "true" : "false";

            $.ajax({
                type : 'post',
                url : "/cms/channel/activeChanger",
                data : {
                    chSeq: id,
                    chActiveYn: chActiveYn
                },
                success : function(result) {
                    console.log(result);
                    alert('활성화 여부를 변경했습니다.');
                },
                error: function(request, status, error) {
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }

    })



    //회원 리스트 조회
    function getChannelList(f=document.searchForm) {

        $("#gridLoader").css("display", "block");

        $.ajax({
            type : 'GET',
            url : '/cms/channel/more',
            async: false,
            data : {
                con: f.con.value,
                inq: f.inq.value,
                from: f.from.value,
                to: f.to.value,
                active: f.active.value,
                page: f.page.value,
            },
            success : function(result) {

                gridView = new wijmo.collections.CollectionView(result, {
                    pageSize: Number($('#setGridPageCount').val())
                });

                setGridPager.cv = gridView;

                setGrid.itemsSource = gridView;
                refreshPaging(setGrid.collectionView.totalItemCount, 1, setGrid, 'setGrid');  // 페이징 초기 셋팅
                makeUrlHistoryPoint({
                    path: "con=" + f.con.value +
                        "&inq=" + f.inq.value +
                        "&from=" + f.from.value +
                        "&to=" + f.to.value +
                        "&active=" + f.active.value +
                        "&page=" + f.page.value
                })



            },
            error: function(request, status, error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function () {
                $("#gridLoader").css("display", "none");
            }
        });

        return false;
    }


    function channelModify(f) {

        var submitType = f.submitType.value;

        if (f.chName.value == "") {
            alert("채널명을 입력해주세요");
            return false;
        }

        if (f.chImg.value == "") {
            alert("채널 대표 이미지를 첨부해주세요");
            return false;
        }

        if (f.chDateRange.value == "") {
            alert("채널 기간을 설정해주세요");
            return false;
        }

        if (!confirm(submitType + "하시겠습니까?")) {
            return false;
        }


        var chDateRangeSplit = f.chDateRange.value.split("~");

        f.chStDt.value = chDateRangeSplit[0];
        f.chEndDt.value = chDateRangeSplit[1];

        if (f.chOpenYn.value == "t") {
            f.chOpenYn.value = "true";
        } else {
            f.chOpenYn.value = "false";
        }

        /* 비밀번호가 있을 경우 무조건 오픈펄스 */
        if (f.chPass.value != "") {
            f.chOpenYn.value = "false";
        } else {
            f.chOpenYn.value = "true";
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
                url = "/cms/channel/modify";
                break;
            case "삭제":
                url = "/cms/channel/delete"
                break;

            case "생성":
            default:
                url = "/cms/channel/create"
                f.chActiveYn.value = f.chActiveYn.value == 'true' ? true : false;
                f.cretDt.value = f.updtDt.value;
                f.chSeq.value = 0;
                break;
        }

        var formData = new FormData(f);


        $.ajax({
            type : 'post',
            url : url,
            data : formData,
            enctype: 'multipart/form-data',
            processData : false,
            contentType : false,
            success : function(result) {
                alert(submitType + '했습니다');
                getChannelList();
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

    document.querySelector("input[name='chImgFileUpload']").addEventListener("change", function(e) {
        document.querySelector("input[name='chImg']").value = e.target.files[0].name;
    })


    function createChannelModal() {

        var modal = $(".modal.edit_modal");
        var opacity = modal.css("opacity");

        $(".btn_style01.create").css("display", "inline-block");
        $(".btn_style01.update").css("display", "none");

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

            var f = document.modifyForm;
            var fInput = f.querySelectorAll("input");
            $(".modal-form-title.create").css("display", "block");
            $(".modal-form-title.modify").css("display", "none");
            f.submitType.value = "생성"

            fInput.forEach((el) => {
                el.value = '';
            })

            // f.submitType.value = "생성"

        }
    }





</script>
