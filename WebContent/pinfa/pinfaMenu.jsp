<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%> 
<%-- <%@ page language="java" contentType="text/html; charset=GBK" --%>
<!-- 	pageEncoding="GBK"%> -->
 
<!-- <h1> -->
<!-- 	<a href="pinfa_showPinfaZhishu.action" target="main"> &nbsp; 频发指数</a> -->
<!-- </h1> -->
<!-- BI版 -->
<h1>
	<a
		href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/yiweipinfajisuan&NQUser=weblogic&NQPassword=Admin123"
		target="main"> 一维频发指数</a>
</h1>
<h1>
	<a
		href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/erweipinfajisuan&NQUser=weblogic&NQPassword=Admin123"
		target="main"> 二维频发指数</a>
</h1>
<script language="JavaScript">
<!--//
	function ShowMenu(obj, n) {
		var Nav = obj.parentNode;
		if (!Nav.id) {
			var BName = Nav.getElementsByTagName("ul");
			var HName = Nav.getElementsByTagName("h2");
			var t = 2;
		} else {
			var BName = document.getElementById(Nav.id).getElementsByTagName(
					"span");
			var HName = document.getElementById(Nav.id).getElementsByTagName(
					"h1");
			var t = 1;
		}
		for ( var i = 0; i < HName.length; i++) {
			HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
			HName[i].className = "";
		}
		obj.className = "h" + t;
		for ( var i = 0; i < BName.length; i++) {
			if (i != n) {
				BName[i].className = "no";
			}
		}
		if (BName[n].className == "no") {
			BName[n].className = "";
			obj.innerHTML = obj.innerHTML.replace("+", "-");
		} else {
			BName[n].className = "no";
			obj.className = "";
			obj.innerHTML = obj.innerHTML.replace("-", "+");
		}
	}
//-->
</script>
