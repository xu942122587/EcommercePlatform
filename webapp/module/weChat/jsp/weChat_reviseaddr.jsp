<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title>地址管理</title>
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

	<body>
		<!--暂无地址-->
		<div class="list-none">
			<img src="${path}/module/weChat/img/list_none_address.png" class="imgs">
			<div class="fonts">收货地址在哪里</div>
		</div>
		<!--地址列表-->
		<ul class="address_lists ">
			<c:forEach items="${addressList}" var="address">
				<li class="address_list">
					<c:if test="${'1' eq address.isDefault}">
						<input type="hidden" value="${address.id }" select="select">
					</c:if>
					<c:if test="${'2' eq address.isDefault}">
						<input type="hidden" value="${address.id }" select="">
					</c:if>
					<div class="sureorder-line"></div>
					<div class="address_right_content" style="width: 96%;">
						<div class="overflow">
							<span class="name font-large">${address.receiver}</span>
							<span class="tel font-large">${address.phone}</span>
						</div>
						<div class="address">${address.content}</div>
						<!--设为默认地址-->
						<div class="new_address">
							<c:if test="${'1' eq address.isDefault}">
								<img src="${path}/module/weChat/img/address_default_nochoose.png" class="new_address_nochoose" style="display: none"/>
								<img src="${path}/module/weChat/img/address_default.png" class="new_address_choose" style="display: inline;"/>
							</c:if>
							<c:if test="${'2' eq address.isDefault}">
								<img src="${path}/module/weChat/img/address_default_nochoose.png" class="new_address_nochoose" style="display:inline;"/>
								<img src="${path}/module/weChat/img/address_default.png" class="new_address_choose" style="display: none" />
							</c:if>
							<span class="new_address_text">设为默认地址</span>
							<button class="delete_btn" onclick="doDeleteAddress('${address.id}')">删除</button>
							<button class="edit_btn" onclick="updateAddress(this)">编辑</button>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		
		<c:if test="${empty addressList}">
			<!--列表为空-->
			<div class="list-none" style="display: block;">
				<img src="${path}/module/weChat/img/list_none.png" class="imgs">
				<div class="fonts">您还没有收货地址哦 o≧▽≦o</div>
			</div>
		</c:if>
		
		<!--底部按钮-->
		<div style="height: 40px"></div>
		<button onclick="goNewAddress(this)" class="confirm-btn">添加新地址</button>
		
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
			// 默认地址点击选中
			$(".new_address_nochoose").click(function() {
				$(".new_address_choose").hide();
				$(".new_address_nochoose").show();
				$(this).hide();
				$(this).next(".new_address_choose").show();
				if(null == $(this).parent().parent().parent().parent().find("input[select=select]").val()
						|| "" == $(this).parent().parent().parent().parent().find("input[select=select]").val()){
					var oldSelectId = "";
				}else{
					var oldSelectId = $(this).parent().parent().parent().parent().find("input[select=select]").val().trim();
					$(this).parent().parent().parent().parent().find("input[select=select]").attr("select","");
				}
				var newSelectId = $(this).parent().parent().parent().find("input").val().trim();
				$(this).parent().parent().parent().find("input").attr("select","select");
				selectIsDefault(oldSelectId,newSelectId);
			});
			//默认地址点击取消
			$(".new_address_choose").click(function() {
				$(this).hide();
				$(this).prev(".new_address_nochoose").show();
				var oldSelectId = $(this).parent().parent().parent().parent().find("input[select=select]").val().trim();
				$(this).parent().parent().parent().parent().find("input[select=select]").attr("select","");
				var newSelectId = "";
				selectIsDefault(oldSelectId,newSelectId);
			});
			
			function selectIsDefault(oldSelectId,newSelectId) {
				$.ajax({
					url : "${path}/weChat/selectIsDefault?employeeId=${employeeId}&oldSelectId=" + oldSelectId+"&newSelectId=" + newSelectId,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							displayTip(data.msg);
						} else {
							displayTip(data.msg);
						}
					},
					error : function(xhr, type, exception) {
						displayTip("请检查网络设置");
					}
				});
				return false;//防止页面刷新
			};
			
			function displayTip(message){
				$("#successTip").html(message);
				$("#successTip").fadeToggle(500, function() {
					setTimeout(function() {
						$("#successTip").fadeToggle(1000);
					}, 800);
				});
			}
			
			function hiddenLodding(){
				$("#loadingDiv").hide();
			}
			
			function showLodding(){
				$("#loadingDiv").show();
			}
			
			function updateAddress(this_){
				if(null == $(this_).parent().parent().parent().parent().find("input[select=select]").val()
						|| "" == $(this_).parent().parent().parent().parent().find("input[select=select]").val()){
					var oldSelectId = "";
				}else{
					var oldSelectId = $(this_).parent().parent().parent().parent().find("input[select=select]").val().trim();
				}
				var addressId = $(this_).parent().parent().parent().find("input").val().trim();
				window.location='${path}/weChat/goNewAddress?employeeId=${employeeId}&addressId='+addressId+'&oldSelectId='+oldSelectId;
			}
			
			function goNewAddress(this_){
				if(null == $(this_).parent().find("input[select=select]").val()
						|| "" == $(this_).parent().find("input[select=select]").val()){
					var oldSelectId = "";
				}else{
					var oldSelectId = $(this_).parent().find("input[select=select]").val().trim();
				}
				var addressId = "";
				window.location='${path}/weChat/goNewAddress?employeeId=${employeeId}&addressId='+addressId+'&oldSelectId='+oldSelectId;
			}
			
			var isSuccess = true;
			function doDeleteAddress(addressId){
				if (isSuccess) {
					isSuccess = false;
					showLodding();
					$.ajax({
						url : "${path}/weChat/doDeleteAddress?addressId=" + addressId,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								hiddenLodding();
								isSuccess = true;//防止重复提交
								displayTip(data.msg);
								setTimeout(function() {
									window.location='${path}/weChat/goReviseaddr?employeeId=${employeeId}';
								}, 1000);
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
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>