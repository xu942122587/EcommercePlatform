<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title>新建地址</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="UTF-8"></script>
	</head>

	<body class="bg_login">
		<c:if test="${empty address}">
			<p class="login_title">新建地址</p>
			<form id="theForm">
				<input type="hidden" select="">
				<input class="login_input" type="text" id="receiver_input" name="model.receiver" placeholder="请输入收货人姓名"></input>
				<input class="login_input" type="number" id="phone_input" name="model.phone" maxlength="11" placeholder="请输入手机号码"></input>
				<input id='city_input' class="login_input city_btn" type="text" maxlength="30" value="内蒙古包头市" readonly="readonly"></input>
				<div class="login_input region" id='district_div'>请选择区</div>
				<textarea class="login_input" id='content_area' placeholder="请输入详细地址，如街道、楼排号等"></textarea>
				<div class="new_address" style="margin-top: -16px;">
					<img src="${path}/module/weChat/img/address_default_nochoose.png" class="new_address_nochoose" />
					<img src="${path}/module/weChat/img/address_default.png" class="new_address_choose" />
					<span class="new_address_text">设为默认地址</span>
				</div>
			</form>
		</c:if>
		<c:if test="${not empty address}">
			<p class="login_title">修改地址</p>
			<form id="theForm">
				<input type="hidden" name="model.id" value="${address.id}" select="">
				<input class="login_input" type="text" id="receiver_input" name="model.receiver" placeholder="请输入收货人姓名" value="${address.receiver}"></input>
				<input class="login_input" type="number" id="phone_input" name="model.phone" maxlength="11" placeholder="请输入手机号码" value="${address.phone}"></input>
				<input id='city_input' class="login_input city_btn" type="text" maxlength="30" value="内蒙古包头市" readonly="readonly"></input>
				<div class="login_input region" id='district_div'>${fn:split(address.content, '-')[1]}</div>
				<textarea class="login_input" id='content_area' placeholder="请输入详细地址，如街道、楼排号等">${fn:split(address.content, '-')[2]}</textarea>
				<div class="new_address" style="margin-top: -16px;">
					<c:if test="${'1' eq address.isDefault}">
						<img src="${path}/module/weChat/img/address_default_nochoose.png" class="new_address_nochoose" style="display: none"/>
						<img src="${path}/module/weChat/img/address_default.png" class="new_address_choose" style="display: inline;"/>
					</c:if>
					<c:if test="${'2' eq address.isDefault}">
						<img src="${path}/module/weChat/img/address_default_nochoose.png" class="new_address_nochoose" style="display:inline;"/>
						<img src="${path}/module/weChat/img/address_default.png" class="new_address_choose" style="display: none" />
					</c:if>
					<span class="new_address_text">设为默认地址</span>
				</div>
			</form>
		</c:if>

		<!--保存按钮 -->
		<button type="button" class="login_btn" onclick="doNewAddress()">保存</button>
		<!--选择区弹框-->
		<div class="box_region">
			<div class="box_null"></div>
			<ul class="region_lists">
				<li class="region_list">达尔罕茂明</li>
				<li class="region_list">东河区</li>
				<li class="region_list">白云鄂博矿</li>
				<li class="region_list">青山区</li>
				<li class="region_list">土默特右旗</li>
				<li class="region_list">固阳县</li>
				<li class="region_list">九原区</li>
				<li class="region_list">昆都仑区</li>
				<li class="region_list">石拐区</li>
			</ul>
		</div>

		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		
		<script type="text/javascript">
			//选择区
			$(".region").click(function() {
				$(".box_region").fadeIn(400);
			});
			$(".box_null").click(function() {
				$(".box_region").fadeOut();
			});
			$(".region_list").click(function() {
				$(".region").html($(this).html());
				$(".box_region").hide();
			});
			<c:if test="${not empty address}">
				<c:if test="${'1' eq address.isDefault}">
					var isSelect = true;
				</c:if>
				<c:if test="${'2' eq address.isDefault}">
					var isSelect = false;
				</c:if>
			</c:if>
			<c:if test="${empty address}">
				var isSelect = false;
			</c:if>
			// 默认地址点击选中
			$(".new_address_nochoose").click(function() {
				$(".new_address_choose").hide();
				$(".new_address_nochoose").show();
				$(this).hide();
				$(this).next(".new_address_choose").show();
				isSelect = true;
			});
			//默认地址点击取消
			$(".new_address_choose").click(function() {
				$(this).hide();
				$(this).prev(".new_address_nochoose").show();
				isSelect = false;
			});
			
			var isSuccess = true;
			function doNewAddress() {
				var receiver = $("#receiver_input").val().trim();
				var phone = $("#phone_input").val().trim();
				var city = $("#city_input").val().trim();
				var district = $("#district_div").html().trim();
				var contentArea = $("#content_area").val().trim();
				if("请选择区" == district){
					displayTip("收货地区不能为空");
					return false;
				}
				var content = city+"-"+district+"-"+contentArea
				var phoneReg =/^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
				var receiverReg =/^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$/;
				var formData = $("#theForm").serialize();
				if(!receiverReg.test(receiver)){
					displayTip("请正确格式输入收货人(2字及以上) : <br>汉字及英文字母");
				}else if(!phoneReg.test(phone)){
					displayTip("请正确格式输入手机号");
				}else if("" == receiver){
					displayTip("收货人不能为空");
				}else if("" == phone){
					displayTip("电话不能为空");
				}else if("" == district){
					displayTip("收货地区不能为空");
				}else if("" == contentArea){
					displayTip("地址详情不能为空");
				}else{
					if (isSuccess) {
						showLodding();
						$.ajax({
							url : "${path}/weChat/doNewAddress?model.customer.id=${customerId}&employeeId=${employeeId}&model.content=" + content + "&isSelect=" + isSelect + "&oldSelectId=${oldSelectId}",
							data : formData,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = false;//防止重复提交
									displayTip(data.msg);
									setTimeout(function() {
										window.location='${path}/weChat/goReviseaddr?employeeId=${employeeId}';
									}, 1400);
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