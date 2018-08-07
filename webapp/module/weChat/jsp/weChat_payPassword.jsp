<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<title>支付密码</title>
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
	<body class="bg_login">
		<p class="login_title">支付密码</p>
		<c:if test="${empty customer.payPassword}">
			<form id="theForm">
				<input class="login_input" type="password" id="oldPassword_input" name="oldPassword" placeholder="请输入密码"></input>
				<input class="login_input" type="password" id="newPassword_input" name="newPassword" placeholder="请确认密码"></input>
			</form>
			
			<!--保存按钮 -->
			<button type="button" class="login_btn" onclick="doPayPassword('new')">保存</button>
		</c:if>
		<c:if test="${not empty customer.payPassword}">
			<form id="theForm">
				<input class="login_input" type="password" id="oldPassword_input" name="oldPassword" placeholder="请输入旧密码"></input>
				<input class="login_input" type="password" id="newPassword_input" name="newPassword" placeholder="请输入新密码"></input>
			</form>
			
			<!--保存按钮 -->
			<button type="button" class="login_btn" onclick="doPayPassword('update')">保存</button>
		</c:if>
		
		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		<!--js 获取验证码 -->
		<script type="text/javascript" charset="utf-8">
		var isSuccess = true;
		function doPayPassword(flage) {
			var oldPassword = $("#oldPassword_input").val().trim();
			var newPassword = $("#newPassword_input").val().trim();
			var passwordReg =/^[0-9]{6,6}$/;
			var formData = $("#theForm").serialize();
			if("new" == flage){
				if(!passwordReg.test(oldPassword)){
					displayTip("请正确格式输入密码 : <br>6位数字");
				}else if(!passwordReg.test(newPassword)){
					displayTip("请正确格式输入密码 : <br>6位数字");
				}else if(!oldPassword == newPassword){
					displayTip("两次密码必须一致");
				}else{
					if (isSuccess) {
						showLodding();
						$.ajax({
							url : "${path}/weChat/doPayPassword?customerId=${customer.id}&flage="+flage,
							data : formData,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = false;//防止重复提交
									displayTip(data.msg+"前往钱包!");
									setTimeout(function() {
										window.location='${path}/weChat/goMyWallet?employeeId=${employeeId}';
									}, 1500);
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								isSuccess = true;
								displayTip("请检查网络设置");
							}
						});
					}
				}
			}else if("update" == flage){
				if(!passwordReg.test(oldPassword)){
					displayTip("请正确格式输入密码 : <br>6位数字");
				}else if(!passwordReg.test(newPassword)){
					displayTip("请正确格式输入密码 : <br>6位数字");
				}else{
					if (isSuccess) {
						showLodding();
						$.ajax({
							url : "${path}/weChat/doPayPassword?customerId=${customer.id}&flage="+flage,
							data : formData,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = false;//防止重复提交
									displayTip(data.msg+"前往钱包!");
									setTimeout(function() {
										window.location='${path}/weChat/goMyWallet?employeeId=${employeeId}';
									}, 1500);
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								isSuccess = true;
								displayTip("请检查网络设置");
							}
						});
					}
				}
			}
			return false;//防止页面刷新
		};
		
		function displayTip(message){
			$("#successTip").html(message);
			$("#successTip").fadeToggle(500, function() {
				setTimeout(function() {
					$("#successTip").fadeToggle(1000);
				}, 1200);
			});
		}
		
		function hiddenLodding(){
			$("#loadingDiv").hide();
		}
		
		function showLodding(){
			$("#loadingDiv").show();
		}
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>
</html>
