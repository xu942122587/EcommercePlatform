<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>用户登录</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
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
	<p class="login_title">用户登录</p>
	<form>
		<input class="login_input" type="number" id="model_phone" name="model.phone" maxlength="11" placeholder="请输入手机号码"></input> 
		<input class="login_input" type="password" id="model_loginPassword" name="model.loginPassword" placeholder="请输入密码"></input>
	</form>
	<a onclick="window.location='${path}/weChat/goForgetPassword?employeeId=${employeeId}'" class="forget-a right">忘记密码?</a>
	<!--登录按钮 -->
	<button class="login_btn" type="button" style="margin-bottom: 0;" onclick="doLogin()">登录</button>
	<a
		onclick="window.location='${path}/weChat/goRegister?employeeId=${employeeId}'"
		class="register-a pl12">我还没有帐号，立即注册</a>
		
<!-- 提示弹窗 -->
	<div id="successTip" class="toast">msg</div>
	
	<!-- loading -->
	<div id="loadingDiv" class="loaded" style="display:none">
		<div class="loading">
			<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
			<p class="loading-text">加载中</p>
		</div>
	</div>
	<script>
	var isSuccess = true;
	function doLogin() {
		var phone = $("#model_phone").val().trim();
		var loginPassword = $("#model_loginPassword").val().trim();
		var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
		var passwordReg =/^-?[a-zA-Z0-9_\.]{6,12}$/;
		if("" != phone && "" != loginPassword ){
			if(!phoneReg.test(phone)){
				displayTip("请正确格式输入手机号");
			}else if(!passwordReg.test(loginPassword)){
				displayTip("请正确格式输入密码 : <br>6~12位字母和数字以及_.");
			}else{
				if (isSuccess) {
					showLodding();
					$.ajax({
						url : "${path}/weChat/doLogin?model.phone="+phone+"&model.loginPassword="+loginPassword+"&model.employee.id=${employeeId}",
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								hiddenLodding();
								isSuccess = false;//防止重复提交
								window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'
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
		}else{
			displayTip("手机号或密码不能为空");
		}
		return false;//防止页面刷新
	};
	
	function displayTip(message){
		$("#successTip").html(message);
		$("#successTip").fadeToggle(500, function() {
			setTimeout(function() {
				$("#successTip").fadeToggle(1000);
			}, 2000);
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
