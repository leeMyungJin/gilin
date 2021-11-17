<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%--    <%@ include file="../include/header.jsp" %>--%>
    <title>기린 공지사항</title>
    <script src="https://code.jquery.com/jquery-2.2.4.js" integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" crossorigin="anonymous"></script>
    <script>
        let isEnd = false;

        $(function(){
            $(".accr_cont").hide();

            $(".accr_box .title").click(function(){
                $(this).toggleClass("on");
                if($(this).hasClass("on")){
                    $(this).next().slideDown(300);
                }else{
                    $(this).next().slideUp(300);
                }
                return false;
            });
            $(window).scroll(function(){
                if($(window).scrollTop() >= $(document).height() - $(window).height()){
                    fetchList();
                }
            })
        })

        function show(e) {
            $(e).toggleClass("on");
            if($(e).hasClass("on")){
                $(e).next().slideDown(300);
            }else{
                $(e).next().slideUp(300);
            }
            return false;
        }

        let fetchList = function(){
            if(isEnd == true){
                return;
            }

            let lastNo = $('#notice li').last().data('no')||0;
            console.log("데이터번호" + lastNo)
            let params = {lastNo : lastNo};
            $.ajax({
                type : 'GET',
                url : '/m/getNotice',
                data : params,
                dataType : null,
                success : function(result) {
                    let length = result.length;
                    if(length <= 5){
                        isEnd = true;
                    }
                    $.each(result,function(index,vo){
                        renderList(false, vo);
                    })
                },
                error: function(request, status, error) {
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

                }
            });

            let renderList = function(mode, vo){
                let html = "<li class='accr_box' data-no='"+vo.index+"'>"
                    + "<h2 class='title' onclick='show(this);'>"
                    + "<i>" + "</i>"
                    + "<span class='day'>"+vo.cretDt+"</span>"
                    + "<span class='tit'>"+vo.title+"</span>"
                    + "</h2>"
                    + "<div class='accr_cont'>"
                    + vo.content
                    + "</div>"
                    + "</li>"
                if(mode){
                    $("#notice").prepend(html);
                }
                else{
                    $("#notice").append(html);
                }
            }
        }

    </script>
</head>
<body>
<div class="wrap">
    <!-- 아코디언 메뉴 리스트 -->
    <ul class="accr_wrp">
        <c:forEach var="mustList" items="${mustList}">
            <li class="accr_box" id="must">
                <h2 class="title">
                    <i></i>
                    <span class="day">${mustList.cretDt}</span>
                    <span class="tit">[필독]${mustList.ntTitle}</span>
                </h2>
                <div class="accr_cont">
                    ${mustList.content}
                </div>
            </li>
        </c:forEach>
    </ul>
    <ul class="accr_wrp" id="notice">
        <c:forEach var="CmsNoticeVo" items="${CmsNoticeVo}" >
            <li class="accr_box" data-no="${CmsNoticeVo.ntSeq}">
                <h2 class="title">
                    <i></i>
                    <span class="day">${CmsNoticeVo.cretDt}</span>
                    <span class="tit">${CmsNoticeVo.ntTitle}</span>
                </h2>
                <div class="accr_cont">
                    ${CmsNoticeVo.content}
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<style>
    *{margin:0; padding:0;}
    ul,li,ol{list-style: none;}
    /* 아코디언 메뉴 .accr*/
    .accr_wrp {overflow-y:auto; font-size:13px;}
    .accr_wrp h2{margin:0;}
    .accr_wrp figure > img{position: inherit;}
    .accr_box .title{
        display:block;
        position:relative; border-bottom:1px solid #ddd; padding:15px 45px 15px 10px;
        font-weight:400; font-size: 1.5em; cursor:pointer;
    }
    .accr_box .title span{display:block; margin-left:12px;}
    .accr_box .title span.day{margin-bottom:3px; font-size: 0.8em; color:#868686; font-weight:300;}
    .accr_box .title i {
        display:inline-block;
        position:absolute; top:50%; right:20px; transform: translateX(-50%);
        margin-right:8px; border: solid #ddd; border-width: 2px 2px 0 0;
        width: 7px; height: 7px;
        transform: rotate(135deg);
        transition: transform 0.3s;
        content: "";
    }
    .accr_box .title.on i {transform: rotate(-45deg);}
    .accr_cont{display:none; height:100%; padding:8px 20px; background-color: #fafafa;}
    .accr_cont p, .accr_cont li  {padding:4px;}
    #must {background:#FFCB46;}

</style>
</body>