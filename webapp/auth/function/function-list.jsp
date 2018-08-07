<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">

	var selectNodeId = "";
	var selectNodeLevel = "";
	var success=true;
	$(function() {
		$("#delete").hide();
		$("#update").hide();
		$("#addOperation").hide();
		$.cookie('selectNodeId', "");
		$.cookie('selectNodeLevel', "");
		getFuncTree();
	});
	

	function getFuncTree() {
		$.ajax({
			type : "GET",
			url : "${path}/function/getFunctionTree",
			processData : true,
			async : false,
			success : function(json) {
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
					onNodeSelected : function(event, node) {
						if (node.level == '0') {
							$("#addOperation").hide();
						} else {
							$("#addOperation").show();
						}
						$("#delete").show();
						$("#update").show();
						
						//alert("fff"+node.id);
						$.cookie('selectNodeId', node.id); // 存储 cookie 
						$.cookie('selectNodeLevel', node.level); // 存储 cookie 
						$.cookie('selectNodeText', node.text); // 存储 cookie 
						
						//加载页面
						$("#operationTable").load(
								"${path}/operation/list?model.parentFunction.id="
										+ node.id+"&title="+node.text);
					},
					onNodeUnselected : function(event, node) {
						//取消选中时清楚cookie
						$.cookie('selectNodeId', "");
						$.cookie('selectNodeLevel', "");
					},
					data : eval("("+json+")").function_
				});
			}
		});
	}
	function goUpdateFunction() {
		selectNodeId = $.cookie('selectNodeId');
		selectNodeLevel = $.cookie('selectNodeLevel');
		 if (selectNodeId == "") {
			toastr.warning('请选择功能！');
			return;
		}
		com.yunt.index.loadInner("${path}/function/goAddOrUpdate?inputKind=update&id="
				+ selectNodeId,"更新菜单");
	}

	function goAddOperation() {
		selectNodeId = $.cookie('selectNodeId');
		selectNodeLevel = $.cookie('selectNodeLevel');
		if (selectNodeId == "") {
			toastr.warning('请选择功能！');
			return;
		}
		if (selectNodeLevel == 0) {
			toastr.warning('一级菜单不能添加功能！');
			return;
		}
		//能清除所有数据，无法清除验证错误提示，不能清除掉type为hidden类型的input的数据
		$('#theFormOperation')[0].reset();
		//只能清除验证，无法清除不带验证input标签的数据
		$('#theFormOperation').bootstrapValidator('resetForm', true);
		
		$("#theFormOperation #id").val("");
		$('#parentOperationName').val($.cookie('selectNodeText'));
		$('#parentFunctionId').val($.cookie('selectNodeId'));
		$('#addOperationModal').modal('show');
		success=true;
	}

	function doDelete() {
		selectNodeId = $.cookie('selectNodeId');
		selectNodeLevel = $.cookie('selectNodeLevel');
		if (selectNodeId == "") {
			toastr.warning('请选择菜单！');
			return;
		}
		
		//alert("${path}/function/doDelete?functionId="+selectNodeId);
		$('#deleteModal').modal('show');
		$("#deleteButton").unbind("click").click(function(){
			 $.ajax({
				url : "${path}/function/doDelete?functionId="+selectNodeId,
				type : "POST",
				dataType : "json",
				success : function(data) {
					//$('#deleteModal').modal('hide');
					 if (data.success) {
						toastr.success('删除菜单成功！');
						getFuncTree();
					} else {
						toastr.error('删除菜单失败！');
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
	

	function submitOperation() {
		 if($('#theFormOperation').data('bootstrapValidator').validate().isValid()){
			var formData = $("#theFormOperation").serialize();
			if(success){
				$.ajax({
					url : "${path}/operation/doAddOrUpdate",
					data : formData,
					type : "post",
					async : false,
					dataType : "json",
					success : function(data) {
						success=false;
						$('#addOperationModal').modal('hide');
						$('#theFormOperation')[0].reset();
						if (data.success) {
							toastr.success(data.msg);
							//加载页面
							$("#operationTable").load(
										"${path}/operation/list?model.parentFunction.id="
												+ $.cookie('selectNodeId'));
							 $("#operationTable").load(
									"${path}/operation/list?model.parentFunction.id="
											+ $.cookie('selectNodeId')+"&title="+$.cookie('selectNodeText'));
						} else {
							toastr.error('添加操作失败！');
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
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<!-- toolBar -->
		<div class="row">
			<div class="col-xs-6">
				<div class="quick-add-btn">
					<a href="javascript:void(0)" onclick="com.yunt.index.loadInner('${path}/function/goAddOrUpdate?inputKind=add','添加菜单')" type="button" class="btn btn-danger">
						<span class="glyphicon glyphicon-new-window"></span>添加菜单
					</a>
					<a id="addOperation" href="javascript:void(0)" onclick="goAddOperation()" type="button" class="btn btn-danger" style="margin-left: 10px;">
						<span class="glyphicon glyphicon-new-window"></span>添加操作
					</a>
					<a id="update" href="javascript:void(0);" onclick="goUpdateFunction()" type="button" class="btn btn-danger" style="margin-left: 10px;">
						<span class="glyphicon glyphicon-new-window"></span>修改
					</a>
					<a id="delete" data-toggle="modal" href="javascript:void(0)"  onclick="doDelete()" type="button" class="btn btn-danger" style="margin-left: 10px;">
						<span class="glyphicon glyphicon-new-window"></span>删除
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- toolBar -->
	<!-- 菜单树和功能表 -->
	<div class="row">
		<!-- 菜单树 -->
		<div id="tree" class="col-xs-3"></div>
		<!-- 功能表 -->
		<div class="col-xs-9" id="operationTable"></div>
	</div>

	<!-- 弹出框 -->
	<div id="addOperationModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加操作</h4>
				</div>
				<div class="modal-body row">
					<form  onsubmit="return submitOperation()"  class="form-horizontal"  id="theFormOperation" role="form" method="get"  >
					<input id='id' type="hidden" name="id"   />
					<input type="hidden" id="parentFunctionId" name="parentFunction.id" value="${parentFunction.id}"  />
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">名称</label>
						<div class="col-xs-6">
							<input type="text"  class="form-control" id="name" name="name" maxlength="200">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">操作编码</label>
						<div class="col-xs-6">
							<input type="text"  class="form-control" id="code" name="code" required data-bv-notempty-message="编码不能为空" maxlength="200">
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">父级菜单</label>
						<div class="col-xs-6">
							<input  type="text"  class="form-control" id="parentOperationName"  disabled="disabled">
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">访问路径</label>
						<div class="col-xs-6">
							<input type="text"  class="form-control" id="url" name="url"  maxlength="200" >
						</div>
					</div>

					<div class="form-group">
						<label for="device-description" class="col-xs-4 control-label">操作描述</label>
						<div class="col-xs-6">
							<textarea class="form-control"  id="description" name="description" rows="3" maxlength="500" ></textarea>
						</div>
					</div>
					  <div class="form-group">
						<label for="ert" class="col-xs-4 control-label"></label>
						<div class="col-xs-6">
							<input id="ert" type="button" onclick="submitOperation();" class="btn btn-primary btn-block" value="提交">
						</div>
					</div> 
				</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 弹出框 -->
	<script type="text/javascript">
		//模态框中表单验证
		$(document).ready(function() {
		    $('#theFormOperation').bootstrapValidator({
		        message: '此值无效',
		        feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
		        },
		        fields: {
		        	name: {
		                message: '操作名称无效',
		                validators: {
		                    notEmpty: {
		                        message: '操作名称不能为空'
		                    }
		                }
		            },
		            url: {
		                message: '操作访问路径无效',
		                validators: {
		                    notEmpty: {
		                        message: '操作访问路径不能为空'
		                    }
		                }
		            }
		        }
		        
		    });
		});
	</script>
</body>
</html>
