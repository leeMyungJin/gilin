<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<body>
   <%@ include file="../include/header.jsp" %>

  <div class="sub mychannel_modi">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 채널 관리</p>
      </div>
    </div>

    <div class="board board_write">
      <div class="inner">

        <table class="board_table">
          <tr>
            <th>채널명</th>
            <td><input type="text" class="w100"></td>
          </tr>
          <tr>
            <th>채널 이미지</th>
            <td>
              <div class='file_input'>
                <input type='file'>
                <div class="btn">파일선택</div>
                <p data-js-label>No file selected</p>
              </div>
            </td>
          </tr>
          <tr>
            <th>채널 요약 설명</th>
            <td><textarea id="story" rows="3" resize="none" style="height:360px;"></textarea></td>
          </tr>
          <tr>
            <th>채널 공개 여부</th>
            <td>
              <div class="chk_wrap">
                <div class="chk_btn">
                  <input id="public" name="radio" type="radio" value="public">
                  <label for="public">공개</label>
                  <div class="chk_btn_circle"></div>
                </div>
                <div class="chk_btn">
                  <input id="private" name="radio" type="radio" value="private" checked>
                  <label for="private">비공개</label>
                  <div class="chk_btn_circle"></div>
                </div>
                <div class="showbox active">
                  <input type="text" placeholder="4자리 비밀번호" maxlength="4">
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <th>프로젝트 기간</th>
            <td>
              <input type="text" class="datepicker"><span class="to">-</span><input type="text" class="datepicker">
            </td>
          </tr>
          <tr>
            <th>펀딩 기간</th>
            <td>
              <input type="text" class="datepicker"><span class="to">-</span><input type="text" class="datepicker">
            </td>
          </tr>
        </table>

        <div class="btn_wrap bottom">
          <button class="btn_style01">수정</button>
          <button class="btn_style01">삭제</button>
        </div>

      </div>
    </div>


  </div>
  
	<%@ include file="../include/footer.jsp" %>


</body>
</html>
