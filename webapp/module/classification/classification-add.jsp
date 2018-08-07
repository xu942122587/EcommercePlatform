<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<script type="text/javascript">
			var isSuccess = true;
			Namespace.register("com.yunt.classification.add");
			com.yunt.classification.add = {
				submitClassification : function() {
					if($('#theForm').data('bootstrapValidator').isValid()){
						var formData = $("#theForm").serialize();
						if(isSuccess){
							$.ajax({
								url : "${path}/classification/doAddOrUpdate?flag=${flag}",
								data : formData,
								type : "post",
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
									alert("请检查网络设置");
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
					<form  onsubmit="return com.yunt.classification.add.submitClassification()" class="form-horizontal" 
							id="theForm" role="form" method="get"  data-bv-message="This value is not valid"
							data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
							data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
							data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
						</div>

						<input hidden="hidden" name="model.level" value="${level}">
						<c:if test="${not empty model.id }">
							<input type="hidden" name="model.id" value="${model.id}"  />
						</c:if>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-4 control-label">分类名称</label>
							<div class="col-xs-4">
								<input type="text" onkeydown="if(event.keyCode==32) return false;" value="${model.name }" class="form-control" id="name" name="model.name" required data-bv-notempty-message="分类名称不能为空"
								<c:if test="${not empty parentModel }">
									maxlength="${((((parentModel.level-0)+1)*2)+4)}"
								</c:if>
								<c:if test="${empty parentModel }">
									maxlength="4"
								</c:if>/>
							</div>
						</div>
						
						<c:if test="${not empty parentModel }">
							<div class="form-group" id="parentClassification">
								<label for="category-name" class="col-xs-4 control-label">上级分类</label>
								<div class="col-xs-4">
									<input hidden="hidden" onkeydown="if(event.keyCode==32) return false;" name="model.parentClassification.id" value="${parentModel.id }">
									<input type="text" value="${parentModel.name }" class="form-control" disabled="disabled" >
								</div>
							</div>
						</c:if>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-4 control-label">分类顺序</label>
							<div class="col-xs-4">
								<input  class="form-control" onkeydown="if(event.keyCode==32) return false;" value="${model.seq }" id="seq" name="model.seq" min="0" max="1000"
										required data-bv-notempty-message="分类顺序不能为空" 
										data-bv-greaterthan-message="输入值必须大于等于0"
										data-bv-lessthan-message="输入值必须小于1000" />
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">分类描述</label>
							<div class="col-xs-4">
								<textarea class="form-control"  id="device-description" name="model.description" rows="3" maxlength="500" >${model.description }</textarea>
							</div>
						</div>

						<div class="form-actions col-xs-8 pull-right">
							<button id="ert" type="submit" class="btn btn-primary" >提交</button>
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
