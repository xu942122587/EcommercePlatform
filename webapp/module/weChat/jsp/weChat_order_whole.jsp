<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>订单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			.shoppingcart-goodsimg {
				padding-left: 8px;
			}
			.shoppingcart-goodsinfomation,.format_{
				width: 67%;
			}
		</style>
	</head>

	<body>
		<!--列表为空-->
		<c:if test="${empty orderVoList }">
			<div class="list-none" style="display: block;">
				<img src="${path}/module/weChat/img/list_none.png" class="imgs">
				<div class="fonts">您还没有相关订单</div>
				<button onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'" class="goindex_btn">去首页逛逛</button>
			</div>
		</c:if>
		<c:if test="${not empty orderState }">
			<c:if test="${not empty orderVoList }">
				<c:if test="${'1' eq orderState}">
					<c:forEach items="${orderVoList }" var="orderVo">
						<div class="orderlist">
							<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
								<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
								<span class="left font-large">天和商城</span>
								<span class="right">待付款</span>
							</div>
							<c:forEach items="${orderVo.orderList  }" var="parentOrder">
								<a >
								<div class="shoppingcart_store">
									<span>${parentOrder.store.name }</span>
								</div>
								<c:forEach items="${parentOrder.orderList }" var="order">
									<!--未支付订单开始-->
									<c:if test="${'1' eq order.type}">
										<c:forEach items="${order.orderGoodList }" var="orderGoods">
											<div class="shoppingcart-goodslist">
												<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
													<c:if test="${empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
													</c:if>
													<c:if test="${not empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
													</c:if>
												class="shoppingcart-goodsimg">
												<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<div class="goods-name">
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</div>
												</div>
												<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<span>${orderGoods.goods.other_attr_value }</span>
													<span class="right">x${orderGoods.count }</span>
												</div>
												<div class="shoppingcart-goodsinfomation">
													<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
												</div>
											</div>
										</c:forEach>
									</c:if>
									<!--未支付订单结束-->
									</c:forEach>
									<div class="order-total">
										<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
										<div class="price right pr6"><span class="color-black">小计：</span>&yen;${parentOrder.payMoney }</div>
									</div>
								</a>
							</c:forEach>
							<div class="order-btn-bg">
								<div class="order-btn right" onclick="submitPayMoney('${orderVo.batchCode}','${orderVo.orderList[0].payType}','${orderVo.orderList[0].receiverName}','${orderVo.orderList[0].receiverAddress}','${orderVo.orderList[0].receiverPhone}')">
									付款
								</div>
								<div class="right" style="padding-right: 6px">
									<span class="font-small mt10">合计:</span>
									<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
									<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				
				<c:if test="${'2' eq orderState}">
					<c:forEach items="${orderVoList }" var="orderVo">
						<div class="orderlist">
							<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
								<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
								<span class="left font-large">天和商城</span>
								<span class="right">待发货</span>
							</div>
							<c:forEach items="${orderVo.orderList  }" var="parentOrder">
								<a >
								<div class="shoppingcart_store">
									<span>${parentOrder.store.name }</span>
								</div>
								<c:forEach items="${parentOrder.orderList }" var="order">
									<c:if test="${'1' eq order.type}">
										<!--未发货订单开始-->
										<c:forEach items="${order.orderGoodList }" var="orderGoods">
											<div class="shoppingcart-goodslist">
												<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
													<c:if test="${empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
													</c:if>
													<c:if test="${not empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
													</c:if>
												 class="shoppingcart-goodsimg">
												<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<div class="goods-name">
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</div>
												</div>
												<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<span>${orderGoods.goods.other_attr_value }</span>
													<span class="right">x${orderGoods.count }</span>
												</div>
												<div class="shoppingcart-goodsinfomation">
													<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
												</div>
											</div>
										</c:forEach>
										<!--未发货订单结束-->
									</c:if>
									</c:forEach>
									<div class="order-total">
										<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
										<div class="price right pr6"><span class="color-black">小计：</span>&yen;${parentOrder.payMoney }</div>
									</div>
								</a>
							</c:forEach>
							<div class="order-btn-bg">
								<div class="right" style="padding-right: 6px">
									<span class="font-small mt10">合计:</span>
									<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
									<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				
				<c:if test="${'4' eq orderState}">
					<c:forEach items="${orderVoList }" var="orderVo">
						<div class="orderlist">
							<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
								<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
								<span class="left font-large">天和商城</span>
								<span class="right">已发货</span>
							</div>
							<c:forEach items="${orderVo.orderList  }" var="parentOrder">
								<a >
								<div class="shoppingcart_store">
									<span>${parentOrder.store.name }</span>
								</div>
								<c:forEach items="${parentOrder.orderList }" var="order">
									<c:if test="${'1' eq order.type}">
										<!--已发货订单开始-->
										<c:forEach items="${order.orderGoodList }" var="orderGoods">
											<div class="shoppingcart-goodslist">
												<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
													<c:if test="${empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
													</c:if>
													<c:if test="${not empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
													</c:if>
												 class="shoppingcart-goodsimg">
												<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<div class="goods-name">
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</div>
												</div>
												<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<span>${orderGoods.goods.other_attr_value }</span>
													<span class="right">x${orderGoods.count }</span>
												</div>
												<div class="shoppingcart-goodsinfomation">
													<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
												</div>
											</div>
										</c:forEach>
										<!--已发货订单结束-->
									</c:if>
									</c:forEach>
									<div class="order-total">
										<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
										<div class="price right pr6"><span class="color-black">合计：</span>&yen;${parentOrder.payMoney }</div>
									</div>
								</a>
							</c:forEach>
							<div class="order-btn-bg">
								<div class="order-btn" onclick="sendGoods('${orderVo.batchCode}')">
									确认收货
								</div>
								<div class="right" style="padding-right: 6px">
									<span class="font-small mt10">合计:</span>
									<span class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
									<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				
				<c:if test="${'5' eq orderState}">
					<c:forEach items="${orderVoList }" var="orderVo">
						<div class="orderlist">
							<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
								<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
								<span class="left font-large">天和商城</span>
								<span class="right">待评价</span>
							</div>
							<c:forEach items="${orderVo.orderList  }" var="parentOrder">
								<div class="shoppingcart_store">
									<span>${parentOrder.store.name }</span>
								</div>
								<c:forEach items="${parentOrder.orderList }" var="order">
									<c:if test="${'1' eq order.type}">
										<!--待评价订单开始-->
										<c:forEach items="${order.orderGoodList }" var="orderGoods">
											<div class="shoppingcart-goodslist">
												<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
													<c:if test="${empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
													</c:if>
													<c:if test="${not empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
													</c:if>
												 class="shoppingcart-goodsimg">
												<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<div class="goods-name">
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</div>
												</div>
												<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<span>${orderGoods.goods.other_attr_value }</span>
													<span class="right">x${orderGoods.count }</span>
												</div>
												<div class="shoppingcart-goodsinfomation">
													<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
													<c:if test="${empty orderGoods.goods.name }">
														<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
													</c:if>
													<c:if test="${not empty orderGoods.goods.name }">
														<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
													</c:if>
												</div>
											</div>
										</c:forEach>
										<!--待评价订单结束-->
									</c:if>
									</c:forEach>
									<div class="order-total">
										<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
										<div class="price right pr6"><span class="color-black">小计：</span>&yen;${parentOrder.payMoney }</div>
									</div>
							</c:forEach>
							<div class="order-btn-bg">
								<div class="right" style="padding-right: 6px">
									<span class="font-small mt10">合计:</span>
									<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
									<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				
				<c:if test="${'6' eq orderState}">
					<c:forEach items="${orderVoList }" var="orderVo">
						<div class="orderlist">
							<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
								<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
								<span class="left font-large">天和商城</span>
								<span class="right">已完成</span>
							</div>
							<c:forEach items="${orderVo.orderList  }" var="parentOrder">
								<div class="shoppingcart_store">
									<span>${parentOrder.store.name }</span>
								</div>
								<c:forEach items="${parentOrder.orderList }" var="order">
									<c:if test="${'1' eq order.type}">
										<!--已完成订单开始-->
										<c:forEach items="${order.orderGoodList }" var="orderGoods">
											<div class="shoppingcart-goodslist">
												<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
													<c:if test="${empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
													</c:if>
													<c:if test="${not empty orderGoods.goods.name}">
														src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
													</c:if>
												 class="shoppingcart-goodsimg">
												<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<div class="goods-name">
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</div>
												</div>
												<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
													<span>${orderGoods.goods.other_attr_value }</span>
													<span class="right">x${orderGoods.count }</span>
												</div>
												<div class="shoppingcart-goodsinfomation">
													<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
													<c:if test="${empty orderGoods.goods.name }">
														<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
													</c:if>
													<c:if test="${not empty orderGoods.goods.name }">
														<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
													</c:if>
												</div>
											</div>
										</c:forEach>
										<!--已完成订单结束-->
									</c:if>
									</c:forEach>
									<div class="order-total">
										<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
										<div class="price right pr6"><span class="color-black">合计：</span>&yen;${parentOrder.payMoney }</div>
									</div>
							</c:forEach>
							<div class="order-btn-bg">
								<div class="right" style="padding-right: 6px">
									<span class="font-small mt10">合计:</span>
									<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
									<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${empty orderState }">
			<c:forEach items="${orderVoList }" var="orderVo">
				<div class="orderlist">
					<div style="overflow: hidden;padding: 12px 12px;background: #ff4993;color:#fff">
						<img class="left" style="width: 22px;margin: 0px 6px 0 0;" src="${path}/module/weChat/img/order_title_icon.png" />
						<span class="left font-large">天和商城</span>
						<span class="right">
							<c:if test="${'1' eq orderVo.state}">
								待付款
							</c:if>
							<c:if test="${'2' eq orderVo.state}">
								待发货
							</c:if>
							<c:if test="${'4' eq orderVo.state}">
								已发货
							</c:if>
							<c:if test="${'5' eq orderVo.state}">
								待评价
							</c:if>
							<c:if test="${'6' eq orderVo.state}">
								已完成
							</c:if>
						</span>
					</div>
					<c:forEach items="${orderVo.orderList }" var="parentOrder">
						<a >
						<div class="shoppingcart_store">
							<span>${parentOrder.store.name }</span>
						</div>
						<c:forEach items="${parentOrder.orderList }" var="order">
							<c:if test="${'1' eq order.type}">
								<!--已完成订单开始-->
								<c:forEach items="${order.orderGoodList }" var="orderGoods">
									<div class="shoppingcart-goodslist">
										<img onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'"
											<c:if test="${empty orderGoods.goods.name}">
												src="${path}/platform/images/${orderGoods.goods.goods.imgUrl[0]}" 
											</c:if>
											<c:if test="${not empty orderGoods.goods.name}">
												src="${path}/platform/images/${orderGoods.goods.imgUrl[0]}"
											</c:if>
										 class="shoppingcart-goodsimg">
										<div class="shoppingcart-goodsinfomation" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
											<div class="goods-name">
												<c:if test="${empty orderGoods.goods.name }">
													${orderGoods.goods.goods.name }
												</c:if>
												<c:if test="${not empty orderGoods.goods.name }">
													${orderGoods.goods.name }
												</c:if>
											</div>
										</div>
										<div class="font_small color-grey format_" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">
											<span>${orderGoods.goods.other_attr_value }</span>
											<span class="right">x${orderGoods.count }</span>
										</div>
										<div class="shoppingcart-goodsinfomation">
											<div class="left shoppingcart_price" onclick="window.location='${path}/weChat/goOrderDetails?employeeId=${employeeId}&orderId=${parentOrder.id }'">&yen;${orderGoods.price }</div>
											<c:if test="${'5' eq order.state}">
												<c:if test="${empty orderGoods.goods.name }">
													<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
												</c:if>
												<c:if test="${not empty orderGoods.goods.name }">
													<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
												</c:if>
											</c:if>
											<c:if test="${'6' eq order.state}">
												<c:if test="${empty orderGoods.goods.name }">
													<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
												</c:if>
												<c:if test="${not empty orderGoods.goods.name }">
													<div class="order-btn order_evaluate_btn" onclick="window.location='${path}/weChat/goEvaluate?employeeId=${employeeId}&goodsId=${orderGoods.goods.id }&orderId=${parentOrder.id }'" style="background: #00a900;margin: 6px 0 0;">评价</div>
												</c:if>
											</c:if>
										</div>
									</div>
								</c:forEach>
								<!--已完成订单结束-->
							</c:if>
							</c:forEach>
							<div class="order-total">
								<div class="left pl6">共${parentOrder.sumNumber }件商品</div>
								<div class="price right pr6"><span class="color-black">小计：</span>&yen;${parentOrder.payMoney }</div>
							</div>
						</a>
					</c:forEach>
					<c:if test="${'1' ne orderVo.state && '4' ne orderVo.state}">
						<div class="order-btn-bg">
							<div class="right" style="padding-right: 6px">
								<span class="font-small mt10">合计:</span>
								<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
								<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
							</div>
						</div>
					</c:if>
					<c:if test="${'1' eq orderVo.state}">
						<div class="order-btn-bg">
							<div class="order-btn" onclick="submitPayMoney('${orderVo.batchCode}','${orderVo.orderList[0].payType}','${orderVo.orderList[0].receiverName}','${orderVo.orderList[0].receiverAddress}','${orderVo.orderList[0].receiverPhone}')">
								付款
							</div>
							<div class="right" style="padding-right: 6px">
								<span class="font-small mt10">合计:</span>
								<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
								<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
							</div>
						</div>
					</c:if>
					<c:if test="${'4' eq orderVo.state}">
						<div class="order-btn-bg">
							<div class="order-btn" onclick="sendGoods('${orderVo.batchCode}')">
								确认收货
							</div>
							<div class="right" style="padding-right: 6px">
								<span class="font-small mt10">合计:</span>
								<span  class="price mt10">&yen;${orderVo.orderList[0].inLinePayMoney}</span>
								<span class="font-small mt10">(含邮费:&yen;${orderVo.orderList[0].postage })</span>
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>   
		</c:if>
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
		
		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		
		<!--底部菜单结束-->
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
			
			function submitPayMoney(batchCode,payType,receiverName,receiverAddress,receiverPhone){
				window.location='${path}/weChat/showOrder?employeeId=${employeeId}&batchCode='+batchCode+'&payType='+payType+'&receiverName='+receiverName+'&receiverAddress='+receiverAddress+'&receiverPhone='+receiverPhone
			}
			
			function sendGoods(batchCode){
				showLodding();
				$.ajax({
					url : "${path}/weChat/sendGoodsByBatchCode?employeeId=${employeeId}&batchCode="+batchCode,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							hiddenLodding();
							displayTip(data.msg);
							window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=5'
						} else {
							hiddenLodding();
							displayTip(data.msg);
						}
					},
					error : function(xhr, type, exception) {
						hiddenLodding();
						displayTip("请检查网络设置");
					}
				});
			}
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>