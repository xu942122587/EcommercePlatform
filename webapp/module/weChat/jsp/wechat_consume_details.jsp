<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>账单详情</title>
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

	<body class="bg-white">
		<!--支付 信息-->
		<div class="details_list mt6">
			<span class="left">金额</span>
			<span class="right record_details_price">&yen;${consume.money}</span>
		</div>
		<hr />
		<div class='details_list'>
			<span class="left">交易类别</span>
			<span class="right">${consume.typeValue}</span>
		</div>
		<div class='details_list'>
			<p class="left">当前状态</p>
			<span class="right">支付成功</span>
		</div>
		<div class='details_list'>
			<p class="left">交易时间</p>
			<span class="right">
				<fmt:formatDate value="${consume.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span>
		</div>
		<div class='details_list'>
			<p class="left">交易单号</p>
			<span class="right">${consume.id }</span>
		</div>
		<hr />
	</body>

<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
</html>