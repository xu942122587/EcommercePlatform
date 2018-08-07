<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title><c:if test="${'order' eq flag }">支付成功</c:if><c:if test="${'wallet' eq flag }">充值成功</c:if></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
	</head>

	<body class="bg-white">
		<!--支付成功-->
		<div class="pay_fail_box" style="background: #5fbde7;">
			<img src="${path}/module/weChat/img/pay_success.png" class="pay_imgs">
			<div class="pay_fail_largefont"><c:if test="${'order' eq flag }">支付成功</c:if><c:if test="${'wallet' eq flag }">充值成功</c:if></div>
			<c:if test="${'order' eq flag }">
				<p >买家已付款...</p>
				<p>您的包裹蓄势待发呦~</p>
			</c:if>
		</div>
		<c:if test="${'order' eq flag }">
			<button class="btn_pay_left" style="background: #5fbde7;" onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=2'">前往订单</button>
		</c:if>
		<c:if test="${'wallet' eq flag }">
			<button class="btn_pay_left" style="background: #5fbde7;" onclick="window.location='${path}/weChat/goMyWallet?employeeId=${employeeId}'">前往钱包</button>
		</c:if>
		<button class="btn_pay_right" style="background: #ee196b;" onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">返回首页</button>
	<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>