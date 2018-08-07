<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<title>修改密码</title>
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
		<p class="login_title">修改密码</p>
		<form id="theForm">
			<input class="login_input" type="password" id="oldPassword_input" name="oldPassword" placeholder="请输入旧密码"></input>
			<input class="login_input" type="password" id="newPassword_input" name="newPassword" placeholder="请输入新密码"></input>
		</form>
		
		<!--保存按钮 -->
		<button type="button" class="login_btn" onclick="doModPassword()">保存</button>
		
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
		function doModPassword() {
			var oldPassword = $("#oldPassword_input").val().trim();
			var newPassword = $("#newPassword_input").val().trim();
			var passwordReg =/^-?[a-zA-Z0-9_\.]{6,12}$/;
			var formData = $("#theForm").serialize();
			if(!passwordReg.test(oldPassword)){
				displayTip("请正确格式输入密码 : <br>6~12位字母和数字以及_.");
			}else if(!passwordReg.test(newPassword)){
				displayTip("请正确格式输入密码 : <br>6~12位字母和数字以及_.");
			}else{
				if (isSuccess) {
					showLodding();
					$.ajax({
						url : "${path}/weChat/doModPassword?customerId=${customer.id}",
						data : formData,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								hiddenLodding();
								isSuccess = false;//防止重复提交
								displayTip(data.msg+"前往登录!");
								setTimeout(function() {
									window.location='${path}/weChat/goLogin?employeeId=${employee.id}';
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
