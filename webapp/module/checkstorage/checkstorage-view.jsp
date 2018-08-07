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
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">盘库单信息</label>
				</div>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">盘库单号</label>
					<div class="col-xs-4" style="padding-top: 7px;">${model.code }</div>

					<label for="product-uuid" class="col-xs-2 control-label">盘库仓库</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.storage.name }</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">盘库门店</label>
					<div class="col-xs-4" style="padding-top: 7px;">${model.store.name}</div>

					<label for="product-uuid" class="col-xs-2 control-label">盘库状态</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.stateValue}</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">操作人</label>
					<div class="col-xs-4" style="padding-top: 7px;">${model.fu_user.name}</div>

					<label for="product-uuid" class="col-xs-2 control-label">盘库开始时间</label>
					<div class="col-xs-3" style="padding-top: 7px;">
						<fmt:formatDate value="${model.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">盘库完成时间</label>
					<div class="col-xs-4" style="padding-top: 7px;">
						<fmt:formatDate value="${model.checkDate}" pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">备注</label>
					<div class="col-xs-9" style="padding-top: 7px;">${model.remark }</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">盘库商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>库存盘点</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">盘点数量</th>
								<th class="text-center">盘点前数量</th>
								<th class="text-center">盈亏数量</th>
							</tr>
						</thead>
						<tbody id="checkstorageGoods_All">
							<c:forEach items="${checkstorageGoodsVOList}" var="checkstorageGoodsVO" varStatus="i">
								<c:if test="${0 eq checkstorageGoodsVO.profitNumber}">
									<tr>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorageGoods_id" value="${checkstorageGoodsVO.id}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_id" value="${checkstorageGoodsVO.checkstorageId}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_goods_id" value="${checkstorageGoodsVO.goodsId}" >
										</td>
										<td class="text-center" >${i.index + 1 }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsCode }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsName }</td>
										<td class="text-center" >${checkstorageGoodsVO.other_attr_value}</td>
										<td class="text-center" >${checkstorageGoodsVO.checkNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.inventoryNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.profitNumber}</td>
									</tr>
								</c:if>
								<c:if test="${0 gt checkstorageGoodsVO.profitNumber}">
									<tr style="color: red;">
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorageGoods_id" value="${checkstorageGoodsVO.id}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_id" value="${checkstorageGoodsVO.checkstorageId}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_goods_id" value="${checkstorageGoodsVO.goodsId}" >
										</td>
										<td class="text-center" >${i.index + 1 }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsCode }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsName }</td>
										<td class="text-center" >${checkstorageGoodsVO.other_attr_value}</td>
										<td class="text-center" >${checkstorageGoodsVO.checkNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.inventoryNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.profitNumber}</td>
									</tr>
								</c:if>
								<c:if test="${0 lt checkstorageGoodsVO.profitNumber}">
									<tr style="color: green;">
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorageGoods_id" value="${checkstorageGoodsVO.id}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_id" value="${checkstorageGoodsVO.checkstorageId}" >
										</td>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="checkstorage_goods_id" value="${checkstorageGoodsVO.goodsId}" >
										</td>
										<td class="text-center" >${i.index + 1 }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsCode }</td>
										<td class="text-center" >${checkstorageGoodsVO.goodsName }</td>
										<td class="text-center" >${checkstorageGoodsVO.other_attr_value}</td>
										<td class="text-center" >${checkstorageGoodsVO.checkNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.inventoryNumber}</td>
										<td class="text-center" >${checkstorageGoodsVO.profitNumber}</td>
									</tr>
								</c:if>
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
