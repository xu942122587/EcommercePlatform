<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.user.list");
	com.yunt.user.list = {
		refresh : function() {
			com.yunt.index.load('${path}/user/list?model.name=' + $("#name").val(),menuIndexTemp,submenuIndexTemp);
		},
		doDelete:function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/user/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除用户成功！');
							com.yunt.user.list.refresh();
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
	};
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<c:if test="${fn:indexOf(user.role.operationCodes,'user_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)" onclick="com.yunt.index.loadInner('${path}/user/input?inputKind=add','添加用户')" type="button" class="btn btn-danger">
							<span class="glyphicon glyphicon-new-window"></span>添加用户
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" user="form">
					<div class="form-group">
						<input type="text" id="name" name="name" class="form-control" placeholder="用户名称……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.user.list.refresh()">筛选</button>
				</form>
			</div>
		</div>
	</div>

	<form id="theForm" action="${path}/user/list?model.name=${model.name }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>用户</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">用户名</th>
						<th class="text-center">姓名</th>
						<th class="text-center">角色</th>
						<th class="text-center">联系电话</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="user_" varStatus="i">
						<tr>
							<td class="">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td>${user_.username}</td>
							<td>${user_.name}</td>
							<td>
								<c:if test="${empty user_.role.name }">
									——
								</c:if>
								<c:if test="${not empty user_.role.name }">
									${user_.role.name}
								</c:if>
							</td>
							<td>
								<c:if test="${empty user_.phone }">
									——
								</c:if>
								<c:if test="${not empty user_.phone }">
									${user_.phone}
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${user.id ne user_.id }">
									<c:if test="${('1' ne user.role.type && '1' ne user_.role.type) || '1' eq user.role.type}">
										<c:if test="${fn:indexOf(user.role.operationCodes,'user_input') > -1 }">
											<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
													onclick="com.yunt.index.loadInner('${path}/user/input?inputKind=update&id=${user_.id }','修改用户信息')" />
											&nbsp;&nbsp; 
										</c:if>
									</c:if>
									<c:if test="${'1' ne user.role.type && '1' eq user_.role.type}">
										<c:if test="${fn:indexOf(user.role.operationCodes,'user_input') > -1 }">
											<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device" disabled="disabled"/>
											&nbsp;&nbsp; 
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${user.id eq user_.id }">
									<c:if test="${fn:indexOf(user.role.operationCodes,'user_input') > -1 }">
										<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device" disabled="disabled"/>
										&nbsp;&nbsp; 
									</c:if>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'user_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/user/view?id=${user_.id }','查看用户信息')" />
								</c:if>
								<c:if test="${'1' ne user_.role.type }">
									<c:if test="${fn:indexOf(user.role.operationCodes,'user_delete') > -1 }">
										&nbsp;&nbsp; 
										<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.user.list.doDelete('${user_.id }')">删除</a>
									</c:if>
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
