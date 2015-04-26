<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ page language="java" contentType="text/html; charset=GBK" --%>
<%--   	pageEncoding="GBK"%>  --%>
<div id="head1">
	<div id="head11">
		<table width="100%" align="center">
			<tr>
				<td><a href="tongji_show.action"><img
						src="${ctx}/image/1-1.jpg" width="100" height="40" /></a></td>
				<td><a href="pinfa_show.action"><img
						src="${ctx}/image/1-2.jpg" width="100" height="40" /></a></td>
				<td><a href="oufa_showOufaMain.action"><img
						src="${ctx}/image/1-3.jpg" width="100" height="40" /></a></td>
				<td><a href="yujing_showYujingMain.action"><img
						src="${ctx}/image/1-4.jpg" width="100" height="40" /></a></td>
			    <td>
			    <div style="margin:5px 5px 20px 30px;font:bold 14px 宋体;"> 
				<s:if test="null == #session.get('username')">
					  用户 
					|<a href="logout.action">注销</a> 
				</s:if>
				<s:else>
					  <s:property
								value="#session.get('username')" /> |
					 <a href="logout.action">注销</a> 
				</s:else>
				<s:else>
					 <a href="login.action">登录</a> 
				</s:else>
			 </div></td>
			</tr>
		</table>
	</div>
</div>

<div id="head2"></div>
