<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>个人中心</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<style>
			hr {
				width: 100%;
				margin: 0;
				border-top: 1px solid #1b1b1b;
			}
		</style>
	</head>

	<body>
		<!--个人信息-->
		<div class="personal-info">
			<div class="headimg_box">
				<c:if test="${empty customer.employee.headimgurl }">
					<img id="upload-head" class="headimg upload-headimg" src="${path}/module/weChat/img/personal-headimg.png" />
				</c:if>
				<c:if test="${not empty customer.employee.headimgurl }">
					<img id="upload-head" class="headimg upload-headimg" src="${customer.employee.headimgurl }" />
				</c:if>
			</div>
			<span class="personalname">${customer.name}</span>
		</div>
		<!--订单-->
		<div class="bg-white">
			<div class="bg_red0"></div>
			<div class="order">
				<a onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=1'">
					<img src="${path}/module/weChat/img/personal-icon-nopay.png" class="Order_icon">
					<div class="Order_text">
						待付款
					</div>
				</a>
				<a onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=2'">
					<img src="${path}/module/weChat/img/personal-icon-noshipped.png" class="Order_icon">
					<div class="Order_text">
						待发货
					</div>
				</a>
				<a onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=4'">
					<img src="${path}/module/weChat/img/personal-icon-ingshipped.png" class="Order_icon">
					<div class="Order_text">
						待收货
					</div>
				</a>
				<a onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=5'">
					<img src="${path}/module/weChat/img/personal-icon-evaluate.png" class="Order_icon">
					<div class="Order_text">
						待评价
					</div>
				</a>
				<a onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=6'">
					<img src="${path}/module/weChat/img/personal-icon-ChangingRefunding.png" class="Order_icon">
					<div class="Order_text">
						已完成
					</div>
				</a>
			</div>
		</div>
		<a class="personal_title" onclick="window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState='">
			<img src="${path}/module/weChat/img/personal-icon-wholeorder.png" class="personal_title_icon">
			<div class="personal_title_text">
				全部订单
			</div>
			<img src="${path}/module/weChat/img/all-enter.png" class="enter" />
		</a>
		<hr />
		<!--我的钱包-->
		<a class="personal_title bg-white mt6" onclick="window.location='${path}/weChat/goMyWallet?employeeId=${employeeId}'">
			<img src="${path}/module/weChat/img/personal-wallet.png" class="personal_title_icon">
			<div class="personal_title_text">
				我的钱包
			</div>
			<img src="${path}/module/weChat/img/all-enter.png" class="enter" />
		</a>
		<hr />
		<!--电子券-->
		<a class="personal_title bg-white mt6" onclick="window.location='${path}/weChat/goEticket?employeeId=${employeeId}'">
			<img src="${path}/module/weChat/img/personal-icon-electroniccoupons.png" class="personal_title_icon">
			<div class="personal_title_text">
				电子券
			</div>
			<img src="${path}/module/weChat/img/all-enter.png" class="enter" />
		</a>
		<hr />
		<!--地址管理-->
		<a class="personal_title bg-white mt6" onclick="window.location='${path}/weChat/goReviseaddr?employeeId=${employeeId}'">
			<img src="${path}/module/weChat/img/personal-position.png" class="personal_title_icon">
			<div class="personal_title_text">
				地址管理
			</div>
			<img src="${path}/module/weChat/img/all-enter.png" class="enter" />
		</a>
		<hr />
		<!--修改密码-->
		<a class="personal_title bg-white mt6" onclick="window.location='${path}/weChat/goModPassword?employeeId=${employeeId}'">
			<img src="${path}/module/weChat/img/wallet_icon3.png" class="personal_title_icon">
			<div class="personal_title_text">
				修改密码
			</div>
			<img src="${path}/module/weChat/img/all-enter.png" class="enter" />
		</a>
		<hr />

		<button class="btn_exit_personal font-large" onclick="doLogOut()">退出登录</button>
		<div style="height: 100px"></div>

		<!--底部菜单开始-->
		<nav class="nav-bar nav-bar-tab">
			<a onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-index.png" class="nav-icon">
				<div class="nav_font">首页</div>
			</a>
			<!--<a href="weChat_found.html">
				<img src="img/nav-icon-classify.png" class="nav-icon">
				<div class="nav_font">分类</div>
			</a>-->
			<a onclick="window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-shoppingCart.png" class="nav-icon">
				<div class="nav_font">购物袋</div>
			</a>
			<a onclick="window.location='${path}/weChat/goPersonalCenter?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-personalactive.png" class="nav-icon">
				<div class="nav_font active">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->
		
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
		function doLogOut() {
			if (isSuccess) {
				showLodding();
				$.ajax({
					url : "${path}/weChat/doLogOut?employeeId=${employeeId}",
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