<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<aside class="col-md-2 col-md-pull-10 col-sm-3 col-sm-pull-9">

	<div id="sidebar">

		<div class="panel-group" id="app-menu">

			<div class="panel panel-default panel-no-padding">
				<div class="panel-heading">
					<h4 class="panel-title">用户管理</h4>
				</div>
				<!-- /.panel-heading -->
				<div id="menu-app" class="panel-collapse collapse in">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked" id="pages-app">
							<li class="active"><a
								href="admin_userlist.action"><b class="icon-cover"></b><i
									class="imoon imoon-dashboard fa-fw"></i> 个人用户管理</a></li>
						</ul>
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel-collapse -->
			</div>
			<!-- /.panel -->

		 
			 
			 

	</div>
	<!-- /#sidebar -->

</aside>
<script type="text/javascript">
	document.onreadystatechange = function() {
		
		/* 首先加载 */
		window.setInterval(getNewMsg());
		/* 循环加载 */
		window.setInterval(getNewMsg, 5000);
		function getNewMsg() {
			$.post("admin-leftpanel.action", {}, function(data) {
				var a = document.getElementById("approve-count");
				if (data == 0) {
					a.style.display = "none";
				} else {
					a.innerHTML = data;
					a.style.display = "block";
				}

				console.log(data);
			}, "json");
		}
	};//当页面加载状态改变的时候执行这个方法. 
	/* function subSomething() 
	 { 
	 if(document.readyState == “complete”) //当页面加载状态 
	 myform.submit(); //表单提交 
	 }  */

	
</script>