<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>交易记录</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>
		<ul class=" bg-white">
			<c:forEach items="${consumeList}" var="consume">
				<li class="record_list" onclick="window.location='${path}/weChat/goConsumeDetails?consumeId=${consume.id}'">
					<div class="right">
						<c:if test="${'1' eq consume.type}">
							+
						</c:if>
						<c:if test="${'2' eq consume.type}">
							+
						</c:if>
						<c:if test="${'3' eq consume.type}">
							+
						</c:if>
						<c:if test="${'4' eq consume.type}">
							+
						</c:if>
						<c:if test="${'5' eq consume.type}">
							-
						</c:if>
						<c:if test="${'6' eq consume.type}">
							-
						</c:if>
						<c:if test="${'7' eq consume.type}">
							+
						</c:if>
						<fmt:formatNumber value="${consume.money}" pattern="#,###.##"/>
					</div>
					<div class="left">
						<span class="record_list_type">
							${consume.typeValue}
						</span>
						<p class="time">
							<fmt:formatDate value="${consume.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</p>
					</div>
				</li>
				<hr />
			</c:forEach>
		</ul>
		<c:if test="${empty consumeList}">
			<!--列表为空-->
			<div class="list-none" style="display: block;">
				<img src="${path}/module/weChat/img/list_none.png" class="imgs">
				<div class="fonts">您还没有交易记录哦 o≧▽≦o</div>
			</div>
		</c:if>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>