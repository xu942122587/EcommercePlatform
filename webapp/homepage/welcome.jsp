<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="utf-8" />
		<title>登录</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<meta name="renderer" content="webkit" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<link rel="shortcut icon" type="image/x-icon" href="${path}/platform/theme/login/default/images/favicon.ico">
		<link rel="stylesheet" href="${path }/platform/theme/distributionSystem/css/houtai_denglu.css" type="text/css">
		<script src="${path}/platform/common/js/prototype-ext.js"></script>
		<!-- jQuery -->
		<script src="${path}/platform/common/js/jquery-1.11.1.js"></script>
		<script src="${path}/platform/common/js/jquery-ext.js"></script>
		<script>
		$('.all_html').height($('.content').height());
		</script>
		<script type="text/javascript">
			Namespace.register('com.yunt.welcome');
			com.yunt.welcome = {
				login: function(loginName, password){
					if(loginName==""||password==""){
						$(".fail_title").html("用户名或者密码不能为空");
						return;
					}
					$.getJSON("${path}/bd/welcome/ajaxValidationUser", {"loginName":loginName, "password":password}, function(info){
						if(info.successStatus=="false"){
							$(".fail_title").html("用户名或者密码错误");
							return;
						}
						$(".fail_title").html("");
						$('#${pageId}welcomeForm').submit();
					});
				},
				submit: function(){
					var space = this;
					var loginName=$("#${pageId}loginName").val().trim();
					var password=$("#${pageId}password").val();
					var img = $('#${pageId}imgjudge').val();
					if(loginName==""||password==""){
						$(".fail_title").html("用户名或者密码不能为空");
						return;
					}
					space.login(loginName, password);
				},
				autoEnterSubmit: function(e){
					var keynum;
					if(window.event) {
						keynum = e.keyCode;
					}else if(e.which) {
						keynum = e.which;
					}
					if (keynum && keynum == 13){
						this.submit();
					}
				},
			};
		</script>
	</head>

	<body onkeydown="com.yunt.welcome.autoEnterSubmit(event);">
		<div class="all_html">
			<div class="zongti">
				<img class="denglu_leftpic" src="${path }/platform/theme/distributionSystem/images/Socialmedia.png" />
				<div class="denglu_right_input">
					<span class="denglu_title">后台管理系统</span>
					<uc:form id="${pageId}welcomeForm" method="post" action="${path}/bd/welcome/login">
						<input type="hidden" id="${pageId}spring-security-redirect" name="spring-security-redirect"/>
						<div class="allinput">
							<div class="input_type">登录</div>
							<div class="denglu_username">
								<input type="text" id="${pageId}loginName" placeholder="用户名" tabindex="1" name="j_username" value="" />
							</div>
							<div class="denglu_pwd">
								<input type="password" id="${pageId}password" placeholder="密码" tabindex="2" name="j_password" value=""/>
							</div>
							<p class="fail_title"></p>
							<div class="denglu_submit">
								<input type="button" value="登录" onclick="com.yunt.welcome.submit();"/>
							</div>
							<!-- <div class="miss_pwd">忘记密码</div> -->
						</div>
					</uc:form>
				</div>
				<div class="denglu_banquan">包头市天和商城有限公司</div>
			</div>
		</div>
	</body>
</html>
