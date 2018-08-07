<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function() {
		//初始化表格，中文显示必须要使用js初始化
		/* $('#ggg').bootstrapTable({
			//url:'${path}/platform/ui/bootstrap/aaa.json'
		}); */
	});

	function goUpdateAttr(attrCode,id) {
		selectNodeId = $.cookie('selectNodeId');
		com.yunt.index.loadInner("${path}/classification/otherAttrJsonAddOrUpdate?flag=update&attrCode="+attrCode+"&nodeId="
				+id,"修改属性");
	}

	function doDelete(attrCode,id) {
		$('#deleteModal').modal('show');
		$("#deleteButton").unbind("click").click(function(){
			 $.ajax({
				url : "${path}/classification/otherAttrJsonDoDelete?attrCode="+attrCode+"&id="+id,
				type : "POST",
				dataType : "json",
				success : function(data) {
					 if (data.success) {
						 $("#operationTable").load(
									"${path}/classification/otherAttrJsonList?id="
									+ id);
						toastr.success(data.msg);
					} else {
						toastr.error(data.msg);
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
</script>
</head>
<body>
	<!--the toolbar begin -->
	<%-- <div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<c:if test="${fn:indexOf(user.role.operationCodes,'user_input') > -1 }">
					<div class="quick-add-btn">
							<a href="javascript:void(0)"
								onclick="com.yunt.index.loadInner('${path}/user/input?inputKind=add','添加用户')"
								type="button" class="btn btn-danger"><span
								class="glyphicon glyphicon-new-window"></span> 新增属性</a>
					</div>
				</c:if>
			</div>
		</div>
	</div> --%>
	<form id="theForm" onsubmit="return false;">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>属性列表</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">所属分类</th>
						<th class="text-center">属性</th>
						<th class="text-center">输入类型</th>
						<th class="text-center">是否必填</th>
						<th class="text-center">备选项</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${classStringList}" var="classString" varStatus="i">
						<tr>
							<td>
								${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}
								<input hidden="hidden" name="model.attrCode" value="${classString.attrCode}">
								<input hidden="hidden" name="model.classification" value="${classString.classification}">
								<input hidden="hidden" name="model.inputType" value="${classString.inputType}">
								<input hidden="hidden" name="model.isRequired" value="${classString.isRequired}">
								<input hidden="hidden" name="model.childAttr" value="${classString.childAttr}">
							</td>
							<td>
								${classString.classification.name}
							</td>
							<td>${classString.attr}</td>
							<td>${classString.inputTypeValue}</td>
							<td>${classString.isRequiredValue}</td>
							<td>
								<c:if test="${ not empty classString.childAttr }">
								${classString.childAttr}
								</c:if>
								<c:if test="${ empty classString.childAttr }">
								-----
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'otherAttrJson_addOrUpdate') > -1 }">
									&nbsp;&nbsp; 
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="goUpdateAttr('${classString.attrCode}','${classString.classification.id}')">修改</a>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'otherAttrJson_delete') > -1 }">
									&nbsp;&nbsp; 
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="doDelete('${classString.attrCode}','${classString.classification.id}')">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
		</div>
	</form>	
</body>
</html>
