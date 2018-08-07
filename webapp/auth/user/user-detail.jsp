<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.user.detail");
	com.yunt.user.detail = {
		submitUser : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$
							.ajax({
								url : "${path}/user/updateSelfDetail",
								data : formData,
								type : "POST",
								async : false,
								dataType : "json",
								success : function(data) {
									if (data.success) {
										isSuccess = false;//防止重复提交
										toastr.success(data.msg);
										com.yunt.index.toIndex();
									} else {
										toastr.error('修改个人信息失败！');
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
	};
	$(function() {

	});
</script>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.user.detail.submitUser()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<input type="hidden" name="id" value="${user.id}" />
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">姓名</label>
						<div class="col-xs-4">
							<input type="text" value="${user.name }" class="form-control"
								id="name" name="name" required data-bv-notempty-message="姓名不能为空"
								 pattern="^-?[\u4e00-\u9fa5]{2,30}$"  data-bv-regexp-message="请输入正确的姓名"
								>
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">用户名</label>
						<div class="col-xs-4">
							<input type="text" value="${user.username }" class="form-control"
								id="username" name="username" required data-bv-notempty-message="用户名不能为空"
								pattern="^-?[a-zA-Z0-9_\.]{6,12}$"  data-bv-regexp-message="只能输入6~12位字母和数字以及_\."
								data-bv-remote="true" data-bv-remote-url="${path}/user/validateUserIsExist" data-bv-remote-message="此账号已经存在">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">联系电话</label>
						<div class="col-xs-4">
							<input type="text" value="${user.phone }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="phone" name="phone" required data-bv-notempty-message="联系电话不能为空"
								pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$"
								data-bv-regexp-message="请输入正确的联系电话">
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toIndex();">返回首页</button>
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
