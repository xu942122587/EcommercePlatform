<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script type="text/javascript">
	$(function() {
		
	});
	Namespace.register("com.yunt.operation.list");
	com.yunt.operation.list = {
		goUpdateOperation : function(id,name,parentFunctionName,url,description,code) {
			top.success=true;
			//能清除所有数据，无法清除验证错误提示
			$('#theFormOperation')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#theFormOperation').bootstrapValidator('resetForm', true);
			 $("#theFormOperation #id").val(id);
			$("#theFormOperation #name").val(name);
			$("#theFormOperation #parentOperationName").val(parentFunctionName);
			$("#theFormOperation #url").val(url);
			$("#theFormOperation #code").val(code);
			$("#theFormOperation #description").val(description);
			$('#addOperationModal').modal('show');
		},
		doDeleteOperation:function(operationId){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				  $.ajax({
					url : "${path}/operation/doDelete?operationId="+operationId,
					type : "POST",
					dataType : "json",
					success : function(data) {
						//$('#deleteModal').modal('hide');
						 if (data.success) {
							
							toastr.success('删除操作成功！');
							//加载页面
							$("#operationTable").load(
										"${path}/operation/list?model.parentFunction.id="
												+ $.cookie('selectNodeId'));
						} else {
							toastr.error('删除操作失败！');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.status);
	                    alert(XMLHttpRequest.readyState);
	                    alert(textStatus);
					}
				}); 
			});
		}
	};
</script>
</head>
<body>

	<form id="theForm">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5 id="operationTableTitle">${title}操作列表</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center table-condensed"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">id</th>
						<th class="text-center">名称</th>
						<th class="text-center">操作编码</th>
						<th class="text-center">链接</th>
						<th class="text-center">简介</th>
						<c:if test="${isFromRole==false}">
							<th class="text-center">操作</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="operation" varStatus="i">
						<tr>
							<td class="">
								<c:if test="${isFromRole == true}">
									<c:if test="${empty role_operation_String }">
										<div class="checkbox" style="margin: 0 auto;width: 100%;">
											<label style="float: left;">
												<input type="checkbox" onchange="checkbox_click(this);" 
														value="${operation.id }" data-dependencies="buttons.less" >
												${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}
											</label>
										</div>
									</c:if>
									<c:if test="${not empty role_operation_String }">
										<c:if test="${fn:indexOf(role_operation_String,operation.code) > -1 }">
											<div class="checkbox" style="margin: 0 auto;width: 100%;">
												<label style="float: left;">
													<input type="checkbox" onchange="checkbox_click(this);" checked="checked" style="float: left;"
															value="${operation.id }" data-dependencies="buttons.less" >
													${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}
												</label>
											</div>
										</c:if>
										<c:if test="${fn:indexOf(role_operation_String,operation.code) <= -1 }">
											<div class="checkbox" style="margin: 0 auto;width: 100%;">
												<label style="float: left;">
													<input type="checkbox" onchange="checkbox_click(this);" style="float: left;"
															value="${operation.id }" data-dependencies="buttons.less" >
													${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}
												</label>
											</div>
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${isFromRole == false}">
									${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}
								</c:if>
							</td>
							<td>${operation.name}</td>
							<td>${operation.code}</td>
							<td>${operation.url}</td>
							<td>${operation.description}</td>
							<c:if test="${isFromRole==false}">
								<td class="text-center">
									<a class="btn btn-danger btn-xs" 
											onclick="com.yunt.operation.list.goUpdateOperation('${operation.id}','${operation.name}','${operation.parentFunction.name}','${operation.url}','${operation.description}','${operation.code }')">
										修改
									</a>
									&nbsp;&nbsp;
									<a class="btn btn-default btn-xs" href="#" onclick="com.yunt.operation.list.doDeleteOperation('${operation.id}')">删除</a>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
		</div>
	</form>
	<!-- 菜单树和功能表 -->
	<script type="text/javascript">
	function checkbox_click(this_){
		if($(this_).is(':checked')){
			arrayPush(operationArray, $(this_).val().trim());
		}else{
			arrayRemove(operationArray, $(this_).val().trim());
		}
	} 
	</script>
</body>
</html>
