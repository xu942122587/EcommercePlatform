<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.procurement.view");
	com.yunt.procurement.view = {
	};
	
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">订单详情</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">订单号</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>

						<label for="product-uuid" class="col-xs-2 control-label">导购编号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.guideUser.username }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.store.storeCode }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.store.name }(${model.store.typeValue })</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">客户名</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.customer.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">客户手机号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.customer.phone }</div>
					</div>

					<c:if test="${'4' eq model.type }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">预约人</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.reserveName }</div>

							<label for="product-uuid" class="col-xs-2 control-label">预约电话</label>
							<div class="col-xs-3" style="padding-top:7px;">${model.reservePhone }</div>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">定金</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.reserveMoney }</div>

							<label for="product-uuid" class="col-xs-2 control-label">预约时间</label>
							<div class="col-xs-3" style="padding-top:7px;">
								<fmt:formatDate value="${model.reserveTime }" pattern="yyyy-MM-dd HH:mm"/>
							</div>
						</div>
					</c:if>

					<c:if test="${'1' eq model.type }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">收货人</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.receiverName }</div>

							<label for="product-uuid" class="col-xs-2 control-label">收货人电话</label>
							<div class="col-xs-3" style="padding-top:7px;">${model.receiverPhone }</div>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">收货地址</label>
							<div class="col-xs-8" style="padding-top: 7px;">${model.receiverAddress }</div>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">运费</label>
							<div class="col-xs-8" style="padding-top: 7px;">${model.postage }</div>
						</div>
					</c:if>

					<c:if test="${not empty model.subUserType }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">优惠人员类型</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.subUserTypeValue }</div>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">订单金额</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span><fmt:formatNumber value="${model.sumMoney }" pattern="#,###.##"/></span>元</div>

						<label for="product-uuid" class="col-xs-2 control-label">活动优惠金额</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${(model.subMoney - model.eticketMoney) }" pattern="#,###.##"/></span>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">优惠劵优惠金额</label>
						<c:if test="${not empty model.eticketMoney }">
							<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.eticketMoney }" pattern="#,###.##"/></span>元</div>
						</c:if>
						<c:if test="${empty model.eticketMoney }">
							<div class="col-xs-3" style="padding-top: 7px;"><span >0</span>元</div>
						</c:if>

						<label for="product-uuid" class="col-xs-2 control-label">总优惠</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.subMoney }" pattern="#,###.##"/></span>元</div>
					</div>

					<div class="form-group">
						<c:if test="${'4' eq model.type }">
							<label for="product-uuid" class="col-xs-2 control-label">定金实付款：</label>
							<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.onePayMoney}" pattern="#,###.##"/></span>元</div>
	
							<c:if test="${not empty model.twoCashierCode }">
								<label for="product-uuid" class="col-xs-2 control-label">尾款实付款：</label>
								<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.twoPayMoney}" pattern="#,###.##"/></span>元</div>
							</c:if>
						</c:if>
						<c:if test="${'1' eq model.type || '2' eq model.type}">
							<label for="product-uuid" class="col-xs-2 control-label">首次实付款：</label>
							<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.onePayMoney}" pattern="#,###.##"/></span>元</div>
						</c:if>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">合计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.payMoney }" pattern="#,###.##"/></span>元</div>
					</div>

					<c:if test="${'1' eq model.type }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">留言</label>
							<div class="col-xs-8" style="padding-top: 7px;">${model.leaveMessage }</div>
							<label for="product-uuid" class="col-xs-2"></label>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8" style="padding-top: 7px;">${model.remark }</div>
					</div>

					<c:if test="${'4' eq model.type || '1' eq model.type}">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
								<c:if test="${'4' eq model.type }">
									预约详情
								</c:if>
								<c:if test="${'1' eq model.type }">
									订单详情
								</c:if>
							</label>
						</div>

						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<c:if test="${'4' eq model.type }">
									预约商品清单
								</c:if>
								<c:if test="${'1' eq model.type }">
									订单商品清单
								</c:if>
							</div>

							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">序号</th>
										<th class="text-center">商品编号</th>
										<th class="text-center">商品名称</th>
										<th class="text-center">商品属性</th>
										<th class="text-center">商品售价</th>
										<th class="text-center">优惠价</th>
										<th class="text-center">实售价</th>
										<th class="text-center">数量</th>
									</tr>
								</thead>
								<tbody >
								<c:set value="1" var="index"/>
									<c:forEach items="${model.orderList }" var="childOrder" >
										<c:if test="${not empty childOrder.proType }">
											<c:forEach items="${childOrder.orderGoodList }" var="orderGoods" varStatus="j">
												<tr >
													<td class="text-center" >${index}<c:set value="${index + 1 }" var="index"/></td>
													<td class="text-center" >
														<c:if test="${empty orderGoods.goods.goodsCode }">
															${orderGoods.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty orderGoods.goods.goodsCode }">
															${orderGoods.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty orderGoods.goods.name }">
															${orderGoods.goods.goods.name }
														</c:if>
														<c:if test="${not empty orderGoods.goods.name }">
															${orderGoods.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty orderGoods.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty orderGoods.goods.other_attr_value }">
															${orderGoods.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${orderGoods.price } / 件</td>
													<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
													<td class="text-center" >${orderGoods.salesPrice } / 件</td>
													<td class="text-center" >${orderGoods.count }件</td>
												</tr>
											</c:forEach>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>

<%-- 						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
								<c:if test="${'4' eq model.type }">
									预约发货详情
								</c:if>
								<c:if test="${'1' eq model.type }">
									订单发货详情
								</c:if>
							</label>
						</div> --%>
					</c:if>
					
					
					<c:forEach items="${model.orderList }" var="childOrder" >
								<c:if test="${'1' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											线上发货清单
										</label>
									</div>
								</c:if>
								<c:if test="${'2' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											线下商品清单
										</label>
									</div>
								</c:if>
								<c:if test="${'3' eq childOrder.type && '7' ne childOrder.state}">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											换购商品清单
										</label>
									</div>
								</c:if>
								<c:if test="${'4' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											预约发货清单
										</label>
									</div>
								</c:if>
								<c:if test="${'5' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											退货商品清单
										</label>
									</div>
								</c:if>
								<c:if test="${'6' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
										换货商品清单
										</label>
									</div>
								</c:if>
								<c:if test="${'7' eq childOrder.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
											同码换货商品清单
										</label>
									</div>
								</c:if>
					
						<div class="panel panel-default" id="all-device-detail">
							<c:if test="${'1' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										<c:if test="${'goodsOrder' eq childOrder.proType }">
											产品级线上发货清单
										</c:if>
										<c:if test="${'storeOrder' eq childOrder.proType }">
											门店级线上发货清单
										</c:if>
										<c:if test="${'tianheOrder' eq childOrder.proType }">
											天和级线上发货清单
										</c:if>
										<c:if test="${'otherOrder' eq childOrder.proType }">
											无活动线上发货清单
										</c:if>
									</h5>
								</div>
							</c:if>
							<c:if test="${'3' eq childOrder.type && '7' ne childOrder.state}">
								<div class="panel-heading">
									<h5>
										换购商品清单（实付款：${childOrder.onePayMoney}）
									</h5>
								</div>
							</c:if>
							<c:if test="${'4' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										<c:if test="${'goodsOrder' eq childOrder.proType }">
											产品级预约发货清单
										</c:if>
										<c:if test="${'storeOrder' eq childOrder.proType }">
											门店级预约发货清单
										</c:if>
										<c:if test="${'tianheOrder' eq childOrder.proType }">
											天和级预约发货清单
										</c:if>
										<c:if test="${'otherOrder' eq childOrder.proType }">
											无活动预约发货清单
										</c:if>
										<c:if test="${'nullOrder' eq childOrder.proType }">
											<c:if test="${empty model.subUserType }">
												非会员订单
											</c:if>
											<c:if test="${not empty model.subUserType }">
												讲价优惠清单
											</c:if>
										</c:if>
									</h5>
								</div>
							</c:if>
							<c:if test="${'5' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										退货商品清单 （实付款：${childOrder.onePayMoney}）
									</h5>
								</div>
							</c:if>
							<c:if test="${'6' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										换货商品清单（实付款：${childOrder.onePayMoney}）
									</h5>
								</div>
							</c:if>
							<c:if test="${'7' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										同码换货商品清单
									</h5>
								</div>
							</c:if>
							
							<c:if test="${'2' eq childOrder.type }">
								<div class="panel-heading">
									<h5>
										<c:if test="${'goodsOrder' eq childOrder.proType }">
											产品级活动清单
										</c:if>
										<c:if test="${'storeOrder' eq childOrder.proType }">
											门店级活动清单
										</c:if>
										<c:if test="${'tianheOrder' eq childOrder.proType }">
											天和级活动清单
										</c:if>
										<c:if test="${'otherOrder' eq childOrder.proType }">
											无活动清单
										</c:if>
										<c:if test="${'nullOrder' eq childOrder.proType }">
											<c:if test="${empty model.subUserType }">
												非会员订单
											</c:if>
											<c:if test="${not empty model.subUserType }">
												讲价优惠清单
											</c:if>
										</c:if>
									</h5>
								</div>
								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">商品售价</th>
											<th class="text-center">优惠价</th>
											<th class="text-center">实售价</th>
										</tr>
									</thead>
									<tbody >
									<c:set value="1" var="index"/>
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods" >
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" >
												<tr >
													<td class="text-center" >${index} 
													<c:set value="${index + 1 }" var="index"/>
													</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
															${oGQ.qrcode.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${orderGoods.price } / 件</td>
													<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
													<td class="text-center" >${orderGoods.salesPrice } / 件</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'1' eq childOrder.type }">
								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">商品售价</th>
											<th class="text-center">优惠价</th>
											<th class="text-center">实售价</th>
										</tr>
									</thead>
									<tbody >
									<c:set value="1" var="index"/>
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods" >
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" >
												<tr >
													<td class="text-center" >${index} 
													<c:set value="${index + 1 }" var="index"/>
													</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
															${oGQ.qrcode.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${orderGoods.price } / 件</td>
													<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
													<td class="text-center" >${orderGoods.salesPrice } / 件</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'3' eq childOrder.type && '7' ne childOrder.state}">
								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">商品售价</th>
											<th class="text-center">优惠价</th>
											<th class="text-center">实售价</th>
										</tr>
									</thead>
									<tbody >
									<c:set value="1" var="index"/>
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods" >
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" >
												<tr >
													<td class="text-center" >${index} 
													<c:set value="${index + 1 }" var="index"/>
													</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
															${oGQ.qrcode.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${orderGoods.price } / 件</td>
													<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
													<td class="text-center" >${orderGoods.salesPrice } / 件</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'4' eq childOrder.type }">
								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">商品售价</th>
											<th class="text-center">优惠价</th>
											<th class="text-center">实售价</th>
										</tr>
									</thead>
									<tbody >
									<c:set value="1" var="index"/>
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods" >
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" >
												<tr >
													<td class="text-center" >${index} 
													<c:set value="${index + 1 }" var="index"/>
													</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
															${oGQ.qrcode.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${orderGoods.price } / 件</td>
													<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
													<td class="text-center" >${orderGoods.salesPrice } / 件</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'5' eq childOrder.type }">
								<table class="table table-striped table-hover table-bordered text-center"
									id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">现存仓库</th>
											<th class="text-center">退货价格</th>
										</tr>
									</thead>
									<tbody >
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
											<c:if test="${'2' eq orderGoods.type}">
												<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
													<tr >
														<td class="text-center" >${(i.index+1)}</td>
														<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goods.goodsCode }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goodsCode }
															</c:if>
														</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.goods.name }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.name }
															</c:if>
														</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
																空
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
																${oGQ.qrcode.goods.other_attr_value }
															</c:if>
														</td>
														<td class="text-center" >${oGQ.qrcode.storage.name }</td>
														<td class="text-center" >${orderGoods.salesPrice }</td>
													</tr>
												</c:forEach>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'6' eq childOrder.type }">
								<table class="table table-striped table-hover table-bordered text-center"
									id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">现存仓库</th>
											<th class="text-center">换货价格</th>
										</tr>
									</thead>
									<tbody >
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
											<c:if test="${'2' eq orderGoods.type}">
												<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
													<tr >
														<td class="text-center" >${(i.index+1)}</td>
														<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goods.goodsCode }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goodsCode }
															</c:if>
														</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.goods.name }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.name }
															</c:if>
														</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
																空
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
																${oGQ.qrcode.goods.other_attr_value }
															</c:if>
														</td>
														<td class="text-center" >${oGQ.qrcode.storage.name }</td>
														<td class="text-center" >${orderGoods.salesPrice }</td>
													</tr>
												</c:forEach>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>换货商品</h5>
								</div>
					
								<table class="table table-striped table-hover table-bordered text-center"
									id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
											<th class="text-center">商品价格</th>
											<th class="text-center">换货价格</th>
											<th class="text-center">优惠价格</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
											<c:if test="${'1' eq orderGoods.type}">
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="j">
												<tr >
													<td class="text-center" >${(j.index+1)}</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
															空
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
															${oGQ.qrcode.goods.other_attr_value }
														</c:if>
													</td>
													<td class="text-center" >${ orderGoods.price } / 件</td>
													<td class="text-center" >${ orderGoods.salesPrice } / 件</td>
													<td class="text-center" >${ orderGoods.subMoneyOne} / 件</td>
												</tr>
											</c:forEach>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							
							<c:if test="${'7' eq childOrder.type }">
								<table class="table table-striped table-hover table-bordered text-center"
									id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
										</tr>
									</thead>
									<tbody >
										<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
											<c:if test="${'2' eq orderGoods.type}">
												<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
													<tr >
														<td class="text-center" >${(i.index+1)}</td>
														<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goods.goodsCode }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
																${oGQ.qrcode.goods.goodsCode }
															</c:if>
														</td>
														<td class="text-center" >
															<c:if test="${empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.goods.name }
															</c:if>
															<c:if test="${not empty oGQ.qrcode.goods.name }">
																${oGQ.qrcode.goods.name }
															</c:if>
														</td>
														<td class="text-center" >${oGQ.qrcode.goods.other_attr_value }</td>
													</tr>
												</c:forEach>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>换货商品</h5>
								</div>
					
								<table class="table table-striped table-hover table-bordered text-center"
									id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">序号</th>
											<th class="text-center">商品条码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">商品属性</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${childOrder.orderGoodList}" var="orderGoods">
											<c:if test="${'1' eq orderGoods.type}">
											<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="j">
												<tr >
													<td class="text-center" >${(j.index+1)}</td>
													<td class="text-center" ><c:if test="${empty oGQ.qrcode.id }">----</c:if>${oGQ.qrcode.id }</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goods.goodsCode }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
															${oGQ.qrcode.goods.goodsCode }
														</c:if>
													</td>
													<td class="text-center" >
														<c:if test="${empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.goods.name }
														</c:if>
														<c:if test="${not empty oGQ.qrcode.goods.name }">
															${oGQ.qrcode.goods.name }
														</c:if>
													</td>
													<td class="text-center" >${oGQ.qrcode.goods.other_attr_value }</td>
												</tr>
											</c:forEach>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
					</c:forEach>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">订单活动记录</label>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>活动记录</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="promotion_table" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">活动名称</th>
									<th class="text-center">活动详情</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${model.orderList }" var="order">
									<c:forEach items="${order.orderGoodList }" var="orderGoods">
										<c:if test="${not empty orderGoods.orderSubremark }">
											<tr data_id="${orderGoods.orderSubremark.promotion.id }">
												<td class="text-center" >${orderGoods.orderSubremark.promotion.typeValue}(${orderGoods.orderSubremark.promotion.promotionGroup.scopeValue})</td>
												<td class="text-center" >
													<c:if test="${'11' eq orderGoods.orderSubremark.promotion.type}">
														折扣为${orderGoods.orderSubremark.promotion.otherPro1}%
													</c:if>
													<c:if test="${'10' eq orderGoods.orderSubremark.promotion.type}">
														第二件折扣为${orderGoods.orderSubremark.promotion.otherPro1}%
													</c:if>
													<c:if test="${'4' eq orderGoods.orderSubremark.promotion.type}">
														特价为${orderGoods.orderSubremark.promotion.otherPro1}
													</c:if>
													<c:if test="${'5' eq orderGoods.orderSubremark.promotion.type}">
														两件特价折扣为${orderGoods.orderSubremark.promotion.otherPro1}%,${orderGoods.orderSubremark.promotion.otherPro2}%
													</c:if>
													<c:if test="${'6' eq orderGoods.orderSubremark.promotion.type}">
														前三件特价折扣为${orderGoods.orderSubremark.promotion.otherPro1}%,${orderGoods.orderSubremark.promotion.otherPro2}%,${orderSubremark.promotion.otherPro3}%
													</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${not empty orderGoods.orderSubremark.promotionLadder}">
											<tr data_id="${orderGoods.orderSubremark.promotionLadder.id }">
												<td class="text-center" >${orderGoods.orderSubremark.promotionLadder.promotion.typeValue}(${orderGoods.orderSubremark.promotionLadder.promotion.promotionGroup.scopeValue})</td>
												<td class="text-center" >
													<c:if test="${'1' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,折扣${orderGoods.orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'2' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,减${orderGoods.orderSubremark.promotionLadder.promotionMoney }元
													</c:if>
													<c:if test="${'3' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,返${orderGoods.orderSubremark.promotionLadder.promotionMoney }元
													</c:if>
													<c:if test="${'7' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,送${orderGoods.orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'8' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														买${orderGoods.orderSubremark.promotionLadder.goodsNumberBuy }个,送${orderGoods.orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'9' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,加${orderGoods.orderSubremark.promotionLadder.goodsPrice },换${orderSubremark.promotionLadder.goods.name }
													</c:if>
												</td>
											</tr>
										</c:if>
									</c:forEach>
									<c:if test="${not empty order.orderSubremarkList }">
										<c:forEach items="${order.orderSubremarkList }" var="orderSubremark">
											<c:if test="${not empty orderSubremark.promotion}">
												<tr data_id="${orderSubremark.promotion.id }">
													<td class="text-center" >${orderSubremark.promotion.typeValue}(${orderSubremark.promotion.promotionGroup.scopeValue})</td>
													<td class="text-center" >
														<c:if test="${'11' eq orderSubremark.promotion.type}">
															折扣为${orderSubremark.promotion.otherPro1}%
														</c:if>
														<c:if test="${'10' eq orderSubremark.promotion.type}">
															第二件折扣为${orderSubremark.promotion.otherPro1}%
														</c:if>
														<c:if test="${'4' eq orderSubremark.promotion.type}">
															特价为${orderSubremark.promotion.otherPro1}
														</c:if>
														<c:if test="${'5' eq orderSubremark.promotion.type}">
															两件特价折扣为${orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%
														</c:if>
														<c:if test="${'6' eq orderSubremark.promotion.type}">
															前三件特价折扣为${orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%,${orderSubremark.promotion.otherPro3}%
														</c:if>
													</td>
												</tr>
											</c:if>
											<c:if test="${not empty orderSubremark.promotionLadder}">
												<tr data_id="${orderSubremark.promotionLadder.id }">
													<td class="text-center" >${orderSubremark.promotionLadder.promotion.typeValue}(${orderSubremark.promotionLadder.promotion.promotionGroup.scopeValue})</td>
													<td class="text-center" >
														<c:if test="${'1' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,折扣${orderSubremark.promotionLadder.promotionMoney }%
														</c:if>
														<c:if test="${'2' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,减${orderSubremark.promotionLadder.promotionMoney }元
														</c:if>
														<c:if test="${'3' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,返${orderSubremark.promotionLadder.promotionMoney }元
														</c:if>
														<c:if test="${'7' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
														</c:if>
														<c:if test="${'8' eq orderSubremark.promotionLadder.promotion.type}">
															买${orderSubremark.promotionLadder.goodsNumberBuy }个,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
														</c:if>
														<c:if test="${'9' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,加${orderSubremark.promotionLadder.goodsPrice },换${orderSubremark.promotionLadder.goods.name }
														</c:if>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
								<c:if test="${not empty model.orderSubremarkList }">
									<c:forEach items="${model.orderSubremarkList }" var="orderSubremark">
										<c:if test="${not empty orderSubremark.promotion}">
											<tr data_id="${orderSubremark.promotion.id }">
												<td class="text-center" >${orderSubremark.promotion.typeValue}(${orderSubremark.promotion.promotionGroup.scopeValue})</td>
												<td class="text-center" >
													<c:if test="${'11' eq orderSubremark.promotion.type}">
														折扣为${orderSubremark.promotion.otherPro1}%
													</c:if>
													<c:if test="${'10' eq orderSubremark.promotion.type}">
														第二件折扣为${orderSubremark.promotion.otherPro1}%
													</c:if>
													<c:if test="${'4' eq orderSubremark.promotion.type}">
														特价为${orderSubremark.promotion.otherPro1}
													</c:if>
													<c:if test="${'5' eq orderSubremark.promotion.type}">
														两件特价折扣为${orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%
													</c:if>
													<c:if test="${'6' eq orderSubremark.promotion.type}">
														前三件特价折扣为${orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%,${orderSubremark.promotion.otherPro3}%
													</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${not empty orderSubremark.promotionLadder}">
											<tr data_id="${orderSubremark.promotionLadder.id }">
												<td class="text-center" >${orderSubremark.promotionLadder.promotion.typeValue}(${orderSubremark.promotionLadder.promotion.promotionGroup.scopeValue})</td>
												<td class="text-center" >
													<c:if test="${'1' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,折扣${orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'2' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,减${orderSubremark.promotionLadder.promotionMoney }元
													</c:if>
													<c:if test="${'3' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,返${orderSubremark.promotionLadder.promotionMoney }元
													</c:if>
													<c:if test="${'7' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'8' eq orderSubremark.promotionLadder.promotion.type}">
														买${orderSubremark.promotionLadder.goodsNumberBuy }个,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'9' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,加${orderSubremark.promotionLadder.goodsPrice },换${orderSubremark.promotionLadder.goods.name }
													</c:if>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>

					<c:if test="${not empty putOutQrcodeList }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">赠品领取明细</label>
						</div>

						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>赠品领取明细</h5>
							</div>

							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">商品二维码</th>
										<th class="text-center">商品编号</th>
										<th class="text-center">商品名称</th>
										<th class="text-center">数量</th>
									</tr>
								</thead>
								<tbody id="putout_qrcode_all">
									<c:forEach items="${putOutQrcodeList }" var="qrcode">
										<tr>
											<td id="qrcode_id">${qrcode.id }</td>
											<td id="goodsCode">${qrcode.goods.goodsCode }<c:if test="${empty qrcode.goods.goodsCode }">${qrcode.goods.goods.goodsCode }</c:if></td>
											<td id="goodsName">${qrcode.goods.name }<c:if test="${empty qrcode.goods.name }">${qrcode.goods.goods.name }</c:if></td>
											<td>1</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券使用明细</label>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>电子券列表</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">电子券编号</th>
									<th class="text-center">电子券名称</th>
									<th class="text-center">抵扣金额</th>
									<th class="text-center">获得时间</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${model.orderList }" var="order_">
									<c:forEach items="${order_.eticketUseRecordList }" var="eticketUseRecord">
										<tr>
											<td class="text-center">${eticketUseRecord.eticketOutRecord.code }</td>
											<td class="text-center">${eticketUseRecord.eticketOutRecord.eticket.name }</td>
											<td class="text-center">${eticketUseRecord.eticketOutRecord.eticket.price }</td>
											<td class="text-center"><fmt:formatDate value="${eticketUseRecord.eticketOutRecord.createDate }" pattern="yyyy-MM-dd"/></td>
										</tr>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var promotion_table_tr_data_id_array = [];
		$(function(){
			$("#promotion_table tbody tr").each(function(){
				var value = $(this).attr("data_id");
				if(null != promotion_table_tr_data_id_array && 0 <= $.inArray(value, promotion_table_tr_data_id_array)){
					$(this).hide();
				} else {
					promotion_table_tr_data_id_array.push(value);
				}
			});
			$(".panel.panel-default").each(function(){
				if("" == $(this).html().trim())
					$(this).hide();
			})
		});
	</script>
</body>
</html>
