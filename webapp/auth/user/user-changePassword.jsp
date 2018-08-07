<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	function changePassword() {
		if ($('#theForm').data('bootstrapValidator').isValid()) {
			var formData = $("#theForm").serialize();
			if (isSuccess) {
				$.ajax({
					url : "${path}/user/changePassword",
					data : formData,
					type : "POST",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							isSuccess = false;//防止重复提交
							toastr.success("修改密码成功！");
							com.yunt.index.toIndex();
						} else {
							toastr.error('修改密码失败！');
						}
					},
					error : function(xhr, type, exception) {
						alert("请检查网络设置");
					}
				});
			}
		}
		return false;//防止页面刷新
	}
	$(function() {

	});
</script>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return changePassword()" class="form-horizontal"
					id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<input type="hidden" name="id" value="${user.id}" />
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">原密码</label>
						<div class="col-xs-4">
							<input type="password" value="" class="form-control"
								id="password" name="password" required
								data-bv-notempty-message="原密码不能为空"
								pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
								data-bv-regexp-message="只能输入6~12位字母和数字以及_\."
								data-bv-remote="true"
								data-bv-remote-url="${path}/user/passwordIsRight"
								data-bv-remote-message="密码错误">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">新密码</label>
						<div class="col-xs-4">
							<input type="password" value="" class="form-control"
								id="newPassword" name="newPassword" required
								data-bv-notempty-message="新密码不能为空"
								pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
								data-bv-regexp-message="只能输入6~12位字母和数字以及_\.">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">确认新密码</label>
						<div class="col-xs-4">
							<input type="password" value="" class="form-control"
								id="confirmPassword" name="confirmPassword" required
								data-bv-notempty-message="确认新密码不能为空"
								pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
								data-bv-regexp-message="只能输入6~12位字母和数字以及_\."
								data-bv-identical="true" data-bv-identical-field="newPassword"
								data-bv-identical-message="确认新密码和密码不一致">
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default"
							onclick="com.yunt.index.toIndex();">返回首页</button>
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
