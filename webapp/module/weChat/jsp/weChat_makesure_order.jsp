<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>结算</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<script src="${path}/platform/common/js/NumberUtil.js" type="text/javascript" charset="utf-8"></script>
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
			.Electronic_bg_black,.Electronic_state{
				display: none;
			}
		</style>
	</head>

	<body class="bg-white">
		<!--收货地址-->
		<div class="sureorder-line  clear_both"></div>
		<div class="address_list">
			<div class="address_left_check">
				<img class="address_nocheck" src="${path}/module/weChat/img/list_none_address.png" />
			</div>
			<div class="address_right_content">
				<div class="overflow">
					<span class="name font-large">${receiverName}</span>
					<span class="tel font-large">${receiverPhone}</span>
				</div>
				<div class="address">${receiverAddress }</div>
			</div>
		</div>
		<div class="sureorder-line  clear_both"></div>

		<!--商品-->
		

		<!--合计运费-->
		<c:forEach items="${orderList }" var="parentOrder">
			<div class="shoppingcart_store">
				<span>${parentOrder.store.name } </span>
			</div>
			<c:forEach items="${parentOrder.orderList }" var="order">
				<c:forEach items="${order.orderGoodList }" var="orderGoods">
					<div class="shoppingcart-goodslist">
						<img 
							<c:if test="${empty orderGoods.goods.name}">
								src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
							</c:if>
							<c:if test="${not empty orderGoods.goods.name}">
								src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
							</c:if>
						 class="shoppingcart-goodsimg">
						<div class="shoppingcart-goodsinfomation">
							<div class="goods-name">
								<c:if test="${empty orderGoods.goods.name }">
									${orderGoods.goods.goods.name }
								</c:if>
								<c:if test="${not empty orderGoods.goods.name }">
									${orderGoods.goods.name }
								</c:if>
							</div>
						</div>
						<div class="font_small color-grey format_">${orderGoods.goods.other_attr_value }</div>
						<div class="shoppingcart-goodsinfomation">
							<div class="left shoppingcart_price">&yen;${orderGoods.price }</div>
							<div class="right color-grey">x${orderGoods.count }</div>
						</div>
					</div>
				</c:forEach>
			</c:forEach>
			<div class="choose_cupon_enter">
				<span>选择电子券</span>
				<span class="choose_cupon_font_small">(电子代金券发放及使用细则)</span>
				<span class="choose_cupon_enter_icon" onclick="getUseEticketByOrderId('${parentOrder.store.name}','${parentOrder.id}')"> &rsaquo;</span>
			</div>
		</c:forEach>
		<!--合计运费-->
		<div class="bg-white">
			<div class="cost_content ">
				<div class="left">数量：</div>
				<div class="right">${sumNumber }件</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">商品总价：</div>
				<div class="right price">&yen;${sumMoney }</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">活动优惠：</div>
				<div class="right price">&yen;${subMoney }</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">优惠券(<span id="eticketNumber">${eticketNumber }</span>张)：</div>
				<div class="right price">&yen;<span id="eticketMoney">${eticketMoney }</span></div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">邮费：</div>
				<div class="right price">&yen;<span id="postage">${postage }</span></div>
			</div>
			<c:if test="${not empty promotionGoodsList}">
				<div class="cost_content ">
					<div class="left">赠品：</div>
					<div class="right price">
						<c:forEach  items="${promotionGoodsList }" var="promotionGoods">
							<p>${promotionGoods }</p>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<hr/>
			<div class="sureorder_total">总计：&yen;<span class="payMoney">${payMoneyAndPostage }</span></div>
		</div>
		<p style="line-height: 40px;padding-left: 20px;background: #fefff6;clear: both;">付款方式</p>
		<!--选择支付方式-->
		<div class="wechat_pay">
			<c:if test="${'5' eq payType }">
			<img src="${path}/module/weChat/img/walletpay.png" />
				<span id="payType" payType='5'>
					余额支付
				</span>
			</c:if>
			<c:if test="${'3' eq payType }">
			<img src="${path}/module/weChat/img/wechatpay.png" />
				<span id="payType" payType='3'>
					微信支付
				</span>
			</c:if>
		</div>

		<div style="height: 50px"></div>
		<!--底部栏-->
		<div class="shoppingcart_foot" style="bottom: 0;">
			<span class="total_num" style="bottom: 10px;">${sumNumber }</span>
			<button class="btn-cart">总计：&yen;<span class="payMoney">${payMoneyAndPostage }</span></button>
			<button class="btn-buy" onclick="submitPayMoney()">付款</button>
			<!--返回顶部-->
			<div class="gotop_box">
				<div class="gotop"></div>
			</div>
		</div>

		<!--选择电子券弹框-->
		<div class="add_alert_" id="choose_cupon_alert">
			<div class="add_alert" style="width: 96%;margin: 7% 2%;">
				<img src="${path }/module/weChat/img/register-close.png" class="close_img" />
				<!--电子券列表-->
				<ul class="address_lists property">
					<div class="prop-area" id="eticket_List" style="min-height:300px;overflow: hidden;">
					</div>
				</ul>
				<!--底部按钮-->
				<div style="height: 40px"></div>
				<button class="makesure_cupon" onclick="orderUseEticket()">确定选择</button>
			</div>
		</div>

		<!--电子券规则弹框-->
		<div class="add_alert_ " id="cupon_rules_alert">
			<div class="add_alert" style="line-height: 24px;letter-spacing: 2px;padding:0 12px;text-align: justify;">
				<img src="${path }/module/weChat/img/register-close.png" class="close_img" />
				<p class="title center font-large mt6" style="padding-top: 30px;line-height: 30px;">天和商城电子代金券发放及使用细则</p>
				<div style="height: 70%;overflow: auto;">
					<p>★天和商城发放的电子代金券仅限商城会员使用，天和商城实体店及网上商城均可使用;</p><br />
					<p>★天和商城将在各种营销活动及赠送会员生日礼时发放电子代金券，电子券以电子版的形式发放到会员微信帐户中;</p><br />
					<p>★电子代金券分为通用券、专用券两种。通用券可在多家标示门店使用，专用券仅限券面标示门店使用;</p><br />
					<p>★电子代金券依据券面标注使用规则即可使用，不可与多种优惠活动同时使用;</p><br />
					<p>★电子代金券使用后自动作废，不可重复使用，不可兑换，不设找零。</p>
				</div>
			</div>
		</div>

		<!--余额支付密码弹框-->
		<div class="add_alert_ " id="pay_password_alert">
			<div class="add_alert">
				<img src="${path }/module/weChat/img/register-close.png" class="close_img" />
				<p class="title center font-large">请输入支付密码</p>
				<hr />
				<p class="title center mt6">余额支付</p>
				<p class="title center" style="font-size: 28px;">&yen;<span class="payMoney">${payMoneyAndPostage }</span></p>
				<form id="password" class="pay_password_box" disabled="disabled">
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled"/>
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled"/>
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled"/>
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled"/>
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled"/>
					<input readonly="" class="pay_password" type="password" maxlength="1" value="" disabled="disabled" style="border-right: none;"/>
				</form>
				<!--键盘-->
				<div class="password_keyboard">
					<div class="keyboard_num">1</div>
					<div class="keyboard_num">2</div>
					<div class="keyboard_num">3</div>
					<div class="keyboard_num">4</div>
					<div class="keyboard_num">5</div>
					<div class="keyboard_num">6</div>
					<div class="keyboard_num">7</div>
					<div class="keyboard_num">8</div>
					<div class="keyboard_num">9</div>
					<div class="keyboard_null">&nbsp;</div>
					<div class="keyboard_num">0</div>
					<div class="keyboard_delete">删除</div>
				</div>
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
			$(".shoppingcart-goodsimg").height($(".shoppingcart-goodsimg").width());
			//回到顶部
			$(".gotop").click(function() {
				$('body,html').animate({scrollTop:0},500);
			});
			//orderIdList
			var isSuccess=true;
			function submitPayMoney(){
				if(isSuccess){
					showLodding();
					isSuccess = false;
					$.ajax({
						url : "${path}/weChat/selectINLinePayMoneyZero?orderIds=${orderIdList}&employeeId=${employeeId}",
						data : null,
						type : "post",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success){
								if("zeroPay" !=data.obj){
									hiddenLodding();
									isSuccess = true;
									if("3" == $("#payType").attr("payType")){
										showLodding();
										if(isSuccess){
											isSuccess = false;
											$.ajax({
												url : "${path}/weChat/doPay?orderIds=${orderIdList}&employeeId=${employeeId}",
												data : null,
												type : "post",
												async : false,
												dataType : "json",
												success : function(data) {
													if ("请检查网络设置" == data){
														isSuccess = true;
														displayTip(data);
														hiddenLodding();
													}else {
														isSuccess = false;
														hiddenLodding();
														wxPayF(data);
													} 
												},
												error : function(xhr, type, exception) {
													isSuccess = true;
													displayTip("请检查网络设置");
													hiddenLodding();
												}
											});
										}
									}else if("5" == $("#payType").attr("payType")){
										if(isSuccess){
											isSuccess = false;
											$.ajax({
												url : "${path}/weChat/walletPayIsHavePassword?employeeId=${employeeId}",
												data : null,
												type : "post",
												async : false,
												dataType : "json",
												success : function(data) {
													if (data.success){
														isSuccess = true;
													}else {
														displayTip(data.msg);
														isSuccess = true;
														if("noPassword" == data.obj){
															setTimeout(function() {
																window.location='${path}/weChat/goPayPassword?employeeId=${employeeId}'
															}, 500);
														}
													}
												},
												error : function(xhr, type, exception) {
													isSuccess = true;
													displayTip("请检查网络设置");
												}
											});
										}
										//余额支付输入密码
										$("#pay_password_alert").show();
										$("body").scrollTop(0);
										$("html,body").css("overflow", "hidden");
										$("html,body").height("100%");
										var check_pass_word = '';
										var passwords = $('#password').get(0);
										var character, index = 0;
										$('.password_keyboard div').click(function() {
											if($(this).hasClass('keyboard_delete')) {
												$(passwords.elements[--index % 6]).val('');
												if($(passwords.elements[0]).val() == '') {
													index = 0;
												}
												return false;
											}
											if($(this).hasClass('keyboard_num')) {
												character = $(this).text();
												$(passwords.elements[index++ % 6]).val(character);
												if($(passwords.elements[5]).val() != '') {
													index = 0;
												}
												if(0 == index){
														var payPassword = "";
														$('#password').find("input").each(function(){
															payPassword +=$(this).val();
														})
														showLodding();
														if('' == payPassword || null == payPassword){
															displayTip("请重新输入密码!");
															$('#password input').val("");
															hiddenLodding();
															index = 0;
															return false;
														}
														if(isSuccess){
															isSuccess = false;
															$.ajax({
																url : "${path}/weChat/walletPay?orderIds=${orderIdList}&employeeId=${employeeId}&passWord="+payPassword,
																data : null,
																type : "post",
																async : false,
																dataType : "json",
																success : function(data) {
																	if (data.success){
																		isSuccess = false;
																		$("#pay_password_alert").hide();
																		displayTip(data.msg);
																		hiddenLodding();
																		window.location.href = "${path}/weChat/paySuccess?employeeId=${employeeId}&flag=order";
																	}else {
																		isSuccess = true;
																		hiddenLodding();
																		if("password" == data.obj){
																			displayTip(data.msg);
																			$('#password input').val("");
																		}else if("payMoney" == data.obj){
																			displayTip(data.msg);
																			$('#password input').val("");
																		}else{
																			displayTip(data.msg);
																			setTimeout(function() {
																				window.location = "${path}/weChat/payFail?employeeId=${employeeId}&flag=order";
																			}, 2500);
																		}
																	}
																},
																error : function(xhr, type, exception) {
																	isSuccess = true;
																	$('#password input').val("");
																	displayTip("请检查网络设置");
																	hiddenLodding();
																}
															});
														}
												}
											}
										});
									}
								}else if("zeroPay" == data.obj) {
									isSuccess = false;
									$("#pay_password_alert").hide();
									displayTip(data.msg);
									hiddenLodding();
									window.location.href = "${path}/weChat/paySuccess?employeeId=${employeeId}&flag=order";
								}
							}else {
								isSuccess = true;
								hiddenLodding();
								displayTip(data.msg);
								setTimeout(function() {
									window.location = "${path}/weChat/payFail?employeeId=${employeeId}&flag=order";
								}, 2500);
							}
						},
						error : function(xhr, type, exception) {
							isSuccess = true;
							$('#password input').val("");
							displayTip("请检查网络设置");
							hiddenLodding();
						}
					});
				}
				
			}
			
			function wxPayF(data){
				try {
					/* var obj = eval("(" + data + ")"); */
					var obj = data;
					//在线支付 
					if (typeof WeixinJSBridge == "undefined") {
						if (document.addEventListener) {
							document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
						} else if (document.attachEvent) {
							document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
							document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
						}
					} else {
						WeixinJSBridge.invoke('getBrandWCPayRequest', {
									"appId" : obj.appId, //公众号名称，由商户传入
									"timeStamp" : obj.timeStamp, //时间戳，自1970年以来的秒数
									"nonceStr" : obj.nonceStr, //随机串
									"package" : obj.package,
									"signType" : obj.signType, //微信签名方式:
									"paySign" : obj.paySign //微信签名
								},
								function(res) {
									if (res.err_msg == "get_brand_wcpay_request:ok") {
										hiddenLodding();
										window.location.href = "${path}/weChat/paySuccess?employeeId=${employeeId}&flag=order";
									} else {
										hiddenLodding();
										isSuccess = true;
										window.location.href = "${path}/weChat/payFail?employeeId=${employeeId}&flag=order";
									} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回   ok，但并不保证它绝对可靠。
								});
					}
				} catch (e) {
					isSuccess = true;
				}
			}
			
			$(".close_img").click(function() {
				$(".add_alert_").hide();
				$("html,body").css("overflow", "scroll");
				$("html,body").height("");
			});
			
			function getUseEticketByOrderId(storeName,orderId){
				var storeName = storeName;
				$.ajax({
					type : "POST",
					url : "${path}/weChat/getUseEticketByOrderId?employeeId=${employeeId}&orderId="+orderId,
					dataType : "json",
					success : function(data) {
						if(data.success){
							$("#eticket_List").html("");
							var jsonData = eval(data.obj);
							for ( var o in jsonData) {
								if("5" == jsonData[o].eticket.outType){
									if("1" == jsonData[o].eticket.type){
										$("#eticket_List").append(
												"<div class='Electronic_coupons Electronic_coupons_birthday' onclick='selectEticket(this)'>"
													+"<img class='Electronic_coupons_code' src='${path}/platform/qrcode/eticket/"+jsonData[o].code+".png' />"
													+"<img class='Electronic_birthday' src='${path }/module/weChat/img/birthday.png' />"
													+"<div class='store_name'>"+storeName+"</div>"
													+"<input value='"+jsonData[o].code+"' type='hidden' isSelect='' orderId='"+orderId+"' id='eticketId'>"
													+"<div class='Electronic_coupons_value'>"
														+"<span style='font-size: 18px;'>&yen;</span><span>"+jsonData[o].eticket.price+"</span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"<span class='Electronic_coupons_type'>专用券 </span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"满<span style='color: #ec196b;font-size: 20px;'>"+jsonData[o].eticket.useLimit+"</span>"
														+"使用 &nbsp;&nbsp;"+jsonData[o].endDateValue+"前使用"
													+"</div>"
													+"<img class='Electronic_bg_black' src='${path }/module/weChat/img/Electronic_bg_black.png' />"
													+"<p class='Electronic_state'>已选择</p>"
												+"</div>"
										);
									}else if("2" == jsonData[o].eticket.type){
										$("#eticket_List").append(
												"<div class='Electronic_coupons Electronic_coupons_birthday' onclick='selectEticket(this)'>"
													+"<img class='Electronic_coupons_code' src='${path}/platform/qrcode/eticket/"+jsonData[o].code+".png' />"
													+"<img class='Electronic_birthday' src='${path }/module/weChat/img/birthday.png' />"
													+"<div class='store_name'></div>"
													+"<input value='"+jsonData[o].code+"' type='hidden' isSelect=''  orderId='"+orderId+"'  id='eticketId'>"
													+"<div class='Electronic_coupons_value'>"
														+"<span style='font-size: 18px;'>&yen;</span><span>"+jsonData[o].eticket.price+"</span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"<span class='Electronic_coupons_type'>通用劵 </span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"满<span style='color: #ec196b;font-size: 20px;'>"+jsonData[o].eticket.useLimit+"</span>"
														+"使用 &nbsp;&nbsp;"+jsonData[o].endDateValue+"前使用"
													+"</div>"
													+"<img class='Electronic_bg_black' src='${path }/module/weChat/img/Electronic_bg_black.png' />"
													+"<p class='Electronic_state'>已选择</p>"
												+"</div>"
										);
									}
								}else{
									if("1" == jsonData[o].eticket.type){
										$("#eticket_List").append(
												"<div class='Electronic_coupons Electronic_coupons_able' onclick='selectEticket(this)'>"
													+"<img class='Electronic_coupons_code' src='${path}/platform/qrcode/eticket/"+jsonData[o].code+".png' />"
													+"<div class='store_name'>"+storeName+"</div>"
													+"<input value='"+jsonData[o].code+"' type='hidden' isSelect=''  orderId='"+orderId+"'  id='eticketId'>"
													+"<div class='Electronic_coupons_value'>"
														+"<span style='font-size: 18px;'>&yen;</span><span>"+jsonData[o].eticket.price+"</span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"<span class='Electronic_coupons_type'>专用券 </span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"满<span style='color: #ec196b;font-size: 20px;'>"+jsonData[o].eticket.useLimit+"</span>"
														+"使用 &nbsp;&nbsp;"+jsonData[o].endDateValue+"前使用"
													+"</div>"
													+"<img class='Electronic_bg_black' src='${path }/module/weChat/img/Electronic_bg_black.png' />"
													+"<p class='Electronic_state'>已选择</p>"
												+"</div>"
										);
									}else if("2" == jsonData[o].eticket.type){
										$("#eticket_List").append(
												"<div class='Electronic_coupons Electronic_coupons_able' onclick='selectEticket(this)'>"
													+"<img class='Electronic_coupons_code' src='${path}/platform/qrcode/eticket/"+jsonData[o].code+".png' />"
													+"<div class='store_name'></div>"
													+"<input value='"+jsonData[o].code+"' type='hidden' isSelect=''  orderId='"+orderId+"'  id='eticketId'>"
													+"<div class='Electronic_coupons_value'>"
														+"<span style='font-size: 18px;'>&yen;</span><span>"+jsonData[o].eticket.price+"</span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"<span class='Electronic_coupons_type'>通用劵 </span>"
													+"</div>"
													+"<div class='Electronic_coupons_period_of_validity'>"
														+"满<span style='color: #ec196b;font-size: 20px;'>"+jsonData[o].eticket.useLimit+"</span>"
														+"使用 &nbsp;&nbsp;"+jsonData[o].endDateValue+"前使用"
													+"</div>"
													+"<img class='Electronic_bg_black' src='${path }/module/weChat/img/Electronic_bg_black.png' />"
													+"<p class='Electronic_state'>已选择</p>"
												+"</div>"
										);
									}
								}
							}
							$("#choose_cupon_alert").show();
						}else{
							displayTip(data.msg);
						}
					},
					error :function(){
						displayTip("请检查网络设置");
					}
				});
			}
			
			function selectEticket(this_){
				$("#eticket_List").find("input").each(function(){
					$(this).attr("isSelect","");
				});
				$(".Electronic_bg_black,.Electronic_state").hide();
				$(this_).children(".Electronic_bg_black,.Electronic_state").show();
				$(this_).find("input").attr("isSelect","select");
			}
			
			function orderUseEticket(){
				var eticketOutCode = "";
				var eticketNumber = $("#eticketNumber").html().trim() - 0;
				var orderId = "";
				$("#eticket_List").find("input").each(function(){
					if("select" == $(this).attr("isSelect")){
						eticketOutCode = $(this).val();
						orderId = $(this).attr("orderId");
					}
				});
				if("" == eticketOutCode || "" == orderId){
					displayTip("请选择一张优惠劵!");
				}else{
					$.ajax({
						type : "POST",
						url : "${path}/weChat/orderUseEticket?employeeId=${employeeId}&orderId="+orderId+"&eticketOutCode="+eticketOutCode,
						dataType : "json",
						success : function(data) {
							if(data.success){
								eticketNumber++;
								$("#eticketMoney").html(accAdd($("#eticketMoney").html().trim(),data.attributes.subMoney_all) );
								$("#eticketNumber").html(eticketNumber);
								var payMoney = Subtr($(".payMoney").html().trim(),data.attributes.subMoney_all);
								if(0.0 >= parseFloat($("#postage").html())){
									payMoney = accAdd(payMoney,data.attributes.postage);
								}
								$("#postage").html(data.attributes.postage);
								if(0 >= payMoney){
									$(".payMoney").html("0");
								}else{
									$(".payMoney").html(payMoney);
								}
								displayTip(data.msg);
								$("#choose_cupon_alert").hide();
							}else{
								displayTip(data.msg);
							}
						},
						error :function(){
							displayTip("请检查网络设置");
						}
					});
				}
			}
			
			//电子券使用规则
			$(".choose_cupon_font_small").click(function() {
				$("#cupon_rules_alert").show();
			});
			
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>