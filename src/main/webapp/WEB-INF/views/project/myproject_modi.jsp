<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <%@ include file="../include/head.jsp" %>
</head>

<body>
  <%@ include file="../include/header.jsp" %>

  <div class="sub channel_open">

    <div class="sub_header02">
      <div class="inner">
        <p class="tit">MY 프로젝트 관리</p>
      </div>
    </div>

    <div class="board board_write">
      <div class="inner">

        <table class="board_table">
          <tr>
            <th>프로젝트 명</th>
            <td><input type="text" class="w100"></td>
          </tr>
          <tr>
            <th>프로젝트 이미지</th>
            <td>
              <div class='file_input'>
                <input type='file'>
                <div class="btn">파일선택</div>
                <p data-js-label>No file selected</p>
              </div>
            </td>
          </tr>
          <tr>
            <th>프로젝트 요약 설명</th>
            <td><textarea id="story" rows="3" resize="none" style="height:360px;"></textarea></td>
          </tr>
          <tr>
            <th colspan="2">상세페이지 작성</th>
          </tr>
          <tr>
            <td colspan="2">
              <div class="editor">
                에디터 영역
              </div>

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
