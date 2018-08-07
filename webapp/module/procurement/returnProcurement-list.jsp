<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.returnProcurement.list");
	var isSuccess = true;
	com.yunt.returnProcurement.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/procurement/returnList?model.procurementCode='
				+ $("#model_procurementCode").val().trim()
				+ '&model.vende.id='
				+ $("#model_vende_id").val().trim()
				+ '&model.store.id='
				+ $("#model_store_id").val().trim()
				+"&model.startDate=" + $("#procurement_startDate_select").val().trim()
				+"&model.endDate=" + $("#procurement_endDate_select").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#procurement_endDate_select").val().trim() != ''){
					if(compareCurrentDate($("#procurement_endDate_select").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#procurement_startDate_select").val().trim() != ''){
					if(compareCurrentDate($("#procurement_startDate_select").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#procurement_startDate_select").val().trim() != '' && $("#procurement_endDate_select").val().trim() != ''){
					if(!compareDate($("#procurement_endDate_select").val(),$("#procurement_startDate_select").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/procurement/doDelete?id="+id+"&isReturn=isReturn",
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success(data.msg);
							com.yunt.returnProcurement.list.refresh();
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
			<div class="col-xs-4">
				<c:if
					test="${fn:indexOf(user.role.operationCodes,'procurement_add') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)" type="button" class="btn btn-danger"
							onclick="toSave()"> <span
							class="glyphicon glyphicon-new-window"></span> 添加采购退货单
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-8">
				<form class="form-inline pull-right" action="" id="search"
					procurement="form">
					<div class="form-group">
						<select class="form-control" name="model.store.id"
							id="model_store_id">
							<option value="" selected="selected">门店</option>
							<c:forEach items="${storeList}" var="store">
								<option value="${store.id}"
									<c:if test="${model.store.id eq store.id }">selected="selected"</c:if>>${store.name}</option>
							</c:forEach>
						</select> 
						<select class="form-control" name="model.vende.id"
							id="model_vende_id">
							<option value="" selected="selected">供应商</option>
							<c:forEach items="${vendeList}" var="vende">
								<option value="${vende.id}"
									<c:if test="${model.vende.id eq vende.id }">selected="selected"</c:if>>${vende.name}</option>
							</c:forEach>
						</select>
						<input type="text" id="model_procurementCode"
							name="model.procurementCode" class="form-control"
							placeholder="单号……" maxlength="20"
							value="${model.procurementCode }">
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="结束日期" id="procurement_endDate_select" value="${model.endDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="开始日期" id="procurement_startDate_select" value="${model.startDate }" />
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.returnProcurement.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>

	<form id="theForm"
		action="${path}/procurement/list?model.procurementCode=${model.procurementCode}&model.store.id=${model.store.id}&model.vende.id=${model.vende.id}&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>采购退货</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">退货单号</th>
						<th class="text-center">供应商</th>
						<th class="text-center">门店</th>
						<th class="text-center">状态</th>
						<th class="text-center">创建时间</th>
						<th class="text-center">发货时间</th>
						<th class="text-center">创建人</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="procurement"
						varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${procurement.procurementCode }</td>
							<td class="text-center">${procurement.vende.name}</td>
							<td class="text-center">${procurement.store.name}</td>
							<td class="text-center">${procurement.stateValue }</td>
							<td class="text-center">
								<fmt:formatDate value="${procurement.createTime }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">
								<c:if test="${empty procurement.procurementDate }">
									未发货
								</c:if>
								<c:if test="${not empty procurement.procurementDate }">
									<fmt:formatDate value="${procurement.procurementDate }" pattern="yyyy-MM-dd" />
								</c:if>
							</td>
							<td class="text-center">${procurement.fu_string }</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_view') > -1 }">
										<input type="button" value="查看" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/returnView?procurementId=${procurement.id }','查看商品信息')" />
										&nbsp;&nbsp;
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_update') > -1 }">
									<c:if test="${user.id eq procurement.fu || (user.id ne procurement.fu && '3' ne user.role.type)}">
										<c:if test="${'7' eq procurement.state}">
											<input type="button" value="继续填写" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/procurement/returnInput?storeId=${procurement.store.id}&procurementId=${procurement.id}', '添加采购退货');" />
											&nbsp;&nbsp;
										</c:if>
										<c:if test="${'5' eq procurement.state}">
											<input type="button" value="修改" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/procurement/returnInput?storeId=${procurement.store.id}&procurementId=${procurement.id}', '添加采购退货');" />
											&nbsp;&nbsp;
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_check') > -1 && '1' eq procurement.state }">
									<input type="button" value="审核" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/returnInput?procurementId=${procurement.id }&storeId=${procurement.store.id }','审核退货订单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_proGoodsGoHome') > -1 && '3' eq procurement.state }">
									<input type="button" value="确认发货" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/returnInput?procurementId=${procurement.id }&isCheck=proGoodsGoHome&storeId=${procurement.store.id }','确认发货')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_printView') > -1 }">
									<c:if test="${'4' eq procurement.state}">
										<input type="button" value="打印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="window.open('${path}/procurement/returnProcurementPrintView?procurementId=${procurement.id }','打印订单信息')" />
										&nbsp;&nbsp;
									</c:if>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.returnProcurement.list.doDelete('${procurement.id }')">删除</a>
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
					formId="theForm" pageName="com.yunt.index" />
			</div>
		</div>
	</form>

	<!-- 新增弹框 -->
	<div id="procurement_add_list" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">采购退货设置</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_procurement"
							role="form" onsubmit="return false;">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">供应商:</label>
							<div class="col-xs-8">
								<select class="form-control" name="procurement_vende_id"
									id="procurement_vende_id"
									style="width: 70%; display: inline-block;">
									<option value="" selected="selected">选择供应商</option>
									<c:forEach items="${vendeList}" var="vende">
										<option value="${vende.id}">${vende.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">门店:</label>
							<div class="col-xs-8">
								<select class="form-control" name="store_id" id="store_id"
									style="width: 70%; display: inline-block;">
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
								<input type="text" id="model_remark"
								name="model_remark" class="form-control"
								placeholder="备注……" maxlength="20" style="width: 70%;
								value="${model.remark}">
							</div>
						</div>

						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="toProcurement()" class="btn btn-primary btn-block" value="前往退货">
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
			$('#testForm_save_procurement').bootstrapValidator({
				messagse : '此值无效',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					'procurement_vende_id' : {
						message : '请选择供货商',
						validators : {
							notEmpty : {
								message : '请选择供货商!'
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
		function toProcurement() {
			var isSuccess = true;
			if ($('#testForm_save_procurement').data('bootstrapValidator').validate().isValid()) {
				var vendeId = $("#procurement_vende_id").val().trim();
				var storeId = $("#store_id").val().trim();
				var remark = $("#model_remark").val().trim();
				if (isSuccess) {
					$.ajax({
						url : "${path}/procurement/returnSaveOrUpdate?model.vende.id="+vendeId+"&model.store.id="+storeId+"&model.remark="+remark,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								$("#procurement_add_list").modal("hide");
								setTimeout(function(){
									com.yunt.index.loadInner('${path}/procurement/returnInput?'
											+ 'storeId=' + $("#store_id").val().trim()
											+ '&procurementId=' + data.obj.id, '添写采购退货');
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
			$('#testForm_save_procurement')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#testForm_save_procurement').bootstrapValidator('resetForm', true);
			$("#procurement_add_list").modal("show");
		}
	</script>
</body>
</html>
