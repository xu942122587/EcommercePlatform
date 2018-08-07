<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	var isAlert = true;
	Namespace.register("com.yunt.eticket.view");
	com.yunt.eticket.view = {
	};
	$(function() {
	});
</script>
<style type="text/css">
</style>
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
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">电子券名称:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.name }
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">发放方式:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.outTypeValue }
						</div>
					</div>

					<c:if test="${'2' eq model.outType }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-3 control-label">电子券发放阀值:</label>
							<div class="col-xs-2" style="padding-top:7px;">
								满<fmt:formatNumber value="${model.outLimit }" pattern="#,###.##"/>元发放
							</div>

							<c:if test="${not empty model.outStore.name }">
								<label for="product-uuid" class="col-xs-2 control-label">发放门店:</label>
								<div class="col-xs-2" style="padding-top:7px;">
									${model.outStore.name }
								</div>
							</c:if>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">电子券有效期:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.dateLimit }天
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券价值:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							<fmt:formatNumber value="${model.price }" pattern="#,###.##"/>元
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">类型:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.typeValue }
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券使用阀值:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							满<fmt:formatNumber value="${model.useLimit }" pattern="#,###.##"/>元可用
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">发放截止时间:</label>
						<div class="col-xs-2" style="padding-top:7px;">
							<fmt:formatDate value="${model.stopSendTime}" pattern="yyyy-MM-dd HH:mm:ss" />
						</div>

						<c:if test="${not empty model.useStore.name }">
							<label for="product-uuid" class="col-xs-2 control-label">电子券可用门店:</label>
							<div class="col-xs-2" style="padding-top:7px;">
								${model.useStore.name } 店内订单可用
							</div>
						</c:if>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
