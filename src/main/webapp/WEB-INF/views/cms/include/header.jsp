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
    wijmo.setLicenseKey('gilin.co.kr|www.gilin.co.kr,534271689318341#B0ijPyNHZisnOiwmbBJye0ICRiwiI34TQv56b0N6MnZlQ6pFSKJEeOxmWzg4dnhWQKZkMvMTTs34Z7NDRwVzcyZkMiZDdhhEORtWUJR6UpNDRYdmewFTVq9Gc5I4KsBldZVFT4ZHRPVEVpFmdnp4SGZDS9FnSV3WdqN5TV96KVZFW7l4RhtiathDZuZWdHFDd8RmZsdkSNNXM5ZWZS5EUX5mS9VGOXFUWyokT5NWWBFWVPVDV9NGRalXcz86YQpEdoh4aIVDciN7SY5kWuZTauJEO5YjeLRmYVZWMYhXOVJGc94WMYZTWN5WZth5N4wEN9Qza9ZWb9NXdyk4Z5s6MUdEUFNDbzEEZoxWMnpmNlNzZ5JGZQZVertUa72iba9WVzc5Kx2kMrgTSOZ4cHNmNkJ4MRZVOUd4MOdEe5hmTTlEaYllVxkWTNFFa4g4ZCBXQJJmTvolY4AVd4U5NrIUOVlzc7JVVsJWb74mRrJlI0IyUiwiI7YzMCZjQ6MjI0ICSiwyMwkjM4kDM8ETM0IicfJye&Qf35VfikEMyIlI0IyQiwiIu3Waz9WZ4hXRgACdlVGaThXZsZEIv5mapdlI0IiTisHL3JSNJ9UUiojIDJCLi86bpNnblRHeFBCIyV6dllmV4J7bwVmUg2Wbql6ViojIOJyes4nILdDOIJiOiMkIsIibvl6cuVGd8VEIgc7bSlGdsVXTg2Wbql6ViojIOJyes4nI4YkNEJiOiMkIsIibvl6cuVGd8VEIgAVQM3EIg2Wbql6ViojIOJyes4nIzMEMCJiOiMkIsISZy36Qg2Wbql6ViojIOJyes4nIVhzNBJiOiMkIsIibvl6cuVGd8VEIgQnchh6QsFWaj9WYulmRg2Wbql6ViojIOJyebpjIkJHUiwiI5ETMxkDMgETMxETMyAjMiojI4J7QiwiIytmLvNmLulGbpdmL7d7dsI7au26Yu8Wasl6ZiojIz5GRiwiIFeJ1ImZ1iojIh94QiwiIxQzM8EzM9gjNxcjM4MTNiojIklkIs4XXbpjInxmZiwiIxYXMyAjMiojIyVmdiwSZzyWXm');
</script>