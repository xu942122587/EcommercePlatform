<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
var isSuccess = true;
	Namespace.register("com.yunt.func.add");
	com.yunt.func.add = {
		submitFunction : function() {
			if($('#theForm').data('bootstrapValidator').isValid()){
				var formData = $("#theForm").serialize();
				if(isSuccess){
				$.ajax({
					url : "${path}/function/doAddOrUpdate?inputKind=${inputKind}",
					data : formData,
					type : "get",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							isSuccess = false;//防止重复提交
							toastr.success('添加功能成功！');
							com.yunt.index.toPreIndex();
						} else {
							toastr.error('添加功能失败！');
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
	$(function(){
		if('${function.level}'=='0'){
			$("#parentFunction").hide();
		}
		$("input[name='level']").each(function(index,element){
			$(this).change(function() {
				if($(this).val()==0){
					//$("#url").attr("disabled","disabled");
					$("#parentFunction").hide();
					//$("#parentId").attr("disabled","disabled");
					//$("#nullOption").attr("selected","selected");
				}else{
					//$("#url").attr("required","");
					//$("#url").removeAttr("disabled");
					$("#parentFunction").show();
					//$("#parentId").removeAttr("disabled");
				}
				
			});
		});
		
	});
</script>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form  onsubmit="return com.yunt.func.add.submitFunction()" class="form-horizontal"  id="theForm" role="form" method="get"  data-bv-message="This value is not valid" data-bv-feedbackicons-valid="glyphicon glyphicon-ok" data-bv-feedbackicons-invalid="glyphicon glyphicon-remove" data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty function.id }">
						<input type="hidden" name="id" value="${function.id}"  />
					</c:if>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">菜单名称</label>
						<div class="col-xs-4">
							<input type="text" value="${function.name }" class="form-control" id="name" name="name" required data-bv-notempty-message="菜单名称不能为空" maxlength="50">
						</div>
					</div>
					<c:if test="${empty function.id }">
						<div class="form-group">
						<label for="device-type" class="col-xs-4 control-label">菜单级别</label>
						<div class="col-xs-4">
						<c:if test="${function.level eq 0}">
							<label class="radio-inline"> <input type="radio" id="level" name="level" value="0"  checked> <span class=""></span> 一级
							</label> <label class="radio-inline"> <input type="radio"  id="level" name="level" value="1" > <span class=""></span> 二级
							</label>
						</c:if>
						<c:if test="${function.level ne 0}">
							<label class="radio-inline"> <input type="radio" id="level" name="level" value="0" > <span class=""></span> 一级
							</label> <label class="radio-inline"> <input type="radio"  id="level" name="level" value="1" checked > <span class=""></span> 二级
							</label>
						</c:if>
						</div>
					</div>
					</c:if>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">访问路径</label>
						<div class="col-xs-4">
							<input type="text" value="${function.url }" class="form-control" id="url" name="url"  maxlength="200" required data-bv-notempty-message="访问路径不能为空">
						</div>
					</div>
					
					<c:if test="${empty function.id }">
						<div class="form-group" id="parentFunction">
						<label for="category-name" class="col-xs-4 control-label">父功能点</label>
						<div class="col-xs-4">
							<select class="form-control" name="parentFunction.id" id="parentId">
								<c:forEach items="${parentFunctions }" var="parentFunc">
									<c:if test="${function.parentFunction.id eq parentFunc.id}">
										<option class="level-0" value="${parentFunc.id }" selected="selected">${parentFunc.name }</option>
									</c:if>
									<c:if test="${function.parentFunction.id ne parentFunc.id}">
										<option class="level-0" value="${parentFunc.id }">${parentFunc.name }</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</div>
					</c:if>
										<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">菜单顺序</label>
						<div class="col-xs-4">
							<input  class="form-control" value="${function.seq }" id="seq" name="seq" required   data-bv-notempty-message="菜单顺序不能为空" 
							min="0" max="1000"
							data-bv-greaterthan-message="输入值必须大于等于0"
							data-bv-lessthan-message="输入值必须小于1000"
							>
						</div>
					</div>
					<div class="form-group">
						<label for="device-description" class="col-xs-4 control-label">功能描述</label>
						<div class="col-xs-4">
							<textarea class="form-control"  id="device-description" name="description" rows="3" maxlength="500" >${function.description }</textarea>
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
