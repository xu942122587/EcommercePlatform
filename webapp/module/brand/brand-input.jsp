<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.brand.add");
	com.yunt.brand.add = {
		submitBrand : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if(!$.hz.swfupload.validateAttachment("fileDiv", false)){
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/brand/saveOrUpdate",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								com.yunt.index.toPreIndex();
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.brand.add.submitBrand()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">品牌名称</label>
						<div class="col-xs-3">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.name" required data-bv-notempty-message="品牌名称不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的品牌名称">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">品牌网址</label>
						<div class="col-xs-3">
							<input type="text" value="${model.brandHttpURI }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="brandHttpURI" name="model.brandHttpURI">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">品牌描述</label>
						<div class="col-xs-8">
							<input type="text" value="${model.content }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="content" name="model.content" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									id="name" name="model.remark" />
						</div>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});
	</script>
</body>
</html>
