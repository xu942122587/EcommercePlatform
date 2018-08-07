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
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.vende.name }</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">银行账户</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.vende.bankCardNum }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商负责人</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.vende.chargeName }</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">供应商负责人电话</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.vende.chargePhone }</div>
					</div>
	
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.store.name }</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.store.storeCode }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">状态</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.stateValue }</div>
	
						<c:if test="${'5' eq model.state }">
							<label for="product-uuid" class="col-xs-2 control-label">不通过原因</label>
							<div class="col-xs-3" style="padding-top:7px;">${model.checkRemark }</div>
						</c:if>
					</div>
	
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">采购申请件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber value="${model.count }" pattern="#,###"/>件</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">采购申请金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.sumMoney }" pattern="#,##0.00"/>元</div>
					</div>
	
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">采购到货件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber value="${model.buyCount }" pattern="#,###"/>件</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">采购到货金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.buySumMoney }" pattern="#,##0.00"/>元</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8" style="padding-top:7px;">${model.remark }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">收发商品</label>
					</div>
					
					<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">产品吊牌价</th>
								<th class="text-center">采购折扣</th>
								<th class="text-center">采购单价</th>
								<th class="text-center">销售折扣</th>
								<th class="text-center">销售单价</th>
								<th class="text-center">采购申请数量</th>
								<th class="text-center">采购到货数量</th>
								<th class="text-center">打印数量</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${model.procurementGoodsList}" var="procurementGoods" varStatus="j">
								<tr >
									<td class="text-center" >${j.index + 1 }</td>
									<td class="text-center" >
										<c:if test="${empty procurementGoods.goods.goodsCode}">
											${procurementGoods.goods.goods.goodsCode }
										</c:if>
										<c:if test="${not empty procurementGoods.goods.goodsCode}">
											${procurementGoods.goods.goodsCode }
										</c:if>
									</td>
									<td class="text-center" >
										<c:if test="${empty procurementGoods.goods.name}">
											${procurementGoods.goods.goods.name }
										</c:if>
										<c:if test="${not empty procurementGoods.goods.name}">
											${procurementGoods.goods.name }
										</c:if>
										<c:if test="${not empty procurementGoods.goods.other_attr_value }">
											${procurementGoods.goods.other_attr_value }
										</c:if>
									</td>
									<td class="text-center" >${procurementGoods.goods.other_attr_value}</td>
									<td class="text-center" >${procurementGoods.goodsPrice}</td>
									<td class="text-center" ><c:if test="${empty procurementGoods.buyAgio }">----</c:if><c:if test="${not empty procurementGoods.buyAgio }">${procurementGoods.buyAgio}%</c:if></td>
									<td class="text-center" >${procurementGoods.buyPrice}</td>
									<td class="text-center" ><c:if test="${empty procurementGoods.salseAgio }">----</c:if><c:if test="${not empty procurementGoods.salseAgio }">${procurementGoods.salseAgio}%</c:if></td>
									<td class="text-center" >${procurementGoods.salseMoney}</td>
									<td class="text-center" >${procurementGoods.count}</td>
									<td class="text-center" >${procurementGoods.buyCount}</td>
									<td class="text-center" >${procurementGoods.printCount}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
