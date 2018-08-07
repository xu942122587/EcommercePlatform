<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>确认订单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<style>
			.shoppingcart-goodslist {
				padding: 8px 20px;
			}
			
			.shoppingcart-goodsimg {
				width: 32%;
			}
			
			.address_nocheck {
				width: 14px;
				padding: 32px 14px;
			}
		</style>
		
		<script>
			var isSuccess = true
			function saveOrder(goType){
				if("sc" == goType){
					var shoppingcartIdList = new Array();
					$('.shoppingcart-goodslist').find("#shoppingcartId").each(function(){
						shoppingcartIdList.push($(this).val());
					});
					var addressId = $("#defaultAddressId").val();
					if("" == addressId || undefined == addressId || null == addressId){
						displayTip("请选择地址!");
						return false;
					}
					var leaveMessage = $("#leaveMessage").val();
					var payType = $(".pay_chooose_checked").attr("payType");
					if(isSuccess){
						showLodding();
						isSuccess = false;
						$.ajax({
							url : "${path}/weChat/saveOrder?shoppingcartIdList="+shoppingcartIdList+"&employeeId=${employeeId}&leaveMessage="+leaveMessage+"&addressId="+addressId+"&payType="+payType+"&goType="+goType,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = true;
									window.location='${path}/weChat/showOrder?employeeId=${employeeId}&orderIdList='+data.obj+'&payType='+payType+'&addressId='+addressId;
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								displayTip("请检查网络设置");
								isSuccess = true;
							}
						});
					}
				}else if("icon" == goType){
					var goodsId = "";
					$('.shoppingcart-goodslist').find("#goodsId").each(function(){
						goodsId = $(this).val();
					});
					var count = $("#icon_count").html();
					var addressId = $("#defaultAddressId").val();
					if("" == addressId || undefined == addressId || null == addressId){
						displayTip("请选择地址!");
						return false;
					}
					if("" == goodsId || undefined == goodsId || null == goodsId){
						displayTip("请选择商品属性及数量!");
						return false;
					}
					var leaveMessage = $("#leaveMessage").val();
					var payType = $(".pay_chooose_checked").attr("payType");
					if(isSuccess){
						showLodding();
						isSuccess = false;
						$.ajax({
							url : "${path}/weChat/saveOrder?goodsId="+goodsId+"&employeeId=${employeeId}&leaveMessage="+leaveMessage+"&addressId="+addressId+"&payType="+payType+"&goType="+goType+"&count="+count,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
									window.location='${path}/weChat/showOrder?employeeId=${employeeId}&orderIdList='+data.obj+'&payType='+payType+'&addressId='+addressId;
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								displayTip("请检查网络设置");
								isSuccess = true;
							}
						});
					}
				}
			}
		</script>
	</head>

	<body class="bg-white">
		<!--收货地址-->
		<div class="sureorder-line  clear_both"></div>
		<c:if test="${not empty defaultAddress }">
			<div class="address_list">
				<div class="address_left_check">
					<img class="address_nocheck" src="${path}/module/weChat/img/list_none_address.png" />
				</div>
				<div class="address_right_content" id="defaultAddress_title">
					<input type="hidden" id="defaultAddressId" value="${defaultAddress.id}">
					<div class="overflow">
						<span class="name font-large">${defaultAddress.receiver}</span>
						<span class="tel font-large">${defaultAddress.phone}</span>
					</div>
					<div class="address">${defaultAddress.content}</div>
					<button class="edit_btn Receiving-information" onclick="openAddressList(this)">更换</button>
				</div>
			</div>
		</c:if>
		<c:if test="${empty defaultAddress }">
			<p class="Continue_to_browse bg-white">
				<span>您还没有默认收货地址!</span><br />
			</p>
			<button style="position:static ;margin: 10px 30%;" onclick="window.location='${path}/weChat/goNewAddress?employeeId=${employeeId}&addressId=&oldSelectId='" class="makesure_alert_address_newbtn">新建地址</button>
		</c:if>
		<div class="sureorder-line  clear_both"></div>
		
		<c:if test="${'sc' eq goType}">
			<c:forEach items="${shoppingcartList}" var="shoppingcart">
				<!--商品-->
				<div class="shoppingcart-goodslist">
					<input type="hidden" id="shoppingcartId" value="${shoppingcart.id}">
					<img 
						<c:if test="${empty shoppingcart.goods.name}">
							src="${path}/platform/images/${shoppingcart.goods.goods.imgUrl[0]}" 
						</c:if>
						<c:if test="${not empty shoppingcart.goods.name}">
							src="${path}/platform/images/${shoppingcart.goods.imgUrl[0]}"
						</c:if>
					class="shoppingcart-goodsimg">
					<div class="shoppingcart-goodsinfomation">
						<div class="goods-name">
							<c:if test="${empty shoppingcart.goods.name}">
								<div class="goods-name">${shoppingcart.goods.goods.name}</div>
							</c:if>
							<c:if test="${not empty shoppingcart.goods.name}">
								<div class="goods-name">${shoppingcart.goods.name}</div>
							</c:if>
						</div>
					</div>
					<!--有属性显示-->
					<div class="font_small color-grey format_" style="padding-right: 20px;">
						${shoppingcart.goods.other_attr_value}
					</div>
					<div class="shoppingcart-goodsinfomation">
						<div class="left shoppingcart_price">&yen;<fmt:formatNumber value="${shoppingcart.goods.salesPrice}" pattern="#,###.##"/></div>
						<div class="right color-grey">x${shoppingcart.count}</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		<c:if test="${'icon' eq goType}">
			<!--商品-->
			<div class="shoppingcart-goodslist" >
				<input type="hidden" id="goodsId" value="">
				<img id="icon_imgUrl" onclick="" src="${path}/platform/images/${goods.imgUrl[0]}" class="shoppingcart-goodsimg">
				<div class="shoppingcart-goodsinfomation">
					<div class="goods-name" id="icon_goodsName">${goods.name}</div>
				</div>
				<!--无属性显示-->
				<div class="choose_property" id="icon_no_goodsAttr">
					<span>请选择属性</span>
					<img src="${path}/module/weChat/img/classify_more-red.png" />
				</div>
	
				<!--有属性显示-->
				<div class="font_small color-grey format_" id="icon_have_goodsAttr" style="padding-right: 20px;display: none;">
					<span>颜色：黑色</span>
					<img class="format_choose" src="${path}/module/weChat/img/classify_more-red.png" />
				</div>
				
				<div class="shoppingcart-goodsinfomation">
					<div class="left shoppingcart_price" id="icon_goodsPrice"></div>
					<div class="right color-grey" id="icon_goodsCount"></div>
				</div>
			</div>
		</c:if>
		
		<div style="background: #fefff6;overflow: hidden;padding: 8px 20px;border-bottom: 1px solid #dddddd;">
			<textarea class="feedback-textarea" maxlength="100" id="leaveMessage" rows="1" placeholder="请输入留言备注" style="border: 1px solid rgb(221, 221, 221);margin: 8px 0;background: #fff;"></textarea>
		</div>
		
		<!--选择支付方式-->
		<p style="line-height: 40px;padding-left: 20px;background: #fefff6;clear: both;">付款方式</p>
		<div class="wechat_pay">
			<div class="pay_click_box box_2"><span payType='3' class="pay_chooose pay_chooose_checked"></span></div>
			<img src="${path}/module/weChat/img/wechatpay.png" />
			<span>微信支付</span>
		</div>
		<div class="wechat_pay" >
			<div class="pay_click_box"><span payType='5' class="pay_chooose "></span></div>
			<img src="${path}/module/weChat/img/walletpay.png" />
			<span>余额支付</span>
		</div>
		

		<div style="height: 50px"></div>
		<!--底部栏-->
		<div class="shoppingcart_foot" style="bottom: 0;">
			<%-- <span class="total_num" id="icon_count" style="bottom: 10px;">
			<c:if test="${empty countGoods}">
				1
			</c:if>
			<c:if test="${not empty countGoods}">
				${countGoods}
			</c:if>
			</span> --%>
			<button class="btn-cart" style="text-align: right!important;padding-right: 16px;">数量：
				<span class="payMoney"  id="icon_count">
					<c:if test="${empty countGoods}">
						1
					</c:if>
					<c:if test="${not empty countGoods}">
						${countGoods}
					</c:if>
				</span>
			</button>
			<button class="btn-buy" onclick="saveOrder('${goType}')">确认订单</button>
			<!--返回顶部-->
			<div class="gotop_box">
				<div class="gotop"></div>
			</div>
		</div>

		<!--选择地址弹框-->
		<div class="add_alert_ alert_address">
			<div class="add_alert">
				<img src="${path}/module/weChat/img/register-close.png" class="close_img" />
				<!--地址列表-->
				<ul class="address_lists ">
					<c:forEach items="${addressList}" var="address">
						<li class="address_list address_current" onclick="selectAddress(this)">
							<input type="hidden" value="${address.id }">
							<div class="overflow">
								<span class="name font-large">${address.receiver}</span>
								<span class="tel font-large">${address.phone}</span></div>
							<div class="address">${address.content}</div>
						</li>
					</c:forEach>
				</ul>
				<!--底部按钮-->
				<div style="height: 40px"></div>
				<button onclick="window.location='${path}/weChat/goNewAddress?employeeId=${employeeId}&addressId=&oldSelectId=${defaultAddress.id }'" class="makesure_alert_address_newbtn">新建地址</button>
			</div>
		</div>
		
		<!--立即购买选择规格-->
		<div class="add_alert_ alert_buychoose_box" id="goodsDetail">
			<div class="add_alert_buychoose_null"></div>
			<div class="add_alert_buychoose" style="border: none;">
				<div class="buychoose_overflow">
					<c:forEach items="${classStringList}" var="classString" varStatus="j">
						<div class="gd_choose pl12">
							<div>${classString.attr}</div>
							<ul class="color_choose ${classString.attrCode }">
								<c:forEach items="${goods.childGoodsAttrMap[classString.attrCode]}" var="childGoodsAttr">
									<li onclick="selectGoods(this)" isSelect="">
										${childGoodsAttr}
										<input type="hidden" id="goodsAttr" value='"${classString.attrCode}":"${childGoodsAttr}"'>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:forEach>
					<div class="gd_choose pl12">
						<div>数量</div>
						<div class="size_choose num_border" style="display: inline-block;">
							<img class="buynum-sub" src="${path}/module/weChat/img/num-sub-disable.png" />
							<!--<input class="buynum-input" type="number" value="0" />-->
							<span class="buynum-input">1</span>
							<img class="buynum-add" src="${path}/module/weChat/img/num-add.png" />
						</div>
					</div>
				</div>
				<!--底部按钮-->
				<div style="height: 40px"></div>
				<button class="makesure_alert_address_newbtn" style="bottom: 22px;" onclick="makesureGoods(this)">确认选择</button>
			</div>
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
		
		<script>
			$(".shoppingcart-goodsimg").height($(".shoppingcart-goodsimg").width());
			$(".pay_click_box").click(function() {
				$(".pay_chooose").removeClass("pay_chooose_checked");
				$(this).children(".pay_chooose").toggleClass("pay_chooose_checked");
			});
			
			function openAddressList(){
				$(".alert_address").show();
				$("body").scrollTop(0);
				$("html,body").css("overflow", "hidden");
				$("html,body").height("100%");
			}
			
			function selectAddress(this_){
				var name = $(this_).find(".name").html();
				var phone = $(this_).find(".tel").html();
				var address = $(this_).find(".address").html();
				var id = $(this_).find("input").val();
				
				$("#defaultAddress_title").find(".name").html(name);
				$("#defaultAddress_title").find(".tel").html(phone);
				$("#defaultAddress_title").find(".address").html(address);
				$("#defaultAddress_title").find("input").val(id);
				
				$(".alert_address").hide();
				$("html,body").css("overflow", "scroll");
				$("html,body").height("");
			}
			
			$(".close_img").click(function() {
				$(".add_alert_").hide();
				$("html,body").css("overflow", "scroll");
				$("html,body").height("");
			});
			
			$(".hot_img").height($(".hot_img").width());
			
			
			//回到顶部
			$(".gotop").click(function() {
				$('body,html').animate({
					scrollTop: 0
				}, 500);
			});

			//选择子商品
			function selectGoods(this_){
				$(this_).parent().find("li").css("backgroundColor", "#fff");
				$(this_).parent().find("li").attr("isSelect","");
				$(this_).css("backgroundColor", "#fee3ec");
				$(this_).attr("isSelect","select");
				
			}
			
			//选择规格
			<c:if test="${'icon' eq goType}">
				$(function() {
					$(".alert_buychoose_box").show();
					$("html,body").css("overflow", "hidden");
					$("html,body").height("100%");
				});
			</c:if>
			
			$(".choose_property,.format_choose").click(function() {
				$(".alert_buychoose_box").show();
				$("html,body").css("overflow", "hidden");
				$("html,body").height("100%");
			});
			$(".add_alert_buychoose_null").click(function() {
				$(".alert_buychoose_box").hide();
				$("html,body").css("overflow", "scroll");
				$("html,body").height("");
			});
			
			function makesureGoods(this_){
				var goodsAttr = new Array();
				var index = 0;
				var goodsCount = 1;
				var selectNum = ${classStringList.size()} - 0;
				$('#goodsDetail li[isSelect="select"]').each(function(){
					goodsAttr[index]=$(this).find("input").val();
					index++;
				});
				if(index == selectNum){
					if(isSuccess){
						showLodding();
						isSuccess = false;
						$.ajax({
							url : "${path}/weChat/selectGoodsForAttr?goodsId=${goods.id}&goodsAttr="+goodsAttr,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = true;
									if("" != data.obj.other_attr_value && null != data.obj.other_attr_value){
										$("#icon_have_goodsAttr").find("span").html(data.obj.other_attr_value)
									}else{
										$("#icon_have_goodsAttr").find("span").html("无")
									}
									$("#icon_no_goodsAttr").hide();
									$("#icon_have_goodsAttr").show();
									$("#icon_goodsPrice").html("&yen;"+data.obj.salesPrice)
									$("#goodsId").val(data.obj.id)
									$("#icon_goodsCount").html("x"+$(this_).parent().find(".buynum-input").html())
									$(".total_num").html($(this_).parent().find(".buynum-input").html())
									
									$(".alert_buychoose_box").hide();
									$("html,body").css("overflow", "scroll");
									$("html,body").height("");
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
									$(".alert_buychoose_box").hide();
									$("html,body").css("overflow", "scroll");
									$("html,body").height("");
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								displayTip("请检查网络设置");
								isSuccess = true;
								$(".alert_buychoose_box").hide();
								$("html,body").css("overflow", "scroll");
								$("html,body").height("");
							}
						});
					}
				}else{
					displayTip("商品属性不能为空,请选择!");
				}
				
			}

			//购买数量加减
			$('.buynum-sub').click(function() {
				if(parseInt($(this).siblings('.buynum-input').html()) > 1) {
					var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
					$(this).siblings('.buynum-input').html(value);
					$("#icon_count").html(value);
				} else if(parseInt($(this).siblings('.buynum-input').html()) < 2) {
					$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png')
				} else {
					var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
					$(this).siblings('.buynum-input').html(value);
					$("#icon_count").html(value);
					$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png')
				}
			});

			$('.buynum-add').click(function() {
				$(this).siblings('.buynum-sub').attr('src', '${path}/module/weChat/img/num-sub.png')
				var value = parseInt($(this).siblings('.buynum-input').html()) + 1;
				$(this).siblings('.buynum-input').html(value);
				$("#icon_count").html(value);
			});
			
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