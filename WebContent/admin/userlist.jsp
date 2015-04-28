<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="BootstrapStyler">

<title>用户管理</title>

<!-- Bootstrap core CSS -->
<link href="../resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome CSS -->
<link
	href="../resources/fonts/font-awesome/css/font-awesome.min.css?v=4.0.3"
	rel="stylesheet">

<!-- Bootstrap Switch -->
<link href="../resources/css/libs/bootstrap-switch.min.css?v=3.0.0"
	rel="stylesheet">

<!-- Bootstrap Select -->
<link href="../resources/css/libs/bootstrap-select.min.css"
	rel="stylesheet">

<!-- Summernote -->
<link href="../resources/css/libs/summernote.css" rel="stylesheet">
<link href="../resources/css/libs/summernote-bs3.css" rel="stylesheet">

<!-- IcoMoon CSS -->
<link href="../resources/fonts/icomoon/style.css?v=1.0" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/styler/style.css" rel="stylesheet"
	type="text/css">

<!-- Sign In and Sign Up page styling -->
<link href="../resources/css/styler/signin.css" rel="stylesheet">
</head>

<body>
	<!-- 引入header -->
	<jsp:include page="admin-header.jsp" flush="true" />
	<div class="container">
		<div class="row">

			<div
				class="col-md-12  col-sm-12  col-no-left-padding">
				<section id="middle">
			    	<div class="panel-body">
						<ul class="nav nav-pills nav-stacked" id="pages-app">
							<li class="active"><a
								href="admin_userlist.action"><b class="icon-cover"></b><i
									class="imoon imoon-dashboard fa-fw"></i> 个人用户管理</a></li>
						</ul>
					</div>
								 
								
					<div class="col-md-12">
						<div class="div-myroademap-right-above">
						<a class="btn btn-primary" href="admin_newuser.action" target="_blank">新增用户</a>
							<table class="table table-hover">
								<thead>
									<tr>
										<th>状态</th>
										<th>姓名</th>
										<th>性别</th>
										<th>权限</th>
										<th>操作1</th>
										<th>操作2</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="allusers" id="user">
										<tr>
<%-- 											<td><s:property value="#user.state" /></td> --%>
											<td><s:if test="#user.state==0">
													 正常
												</s:if> <s:elseif test="#user.state==1">屏蔽</s:elseif> <s:else>无</s:else></td>

											<td><s:if test="#user.username.length()>0">
													<s:property value="#user.username" />
												</s:if> <s:else>暂无</s:else></td>
											<td><s:if
													test=" #user.gender==0||#user.gender==1 ">
													<s:if test="#user.gender==0">男</s:if>
													<s:elseif test="#user.gender==1">女</s:elseif>
												</s:if> <s:else>无</s:else></td>
											 <td><s:if
													test=" #user.permission==0||#user.permission==1 ">
													<s:if test="#user.permission==0">管理员</s:if>
													<s:elseif test="#user.permission==1">普通用户</s:elseif>
												</s:if> <s:else>无</s:else></td>
											<td><s:if test="#user.state!=1">
													<a
														href="admin_del.action?userid=${user.userid}"
														class="btn btn-small btn-danger" type="button">屏蔽</a>
												</s:if> <s:else>
													<a
														href="admin_recover.action?userid=${user.userid}"
														class="btn btn-small btn-warning" type="button">恢复</a>
												</s:else> <%-- <a href="admin-del.action?id=${user.uid}&flag=user" class="btn btn-small btn-danger" type="button">删除</a> --%>
											</td>
											<td><a
												href="admin_userinfo.action?userid=${user.userid}"
												>Edit</a></td>
										</tr>
									</s:iterator>

								</tbody>
							</table>
						 
						</div>
					</div>

				</section>
			</div>
			<!-- /.col-md-10 -->

			<!-- 引入左边的目录 -->
<%-- 			<jsp:include page="admin-leftpanel.jsp" flush="true" /> --%>

		</div>
		<!-- /.row -->
	</div>
 
	<!-- jQuery -->
	<script src="../js/libs/jquery-1.11.0.min.js"></script>

	<!-- Bootstrap core JavaScript -->
	<script src="../bootstrap/js/bootstrap.min.js?v=3.1.1"></script>

	<!-- Sparkline -->
	<script src="../js/libs/jquery.sparkline.min.js"></script>

	<!-- Bootstrap Switch -->
	<script src="../js/libs/bootstrap-switch.min.js?v=3.0.0"></script>

	<!-- Bootstrap Select -->
	<script src="../js/libs/bootstrap-select.min.js"></script>

	<!-- Bootstrap File -->
	<script src="../js/libs/bootstrap-filestyle.js"></script>

	<!-- Raphael JS -->
	<script src="../js/libs/raphael-min.js"></script>

	<!-- morris.js -->
	<script src="../js/libs/morris.min.js"></script>

	<!-- Summernote -->
	<script src="../js/libs/summernote.min.js"></script>

	<!-- Theme script -->
	<script src="../js/styler/script.js"></script>

</body>
</html>