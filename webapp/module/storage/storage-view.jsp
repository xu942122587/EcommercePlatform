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
						<label for="product-uuid" class="col-xs-3 control-label">名称</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">面积</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.acreage }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">负责人</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.chargeName }</div>

						<label for="product-uuid" class="col-xs-2 control-label">联系电话</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.chargePhone }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">状态</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.stateValue }</div>

						<label for="product-uuid" class="col-xs-2 control-label">所属门店</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.store.name }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">创建时间</label>
						<div class="col-xs-2" style="padding-top: 7px;"><fmt:formatDate value="${model.createTime }" pattern="yyyy-MM-dd"/></div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">备注</label>
						<div class="col-xs-6" style="padding-top: 7px;">${model.remark }</div>
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
