<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<style type="text/css">
.placehold::-webkit-input-placeholder {
	font-weight: 600;
	font-size: 8px;
}

.placehold::-moz-placeholder {
	font-weight: 600;
	font-size: 14px;
}

.placehold::-ms-placeholder {
	font-weight: 600;
	font-size: 14px;
}

.placehold::placeholder {
	font-weight: 600;
	font-size: 14px;
}
</style>
</head>
	<script type="text/javascript">
		var goods_count = 0;
		var all_goods_count = 0;
	</script>
<body>
	<!--new device from begin-->
	<div class="row" style="">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;" class="form-horizontal" id="theForm"
					role="form" method="POST" data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid"
							class="col-xs-12 control-label lantiao_lable">子产品库存</label>
					</div>

					<table
						class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">编码</th>
								<th class="text-center">名称</th>
								<th class="text-center">库存</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${goodsChildInventoryList}" var="goodsChildInventory"
								varStatus="i">
								<!-- 系统管理员 -->
								<tr>
									<td class="text-center">${goods.goodsCode}</td>
									<td class="text-center">
										${goods.name}--${goodsChildInventory.goods.other_attr_value}
									</td>
									<td class="text-center">${goodsChildInventory.count}</td>
								</tr>
								<script type="text/javascript">
									goods_count = ${goodsChildInventory.count} - 0;
									all_goods_count += goods_count;
								</script>
							</c:forEach>
						</tbody>
					</table>
								<script type="text/javascript">
									$("#all_goods_count").html($("#all_goods_count").html()+all_goods_count);
								</script>
					<div class="form-group">
						<label for="product-uuid"
							class="col-xs-12 control-label" style="font-size: 20px;font-weight: bold;" id="all_goods_count">库存总和:</label>
					</div>
					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default"
							onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
