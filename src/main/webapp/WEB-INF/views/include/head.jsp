<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="keywords" content="휘테커, Gilin, 기린, 대학생창업교육, 펀딩, 대학생펀딩사이트, 대학생 개발, 대학생펀딩">
  <meta name="description" content="대학생 창업교육 개발 및 진행, Gilin 기린">
  <meta property="og:type" content="website">
  <meta property="og:title" content="Gilin 기린">
  <meta property="og:image" content="/img/common/ogimg.png">
  <meta property="og:description" content="대학생 창업교육 개발 및 진행, Gilin 기린">
  <meta property="og:url" content="">
  <link rel="shortcut icon" type="image/x-icon" href="/img/common/favicon.ico">
  <link rel="canonical" href="">
  <title>GILIN</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
  
  <link rel="stylesheet" href="../css/gilin.css">
  <link rel="stylesheet" href="../css/gilin_cms.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/headhesive/1.2.4/headhesive.min.js"></script>
  <script src="../js/include/gilin.js"></script>
  <script src="../js/include/common.js"></script>
  
  <!-- 애플 로그인 -->
  <script type="text/javascript" src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
  
  <!-- 카카오 로그인 -->
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  
  <!-- Wijmo 컨트롤 (옵션, 필요한 컨트롤 만 추가) -->
<script src="../wijmo/Dist/controls/wijmo.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.input.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.nav.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.filter.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.sheet.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.xlsx.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.xlsx.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.cellmaker.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.chart.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.input.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.gauge.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.xlsx.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.selector.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.search.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.grid.grouppanel.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.barcode.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.barcode.common.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.chart.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.chart.interaction.min.js"></script>
<script src="../wijmo/Dist/controls/wijmo.chart.animation.min.js"></script>
<script src="../wijmo/Dist/jszip.min.js"></script>
  
  <!-- Wijmo 배포라이선스키 적용 (배포 시 필요) -->
<script>
  wijmo.setLicenseKey('gilin.co.kr|www.gilin.co.kr,534271689318341#B0ijPyNHZisnOiwmbBJye0ICRiwiI34TQv56b0N6MnZlQ6pFSKJEeOxmWzg4dnhWQKZkMvMTTs34Z7NDRwVzcyZkMiZDdhhEORtWUJR6UpNDRYdmewFTVq9Gc5I4KsBldZVFT4ZHRPVEVpFmdnp4SGZDS9FnSV3WdqN5TV96KVZFW7l4RhtiathDZuZWdHFDd8RmZsdkSNNXM5ZWZS5EUX5mS9VGOXFUWyokT5NWWBFWVPVDV9NGRalXcz86YQpEdoh4aIVDciN7SY5kWuZTauJEO5YjeLRmYVZWMYhXOVJGc94WMYZTWN5WZth5N4wEN9Qza9ZWb9NXdyk4Z5s6MUdEUFNDbzEEZoxWMnpmNlNzZ5JGZQZVertUa72iba9WVzc5Kx2kMrgTSOZ4cHNmNkJ4MRZVOUd4MOdEe5hmTTlEaYllVxkWTNFFa4g4ZCBXQJJmTvolY4AVd4U5NrIUOVlzc7JVVsJWb74mRrJlI0IyUiwiI7YzMCZjQ6MjI0ICSiwyMwkjM4kDM8ETM0IicfJye&Qf35VfikEMyIlI0IyQiwiIu3Waz9WZ4hXRgACdlVGaThXZsZEIv5mapdlI0IiTisHL3JSNJ9UUiojIDJCLi86bpNnblRHeFBCIyV6dllmV4J7bwVmUg2Wbql6ViojIOJyes4nILdDOIJiOiMkIsIibvl6cuVGd8VEIgc7bSlGdsVXTg2Wbql6ViojIOJyes4nI4YkNEJiOiMkIsIibvl6cuVGd8VEIgAVQM3EIg2Wbql6ViojIOJyes4nIzMEMCJiOiMkIsISZy36Qg2Wbql6ViojIOJyes4nIVhzNBJiOiMkIsIibvl6cuVGd8VEIgQnchh6QsFWaj9WYulmRg2Wbql6ViojIOJyebpjIkJHUiwiI5ETMxkDMgETMxETMyAjMiojI4J7QiwiIytmLvNmLulGbpdmL7d7dsI7au26Yu8Wasl6ZiojIz5GRiwiIFeJ1ImZ1iojIh94QiwiIxQzM8EzM9gjNxcjM4MTNiojIklkIs4XXbpjInxmZiwiIxYXMyAjMiojIyVmdiwSZzyWXm');
</script>