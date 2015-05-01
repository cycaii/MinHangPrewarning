<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>  
<%-- <%@ page language="java" contentType="text/html; charset=GBK" --%>
<%-- 	pageEncoding="GBK"%> --%>

 
<!-- <h1 onClick="javascript:ShowMenu(this,0)"> -->
<!-- 	<a href="javascript:void(0)">+ 一维统计</a> -->
<!-- </h1> -->
<!-- <span class="no"> -->
<!-- 	<h2> -->
<!-- 		<a href="tongji_OnedimTime.jsp" target="main"> 时间维度分析</a> -->
<!-- 	</h2> -->
<!-- 	<h2> -->
<!-- 		<a href="tongji_OnedimDiqu.jsp" target="main"> 空间维度分析</a> -->
<!-- 	</h2> -->
<!-- 	<h2> -->
<!-- 		<a href="#"> 一维统计分析</a> -->
<!-- 	</h2> -->
<!-- </span> -->
<!-- <h3> -->
<!-- 	<a href="tongji_Twodim.jsp" target="main">  &nbsp; 二维统计</a> -->
<!-- </h3> -->

<!-- BI版 -->
<h1 onClick="javascript:ShowMenu(this,0)">
	<a href="javascript:void(0)">  +   一维统计</a>
</h1>
<span class="no">
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/一维频数整体统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 整体排序</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/一维频数时间统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 趋势分析</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/一维频数同比统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 同比分析</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/一维频数环比统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 环比分析</a>
	</h2>
</span>
<h3 onClick="javascript:ShowMenu(this,1)">
	<a href="javascript:void(1)"> +  二维统计</a>
</h3>
<span class="no">
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/二维频数整体统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 整体排序</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/二维频数时间统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 趋势分析</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/二维频数同比统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 同比分析</a>
	</h2>
	<h2>
		<a href="http://localhost:9704/analytics/saw.dll?PortalPages&PortalPath=/shared/minhang/_portal/二维频数环比统计&NQUser=weblogic&NQPassword=Admin123" target="main"> 环比分析</a>
	</h2>
</span>
 
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