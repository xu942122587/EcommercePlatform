<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.brand.view");
	com.yunt.brand.view = {
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
						<label for="product-uuid" class="col-xs-3 control-label">品牌名称</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">品牌网址</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.brandHttpURI }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">品牌描述</label>
						<div class="col-xs-6" style="padding-top: 7px;">${model.content }</div>
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
