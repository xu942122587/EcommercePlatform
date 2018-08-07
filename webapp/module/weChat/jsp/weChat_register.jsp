<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title>用户注册</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<link href="${path}/module/weChat/css/mobiscroll.frame.css" rel="stylesheet" type="text/css" />
		<link href="${path}/module/weChat/css/mobiscroll.frame.android-holo.css" rel="stylesheet" type="text/css" />
		<link href="${path}/module/weChat/css/mobiscroll.scroller.css" rel="stylesheet" type="text/css" />
		<link href="${path}/module/weChat/css/mobiscroll.android-holo-light.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${path}/module/weChat/js/zepto.min.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.zepto.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.core.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.frame.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.scroller.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.util.datetime.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.datetimebase.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.datetime.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.android-holo-light.js"></script>
		<script src="${path}/module/weChat/js/mobiscroll.i18n.zh.js"></script>
	</head>

	<body class="bg_login">
		<p class="login_title">用户注册</p>
		<form id="theForm" method="POST">
			<input name="model.name" type="hidden" id="name_input" value="${employee.name}"></input>
			<input class="login_input" name="model.phone" type="number" maxlength="11" id="phone_input" placeholder="请输入手机号码"></input>
			<button type="button" class="code_btn right" id="code_btn" >点击获取验证码</button>
			<input class="login_input" type="number" name="smsCode" id="smsCode" maxlength="6" placeholder="请输入验证码"></input>
			<input class="login_input" type="password" name="model.loginPassword" id="loginPassword_input" placeholder="请输入密码"></input>
			<!--<input class="login_input" type="date" style="height: 44px;"/>-->
			<input class="login_input" type="text" id="birthday_input" name="model.birthday" placeholder="出生日期(生日当月有礼品赠送)" />
			
			<div style="position: relative;">
				<input class="login_input Guide_number" type="text" placeholder="请输入导购工号(可不填)"></input>
				<img class="guide_more" src="${path}/module/weChat/img/classify_more.png" style="top: 26px;"/>
			</div>
			<input type="hidden" id="model_guideUser_id" name="model.guideUser.id"></input>
			<c:if test="${not empty guideUserList }">
				<ul class="Guides">
					<c:forEach items="${guideUserList}" var="guideUser">
						<li style="display: block;" class="Guide_name" regCode="${guideUser.username}" id="${guideUser.id}">${guideUser.username}--${guideUser.name}</li>
					</c:forEach>
				</ul>
			</c:if>
		</form>

		<!--注册按钮 -->
		<button type="button" class="login_btn" onclick="doRegister()">注册新用户</button>


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
			document.getElementById("code_btn").addEventListener('click',
				function() {
				var phone = $("#phone_input").val().trim();
				var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
				if('' != phone){
					if(!phoneReg.test(phone)){
						displayTip("请正确格式输入手机号");
					}else{
						getSMSCode(phone);
					}
				}else{
					displayTip("手机号不能为空");
				}
			});
		</script>
		<!--导购-->
		<script type="text/javascript"  charset="utf-8">
			<c:if test="${not empty guideUserList }">
				$(".Guide_number").focus(function() {
					$(".Guides").show();
					$(".guide_more").show();
				});
				$(".Guide_name").click(function() {
					$(".Guide_number").val($(this).html());
					$("#model_guideUser_id").val($(this).attr("id"));
					$(".Guides").hide();
					$(".guide_more").hide();
				});
				$(".Guide_number").keyup(function() {
					var guide_value = $(".Guide_number").val().trim();
					$(".Guides li[regCode*=" + guide_value + "]").show();
					$(".Guides li:not(li[regCode*=" + guide_value + "])").hide();
					$(".Guides").show();
					if(0 >= $(".Guides li:visible").length){
						$(".Guides").hide();
					}else{
						$(".Guides").show();
					}
				});
				$(".guide_more").click(function() {
					$(".Guides").hide();
					$(".guide_more").hide();
				});
			</c:if>
			
		$(function() {
			$('#birthday_input').mobiscroll().date({
				theme: "android-holo-light",
				mode: "scroller",
				display: "bottom",
				lang: "zh",
				dateFormat: 'yy-mm-dd',
			});
		});
			
			function getSMSCode(phone){
				$.ajax({
					url : "${path}/weChat/getSMSCode?flage=R&phone="+phone,
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
										$("#phone_input").disabled="disabled";
									} else if(i == 1) {
										code_btn.innerHTML = "重新获取";
										clearInterval(t);
										code_btn.disabled = "";
										$("#phone_input").disabled="";
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
			
			var isSuccess = true;
			function doRegister() {
				var phone = $("#phone_input").val().trim();
				var loginPassword = $("#loginPassword_input").val().trim();
				var smsCode = $("#smsCode").val().trim();
				var birthday = $("#birthday_input").val().trim();
				var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
				var passwordReg =/^-?[a-zA-Z0-9_\.]{6,12}$/;
				if("" == phone){
					displayTip("手机号不能为空");
				}else if(!phoneReg.test(phone)){
					displayTip("请正确格式输入手机号");
				}else if("" == smsCode){
					displayTip("验证码不能为空");
				}else if("" == loginPassword){
					displayTip("密码不能为空");
				}else if(!passwordReg.test(loginPassword)){
					displayTip("请正确格式输入密码 : <br>6~12位字母和数字以及_.");
				}else if("" == birthday){
					displayTip("生日不能为空");
				}else{
					if (isSuccess) {
						var formData = $("#theForm").serialize();
						showLodding();
						$.ajax({
							url : "${path}/weChat/doRegister?employeeId=${employee.id}",
							data : formData,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = false;//防止重复提交
									window.location='${path}/weChat/weChatIndex?employeeId=${employee.id}'
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
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>