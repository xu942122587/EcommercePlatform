<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title>支付失败</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
	</head>

	<body class="bg-white">
		<!--支付失败-->
		<div class="pay_fail_box" >
			<img src="${path}/module/weChat/img/pay_fail.png" class="pay_imgs">
			<div class="pay_fail_largefont">支付失败</div>
			<p >看看出现什么问题...</p>
			<p>点击下方继续付款呦~</p>
		</div>
		<c:if test="${'order' eq flag }">
			<button class="btn_pay_left" onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=1'">重新支付</button>
		</c:if>
		<c:if test="${'wallet' eq flag }">
			<button class="btn_pay_left" style="background: #5fbde7;" onclick="window.location='${path}/weChat/goMyWallet?employeeId=${employeeId}'">重新支付</button>
		</c:if>
		<button class="btn_pay_right" onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">返回首页</button>
	<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>