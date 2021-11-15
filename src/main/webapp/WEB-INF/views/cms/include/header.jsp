<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>기린</title>

<script src="https://code.jquery.com/jquery-2.2.4.js" integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" crossorigin="anonymous"></script>
<%--<link rel="stylesheet" href="/css/styles.css">--%>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
<link rel="stylesheet" href="../../css/gilin.css">
<link rel="stylesheet" href="../../css/gilin_cms.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<link rel="stylesheet" href="../../wijmo/Dist/styles/custom.css"/>
<link rel="stylesheet" href="../../wijmo/Dist/styles/wijmo.css"/>

<!-- wijmo js -->
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.grid.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.input.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.xlsx.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.grid.xlsx.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.grid.filter.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/cultures/wijmo.culture.ko.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/jszip.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.grid.cellmaker.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.nav.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.grid.selector.min.js"></script>
<script type="text/javascript" src="../../wijmo/Dist/controls/wijmo.gauge.min.js"></script>
<script src="../../ckeditor5/build/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="../../ckeditor5/sample/styles.css">
<script src="../../js/include/cms.js"></script>
<!--  -->

<!-- Wijmo 배포라이선스키 적용 (배포 시 필요) -->
<script>
    wijmo.setLicenseKey('checkedu.co.kr|www.checkedu.co.kr,534271689318341#B0yWXmpjIyNHZisnOiwmbBJye0ICRiwiI34zZzA7ahVlSINlbrY4dRtmQxczKFZ6aptSS8InU4clcXp5cxNHMjhTWTt6Vv56RhdWaB5WO05mTzQWdU5Wex2UQxk5KxQEZ7l5c8IjYa3EO6o5MDpGdws6dIZkTYZTOIF7KV54Szo7bRB7VHZDMphkarUDdFJjUYBHdVxmaW36dzZ5KyFHeSB5Mid7NqB7dXJGaRdnSFZ4QWdlRKpkSydVVqBDa5cGeup6avM7VWVFe5tSdGRDZ4YHWNNnT8FWNyZ7SBdkZDlFS5ljWlpXVtlnZ4JmNHNXMu36LM54KTRUYRlzUQJzN54WdjpkcZB5QDR4ZlFXQoJHbndnM9tSbEBjVv5Wc5IWQv94TpdVU5QUQT9UU5pXdqdGNHd4ckVEU7Fle6UVbLdEVoVFewI6QERWTZRXZj96Rs9URjN6dFN4LQl6U0V7Q9gXO6hDTCJ6Q9kWeUtWUxhkI0IyUiwiIFJzQDNEODdjI0ICSiwCN9MzMxMzMzEjM0IicfJye&Qf35VfikEMyIlI0IyQiwiIu3Waz9WZ4hXRgACdlVGaThXZsZEIv5mapdlI0IiTisHL3JSNJ9UUiojIDJCLi86bpNnblRHeFBCIyV6dllmV4J7bwVmUg2Wbql6ViojIOJyes4nILdDOIJiOiMkIsIibvl6cuVGd8VEIgc7bSlGdsVXTg2Wbql6ViojIOJyes4nI4YkNEJiOiMkIsIibvl6cuVGd8VEIgAVQM3EIg2Wbql6ViojIOJyes4nIzMEMCJiOiMkIsISZy36Qg2Wbql6ViojIOJyes4nIVhzNBJiOiMkIsIibvl6cuVGd8VEIgQnchh6QsFWaj9WYulmRg2Wbql6ViojIOJyebpjIkJHUiwiI9QDMxkDMgETMxETMyAjMiojI4J7QiwiIytmLvNmL5RWZrNWZoNmL7d7dsI7au26YuUHZlt6Ylh6YiojIz5GRiwiIFeJ1ImZ1iojIh94QiwiIxQzM8EzM9gjNxcjM4MTNiojIklkIs4XXbpjInxmZiwiIxYXMyAjMiojIyVmdizSWz');
</script>