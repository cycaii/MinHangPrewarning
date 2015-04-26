<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/common/meta.jsp"%>
<link href="${ctx}/resources/bootstrap/css/bootstrap.css"
	rel="stylesheet">
	<title>频发统计</title>
</head>

<body>
	<div class="container">
		<div>
			<form id="form1" name="form1" method="post"
				action="pinfa_showPinfaZhishu.action" onsubmit="return commit()"
				class="form-horizontal" role="form">
				<div class="form-group">
					<label for="inputMsg" class="col-sm-2 control-label"> </label> <label
						style="color: rgb(176, 23, 31)" id="inputMsg"></label>
				</div>
				<div class="form-group">
					<label for="year" class="col-sm-2 control-label">年份</label>
					<div class="col-sm-6">
						<select name="year" id="year" class="form-control">
							<s:iterator value="years" id="oneyear">
								<option value="<s:property value="oneyear" />"
									<s:if test="#oneyear==year">selected="selected"</s:if>>
									<s:property value="oneyear" />
								</option>
							</s:iterator>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="accordingSel">时间类型</label>
					<div class="col-sm-6">
						<select name="accordingSel" id="accordingSel" class="form-control"
							onchange="getCity()">
							<option value="">请选择时间类型</option>
							<option value="年">年</option>
							<option value="月">月</option>
							<option value="周">周</option>
							<option value="旬">旬</option>
							<option value="季度">季度</option>
							<option value="季节">季节</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="numSel">序号</label>
					<div class="col-sm-6">
						<select name="numSel" id="numSel" class="form-control">
							<option value="">请选择序号</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="duibijizhun">对比基准</label>
					<div class="col-sm-6">
						<select name="duibijizhun" id="duibijizhun" class="form-control">
							<option value="">请选择对比基准</option>
							<s:iterator value="duibijizhunNames" id="duibijizhunName">
								<option value="<s:property value="duibijizhunName" />">
									<s:property value="duibijizhunName" />
								</option>
							</s:iterator>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">确定</button>
					</div>
				</div>
			</form>
		</div>
		<div>
			<s:if test="msg!=null">
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<p>
							<s:property value="msg" />
						</p>
					</div>
				</div>
			</s:if>
			<s:elseif test="yiweiResults != null && yiweiResults.size() > 0">
				<table class="table table-hover">
					<caption>
						<s:property value="duibijizhun" />
						(
						<s:property value="year" />
						年第
						<s:property value="numSel" />
						<s:property value="accordingSel" />
						)
					</caption>
					<tr>
						<th width="130">维度类型</th>
						<th width="130">维度值</th>
						<th width="130">频数</th>
						<th width="130">平均频数</th>
						<th width="130">百分百</th>
						<th width="130">频发指数</th>
					</tr>
					<s:iterator value="yiweiResults" id="yiweiResult">
						<tr>
							<td><s:property value="weidulx" /></td>
							<td><s:property value="weiduvalue" /></td>
							<td><s:property value="pinshu" /></td>
							<td><s:property value="avgpinshu" /></td>
							<td><s:property value="percent" /></td>
							<td><s:property value="zhishu" /></td>
						</tr>
					</s:iterator>

				</table>
			</s:elseif>
		</div>
	</div>
</body>
</html>
<script language="JavaScript" type="text/javascript">
	//定义了城市的二维数组，里面的顺序跟省份的顺序是相同的。通过selectedIndex获得省份的下标值来得到相应的城市数组 11   
	var numSel = [
			[ 1 ],
			[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ],
			[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
					19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
					34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
					49, 50, 51, 52 ],
			[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
					19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
					34, 35, 36 ], [ 1, 2, 3, 4 ], [ 1, 2, 3, 4 ] ];
	function getCity() {
		//获得省份下拉框的对象  21         
		var sltProvince = document.form1.accordingSel;
		//获得城市下拉框的对象  23         
		var sltCity = document.form1.numSel;
		//得到对应省份的城市数组  26   
		var provinceCity = numSel[sltProvince.selectedIndex - 1];
		//清空城市下拉框，仅留提示选项 29  
		sltCity.length = 1;
		//将城市数组中的值填充到城市下拉框中 32  
		for ( var i = 0; i < provinceCity.length; i++) {
			sltCity[i + 1] = new Option(provinceCity[i], provinceCity[i]);
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
	function commit() {

		var sel = $("#year").find("option:selected").val();
		if (sel == "") {
			$("#inputMsg").text("请选择年份 ");
			return false;
		}
		sel = $("#accordingSel").find("option:selected").val();
		if (sel == "") {
			$("#inputMsg").text("请选择统计类型 ");
			return false;
		}
		sel = $("#numSel").find("option:selected").val();
		if (sel == "") {
			$("#inputMsg").text("请选择序号 ");
			return false;
		}
		sel = $("#duibijizhun").find("option:selected").val();
		if (sel == "") {
			$("#inputMsg").text("请选择对比基准 ");
			return false;
		}

	}
</script>