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

 <script src="../resources/jquery/jquery-1.8.3.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="../resources/bootstrap/css/bootstrap.min.css?v=3.1.1"
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
<!-- <link href="../resources/css/styler/style_new.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="../resources/css/styler/signin.css" rel="stylesheet"> -->
<link rel="stylesheet" href="../resources/css/libs/bootstrapValidator.css" />
<style type="text/css">
#middle #content {
   background-color: white; 
  padding: 25px;
}
</style>
</head>

<body>
	<!-- 引入header -->
	<jsp:include page="admin-header.jsp" flush="true" />
	<div class="container">
		<div class="row">

			<div class="col-md-12  col-sm-12  col-no-left-padding">
				<section id="middle">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked" id="pages-app">
							<li class="active"><a href="admin_userlist.action"><b
									class="icon-cover"></b><i class="imoon imoon-dashboard fa-fw"></i>
									个人用户管理>添加用户</a></li>
						</ul>
					</div>
					<div
						class="col-md-6 col-md-push-3 col-xs-10 col-xs-push-1 col-sm-8 col-sm-push-2">
						<div id="content">
							<div class="row">
							<font color="red"><s:property value="errinfo"/></font>
								<form id="defaultForm" method="post" class="form-vertical"
									action="admin_saveNewuser.action"
									enctype="multipart/form-data">
									<input id="userid" name="userid" type="hidden"
										value="<s:property value='user.userid'/>" />

									<div class="form-group">
										<label><h3 class="grey">用户名</h3></label> <input type="text"
											id="username" name="username" class="form-control"
											placeholder="用户名"  ><span
											class="text-danger" id="error1" style="display: none;">请输入用户名</span>
										<span class="help-block" id="hint1"></span>
									</div>

									<div class="form-group">
										<label><h3 class="grey">密码</h3></label> <input type="text"
											id="password" name="password" class="form-control" placeholder="密码"
											 > <span
											class="text-danger" id="error2" style="display: none;">请输入密码</span>
										<span class="help-block" id="hint2"></span>
									</div>

									<div class="form-group">
										<label><h3 class="grey">性别</h3></label> <select name="gender"
											class="form-control" id="corp-big">
											<option value="">请选择</option>
											<option value="0"  >男</option>
											<option value="1"  >女</option>
										</select> <span class="text-danger" id="error4" style="display: none;">请选择性别</span>
										<span class="help-block" id="hint4" />
									</div>

									<div class="form-group">
										<label><h3 class="grey">状态</h3></label> <select name="state"
											class="form-control" id="corp-big">
											<option value="">请选择</option>
											<option value="0"  >正常</option>
											<option value="1" >屏蔽</option>
										</select> <span class="text-danger" id="error3" style="display: none;">请选择状态</span>
										<span class="help-block" id="hint3" />
									</div>

									<div class="form-group">
										<label><h3 class="grey">权限</h3></label> <select
											name="permission" class="form-control" id="corp-big">
											<option value="">请选择</option>
											<option value="0"
												 >管理员</option>
											<option value="1"
												 >普通用户</option>
										</select> <span class="text-danger" id="error5" style="display: none;">请选择权限</span>
										<span class="help-block" id="hint5" />
									</div>


									<div class="form-group">
										<label><h3 class="grey">备注</h3></label>
										<textarea id="description" name="description" rows="4"
											maxlength="60" class="form-control" placeholder="请输入备注说明">
										 
								</textarea>
										<span class="help-block">非必填</span> <span class="help-block"
											id="hint6" />
									</div>
									<div class="form-group form-actions pull-right">
										<button type="submit" class="btn btn-new1 btn-lg"
											style="border-radius: 3px;">保存</button>
									</div>
								</form>
							</div>
						</div>
					</div>

				</section>
			</div>
			<!-- /.col-md-10 -->


		</div>
		<!-- /.row -->
	</div>

	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#defaultForm').bootstrapValidator({
				message : 'This value is not valid',
				fields : {
					username : {
						container : '#hint1',
						validators : {
							notEmpty : {
								message : '请输入用户名'
							}
						}
					},
					password : {
						container : '#hint2',
						validators : {
							notEmpty : {
								message : '请输入密码'
							}
						}
					},
					state : {
						container : '#hint3',
						validators : {
							notEmpty : {
								message : '请选择状态'
							}
						}
					},
					gender : {
						container : '#hint4',
						validators : {
							notEmpty : {
								message : '请选择性别'
							}
						}
					},
					permission : {
						container : '#hint5',
						validators : {
							notEmpty : {
								message : '请选择权限'
							}
						}
					},
					description : {
						container : '#hint6',
						validators : {
							notEmpty : {
								message : '请输入备注'
							}
						}
					}
				}
			});
		});
	</script>
</body>
</html>