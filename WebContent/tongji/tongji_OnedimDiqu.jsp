<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page language="java" contentType="text/html; charset=GBK" --%>
<%-- 	pageEncoding="GBK"%> --%>
<%@include file="/common/header.jsp"%>
<%@page
	import="minhang.dao.*,minhang.service.*,minhang.entity.*,java.util.*,org.jfree.chart.*,org.jfree.chart.plot.*,org.jfree.chart.labels.*,
org.jfree.data.category.*,org.jfree.data.general.DefaultPieDataset,org.jfree.ui.*,org.jfree.chart.renderer.category.BarRenderer3D,
org.jfree.chart.servlet.*,org.jfree.chart.plot.PlotOrientation,org.jfree.data.general.DatasetUtilities"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/meta.jsp"%>
<link href="${ctx}/resources/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<title>民航不安全事件分析与预警系统</title>
</head>

<%
	request.setCharacterEncoding("gbk");

	//get common objects
	CommonService c = (CommonService) application
	.getAttribute("CommonService");
	DimtypeDao d = (DimtypeDao) application.getAttribute("DimtypeDao");
	OnedimstatisticDao od = (OnedimstatisticDao) application
	.getAttribute("OnedimstatisticDao");
	String[][] valueStrs = (String[][]) application
	.getAttribute("valueStrsArray");
	List<String> diquStrs = (List<String>) application
	.getAttribute("diquValueStrs");
	List<String> didianStrs = (List<String>) application
	.getAttribute("didianValueStrs");

	//get request parameters from page
	String lineGraphURL = null;
	String diqu = request.getParameter("diquSelect");
	String didian = request.getParameter("didianSelect");
	String dimValue = null, dimtype = "发生地区";
	String timeSel = request.getParameter("timeSelect");
	String startYear = request.getParameter("sy_year"), endYear = request.getParameter("ey_year"), startNum = null, endNum = null;
	
	if (diqu != null && !diqu.trim().equals("")) {
		dimValue = diqu;
	} else if (didian != null && !didian.trim().equals("")) {
		dimValue = didian;
		dimtype = "发生地点";
	}
	System.out.println("dimtype：" + dimtype + "  dimValue" + dimValue);

	if (timeSel != null) {
		int sel = Integer.parseInt(timeSel);
		switch (sel) {
		case 1:
	break;
	case 2:
		startNum = request.getParameter("sj_jijie");
		endNum = request.getParameter("ej_jijie");
		break;
		case 3:
	startNum = request.getParameter("ss_season");
	endNum = request.getParameter("es_season");
	break;
		case 4:
	startNum = request.getParameter("sm_month");
	endNum = request.getParameter("em_month");
	break;
		case 5:
	startNum = request.getParameter("sx_xun");
	endNum = request.getParameter("ex_xun");
	break;
		case 6:
	startNum = request.getParameter("sw_week");
	endNum = request.getParameter("ew_week");
	break;
		
		}

		//数据处理
		List<Onedimstatistic> result = c
		.getOneDimResult(sel, dimtype, dimValue,
		startYear, endYear, startNum, endNum);
		//生成折线图
		JFreeChart chart3 = c.getOneDimLineChart(dimtype, result);
		String lfilename = ServletUtilities.saveChartAsPNG(chart3, 800,
		500, null, session);
		lineGraphURL = request.getContextPath()
		+ "/DisplayChart?filename=" + lfilename;
	}
