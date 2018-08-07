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
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">商品统计</label>
				</div>
				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>商品统计</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">商品数量</th>
							</tr>
						</thead>
						<tbody id="goodsCount_All">
							<c:forEach items="${qrcodeGoodsList}" var="qrcodeGoods" varStatus="j">
								<c:if test="${empty qrcodeGoods.goods.name}">
									<tr>
										<td class="text-center" id="goods_number">${j.index + 1 }</td>
										<td class="text-center" id="goods_goodsCode">${qrcodeGoods.goods.goods.goodsCode }</td>
										<td class="text-center" id="goods_name">${qrcodeGoods.goods.goods.name }</td>
										<td class="text-center" id="goods_other_attr_value">
											<c:if test="${'' eq qrcodeGoods.goods.other_attr_value}">
												空
											</c:if>
											<c:if test="${'' ne qrcodeGoods.goods.other_attr_value}">
												${qrcodeGoods.goods.other_attr_value}
											</c:if>
										</td>
										<td class="text-center" id="goods_qrcodeCount">${qrcodeGoods.qrcodeCount}</td>
									</tr>
								</c:if>
								<c:if test="${not empty qrcodeGoods.goods.name}">
									<tr>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="goods_id" value="${qrcodeGoods.goods.id}" >
										</td>
										<td class="text-center" id="goods_number">${j.index + 1 }</td>
										<td class="text-center" id="goods_goodsCode">${qrcodeGoods.goods.goodsCode }</td>
										<td class="text-center" id="goods_name">${qrcodeGoods.goods.name }</td>
										<td class="text-center" id="goods_other_attr_value">
											<c:if test="${'' eq qrcodeGoods.goods.other_attr_value}">
												空
											</c:if>
											<c:if test="${'' ne qrcodeGoods.goods.other_attr_value}">
												${qrcodeGoods.goods.other_attr_value}
											</c:if>
										</td>
										<td class="text-center" id="goods_qrcodeCount">${qrcodeGoods.qrcodeCount}</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">调库商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>库存调拨</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">二维码</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">现所存库</th>
								<th class="text-center">商品进价</th>
								<th class="text-center">商品流向</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${qrcodeVOList}" var="qrcodeVO" varStatus="i">
								<tr>
									<td class="text-center" id="qrcode_number">${i.index + 1 }</td>
									<td class="text-center" id="qrcode_goods_goodsCode">${qrcodeVO.id }</td>
									<td class="text-center" id="qrcode_goods_name">${qrcodeVO.goodsName }</td>
									<td class="text-center" id="qrcode_goods_other_attr_value">${qrcodeVO.other_attr_value}</td>
									<td class="text-center" id="qrcode_storage_name">${qrcodeVO.storageName}</td>
									<td class="text-center" id="qrcode_procurementPrice">${qrcodeVO.procurementPrice}</td>
									<td class="text-center" id="qrcode_logistics">${qrcodeVO.logistics}</td>
								</tr>
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
</body>
</html>
