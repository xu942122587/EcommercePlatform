<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	var isAlert = true;
	Namespace.register("com.yunt.eticket.manualOut");
	com.yunt.eticket.manualOut = {
		doManualOutEticket : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if("" == $("#customer_input_hidden").val().trim()){
					toastr.error("请先指定会员再发放~");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$ .ajax({
						url : "${path}/eticket/doManualOutEticket",
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
				<form onsubmit="return com.yunt.eticket.manualOut.doManualOutEticket()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">电子券：</label>
						<div class="col-xs-4">
							<select class="form-control" name="model.eticket.id" id="type" required data-bv-notempty-message="请选择电子券">
								<option class="level-0" value="" selected="selected">请选择电子券</option>
								<c:forEach items="${eticketList }" var="eticket">
									<option class="level-0" value="${eticket.id }">${eticket.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">会员手机号：</label>
						<div class="col-xs-4">
							<input type="hidden" value="" name="model.customer.id" id="customer_input_hidden"/>
							<input type="text" class="form-control" onblur="customerPhoneBlur(this);"
									onkeydown="if(event.keyCode==32) return false;" name="phoneValue"
									value="" pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$" 
									required="required" data-bv-notempty-message="请输入会员手机号"
									data-bv-regexp-message="请输入正确的手机号">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">会员昵称：</label>
						<div class="col-xs-4 control-label" id="customer_employee_name" style="text-align: left;"></div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">备注：</label>
						<div class="col-xs-4">
							<input type="text" name="model.remark" class="form-control" maxlength="200"/>
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var phone_test = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
		$(function() {
			$('#theForm').bootstrapValidator();
		});
		/**
		 * 手机号改变的回调函数
		 */
		function customerPhoneBlur(this_){
			var phone_value = $(this_).val().trim();
			if(phone_test.test(phone_value)){
				$.ajax({
					url : "${path}/customer/getCustomerByPhone?phone=" + phone_value,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$("#customer_input_hidden").val(data.obj.id);
							var name_value = (null == data.obj.employee || null == data.obj.employee.name || "" == data.obj.employee.name) ? data.obj.name : data.obj.employee.name;
							$("#customer_employee_name").html(name_value);
							toastr.success(data.msg);
						}else{
							$("#customer_input_hidden").val("");
							$("#customer_employee_name").html("");
							toastr.error(data.msg);
							$(this_).val("");
						}
					},
					error : function(xhr, type, exception) {
						$("#customer_input_hidden").val("");
						$("#customer_employee_name").html("");
						toastr.error("请检查网络设置");
						$(this_).val("");
					}
				});
			} else {
				$("#customer_input_hidden").val("");
				$("#customer_employee_name").html("");
				toastr.error("请输入正确的手机号~");
				$(this_).val("");
				return false;
			}
		}
	</script>
</body>
</html>
