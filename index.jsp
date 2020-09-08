<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../js/tagLib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><s:message code="login.title"/></title>
<%@ include file="../js/ericsson.jsp"%>
<%@ include file="../js/jui.jsp"%>
<%@ include file="../js/zDialog.jsp"%>
<script type="text/javascript">
	$(function() {
		DWZ.init("<%=request.getContextPath()%>/style/jui/xml/dwz.frag_<s:message code='i18n'/>.xml", {
			debug : false, // 调试模式 【true|false】
			callback : function() {
				initEnv();
				$("#themeList").theme({
					themeBase : "themes"
				});
			}
		});
	});
	
	function logout(){
		top.Dialog.confirmDel("<s:message code='list.btn.logout.confirm'/>",function(){doLogout();});
	}
	
	function doLogout(){
		$.ajax({
			type : "post",
			url : "<c:url value='/login/logout'/>",
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			async : false,
			cache : false,
			success : function(data, textStatus) {
				if (textStatus == "success") {
					aData = data;
				}
			}
		});
		fnResult(aData,function(){window.location.href="<%=request.getContextPath()%>/login/login";});
	}
	
	function changePassword(){
		var loginId = '${sessionScope.USER_ID.loginId}'
		top.Dialog.openForCallBack({URL:"<c:url value='/login/edit/pwd/"+loginId+"'/>",Title:"<s:message code='user.edit.pwd.title'/>",Width:600,Height:180},function(p){if(p){top.Dialog.alert(p);};});
	}
	
	function showVersion(){
		top.Dialog.openForCallBack({URL:"<c:url value='/index/version'/>",Title:"<s:message code='showVersion.title'/>",Width:300,Height:90},function(p){if(p){top.Dialog.alert(p);};query();});
	}
</script>
</head>

<body scroll="no">
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<img src="<c:url value='/style/ericsson/imgs/logo.png' />" onclick="showVersion()" style="cursor: pointer;" />
			
				<ul class="nav">
					<%@ include file="../js/local.jsp"%>
					<li><a href="javascript:changePassword();"><s:message code="index.change.password"/></a></li>
					<li><a href="javascript:logout();"><s:message code="index.logout"/></a></li>
				</ul>
				<ul class="themeList" id="themeList">
					         <li style="font: 20;"><s:message code="index.current.user"/>:&nbsp;<span style="color: red">${sessionScope.USER_ID.name}</span>&nbsp;<s:message code="index.host.name"/>:&nbsp;<span style="color: red">${requestScope.hostName}</span>&nbsp;<s:message code="index.login.time"/>:&nbsp;<span style="color: red">${sessionScope.USER_ID.loginTime}</span></li>
				</ul>
			</div>
		</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse">
						<div></div>
					</div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse">
					<h2>SoftBank</h2>
					<div>Hiden</div>
				</div>
				<div class="accordion" fillSpace="sidebar">
					<c:forEach var="bean" items="${requestScope.beanList}" varStatus="status">
						<div class="accordionHeader">
							<h2>
								<span>Folder</span>${bean.name }
							</h2>
						</div>
						<div class="accordionContent">
							<ul class="tree treeFolder">
								<c:forEach var="childBean" items="${bean.childList}" varStatus="status">
									<li>
										<c:if test="${childBean.url=='' }">
											<a href="#" rel="${childBean.id }">${childBean.name }</a>
										</c:if>
										<c:if test="${childBean.url!='' }">
											<a href="<c:url value='${childBean.url }'/>" target="navTab" rel="${childBean.id }" external="true">${childBean.name }</a>
										</c:if>
										<c:forEach var="childBean2" items="${childBean.childList}" varStatus="status">
											<ul>
												<li>
													<c:if test="${childBean2.url=='' }">
														<a href="#" rel="${childBean2.id }">${childBean2.name }</a>
													</c:if>
													<c:if test="${childBean2.url!='' }">
														<a href="<c:url value='${childBean2.url }'/>" target="navTab" rel="${childBean2.id }" external="true">${childBean2.name }</a>
													</c:if>
													<c:forEach var="childBean3" items="${childBean2.childList}" varStatus="status">
														<ul>
															<li>
																<a href="<c:url value='${childBean3.url }'/>" target="navTab" rel="${childBean3.id }" external="true">${childBean3.name }</a>
															</li>
														</ul>
													</c:forEach>
												</li>
											</ul>
										</c:forEach>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent">
						<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
						</ul>
					</div>
					<div class="tabsLeft">left</div>
					<!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
					<div class="tabsRight">right</div>
					<!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
					<div class="tabsMore">more</div>
				</div>
				<ul class="tabsMoreList">
				</ul>
				<div class="navTab-panel tabsPageContent layoutBox">

				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		Copyright&nbsp;©2017 Ericsson
	</div>
</body>
</html>