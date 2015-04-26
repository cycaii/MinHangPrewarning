<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>  
<%-- <%@ page language="java" contentType="text/html; charset=GBK" --%>
<%-- 	pageEncoding="GBK"%> --%>
<%@include file="/common/header.jsp"%>
<%@page
	import="minhang.dao.*,minhang.entity.*,minhang.service.*,java.util.*,org.jfree.chart.*,org.jfree.chart.plot.*,org.jfree.chart.labels.*,
org.jfree.data.category.*,org.jfree.data.general.DefaultPieDataset,org.jfree.ui.*,org.jfree.chart.renderer.category.BarRenderer3D,
org.jfree.chart.servlet.*,org.jfree.chart.plot.PlotOrientation,org.jfree.data.general.DatasetUtilities"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/meta.jsp"%>
<link href="${ctx}/resources/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<%-- 	<link href="${ctx}/resources/bootstrap/css/bootstrap.min.css" --%>
<!-- 	rel="stylesheet"> -->
<title>民航不安全事件分析与预警系统</title>
</head>
<%
	//set encoding
	request.setCharacterEncoding("gbk");

	//get common objects
	CommonService c = (CommonService) application
	.getAttribute("CommonService");
	DimtypeDao d = (DimtypeDao) application.getAttribute("DimtypeDao");
	TwodimstatisticDao od = (TwodimstatisticDao) application
	.getAttribute("TwodimstatisticDao");
	List<String> dimStrs = (List<String>) application
	.getAttribute("dimTypeStrs");
	String[][] valueStrs = (String[][]) application
	.getAttribute("valueStrsArray");
	List<String> diquStrs = (List<String>) application
	.getAttribute("diquValueStrs");

	//获取页面输入参数
	String button1 = request.getParameter("fastButton");
	System.out.println("=========================================");
	System.out.println("button1:"+button1);
	System.out.println("=========================================");
	String dimtype1 = "",dimvalue1="",dimtype2="",dimvalue2="";
	if(button1!=null)//一键分析
	{
	  dimtype1 = "发生地区";
	 dimtype2 = "事件性质";
	}else{
	  dimtype1 = request.getParameter("dtype1Select");
	  dimvalue1 = request.getParameter("dvalue1Select");
	  dimtype2 = request.getParameter("dtype2Select");
	  dimvalue2 = request.getParameter("dvalue2Select");}
	String timeSel = request.getParameter("timeSelect");
	String barGraphURL = null, pieGraphURL = null,lineGraphURL = null;
	String startYear =  request.getParameter("sy_year"), endYear = request.getParameter("ey_year"), startNum = null, endNum = null;

	//设置查询条件参数
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
		List<Twodimstatistic> result = c.getTwoDimResult(sel,
		dimtype1, dimvalue1, dimtype2, dimvalue2, startYear,
		endYear, startNum, endNum);

		//生成直方图
		JFreeChart chart = c.getTwoDimBarChart(dimtype1, dimtype2,
		dimvalue1, dimvalue2, result);
		String bfilename = ServletUtilities.saveChartAsPNG(chart, 800,
		500, null, session);
		barGraphURL = request.getContextPath()
		+ "/DisplayChart?filename=" + bfilename;

		//生成饼状图
		JFreeChart chart2 = c.getTwoDimPieChart(dimtype1, dimtype2,
		result);
		String pfilename = ServletUtilities.saveChartAsPNG(chart2, 500,
		500, null, session);
		pieGraphURL = request.getContextPath()
		+ "/DisplayChart?filename=" + pfilename;

		//生成折线图
		JFreeChart chart3 = c.getTwoDimLineChart(dimtype1, dimtype2,
		result);
		String lfilename = ServletUtilities.saveChartAsPNG(chart3, 800,
		500, null, session);
		lineGraphURL = request.getContextPath()
		+ "/DisplayChart?filename=" + lfilename;
	}
%>

<body>
	<div class="container">
		<div>
			<form action="tongji_Twodim.jsp" method="post" name="form1"
				onsubmit="return commitCheck()" class="form-horizontal" role="form">
				<div class="form-group">
					<label for="inputMsg" class="col-sm-2 control-label"> </label> <label
						style="color: rgb(176, 23, 31)" id="inputMsg"></label>
				</div>
				<div class="form-group">
					<label for="dtype1Select" class="col-sm-2 control-label">维度一</label>
					<div class="col-sm-5">
						<select name="dtype1Select" id="dtype1Select" class="form-control"
							onChange="getValue(this.selectedIndex,1)">
