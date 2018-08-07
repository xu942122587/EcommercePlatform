<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.notice.input");
	com.yunt.notice.input = {
		submitnotice : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if (!$.hz.swfupload.validateAttachment("fileDiv", false)) {
					$("#ert").removeAttr("disabled");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/notice/saveOrUpdate",
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
							toastr.success("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
</script>
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
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.notice.input.submitnotice()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid"
							class="col-xs-12 control-label lantiao_lable">通告信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">通告名称</label>
						<div class="col-xs-8">
							<input type="text" value="${model.title }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								name="model.title" required data-bv-notempty-message="通告名称不能为空"
								>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">通告内容</label>
						<div class="col-xs-8">
							<textarea rows="10" class="form-control"
								type="text" maxlength="4800" placeholder="" name="model.content"
								required data-bv-notempty-message="通告名称不能为空"
								>
								${model.content }
							</textarea>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
								name="model.remark" required data-bv-notempty-message="备注不能为空" />
						</div>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default"
							onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		/**
		 * 重新初始化验证
		 */
		function bootstrapValidator_again() {
			$(".form-control-feedback").remove();
			$(".help-block").remove();
			$('#theForm').data('bootstrapValidator', null);
			$('#theForm').bootstrapValidator('resetForm', false);
			$('#theForm').bootstrapValidator();//初始化验证
		}

		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});
	</script>
</body>
</html>
