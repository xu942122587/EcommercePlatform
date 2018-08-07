<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.store.view");
	com.yunt.store.view = {
	};
</script>
<style type="text/css">

.placehold::-webkit-input-placeholder {font-weight: 600;font-size:8px; }
.placehold::-moz-placeholder {font-weight: 600;font-size:14px; }
.placehold::-ms-placeholder {font-weight: 600;font-size:14px; }
.placehold::placeholder {font-weight: 600;font-size:14px; }

</style>
</head>
<body> 
	<div class="row">
		<div class="col-xs-12 display">
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
				
				<c:if test="${'1' eq type }">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">采购件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber value="${model.buyCount }" pattern="#,###"/>件</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">采购金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.buySumMoney }" pattern="#,###.##"/>元</div>
					</div>
				</c:if>
				
				<c:if test="${'2' eq type }">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">退货件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber value="${model.buyCount }" pattern="#,###"/>件</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">退货金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.buySumMoney }" pattern="#,###.##"/>元</div>
					</div>
				</c:if>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">备注</label>
					<div class="col-xs-8" style="padding-top:7px;">${model.remark }</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">收发商品</label>
				</div>
				<c:if test="${'2' eq type }">
					<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">最后存库</th>
								<th class="text-center">商品进价</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${qrcodeVOList}" var="qrcodeVO" varStatus="i">
								<tr >
									<td class="text-center" id="qrcode_number">${i.index + 1 }</td>
									<td class="text-center" id="qrcode_goods_goodsCode">${qrcodeVO.goodsCode }</td>
									<td class="text-center" id="qrcode_goods_name">${qrcodeVO.goodsName }</td>
									<td class="text-center" id="qrcode_goods_other_attr_value">${qrcodeVO.other_attr_value}</td>
									<td class="text-center" id="qrcode_storage_name">${qrcodeVO.storageName}</td>
									<td class="text-center" id="qrcode_procurementPrice">${qrcodeVO.procurementPrice}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<c:if test="${'1' eq type}">
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
								<th class="text-center">采购到货数量</th>
								<th class="text-center">打印数量</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${procurementGoodsList}" var="procurementGoods" varStatus="j">
								<tr >
									<td class="text-center" >${i.index + 1 }</td>
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
									</td>
									<td class="text-center" >${procurementGoods.goods.other_attr_value}</td>
									<td class="text-center" >${procurementGoods.goodsPrice}</td>
									<td class="text-center" >${procurementGoods.buyAgio}</td>
									<td class="text-center" >${procurementGoods.buyPrice}</td>
									<td class="text-center" >${procurementGoods.buyCount}</td>
									<td class="text-center" >${procurementGoods.printCount}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<div class="form-group col-xs-8 pull-right">
					<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
