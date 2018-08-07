<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.storage.list");
	com.yunt.storage.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/storage/list?model.name=' + $("#name").val().trim();
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
					url : "${path}/storage/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除仓库成功！');
							com.yunt.storage.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						toastr.error(error);
					}
				});
			});
		},
		doStorageStop : function(id){
			$.ajax({
				url : "${path}/storage/doStorageStop?id="+id,
				type : "POST",
				dataType : "json",
				success : function(data) {
					$('#deleteModal').modal('hide');
					 if (data.success) {
						toastr.success('仓库停用成功！');
						com.yunt.storage.list.refresh();
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					toastr.error(error);
				}
			});
		},
		doStorageStart : function(id){
			$.ajax({
				url : "${path}/storage/doStorageStart?id="+id,
				type : "POST",
				dataType : "json",
				success : function(data) {
					$('#deleteModal').modal('hide');
					 if (data.success) {
						toastr.success('仓库开始启用成功！');
						com.yunt.storage.list.refresh();
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					toastr.error(error);
				}
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
				<c:if test="${fn:indexOf(user.role.operationCodes,'storage_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger"
								onclick="com.yunt.index.loadInner('${path}/storage/input','添加仓库')">
							<span class="glyphicon glyphicon-new-window"></span> 添加仓库
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" storage="form">
					<div class="form-group">
						<input type="text" id="name" name="name" class="form-control" placeholder="仓库名称……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.storage.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/storage/list?model.name=${model.name }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>仓库</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">仓库名称</th>
						<th class="text-center">负责人</th>
						<th class="text-center">所属门店</th>
						<th class="text-center">状态</th>
						<th class="text-center">仓库面积</th>
						<th class="text-center">创建时间</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="storage" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${storage.name }</td>
							<td class="text-center">${storage.chargeName }</td>
							<td class="text-center"><c:if test="${empty storage.store.name }">----</c:if> ${storage.store.name }</td>
							<td class="text-center">${storage.stateValue }</td>
							<td class="text-center">${storage.acreage }</td>
							<td class="text-center"><fmt:formatDate value="${storage.createTime }" pattern="yyyy-MM-dd"/></td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'storage_input') > -1 }">
									<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/storage/input?id=${storage.id }','修改仓库信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'storage_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/storage/view?id=${storage.id }','查看仓库信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'storage_stop') > -1 && '1' eq storage.state}">
									<input type="button" value="停用" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.storage.list.doStorageStop('${storage.id }')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'storage_start') > -1  && '2' eq storage.state}">
									<input type="button" value="启用" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.storage.list.doStorageStart('${storage.id }')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'storage_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.storage.list.doDelete('${storage.id }')">删除</a>
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
