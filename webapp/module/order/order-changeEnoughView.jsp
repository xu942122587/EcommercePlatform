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

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">订单金额</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span><fmt:formatNumber value="${model.sumMoney }" pattern="#,###.##"/></span>元</div>

						<label for="product-uuid" class="col-xs-2 control-label">合计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><span ><fmt:formatNumber value="${model.payMoney }" pattern="#,###.##"/></span>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
							换购单详情
						</label>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>换购清单</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">序号</th>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<th class="text-center">商品售价</th>
									<th class="text-center">优惠价</th>
									<th class="text-center">实售价</th>
									<th class="text-center">数量</th>
								</tr>
							</thead>
							<tbody >
							<c:set value="1" var="index"/>
								<c:forEach items="${model.orderGoodList }" var="orderGoods" varStatus="j">
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
										<td class="text-center" >${orderGoods.price }</td>
										<td class="text-center" >${orderGoods.subMoneyOne }</td>
										<td class="text-center" >${orderGoods.salesPrice }</td>
										<td class="text-center" >${orderGoods.count }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
							换购单发货详情
						</label>
					</div>

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
							<c:set value="1" var="index"/>
								<c:forEach items="${model.orderGoodList }" var="orderGoods" >
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
											<td class="text-center" >${orderGoods.price }</td>
											<td class="text-center" >${orderGoods.subMoneyOne }</td>
											<td class="text-center" >${orderGoods.salesPrice }</td>
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
</body>
</html>
