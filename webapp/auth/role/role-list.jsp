<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	var role="";
	$(function() {
		$("#saveRoleFunction").hide();
	});
	Namespace.register("com.yunt.role.list");
	com.yunt.role.list = {
		refresh : function() {
			com.yunt.index.load('${path}/role/list?model.name=' + $("#name").val(),menuIndexTemp,submenuIndexTemp);
		},
		doDelete:function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/role/doDelete?roleId="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						//$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除角色成功！');
							com.yunt.role.list.refresh();
						} else {
							toastr.error('删除角色失败！');
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
	function distributAuth(roleId){
		arrayNode.length = 0;
		operationArray.length = 0;
		$("#tree").show();
		role=roleId;
		getFuncTree(roleId);
		$("#saveRoleFunction").show();
	}
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<div class="quick-add-btn">
					<a href="javascript:void(0)"
						onclick="com.yunt.index.loadInner('${path}/role/goAddOrUpdate?inputKind=add','添加角色')"
						type="button" class="btn btn-danger"><span
						class="glyphicon glyphicon-new-window"></span> 添加角色</a>
						<a id="saveRoleFunction" href="javascript:void(0)"
						onclick="saveFunctionWithRole()"
						type="button" class="btn btn-danger"><span
						class="glyphicon glyphicon-new-window"></span> 保存角色权限</a>
				</div>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search"
					role="form">
					<!-- 				<div class="form-group">
						<select class="form-control">
							<option value="all">全部设备</option>
							<option value="device">传感设备</option>
							<option value="led">显示设备</option>
						</select>
					</div> -->
					<div class="form-group">
						<input type="text" id="name" name="name" value="${model.name }"
							class="form-control" placeholder="角色名称……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.role.list.refresh()">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/role/list?model.name=${model.name }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>角色列表</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">id</th>
						<th class="text-center">角色名称</th>
						<th class="text-center">角色编码</th>
						<th class="text-center">角色描述</th>
						 <th class="text-center">操作</th> 
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="role" varStatus="i">
						<tr>
							<td class="">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td>${role.name}</td>
							<td>${role.roleKey}</td>
							<td>${role.description}</td>
							<td class="text-center"><input type="button" value="修改"
								class="btn btn-primary btn-xs" data-toggle="modal"
								data-target="#edit-device"
								onclick="com.yunt.index.loadInner('${path}/role/goAddOrUpdate?inputKind=update&id=${role.id }','修改角色')" />
								&nbsp;&nbsp; <a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="distributAuth('${role.id }')">分配权限</a>
								<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.role.list.doDelete('${role.id }')">删除</a>
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
	<!-- 菜单树和功能表 -->
	<div class="row">
		<!-- 菜单树 -->
		<div id="tree" class="col-xs-3"></div>
		<!-- 功能表 -->
		<div class="col-xs-9" id="operationTable"></div>
	</div>
	<!-- 菜单树和功能表 -->
	<script type="text/javascript">
		var arrayNode = new Array();
		var operationArray = new Array();//保存第三级权限使用
		var jsonData;
		var functionJsonData;
		var operationJsonData;
		$(document).ready(function() {
			$('#search').bootstrapValidator();//初始化验证
		});
		function getFuncTree(roleId) {
			$.ajax({
				type : "GET",
				url : "${path}/function/getFunctionTree?roleId="+roleId,
				processData : true,
				async : false,
				success : function(json) {
					jsonData=eval("(" + json + ")");
					//先初始化选中的nodeArray
					functionJsonData = jsonData.function_;
					operationJsonData = jsonData.operation_;
					for(var o in functionJsonData){
						if(functionJsonData[o].level=='0'){
							for(var p in functionJsonData[o].nodes){
								if(functionJsonData[o].state!=null){
									if(functionJsonData[o].nodes[p].state.checked==true){
										arrayNode.push(functionJsonData[o].nodes[p].id);
									}
								}
							}
						}
						if(functionJsonData[o].state!=null){
							if(functionJsonData[o].state.checked==true){
								arrayNode.push(functionJsonData[o].id);
							}
						}
					}
					for (var o in operationJsonData) {
						operationArray.push(operationJsonData[o].operationId);
					}
					var $tree = $('#tree').treeview({
						color : "#428bca",
						expandIcon : 'glyphicon glyphicon-chevron-right',
						collapseIcon : 'glyphicon glyphicon-chevron-down',
						state : {
							checked : true,
							disabled : true,
							expanded : true,
							selected : true
						},
						showCheckbox: true,
						onNodeSelected : function(event, node) {
							$.cookie('selectNodeId', node.id); // 存储 cookie 
							$.cookie('selectNodeLevel', node.level); // 存储 cookie 
							//加载页面
							$("#operationTable").show();
							//加载页面
							$("#operationTable").load(
									"${path}/operation/list?isFromRole=true&roleId=" + roleId + "&model.parentFunction.id="
											+ node.id + "&title=" + node.text);
						},
						onNodeUnselected : function(event, node) {
							//取消选中时清楚cookie
							$.cookie('selectNodeId',"");
							$.cookie('selectNodeLevel',"");
						},
						onNodeChecked: function(event, node) {
							arrayPush(arrayNode,node.id);
							if(node.level=='0'){
								var index=0;
								var totalIndex=0;
								for(var o in functionJsonData){
									if(functionJsonData[o].id==node.id){
										var indexSub=index;
										for(var p in functionJsonData[o].nodes){
											arrayPush(arrayNode,functionJsonData[o].nodes[p].id);
											$('#tree').treeview('checkNode', [parseInt(totalIndex)+parseInt(p)+1, { silent: true } ]);
										}
									}
									//为了计算选中一级菜单的二级菜单序号
									for(var p in functionJsonData[o].nodes){
										totalIndex++;
									}
									index++;
									totalIndex++;
								}
						    }
						},
						onNodeUnchecked: function(event, node) {
							arrayRemove(arrayNode,node.id);
							if(node.level=='0'){
								var index=0;
								var totalIndex=0;
								for(var o in functionJsonData){
									if(functionJsonData[o].id==node.id){
										var indexSub=index;
										for(var p in functionJsonData[o].nodes){
											arrayRemove(arrayNode,functionJsonData[o].nodes[p].id);
											$('#tree').treeview('uncheckNode', [parseInt(totalIndex)+parseInt(p)+1, { silent: true } ]);
										}
									}
									//为了计算选中一级菜单的二级菜单序号
									for(var p in functionJsonData[o].nodes){
										totalIndex++;
									}
									index++;
									totalIndex++;
								}
						    }
						},
						data : functionJsonData
					});
				}
			});
		}
		function saveFunctionWithRole(){
			//alert(arrayNode.join(','));
			if(arrayNode.length>0){
				//toastr.success(arrayNode.join(','));
				$.ajax({
					url : "${path}/role/addFunctionWithRole?functions=" + arrayNode.join(',') + "&roleId=" 
								+ role + "&operations=" + operationArray.join(','),//拒绝任务的地址
					data : null,
					type : "get",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$("#tree").hide();
							$("#saveRoleFunction").hide();
							$("#operationTable").hide();
							toastr.success(data.msg);
							arrayNode.length=0;
							operationArray.length=0;
							return false;//防止重复提交
						} else {
							toastr.error(data.msg);
						}
					}
				});
			}else{
				toastr.warning("请选择权限!");
			}
		}
		//从数组中移除指定元素
		function arrayRemove(ary,obj){
			for ( var i = 0; i < ary.length; i++) {
				if (obj == ary[i]) {
					ary.splice(i, 1);
					break;
				}
			}
		}
		//无重复添加
		function arrayPush(ary,obj){
			for ( var i = 0; i < ary.length; i++) {
				if (obj == ary[i]) {
					return;
				}
			}
			ary.push(obj);
		}
	</script>
</body>
</html>
