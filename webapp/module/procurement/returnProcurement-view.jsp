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
			<form onsubmit="return com.yunt.allocation.add.submitAllocation()"
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
					
					<label for="product-uuid" class="col-xs-2 control-label">备注</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.remark }</div>
				</div>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.store.name }</div>

					<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.store.storeCode }</div>
				</div>
				<c:if test="${'5' eq model.state }">
					<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">不通过原因</label>
							<div class="col-xs-8" style="padding-top:7px;">${model.checkRemark }</div>
					</div>
				</c:if>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">退货件数总计</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.buyCount }件</div>

					<label for="product-uuid" class="col-xs-2 control-label">退货金额总计</label>
					<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.buySumMoney }" pattern="#,###.##"/>元</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">退货产品</label>
				</div>

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
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_id" value="${qrcodeVO.id}" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="procurementQrcode_id" value="${qrcodeVO.procurementQrcodeId}" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_goods_id" value="${qrcodeVO.goodsId}" >
								</td>
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
				
				<div class="form-group col-xs-8 pull-right">
					<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
