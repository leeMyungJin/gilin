<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>기린</title>
    <%@ include file="./include/header.jsp" %>
    <style type="text/css">
        .ck-content {height: 80vh;}
    </style>
</head>
<body>
<div id="cms">
    <%@ include file="./include/aside.jsp" %>

    <div class="cms_cont cms_terms">

        <h1 class="cms_tit"><span class="material-icons-round">report</span>약관관리</h1>

        <ul class="tab">
            <li class="current" data-id="1"><a href="">이용약관</a></li>
            <li data-id="2"><a href="">개인정보처리방침</a></li>
        </ul>


        <div class="cms_filter_cont">

            <div id="terms1" role="tabpanel" class="dashboard_area editor_area current" data-id="1">
                <div class="sub_cont term-save-wrap">
                    <div class="dashboard_btn_area">
                        <form action="" onsubmit="return saveTerm(this)">
                            <input type="hidden" name="no" value="1">
                            <input type="hidden" name="subject" value="이용약관">
                            <button class="dash_btn">저장</button>
                        </form>
                    </div>
                </div>
                <div class="edt">
                    <textarea name="service" id="service"></textarea>
                </div>
            </div>

            <div id="terms2" role="tabpanel" class="dashboard_area editor_area" data-id="2">
                <div class="sub_cont term-save-wrap">
                    <div class="dashboard_btn_area">
                        <form action="" onsubmit="return saveTerm(this)">
                            <input type="hidden" name="no" value="2">
                            <input type="hidden" name="subject" value="개인정보처리방침">
                            <button class="dash_btn">저장</button>
                        </form>
                    </div>
                </div>
                <div class="edt">
                    <textarea name="service" id="privacy"></textarea>
                </div>
            </div>

        </div>

    </div>

</div>

<script>

    var terms = ${terms};

    async function loadEditor(type) {

        var selected, _editor;

        if (type == "이용약관") {
            selected = "service";
        } else if (type == "개인정보처리방침") {
            selected = "privacy";
        }

        await ClassicEditor
            .create( document.getElementById(selected), {

                toolbar: {
                    items: [
                        'heading',
                        '|',
                        'bold',
                        'italic',
                        'link',
                        'bulletedList',
                        'numberedList',
                        '|',
                        'outdent',
                        'indent',
                        '|',
                        'blockQuote',
                        'insertTable',
                        'undo',
                        'redo',
                        'fontColor',
                        'fontBackgroundColor',
                        'fontSize',
                        'underline',
                        'specialCharacters',
                        'horizontalLine',
                        'htmlEmbed'
                    ]
                },
                language: 'ko',
                image: {
                    toolbar: [
                        'imageTextAlternative',
                        'imageStyle:inline',
                        'imageStyle:block',
                        'imageStyle:side'
                    ]
                },
                table: {
                    contentToolbar: [
                        'tableColumn',
                        'tableRow',
                        'mergeTableCells'
                    ]
                },
                licenseKey: '',


            })
            .then( editor => {
                editor.setData(terms[selected]);
                _editor = editor;
            })
            .catch( error => {
                console.error( 'Oops, something went wrong!' );
                console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
                console.warn( 'Build id: eed83e2ex4oz-pejoxvy7ffif' );
                console.error( error );
            })


        return _editor

    }


    var editor1, editor2;

    document.addEventListener("DOMContentLoaded", async function () {
        $('#terms').addClass("current");

        editor1 = await loadEditor("이용약관");
        editor2 = await loadEditor("개인정보처리방침");

    })


    //개인정보수집약관 추가
    function saveTerm(f){

        console.log("test...")

        var _editor;

        if (f.subject.value == "이용약관") {
            _editor = editor1
        } else if (f.subject.value == "개인정보처리방침") {
            _editor = editor2
        }

        //필수값 체크
        if (_editor.getData() == "") {
            alert('내용을 입력해주세요')
            return false;
        }

        $.ajax({
            url : "/terms/update",
            type : 'POST',
            cache : false,
            data : {
                no: f.no.value,
                content: _editor.getData()
            },
            success : function(data) {
                alert(f.subject.value + " 작성이 완료되었습니다.");
            },
            error : function(request,status,error) {
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });

        return false;
    }

    $(".tab li").on("click", function () {
        event.preventDefault();
        const id = $(this).data("id");

        $(".tab li").removeClass("current");
        $(this).addClass("current");

        $(".dashboard_area").removeClass("current");
        $("#terms" + id).addClass("current");
    })



</script>
</body>
</html>