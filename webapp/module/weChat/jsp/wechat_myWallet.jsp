<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>我的钱包</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<!--微信不缓存东西  start-->
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<!--微信不缓存东西  end-->
<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
<script src="${path}/module/weChat/js/jquery-3.1.1.min.js"
	type="text/javascript" charset="utf-8"></script>
</head>
<body style="background-color: #fff5e9;">
	<!--余额-->
	<div class="wallet_sum" style="padding: 20px 0; text-align: center;">
		<img src="${path}/module/weChat/img/wallet.png"
			style="width: 100px; margin-top: 30px;" />
		<p class="font-large" style="margin-top: 8px;">我的余额（元）</p>
		<div class="wallet_price">
			<!--<span style="font-size: 18px;">&yen;</span>-->
			<span>
				<c:if test="${empty customer.money}">
					0
				</c:if>
				<c:if test="${not empty customer.money}">
					${customer.money}
				</c:if>
			</span>
		</div>
		<!--<button class="btn_wallet_recharge">充值</button>-->
	</div>
	<a class="personal_title" onclick="window.location='${path}/weChat/goWalletRecharge?employeeId=${employeeId}'"> <img
		src="${path}/module/weChat/img/wallet_icon1.png"
		class="personal_title_icon">
		<div class="personal_title_text">充值</div> <img src="${path }/module/weChat/img/all-enter.png"
		class="enter" />
	</a>
	<hr />
	<a class="personal_title mt6" onclick="window.location='${path}/weChat/goConsume?employeeId=${employeeId}'">
		<img src="${path}/module/weChat/img/wallet_icon2.png"
		class="personal_title_icon">
		<div class="personal_title_text">交易记录</div> <img
		src="${path}/module/weChat/img/all-enter.png" class="enter" />
	</a>
	<hr />
	<a class="personal_title mt6" onclick="window.location='${path}/weChat/goPayPassword?employeeId=${employeeId}'">
		<img src="${path}/module/weChat/img/wallet_icon4.png"
		class="personal_title_icon">
		<div class="personal_title_text">设置密码</div> <img
		src="${path}/module/weChat/img/all-enter.png" class="enter" />
	</a>
	<hr />
	<a class="personal_title mt6" onclick="window.location='${path}/weChat/goForgetPayPassword?employeeId=${employeeId}'">
		<img src="${path}/module/weChat/img/wallet_icon3.png"
		class="personal_title_icon">
		<div class="personal_title_text">忘记密码</div> <img
		src="${path}/module/weChat/img/all-enter.png" class="enter" />
	</a>
	<hr />

	<!-- 提示弹窗 -->
	<div id="successTip" class="toast">msg</div>

	<!-- loading -->
	<div id="loadingDiv" class="loaded" style="display: none">
		<div class="loading">
			<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
			<p class="loading-text">加载中</p>
		</div>
	</div>

	<script>

		function displayTip(message) {
			$("#successTip").html(message);
			$("#successTip").fadeToggle(500, function() {
				setTimeout(function() {
					$("#successTip").fadeToggle(1000);
				}, 2000);
			});
		}

		function hiddenLodding() {
			$("#loadingDiv").hide();
		}

		function showLodding() {
			$("#loadingDiv").show();
		}
	</script>
	<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
</body>
</html>
