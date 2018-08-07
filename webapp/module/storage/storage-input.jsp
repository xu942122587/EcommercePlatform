<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.storage.input");
	com.yunt.storage.input = {
		submitStore : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/storage/saveOrUpdate",
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
				<form onsubmit="return com.yunt.storage.input.submitStore()"
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
						<label for="product-uuid" class="col-xs-2 control-label">仓库名称</label>
						<div class="col-xs-3">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"  maxlength="10"
									id="name" name="model.name" required data-bv-notempty-message="仓库名称不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,10}$"
									data-bv-regexp-message="请输入正确的仓库名称">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">仓库面积</label>
						<div class="col-xs-3">
							<input type="text" value="${model.acreage }"
									onkeydown="if(event.keyCode==32) return false;" maxlength="30"
									class="form-control" id="acreage" name="model.acreage" required
									data-bv-notempty-message="仓库面积不能为空">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">负责人</label>
						<div class="col-xs-3">
							<input type="text" value="${model.chargeName }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;" maxlength="30"
									id="chargeName" name="model.chargeName" required data-bv-notempty-message="负责人不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的负责人">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">联系电话</label>
						<div class="col-xs-3">
							<input type="text" value="${model.chargePhone }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;" maxlength="11"
								id="chargePhone" name="model.chargePhone" required data-bv-notempty-message="联系电话不能为空"
								pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$"
								data-bv-regexp-message="请输入正确的联系电话">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">所属门店</label>
						<div class="col-xs-3">
							<select class="form-control" name="model.store.id" id="storeId">
								<option class="level-0" value="" <c:if test="${empty model.id || empty model.store || empty model.store.id }">selected="selected"</c:if>>公共仓库</option>
								<c:forEach items="${storeList }" var="store">
									<option class="level-0" value="${store.id }" <c:if test="${model.store.id eq store.id}">selected="selected"</c:if>>${store.name }<c:if test="${'1' ne store.state }">(停业)</c:if></option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									id="name" name="model.remark"/>
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