%>
<body>
	<div class="container">
		<form action="tongji_OnedimDiqu.jsp" method="post"
			onsubmit="return commitCheck()" class="form-horizontal" role="form">
			<div class="form-group">
				<label for="inputMsg" class="col-sm-2 control-label"> </label> <label
					style="color: rgb(176, 23, 31)" id="inputMsg"></label>
			</div>

			<div class="form-group">
				<label for="diquSelect" class="col-sm-2 control-label">发生地区</label>
				<div class="col-sm-10">
					<select name="diquSelect" id="diquSelect" class="form-control">
						<option value="">选择发生地区</option>
						<%
							for (int i = 0; i < diquStrs.size(); i++) {
						%>
						<option value=<%=diquStrs.get(i)%>><%=diquStrs.get(i)%></option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="didianSelect" class="col-sm-2 control-label">所在地点</label>
				<div class="col-sm-10">
					<select name="didianSelect" id="didianSelect" class="form-control">
						<option value="">选择所在地点</option>
						<%
							for (int i = 0; i < didianStrs.size(); i++) {
						%>
						<option value=<%=didianStrs.get(i)%>><%=didianStrs.get(i)%></option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="timeSelect" class="col-sm-2 control-label">统计时间</label>
				<div class="col-sm-10">
					<select name="timeSelect" id="timeSelect"
						onChange="selectTimeValue(this.selectedIndex)"
						class="form-control">
						<option value="0">请选择</option>
						<option value="1">年度</option>
						<option value="2">季节</option>
						<option value="3">季度</option>
						<option value="4">月度</option>
						<option value="5">旬度</option>
						<option value="6">周次</option>
					</select>
				</div>
			</div>
			<div class="form-group" id="year_row">
				<label for="sy_year" class="col-sm-2 control-label">起始年度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="sy_year"
						name="sy_year" placeholder="起始年度">
				</div>
				<label for="ey_year" class="col-sm-2 control-label">终止年度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="ey_year"
						name="ey_year" placeholder="终止年度">
				</div>
			</div>

			<div class="form-group" id="jijie_row" style="display: none;">
				<label for="sj_jijie" class="col-sm-2 control-label">起始季节</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="sj_jijie"
						name="sj_jijie" placeholder="起始季节">
				</div>
				<label for="ej_jijie" class="col-sm-2 control-label">终止季节</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="ej_jijie"
						name="ej_jijie" placeholder="终止季节">
				</div>
			</div>

			<div class="form-group" id="season_row" style="display: none;">
				<label for="ss_season" class="col-sm-2 control-label">起始季度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="ss_season"
						name="ss_season" placeholder="起始季度">
				</div>
				<label for="es_season" class="col-sm-2 control-label">终止季度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="es_season"
						name="es_season" placeholder="终止季度">
				</div>
			</div>

			<div class="form-group" id="month_row" style="display: none;">
				<label for="sm_month" class="col-sm-2 control-label">起始月度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="sm_month"
						name="sm_month" placeholder="起始月度">
				</div>
				<label for="em_month" class="col-sm-2 control-label">终止月度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="em_month"
						name="em_month" placeholder="终止月度">
				</div>
			</div>

			<div class="form-group" id="xun_row" style="display: none;">
				<label for="sx_xun" class="col-sm-2 control-label">起始旬度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="sx_xun" name="sx_xun"
						placeholder="起始旬度">
				</div>
				<label for="ex_xun" class="col-sm-2 control-label">终止旬度</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="ex_xun" name="ex_xun"
						placeholder="终止旬度">
				</div>
			</div>
			<div class="form-group" id="week_row" style="display: none;">
				<label for="sw_week" class="col-sm-2 control-label">起始周次</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="sw_week"
						name="sw_week" placeholder="起始周次">
				</div>
				<label for="ew_week" class="col-sm-2 control-label">终止周次</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="ew_week"
						name="ew_week" placeholder="终止周次">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">确定</button>
				</div>
			</div>
		</form>
		<div>
			<%
				if (lineGraphURL != null) {
			%>
			<h3>频发统计图</h3>
			<p>
				<img src="<%=lineGraphURL%>" class="img-rounded">
			</p>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" language="javascript">
	function selectTimeValue(sel) {
		switch (sel) {
		case 0, 1:
			$("#jijie_row").hide();
			$("#season_row").hide();
			$("#month_row").hide();
			$("#xun_row").hide();
			$("#week_row").hide();
			break;
		case 2:
			$("#jijie_row").show();
			$("#season_row").hide();
			$("#month_row").hide();
			$("#xun_row").hide();
			$("#week_row").hide();
			break;
		case 3:
			$("#jijie_row").hide();
			$("#season_row").show();
			$("#month_row").hide();
			$("#xun_row").hide();
			$("#week_row").hide();
			break;
		case 4:
			$("#jijie_row").hide();
			$("#season_row").hide();
			$("#month_row").show();
			$("#xun_row").hide();
			$("#week_row").hide();
			break;
		case 5:
			$("#jijie_row").hide();
			$("#season_row").hide();
			$("#month_row").hide();
			$("#xun_row").show();
			$("#week_row").hide();
			break;
		case 6:
			$("#jijie_row").hide();
			$("#season_row").hide();
			$("#month_row").hide();
			$("#xun_row").hide();
			$("#week_row").show();
			break;
		default:

		}

	}
	/**
	 * 检查输入 数字 
	 */
	function checkValidateNum(name) {
		var value = document.getElementById(name).value;
		if (value && value != null && !isNaN(value)) {
			$("#inputMsg").text(" ");
			return true;
		}
		return false;
	}

	/**
	 * 表单提交 检查 
	 */
	function commitCheck() {
		var diqusel = $("#diquSelect").find("option:selected").val();
		// 		alert("dimsel:" + dimsel + " timesel: " + timesel);
		// 		if (diqusel == "") {
		// 			$("#inputMsg").text("请选择");
		// 			return false;
		var timesel = $("#timeSelect").find("option:selected").val();
		if (timesel == "0") {
			$("#inputMsg").text("请选择统计时间 ");
			return false;
		}
		if (timesel == "0") {
			$("#inputMsg").text("请选择统计时间 ");
			return false;
		}
		if (!checkValidateNum('sy_year') || !checkValidateNum('ey_year')) {
			$("#inputMsg").text("请正确输入年份 ");
			return false;
		}
		switch (timesel) {
		case "1":
			return true;
			break;
		case "2":
			if (!checkValidateNum('sj_jijie') || !checkValidateNum('ej_jijie')) {
				$("#inputMsg").text("请正确输入季节 ");
				return false;
			}
			break;
		case "3":
			if (!checkValidateNum('ss_season')
					|| !checkValidateNum('es_season')) {
				$("#inputMsg").text("请正确输入季度 ");
				return false;
			}
			break;
		case "4":
			if (!checkValidateNum('sm_month') || !checkValidateNum('em_month')) {
				$("#inputMsg").text("请正确输入月度 ");
				return false;
			}
			break;
		case "5":
			if (!checkValidateNum('sx_xun') || !checkValidateNum('ex_xun')) {
				$("#inputMsg").text("请正确输入旬度");
				return false;
			}
			break;
		case "6":
			if (!checkValidateNum('sw_week') || !checkValidateNum('ew_week')) {
				$("#inputMsg").text("请正确输入周次 ");
				return false;
			}
			break;
		}
		return true;

	}
</script>
