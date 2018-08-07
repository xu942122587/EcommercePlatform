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
	$(function(){
		var old_sumMoney = 0;
		var old_sumPayMoney = 0;
		var old_sumSubMoney = 0;
		<c:forEach items="${orderGoodsList }" var="orderGoods">
			<c:if test="${'2' eq orderGoods.type}">
				old_sumMoney += ${(orderGoods.price * orderGoods.count)};
				old_sumPayMoney += ${(orderGoods.price * orderGoods.count) - orderGoods.subMoney};
				old_sumSubMoney += ${orderGoods.subMoney};
			</c:if>
		</c:forEach>
		$("#old_sumMoney").html(old_sumMoney);
		$("#old_sumPayMoney").html(old_sumPayMoney);
		$("#old_sumSubMoney").html(old_sumSubMoney);
		
	})
	
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
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">赔偿单信息</label>
				</div>
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">赔偿单号</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>
					
					<label for="product-uuid" class="col-xs-2 control-label">导购编号</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.order.guideUser.username }</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.order.store.storeCode }</div>
					
					<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.order.store.name }</div>
				</div>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">客户名</label>
					<div class="col-xs-3" style="padding-top: 7px;">
						<c:if test="${empty model.order.customer.name}">
							空
						</c:if>
						<c:if test="${not empty model.order.customer.name}">
							${model.order.customer.name }
						</c:if>
					</div>

					<label for="product-uuid" class="col-xs-2 control-label">用户手机号</label>
					<div class="col-xs-3" style="padding-top:7px;">
						<c:if test="${empty model.order.customer.phone}">
							空
						</c:if>
						<c:if test="${not empty model.order.customer.phone}">
							${model.order.customer.phone }
						</c:if>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">赔偿商品</label>
				</div>
				
				<div class="panel panel-default" id="all-device-detail">
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">现存仓库</th>
								<th class="text-center">赔偿价格</th>
							</tr>
						</thead>
						<tbody >
							<c:forEach items="${model.orderGoodList }" var="orderGoods">
								<c:if test="${'1' eq orderGoods.type}">
									<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
										<tr >
											<td class="text-center" >${(i.index+1)}</td>
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
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">赔偿单金额统计</label>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label" style="font-size: 22px;color: #0AA0D9">赔偿单金额</label>
					<div class="col-xs-2" style="padding-top: 7px;"><span style="font-size: 24px;color: red;">${model.sumMoney }</span>元</div>
					
					<label for="product-uuid" class="col-xs-2 control-label" style="font-size: 22px;color: #0AA0D9">赔偿单优惠总金额</label>
					<div class="col-xs-2" style="padding-top: 7px;"><span style="font-size: 24px;color: red;">${model.subMoney }</span>元</div>
					
					<label for="product-uuid" class="col-xs-2 control-label" style="font-size: 22px;color: #0AA0D9">赔偿单付款金额</label>
					<div class="col-xs-2" style="padding-top: 7px;"><span style="font-size: 24px;color: red;">${model.payMoney }</span>元</div>
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
