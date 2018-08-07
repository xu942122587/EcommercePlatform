<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>订单详情</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
				var orderSubremark_goods = $("#orderSubremark_goods").html().trim();
				if("" == orderSubremark_goods){
					$("#orderSubremark_goods").html("<p>无</p>")
				}
			})
		</script>
		<style>
			.address_list {
				padding: 6px 20px;
			}
			
			.shoppingcart-goodslist {
				padding: 8px 20px;
			}
			
			.shoppingcart-goodsimg {
				width: 32%;
			}
			
			.address_nocheck {
				width: 14px;
				padding: 36px 14px;
			}
		</style>
	</head>

	<body>
		<!--订单号-->
		<div class="bg-white pad-top4">
			<div class="cost_content ">
				<div class="left">订单编号：</div>
				<div class="right">${order.code }</div>
			</div>
			<div class="cost_content ">
				<div class="left">下单时间：</div>
				<div class="right">
					<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd HH:mm"/>
				</div>
			</div>
		</div>
		<!--收货地址-->
		<div class="address_list bg-white mt6">
			<p class="title" style="border-bottom: 1px solid #ddd;">收货地址</p>
			<div class="overflow mt6">
				<span class="name font-large">${order.receiverName }</span>
				<span class="tel font-large">${order.receiverPhone }</span>
			</div>
			<div class="address">${order.receiverAddress }</div>
		</div>
		<div class="sureorder-line  clear_both"></div>

		<!--商品-->
		<p class="title bg-white mt6" style="padding: 0 20px;">商品信息</p>
		<c:forEach items="${order.orderList }" var="childOrder">
			<c:if test="${'1' eq childOrder.type}">
				<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
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
						<div class="font_small color-grey format_">
							<span>${orderGoods.goods.other_attr_value }</span>
							<span class="right">x${orderGoods.count }</span>
						</div>
						<div class="shoppingcart-goodsinfomation">
							<div class="left shoppingcart_price">&yen;${orderGoods.price }</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</c:forEach>

		<!--合计运费-->
		<div class="bg-white">
			<div class="cost_content ">
				<div class="left">数量：</div>
				<div class="right">${order.sumNumber }件</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">商品总价：</div>
				<div class="right price">&yen;${order.sumMoney }</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">活动优惠：</div>
				<div class="right price">&yen;
					<fmt:formatNumber value="${order.subMoney - order.eticketMoney}" pattern="#,###.##"/>
				</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">优惠券抵用：</div>
				<div class="right price">&yen;${order.eticketMoney }</div>
			</div>
			<hr />
			<div class="cost_content ">
				<div class="left">邮费：</div>
				<div class="right price">&yen;${order.postage }</div>
			</div>
			<hr/>
			<div class="cost_content ">
				<div class="left">赠品：</div>
				<div class="right price" id="orderSubremark_goods">
					<c:forEach items="${order.orderList }" var="order1">
						<c:forEach items="${order1.orderGoodList }" var="orderGoods">
							<c:if test="${not empty orderGoods.orderSubremark.promotionLadder}">
								<c:if test="${'7' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
									<p>${orderGoods.orderSubremark.promotionLadder.goods.name }:${orderGoods.orderSubremark.promotionLadder.goodsNumber }个</p>
								</c:if>
								<c:if test="${'8' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
									<p>${orderGoods.orderSubremark.promotionLadder.goods.name }:${orderGoods.orderSubremark.promotionLadder.goodsNumber }个</p>
								</c:if>
							</c:if>
						</c:forEach>
						<c:if test="${not empty order1.orderSubremarkList }">
							<c:forEach items="${order1.orderSubremarkList }" var="orderSubremark">
								<c:if test="${not empty orderSubremark.promotionLadder}">
									<c:if test="${'7' eq orderSubremark.promotionLadder.promotion.type}">
										<p>${orderSubremark.promotionLadder.goods.name }:${orderSubremark.promotionLadder.goodsNumber }个</p>
									</c:if>
									<c:if test="${'8' eq orderSubremark.promotionLadder.promotion.type}">
										<p>${orderSubremark.promotionLadder.goods.name }:${orderSubremark.promotionLadder.goodsNumber }个</p>
									</c:if>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
					<c:if test="${not empty order.orderSubremarkList }">
						<c:forEach items="${order.orderSubremarkList }" var="orderSubremark">
							<c:if test="${not empty orderSubremark.promotionLadder}">
								<c:if test="${'7' eq orderSubremark.promotionLadder.promotion.type}">
									<p>${orderSubremark.promotionLadder.goods.name }:${orderSubremark.promotionLadder.goodsNumber }个</p>
								</c:if>
								<c:if test="${'8' eq orderSubremark.promotionLadder.promotion.type}">
									<p>${orderSubremark.promotionLadder.goods.name }:${orderSubremark.promotionLadder.goodsNumber }个</p>
								</c:if>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<hr/>
			
			<div class="sureorder_total">总计：&yen;${order.payMoney }</div>
		</div>
		
		<!--选择支付方式-->
		<div class="wechat_pay">
			<c:if test="${'5' eq order.payType }">
			<img src="${path}/module/weChat/img/walletpay.png" />
				<span id="payType" payType='5'>
					余额支付
				</span>
			</c:if>
			<c:if test="${'3' eq order.payType }">
			<img src="${path}/module/weChat/img/wechatpay.png" />
				<span id="payType" payType='3'>
					微信支付
				</span>
			</c:if>
		</div>
		
		<div style="height: 52px"></div>
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
		<script type="text/javascript">
			$(".recommend_img").height($(".recommend_img").width());
			$(function(){
				
			})
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>