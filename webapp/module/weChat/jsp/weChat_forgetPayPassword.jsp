<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<title>忘记支付密码</title>
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
		<p class="login_title">忘记支付密码</p>
		<form id="theForm">
			<input class="login_input" name="phone" type="number" maxlength="11" id="phone_input" placeholder="请输入手机号码"></input>
			<button type="button" class="code_btn right" id="code_btn" >点击获取验证码</button>
			<input class="login_input" type="number" name="smsCode" id="smsCode" maxlength="6" placeholder="请输入验证码"></input>
			<input class="login_input" type="password" name="newPassword" id="newPassword_input" placeholder="请输入新支付密码"></input>
		</form>
		
		<!--保存按钮 -->
		<button type="button" class="login_btn" onclick="doForgetPayPassword()">保存</button>
			
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
		document.getElementById("code_btn").addEventListener('click',function() {
			var phone = $("#phone_input").val().trim();
			var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
			if('' != phone){
				if(!phoneReg.test(phone)){
					displayTip("请正确格式输入手机号");
				}else{
					$.ajax({
						url : "${path}/weChat/getSMSCode?flage=F&phone="+phone,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								displayTip(data.msg);
								var code_btn = document.getElementById("code_btn");
								code_btn.innerHTML = "59秒重新获取";
								code_btn.disabled = "disabled";
								var i = 59;
								clearInterval(t);
								var t = setInterval(
									function() {
										if(i > 1) {
											code_btn.innerHTML = --i + "秒重新获取";
											code_btn.disabled = "disabled";
											$("#phone_input").attr("readonly","readonly");
										} else if(i == 1) {
											code_btn.innerHTML = "重新获取";
											clearInterval(t);
											code_btn.disabled = "";
											$("#phone_input").removeAttr("readonly");
										}
									}, 1000)
							} else {
								displayTip(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							displayTip("请检查网络设置");
						}
					});
				}
			}else{
				displayTip("手机号不能为空");
			}
		});

		var isSuccess = true;
		function doForgetPayPassword() {
			var phone = $("#phone_input").val().trim();
			var newPassword = $("#newPassword_input").val().trim();
			var smsCode = $("#smsCode").val().trim();
			var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
			var passwordReg =/^[0-9]{6}$/;
			var formData = $("#theForm").serialize();
			if("" == phone){
				displayTip("手机号不能为空");
			}else if(!phoneReg.test(phone)){
				displayTip("请正确格式输入手机号");
			}else if("" == smsCode){
				displayTip("验证码不能为空");
			}else if("" == newPassword){
				displayTip("新支付密码不能为空");
			}else if(!passwordReg.test(newPassword)){
				displayTip("请输入正确的支付密码 : <br>6位数字");
			}else {
				if (isSuccess) {
					showLodding();
					$.ajax({
						url : "${path}/weChat/doForgetPayPassword",
						data : formData,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								hiddenLodding();
								isSuccess = false;//防止重复提交
								displayTip(data.msg+"前往登录!");
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
