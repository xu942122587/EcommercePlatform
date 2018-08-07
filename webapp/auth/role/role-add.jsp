<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
var isSuccess = true;
Namespace.register("com.yunt.role.add");
com.yunt.role.add = {
	submitRole : function() {
		if($('#theForm').data('bootstrapValidator').isValid()){
			var formData = $("#theForm").serialize();
			if(isSuccess){
				$.ajax({
					url : "${path}/role/doAddOrUpdate?inputKind=${inputKind}",
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
							toastr.error('添加角色失败！');
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
				<form class="form-horizontal" onsubmit="return com.yunt.role.add.submitRole()" action="" id="theForm" role="form" method="post"  data-bv-message="This value is not valid" data-bv-feedbackicons-valid="glyphicon glyphicon-ok" data-bv-feedbackicons-invalid="glyphicon glyphicon-remove" data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty role.id }">
						<input type="hidden" name="id" value="${role.id}"  />
					</c:if>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">角色名称</label>
						<div class="col-xs-4">
							<input type="text" value="${role.name }" class="form-control" id="name" name="name" required data-bv-notempty-message="角色名称不能为空" maxlength="50">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">角色编码</label>
						<div class="col-xs-4">
							<input type="text" value="${role.roleKey }" class="form-control" id="roleKey" name="roleKey" required maxlength="50" data-bv-notempty-message="角色编码不能为空">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">角色类别</label>
						<div class="col-xs-4">
							<select class="form-control" name="type" id="type" required="required" data-bv-notempty-message="请选择角色类别~">
								<c:if test="${empty role.type}">
									<option class="level-0" value="" selected="selected">请选择</option>
									<option class="level-0" value="1">系统管理员</option>
									<option class="level-0" value="2">管理员</option>
									<option class="level-0" value="3">员工</option>
								</c:if>
								<c:if test="${role.type eq '1'}">
									<option class="level-0" value="">请选择</option>
									<option class="level-0" value="1" selected="selected">系统管理员</option>
									<option class="level-0" value="2">管理员</option>
									<option class="level-0" value="3">员工</option>
								</c:if>
								<c:if test="${role.type eq '2'}">
									<option class="level-0" value="">请选择</option>
									<option class="level-0" value="1">系统管理员</option>
									<option class="level-0" value="2"selected="selected">管理员</option>
									<option class="level-0" value="3">员工</option>
								</c:if>
								<c:if test="${role.type eq '3'}">
									<option class="level-0" value="">请选择</option>
									<option class="level-0" value="1">系统管理员</option>
									<option class="level-0" value="2">管理员</option>
									<option class="level-0" value="3"selected="selected">员工</option>
								</c:if>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="device-description" class="col-xs-4 control-label">角色描述</label>
						<div class="col-xs-4">
							<textarea class="form-control"  id="device-description" name="description" rows="3" maxlength="200" >${role.description }</textarea>
						</div>
					</div>
					<div class="form-actions col-xs-8 pull-right">
						<input value="提交" id="ert" type="submit" class="btn btn-primary" />
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex()">取消</button>
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
