<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.checkstorage.list");
	var isSuccess = true;
	com.yunt.checkstorage.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/checkstorage/list?model.code='
				+ $("#model_code").val().trim()
				+ '&model.storage.id='
				+ $("#model_storage_id").val().trim()
				+"&model.startDate=" + $("#checkstorage_startDate_select").val().trim()
				+"&model.endDate=" + $("#checkstorage_endDate_select").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#checkstorage_endDate_select").val().trim() != ''){
					if(compareCurrentDate($("#checkstorage_endDate_select").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#checkstorage_startDate_select").val().trim() != ''){
					if(compareCurrentDate($("#checkstorage_startDate_select").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#checkstorage_startDate_select").val().trim() != '' && $("#checkstorage_endDate_select").val().trim() != ''){
					if(!compareDate($("#checkstorage_endDate_select").val(),$("#checkstorage_startDate_select").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		},
		doDeleteEmpty : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/checkstorage/doDeleteEmpty?checkstorageId="+id,
					type : "POST",
					data : null,
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success(data.msg);
							com.yunt.checkstorage.list.refresh();
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
	
	//-----------------日期统计初始化 -- start---------------
	$(function(){
		$('.date_input_no_class').datepicker({
			format: "yyyy-mm-dd",
			todayBtn: "linked",
			clearBtn: true,
			language: "zh-CN",
			todayHighlight: true,
		});
	});
	//-----------------日期统计初始化 -- end ---------------
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-5">
				<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)" type="button" class="btn btn-danger" onclick="toSave()">
							<span class="glyphicon glyphicon-new-window"></span> 添加盘点
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-7">
				<form class="form-inline pull-right" action="" id="search" checkstorage="form">
					<div class="form-group">
						<select class="form-control" name="model.storage" id="model_storage_id">
							<option value="" selected="selected">仓库</option>
							<c:forEach items="${storageList}" var="storage">
								<option value="${storage.id}" <c:if test="${model.storage.id eq storage.id }">selected="selected"</c:if>>${storage.name}</option>
							</c:forEach>
						</select>
						<input type="text" id="model_code" name="model.code" class="form-control" placeholder="单号……" maxlength="20" value="${model.code}">
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="结束日期" id="checkstorage_endDate_select" value="${model.endDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="开始日期" id="checkstorage_startDate_select" value="${model.startDate }" />
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.checkstorage.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>

	<form id="theForm"
		action="${path}/checkstorage/list?model.code=${model.code}&model.storage.id=${model.storage.id}&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>库存盘点</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">盘库单号</th>
						<th class="text-center">仓库</th>
						<th class="text-center">创建日期</th>
						<th class="text-center">完成日期</th>
						<th class="text-center">盘库单状态</th>
						<th class="text-center">操作人</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="checkstorage"
						varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${checkstorage.code }</td>
							<td class="text-center">${checkstorage.storage.name}</td>
							<td class="text-center"><fmt:formatDate value="${checkstorage.createTime}" pattern="yyyy-MM-dd" /></td>
							<td class="text-center"><fmt:formatDate value="${checkstorage.checkDate}" pattern="yyyy-MM-dd" /></td>
							<td class="text-center">${checkstorage.stateValue}</td>
							<td class="text-center">${checkstorage.fu_user.name }</td>
							<td class="text-center">
								<c:if test="${'1' eq checkstorage.state}">
									<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_view') > -1 }">
										<input type="button" value="查看" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/checkstorage/view?checkstorageId=${checkstorage.id }','查看盘库详情')" />
										&nbsp;&nbsp;
									</c:if>
									<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_input') > -1 }">
										<input type="button" value="已完成" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device" disabled="disabled"/>
										&nbsp;&nbsp;
									</c:if>
								</c:if>	
								<c:if test="${'2' eq checkstorage.state}">
									<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_view') > -1 }">
										<input type="button" value="查看" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device" disabled="disabled"
												onclick="com.yunt.index.loadInner('${path}/checkstorage/view?checkstorageId=${checkstorage.id }','查看盘库详情')" />
										&nbsp;&nbsp;
									</c:if>
									<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_input') > -1 }">
										<input type="button" value="继续完成" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/checkstorage/input?checkstorageId=${checkstorage.id}', '添加盘库详情');" />
										&nbsp;&nbsp;
									</c:if>
									<c:if test="${fn:indexOf(user.role.operationCodes,'checkstorage_doDeleteEmpty') > -1 }">
										<a class="btn btn-default btn-xs " style=" " href="javascript:void(0);" onclick="com.yunt.checkstorage.list.doDeleteEmpty('${checkstorage.id }')">删除空单</a>
										&nbsp;&nbsp; 
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
					formId="theForm" pageName="com.yunt.index" />
			</div>
		</div>
	</form>

	<!-- 新增弹框 -->
	<div id="checkstorage_add_list" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">盘点设置</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_checkstorage" role="form" onsubmit="return false;">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">盘点仓库:</label>
							<div class="col-xs-8">
								<select class="form-control" name="checkstorage_storage_id" id="checkstorage_storage_id" style="width: 70%; display: inline-block;">
									<option value="" selected="selected">选择仓库</option>
									<c:forEach items="${storageAddList}" var="storage">
										<option value="${storage.id}">${storage.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">所属门店:</label>
							<div class="col-xs-8">
								<select class="form-control" name="store_id" id="store_id" style="width: 70%; display: inline-block;">
									<option value="" selected="selected">选择门店</option>
									<c:forEach items="${storeAddList}" var="store">
										<option value="${store.id}">${store.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">备注:</label>
							<div class="col-xs-8">
								<input type="text" id="model_remark" name="model_remark" class="form-control"
										placeholder="备注……" maxlength="20" style="width: 70%; value="${model.remark}">
							</div>
						</div>

						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="toCheckstorage()" class="btn btn-primary btn-block" value="前往盘库">
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
	<script>
		$(document).ready(function() {
			//$('#testForm_save_attachment').bootstrapValidator();//初始化验证
			$('#testForm_save_checkstorage').bootstrapValidator({
				messagse : '此值无效',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					'checkstorage_storage_id' : {
						message : '请选择仓库',
						validators : {
							notEmpty : {
								message : '请选择仓库!'
							}
						}
					},
					'store_id' : {
						message : '请选择门店',
						validators : {
							notEmpty : {
								message : '请选择门店!'
							}
						}
					}
				}
			});
		});
		function toCheckstorage() {
			var isSuccess = true;
			if ($('#testForm_save_checkstorage').data('bootstrapValidator').validate().isValid()) {
				var storageId = $("#checkstorage_storage_id").val().trim();
				var storeId = $("#store_id").val().trim();
				var remark = $("#model_remark").val().trim();
				if (isSuccess) {
					$.ajax({
						url : "${path}/checkstorage/saveOrUpdate?model.storage.id="+storageId+"&model.store.id="+storeId+"&model.remark="+remark,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								$("#checkstorage_add_list").modal("hide");
								setTimeout(function(){
									com.yunt.index.loadInner('${path}/checkstorage/input?' + 'checkstorageId=' + data.obj.id, '添加盘点');
								},500);
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
						}
					});
				}
			}
		}
		function toSave() {
			$('#testForm_save_checkstorage')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#testForm_save_checkstorage').bootstrapValidator('resetForm', true);
			$("#checkstorage_add_list").modal("show");
		}
	</script>
</body>
</html>
