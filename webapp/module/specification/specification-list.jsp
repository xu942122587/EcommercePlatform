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
	Namespace.register("com.yunt.specification.list");
	com.yunt.specification.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/specification/list?model.name=' + $("#name").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/specification/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除单位成功！');
							com.yunt.specification.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						toastr.error(error);
					}
				});
			});
		}
	};
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<c:if test="${fn:indexOf(user.role.operationCodes,'specification_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger"
								onclick="com.yunt.index.loadInner('${path}/specification/input','添加单位')">
							<span class="glyphicon glyphicon-new-window"></span> 添加单位
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" specification="form">
					<div class="form-group">
						<input type="text" value="${model.name }" id="name" name="name" class="form-control" placeholder="单位名称……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.specification.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/specification/list?model.name=${model.name }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>单位</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">名称</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="specification" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${specification.name }</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'specification_input') > -1 }">
									<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/specification/input?id=${specification.id }','修改单位信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'specification_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/specification/view?id=${specification.id }','查看单位信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'specification_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.specification.list.doDelete('${specification.id }')">删除</a>
									&nbsp;&nbsp; 
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
			<div class="clearfix">
				<pager:createPager pageSize="${pageObj.pageSize}"
						totalPage="${pageObj.totalPage}"
						totalCount="${pageObj.totalRecord}" curPage="${pageObj.pageNo}"
						formId="theForm" pageName="com.yunt.index"/>
			</div>
		</div>
	</form>	
</body>
</html>