<!-- 							<option value="">选择维度一</option> -->
							<%
								for (int i = 0; i < dimStrs.size(); i++) {
							%>
							<option value=<%=dimStrs.get(i)%>><%=dimStrs.get(i)%></option>
							<%
								}
							%>
						</select>
					</div>
					<label for="dvalue1Select" class="sr-only"></label>
					<div class="col-sm-5">
						<select name="dvalue1Select" id="dvalue1Select"
							class="form-control">
							<option value="">维度一取值</option>
							<%
								for (int i = 0; i < diquStrs.size(); i++) {
							%>
							<option value=<%=diquStrs.get(i)%>><%=diquStrs.get(i)%>
							</option>
							<%-- 							<option value=<%=diquStrs.get(i)%>> <%=diquStrs.get(i)%></option> --%>
							<%
								}
							%>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="dtype2Select" class="col-sm-2 control-label">维度二</label>
					<div class="col-sm-5">
						<select name="dtype2Select" id="dtype2Select" class="form-control"
							onChange="getValue(this.selectedIndex,2)">
<!-- 							<option value="">选择维度二</option> -->
							<%
								for (int i = 0; i < dimStrs.size(); i++) {
							%>
							<option value=<%=dimStrs.get(i)%>><%=dimStrs.get(i)%></option>
							<%
								}
							%>
						</select>
					</div>
					<label for="dvalue2Select" class="sr-only"></label>
					<div class="col-sm-5">
						<select name="dvalue2Select" id="dvalue2Select"
							class="form-control">
							<option value="">维度二取值</option>
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
						<input type="number" class="form-control" id="sx_xun"
							name="sx_xun" placeholder="起始旬度">
					</div>
					<label for="ex_xun" class="col-sm-2 control-label">终止旬度</label>
					<div class="col-sm-4">
						<input type="number" class="form-control" id="ex_xun"
							name="ex_xun" placeholder="终止旬度">
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
					<div class="col-sm-offset-2 col-sm-4">
						<input type="submit" name="normalButton" class="btn btn-default"
							value="自选维度分析"> </input>
					</div>
					<div class="col-sm-offset-2 col-sm-4">
						<input type="submit" name="fastButton" class="btn btn-default"
							title="发生地区+事件性质" value="一键分析"> </input>
					</div>
				</div>


			</form>
		</div>
		<div>
			<%
				if (barGraphURL != null) {
			%>
			<h3 style="align: center">频发统计图</h3>
			<p>
				<img src="<%=barGraphURL%>" class="img-rounded"></br> </br> <img
					src="<%=pieGraphURL%>" class="img-rounded"></br> </br> <img
					src="<%=lineGraphURL%>" class="img-rounded">
			</p>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>

<script type="text/javascript" language="javascript">
dimValue = new Array();
	<%for(int i = 0; i <valueStrs.length;i++){%> 
		dimValue[<%=i%>]=new Array();
		
		<%for (int j = 0; j < valueStrs[i].length; j++) {%>
			dimValue[<%=i%>][<%=j%>]='<%=valueStrs[i][j]%>';
<%}
 			}%>
 			
	function getValue(dim, num) {
		var i;
		if (num === 1) {
			document.all.dvalue1Select;
			// 			dvalue1Select.length = 1;
			document.all.dvalue1Select.options.length = 1;
			for (i = 0; i < dimValue[dim].length; i++) {
				document.all.dvalue1Select.options[document.all.dvalue1Select.length] = new Option(
						dimValue[dim][i], dimValue[dim][i]);
			}
		}
		if (num === 2) {
			document.all.dvalue2Select.options.length = 1;
			for (i = 0; i < dimValue[dim].length; i++) {
				document.all.dvalue2Select.options[document.all.dvalue2Select.length] = new Option(
						dimValue[dim][i], dimValue[dim][i]);
			}
		}
	}

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
		// 		$("#inputMsg").text("请输入数字 ");
		return false;
	}

	/**
	 * 表单提交 检查 
	 */
	function commitCheck() {
		var timesel = $("#timeSelect").find("option:selected").val();
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