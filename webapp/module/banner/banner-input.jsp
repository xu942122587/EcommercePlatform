<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.banner.input");
	com.yunt.banner.input = {
		submitBrand : function() {
			if(!$.hz.swfupload.validateAttachment("fileDiv", true)){
				$("#ert").removeAttr("disabled");
				return false;
			}
			var formData = $("#theForm").serialize();
			if (isSuccess) {
				$.ajax({
					url : "${path}/banner/saveOrUpdate",
					data : formData,
					type : "POST",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							isSuccess = false;//防止重复提交
							toastr.success('上传图片成功！');
							com.yunt.index.toPreIndex();
						} else {
							$("#ert").removeAttr("disabled");
							toastr.error(data.msg);
						}
					},
					error : function(xhr, type, exception) {
						$("#ert").removeAttr("disabled");
						toastr.error("请检查网络设置");
					}
				});
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
				<form onsubmit="return com.yunt.banner.input.submitBrand()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">微信轮播图</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">图片上传</label>
						<div class="col-xs-8">
							<div id="fileDiv" style="overflow:hidden"></div>
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
			<c:if test="${empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.banner.model.Banner,id",required:true});
			</c:if>
			<c:if test="${not empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.banner.model.Banner,id",idOwner:"${model.id}",required:true});
			</c:if>
		});
	</script>
</body>
</html>
