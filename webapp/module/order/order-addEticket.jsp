<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.saleOrderInput");
	com.yunt.order.saleOrderInput = {
		submit : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/order/bindNoScopeGroup?orderId=${model.id}",
						data : null,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								window.open('${path}/order/salePrintView?id=${model.id}');
								com.yunt.index.toPreIndex();
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
</script>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.order.saleOrderInput.submit()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>
					<input type="hidden" value="${user.store.id }" name="model.store.id"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
							添加电子券
						</label>
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
						<div class="col-xs-3" style="padding-top:7px;">${model.store.name }</div>
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

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">订单金额</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span><fmt:formatNumber value="${model.sumMoney }" pattern="#,###.##"/></span>元</div>

						<label for="product-uuid" class="col-xs-2 control-label">订单优惠金额</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.subMoney }" pattern="#,###.##"/></span>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">合计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.payMoney }" pattern="#,###.##"/></span>元</div>
					</div>

					<c:if test="${'4' eq model.type || '1' eq model.type }">
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
								<h5>预约清单</h5>
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
								<tbody>
									<c:set value="1" var="index"/>
									<c:forEach items="${model.orderList }" var="order">
										<c:forEach items="${order.orderGoodList }" var="orderGoods" varStatus="j">
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
												<td class="text-center" >${orderGoods.count } 件</td>
											</tr>
										</c:forEach>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
								<c:if test="${'4' eq model.type }">
									预约发货详情
								</c:if>
								<c:if test="${'1' eq model.type }">
									订单发货详情
								</c:if>
							</label>
						</div>
					</c:if>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>商品清单</h5>
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
									<th class="text-center">商品售价</th>
									<th class="text-center">优惠价</th>
									<th class="text-center">实售价</th>
								</tr>
							</thead>
							<tbody >
								<c:set value="1" var="index_"/>
								<c:forEach items="${model.orderList }" var="order">
									<c:forEach items="${order.orderGoodList }" var="orderGoods" varStatus="j">
										<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
											<tr >
												<td class="text-center" >${index_} 
												<c:set value="${index_ + 1 }" var="index_"/>
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
														----
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
								</c:forEach>
							</tbody>
						</table>
					</div>

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
														两件特价折扣为${orderGoods.orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%
													</c:if>
													<c:if test="${'6' eq orderGoods.orderSubremark.promotion.type}">
														前三件特价折扣为${orderGoods.orderSubremark.promotion.otherPro1}%,${orderSubremark.promotion.otherPro2}%,${orderSubremark.promotion.otherPro3}%
													</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${not empty orderGoods.orderSubremark.promotionLadder}">
											<tr data_id="${orderGoods.orderSubremark.promotionLadder.id }">
												<td class="text-center" >${orderGoods.orderSubremark.promotionLadder.promotion.typeValue}(${orderGoods.orderSubremark.promotionLadder.promotion.promotionGroup.scopeValue})</td>
												<td class="text-center" >
													<c:if test="${'1' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,折扣${orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'2' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,减${orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'3' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,返${orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'7' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'8' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														买${orderGoods.orderSubremark.promotionLadder.goodsNumberBuy }个,送${orderSubremark.promotionLadder.goods.name },${orderSubremark.promotionLadder.goodsNumber }个
													</c:if>
													<c:if test="${'9' eq orderGoods.orderSubremark.promotionLadder.promotion.type}">
														满${orderGoods.orderSubremark.promotionLadder.ladderStart }元,加${orderSubremark.promotionLadder.goodsPrice },换${orderSubremark.promotionLadder.goods.name }
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
															满${orderSubremark.promotionLadder.ladderStart }元,减${orderSubremark.promotionLadder.promotionMoney }%
														</c:if>
														<c:if test="${'3' eq orderSubremark.promotionLadder.promotion.type}">
															满${orderSubremark.promotionLadder.ladderStart }元,返${orderSubremark.promotionLadder.promotionMoney }%
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
														满${orderSubremark.promotionLadder.ladderStart }元,减${orderSubremark.promotionLadder.promotionMoney }%
													</c:if>
													<c:if test="${'3' eq orderSubremark.promotionLadder.promotion.type}">
														满${orderSubremark.promotionLadder.ladderStart }元,返${orderSubremark.promotionLadder.promotionMoney }%
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

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券使用明细</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">添加电子券</label>
						<div class="col-xs-4">
							<input type="text" value="" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="search_input" placeholder="电子券二维码扫码框~"/>
						</div>
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
							<tbody id="eticket_all">
								<tr id="eticket_one_copy" style="display: none;">
									<td class="text-center" id="eticket_code_td"></td>
									<td class="text-center" id="eticket_name_td"></td>
									<td class="text-center" id="eticket_price_td"></td>
									<td class="text-center" id="eticket_time_td"></td>
								</tr>
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

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control" name="model.remark" />
						</div>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var eticket_code_test = /^[0-9]{18,32}$/,
			eticket_index = 0;
		/**
		 * 添加电子券tr
		 */
		function add_eticket_tr(search_input_value){
			$.ajax({
				url : "${path}/order/bindEticket?orderId=${model.id}&eticketOutCode=" + search_input_value,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var eticket_one = $("#eticket_one_copy").clone();
						eticket_one.find("#eticket_code_td").html(data.obj.code);
						eticket_one.find("#eticket_name_td").html(data.obj.eticket.name);
						eticket_one.find("#eticket_price_td").html(data.obj.eticket.price);
						eticket_one.find("#eticket_time_td").html(data.obj.createDateString);
						eticket_one.removeAttr("id");
						$("#eticket_all").append(eticket_one.show());
						eticket_index++;
						bootstrapValidator_again();
					}else{
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});
		}
		/**
		 * 二维码扫码框监听
		 */
		$('#search_input').bind('keyup', function(event) {
			var search_input_value="";
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input").val().trim();
				$("#search_input").val("");
				if(eticket_code_test.test(search_input_value)){
					var isNeedAdd = true;
					$("#eticket_all tr:not(:hidden)").each(function(){
						if($(this).find("#eticket_code_td").html() == search_input_value){
							isNeedAdd = false;
							// 退出循环
							return;
						}
					})
					if(!isNeedAdd){
						toastr.error("本电子券已经添加过了哦~换一个添加吧~");
						return false;
					}
					// 添加电子券节点
					add_eticket_tr(search_input_value);
				}else{
					toastr.error("无法识别的信息");
				}
			}
		});
		/**
		 * 重新初始化验证
		 */
		function bootstrapValidator_again() {
			$(".form-control-feedback").remove();
			$(".help-block").remove();
			$('#theForm').data('bootstrapValidator', null);
			$('#theForm').bootstrapValidator('resetForm', false);
			$('#theForm').bootstrapValidator();//初始化验证
		}
		var promotion_table_tr_data_id_array = [];
		$(function() {
			$('#theForm').bootstrapValidator();//初始化验证
			$("#promotion_table tbody tr").each(function(){
				var value = $(this).attr("data_id");
				if(null != promotion_table_tr_data_id_array && 0 <= $.inArray(value, promotion_table_tr_data_id_array)){
					$(this).hide();
				} else {
					promotion_table_tr_data_id_array.push(value);
				}
			});
		});
		/**
		 * 去掉页面所有的input的回车监听
		 */
		$(document).on('keyup','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		}).on('keypress','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		}).on('keydown','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		});
	</script>
</body>
</html>
