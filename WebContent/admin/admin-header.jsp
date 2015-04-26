<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand hidden-sm">民航后台管理</a>
		</div>
		<div class="navbar-collapse collapse" role="navigation">
			<ul class="nav navbar-nav navbar-right">
			<s:if
				test="null == #session.get('adname')">
					<li><a href="#">管理员</a></li>
					<li><a href="admin_logout.action">注销</a></li>
			</s:if> 
			<s:else>
					<li><a href="#" class="dropdown-toggle"><s:property
							value="#session.get('adname')" /> </a></li>
					<li><a href="admin_logout.action">注销</a></li>
			</s:else> 
			<s:else>
					<li><a href="admin_login.action">登录</a></li>
			</s:else>
			</ul>
		</div>
	</div>
</div>