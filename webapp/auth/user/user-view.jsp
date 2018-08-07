<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.user.view");
	com.yunt.user.view = {};
</script>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">姓名</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.name }</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">用户名</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.username }</div>
					</div>

					<div class="form-group">
						<label for="category-name" class="col-xs-4 control-label">角色</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.role.name }</div>
					</div>

					<c:if test="${not empty model.store.name }">
						<div class="form-group">
							<label for="category-name" class="col-xs-4 control-label">所属门店</label>
							<div class="col-xs-4" style="padding-top:7px;">${model.store.name}</div>
						</div>
					</c:if>

					<div class="form-group">
						<label for="category-name" class="col-xs-4 control-label">联系电话</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.phone }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">身份证号</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.idCard }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">职位</label>
						<div class="col-xs-4" style="padding-top:7px;">${model.job }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">入职时间</label>
						<div class="col-xs-4" style="padding-top:7px;"><fmt:formatDate value="${model.joinTime }" pattern="yyyy-MM-dd"/></div>
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
