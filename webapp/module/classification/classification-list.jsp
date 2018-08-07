<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<style type="text/css">
			.badge{
				font-weight: 100;
				padding: 4px 8px;
			}
			.badge:hover {
				background-color: #fff;
				color: #000;
				text-decoration: none;
				cursor: pointer;
			}
			.badge-hide{
				background-color: #d9534f;
			}
			.badge-hide:hover{
				background-color: #fff;
				color: #000;
				text-decoration: none;
				cursor: pointer;
			}
			.node-tree{
				font-size: 15px;
			}
		</style>
		<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
		<script src="${path}/platform/common/js/jquery.cookie.js"></script>
		<script type="text/javascript">
			var selectNodeId = "",
				expandedNodeId = "";
			var success=true;
			$(function() {
				$("#delete").hide();
				$("#update").hide();
				$("#showNodeBtn").hide();
				$("#hideNodeBtn").hide();
				$.cookie('selectNodeId', '');
				$.cookie('expandedNodeId', '');
				getClassTree();
			});
			
			function getClassTree() {
				$.ajax({
					type : "GET",
					url : "${path}/classification/getClassificationTree",
					processData : true,
					async : false,
					success : function(json) {
						//console.log(json);
						if('' != json && null != json && undefined != json){
							var treeView = $('#tree').treeview({
								levels : 4,
								showTags : true,
								color : "#428bca",
								expandIcon : 'glyphicon glyphicon-plus',
								collapseIcon : 'glyphicon glyphicon-minus',
								state : {
									disabled : true,
									expanded : true,
									selected : true
								},
								tags: ['available'],
								onNodeExpanded : function(event, node) {
									$.cookie('expandedNodeId', node.nodeId);
									setTimeout(function(){
										colorChanger();
									},10);
								},
								onNodeCollapsed : function(event, node) {
									$.cookie('expandedNodeId', '');
									setTimeout(function(){
										colorChanger();
									},10);
								},
								onNodeSelected : function(event, node) {
									$.cookie('selectNodeId', node.id); // 存储 cookie
									$("#delete").show();
									$("#update").show();
									if('1' == node.isVisible){
										$("#hideNodeBtn").show();
									}else if('2' == node.isVisible){
										$("#showNodeBtn").show();
									}
									
									if(2 <= (node.level - 0)){
										$("#add_trade").hide();
									} else {
										$("#add_trade").show();
									}
									if(1 == node.isBlank-0){
										$("#add_attr").show();
										$("#operationTable").load(
												"${path}/classification/otherAttrJsonList?id="
														+ node.id);
									}else{
										$("#add_attr").hide();
									}
									
									if('' == node.isHaveAttr && '2' == node.isHaveGoods && 2 > (node.level - 0)){
										$("#add_trade").show();
									}else if('' != node.isHaveAttr || '1' == node.isHaveGoods || 2 <= (node.level - 0)){
										$("#add_trade").hide();
									}
									
									setTimeout(function(){
										colorChanger();
									},10);
									
									$("#delete").show();
									$("#update").show();
									
									//alert("fff"+node.id);
									$.cookie('selectNodeId', node.id); // 存储 cookie 
									$.cookie('selectNodeLevel', node.level); // 存储 cookie 
									$.cookie('selectNodeText', node.text); // 存储 cookie 
									
									//加载页面
									
								},
								onNodeUnselected : function(event, node) {
									//取消选中时清cookie
									$.cookie('selectNodeId', '');
									setTimeout(function(){
										colorChanger();
									},10);
									$("#delete").hide();
									$("#update").hide();
									$("#showNodeBtn").hide();
									$("#hideNodeBtn").hide();
									$("#add_trade").show();
									$("#add_attr").hide();
									$("#operationTable").html("");
									//取消选中时清楚cookie
									$.cookie('selectNodeLevel', "");
								},
								data : eval("("+json+")").classification_
							});
							if('' != expandedNodeId){
								$('#tree').treeview('expandNode', [ expandedNodeId, { silent: true } ]);
							}
							colorChanger();
						}
						
					}
				});
			}

			function colorChanger(){
				var spanArr = $(".list-group-item .badge"); 
				for (var index = 0; index < spanArr.length; index++) {
					var element = spanArr[index];
					if($(element).html().indexOf("隐藏") >=0){
						$(element).addClass('badge-hide');
					}
				}
			}

			function goAdd() {
				selectNodeId = $.cookie('selectNodeId');
				com.yunt.index.loadInner("${path}/classification/goAddOrUpdate?flag=add&nodeId="
						+ selectNodeId,"添加分类");
			}
			function goAddAttr() {
				selectNodeId = $.cookie('selectNodeId');
				com.yunt.index.loadInner("${path}/classification/otherAttrJsonAddOrUpdate?flag=add&attrCode=&nodeId="
						+ selectNodeId,"添加属性");
			}

			function goUpdate() {
				selectNodeId = $.cookie('selectNodeId');
				 if (selectNodeId == "") {
					toastr.warning('请选择分类！');
					return;
				}
				com.yunt.index.loadInner("${path}/classification/goAddOrUpdate?flag=update&nodeId="
						+ selectNodeId,"更新分类");
			}
			
			function doClassDelete() {
				selectNodeId = $.cookie('selectNodeId');
				if (selectNodeId == "") {
					toastr.warning('请选择分类！');
					return;
				}
				$('#deleteModal').modal('show');
				$("#deleteButton").unbind("click").click(function(){
					 $.ajax({
						url : "${path}/classification/doDelete?nodeId="+selectNodeId,
						type : "POST",
						dataType : "json",
						success : function(data) {
							 if (data.success) {
								com.yunt.index.toPreIndex();
								toastr.success(data.msg);
								getClassTree();
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
			
			/* function showHideNode(){
				selectNodeId = $.cookie('selectNodeId');
				selectNodeIsVisible = $.cookie('selectNodeIsVisible');
				
				if (selectNodeId == "") {
					toastr.warning('请选择分类！');
					return;
				}
				if(success){
					success = false
					 $.ajax({
							url : "${path}/classification/showHideNode?nodeId="+selectNodeId,
							type : "POST",
							dataType : "json",
							success : function(data) {
								success =true;
								 if (data.success) {
									$("#delete").hide();
									$("#update").hide();
									$("#showNodeBtn").hide();
									$("#hideNodeBtn").hide();
									toastr.success(data.msg);
									getClassTree();
								} else {
									toastr.error(data.msg);
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								success =true;
								alert(XMLHttpRequest.status);
								alert(XMLHttpRequest.readyState);
								alert(textStatus);
							}
					 });
				}
			} */
			
		</script>
	</head>
	<body>
		<!--the toolbar begin -->
		<div class="toolbar">
			<!-- toolBar -->
			<div class="row">
				<div class="col-xs-6">
					<div class="quick-add-btn">
						<a id="add_trade" href="javascript:void(0)" onclick="goAdd()" type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-new-window"></span>添加分类
						</a>
						<a id="update" href="javascript:void(0);" onclick="goUpdate()" type="button" class="btn btn-primary" style="margin-left: 10px;">
							<span class="glyphicon glyphicon-upload"></span>修改
						</a>
						<a id="delete" data-toggle="modal" href="javascript:void(0)"  onclick="doClassDelete()" type="button" class="btn btn-danger" style="margin-left: 10px;">
							<span class="glyphicon glyphicon-trash"></span>删除
						</a>
						<!-- <a id="showNodeBtn" data-toggle="modal" href="javascript:void(0)"  onclick="showHideNode()" type="button" class="btn btn-primary" style="margin-left: 10px;">
							<span class="glyphicon glyphicon-eye-open"></span>可见
						</a>
						<a id="hideNodeBtn" data-toggle="modal" href="javascript:void(0)"  onclick="showHideNode()" type="button" class="btn btn-primary" style="margin-left: 10px;">
							<span class="glyphicon glyphicon-eye-close"></span>隐藏
						</a> -->
						<a id="add_attr" data-toggle="modal" href="javascript:void(0)"  onclick="goAddAttr()" type="button" class="btn btn-primary" style="margin-left: 10px; display: none">
							<span class="glyphicon glyphicon-eye-close"></span>添加属性
						</a>
					</div>
				</div>
			</div>
		</div>
		<!-- toolBar -->
		<!-- 树 -->
		<div class="row">
			<!-- 树 -->
			<div id="tree" class="col-xs-4"></div>
			
			<div class="col-xs-8" id="operationTable"></div>
		</div>
	</body>
</html>
