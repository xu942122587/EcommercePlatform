<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.procurement.list");
	com.yunt.procurement.list = {
		refresh : function(isSelect) {
			var href_string = "${path}/procurement/list?model.type=${model.type}"
				+ "&model.store.storeCode=" + $("#storeCode").val().trim()
				+ "&model.procurementCode=" + $("#proCode").val().trim()
				+ "&model.startDate=" + $("#startDate").val().trim()
				+ "&model.endDate=" + $("#endDate").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#endDate").val().trim() != ''){
					if(compareCurrentDate($("#endDate").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#startDate").val().trim() != ''){
					if(compareCurrentDate($("#startDate").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#startDate").val().trim() != '' && $("#endDate").val().trim() != ''){
					if(!compareDate($("#endDate").val(),$("#startDate").val())){
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
					url : "${path}/procurement/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success(data.msg);
							com.yunt.procurement.list.refresh();
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
	$(function() {
		$('.form-control.date').datepicker({
			format : "yyyy-mm-dd",
			todayBtn : "linked",
			clearBtn : true,
			language : "zh-CN",
			todayHighlight : true
		});
	});
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-2">
				<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_add') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger" onclick="com.yunt.index.loadInner('${path}/procurement/input?proType=${model.type}&isCheck=no','添加${model.type_value_lest}订单')">
							<span class="glyphicon glyphicon-new-window"></span> 添加${model.type_value_lest}订单
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" procurement="form">
					<div class="form-group">
						<input type="text" id="storeCode" class="form-control" placeholder="门店编号" maxlength="20">
						<input type="text" id="proCode" class="form-control" placeholder="${model.type_value_lest}单号" maxlength="20">
						<lable>申请日期：</lable>
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.procurement.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/procurement/list?model.type=${model.type}&model.store.storeCode=${model.store.storeCode}&model.procurementCode=${model.procurementCode}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>${model.type_value_lest}订单</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">${model.type_value_lest}单号</th>
						<th class="text-center">供应商</th>
						<th class="text-center">门店</th>
						<th class="text-center">申请件数</th>
						<th class="text-center">申请金额</th>
						<th class="text-center">到货件数</th>
						<th class="text-center">到货金额</th>
						<th class="text-center">状态</th>
						<th class="text-center">到货时间</th>
						<th class="text-center">创建人</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="procurement" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${procurement.procurementCode }</td>
							<td class="text-center">${procurement.vende.name }</td>
							<td class="text-center">${procurement.store.name }</td>
							<td class="text-center">${procurement.count }</td>
							<td class="text-center">${procurement.sumMoney }</td>
							<td class="text-center">${procurement.buyCount }</td>
							<td class="text-center">${procurement.buySumMoney }</td>
							<td class="text-center">${procurement.stateValue }</td>
							<td class="text-center">
								<fmt:formatDate value="${procurement.procurementDate }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">${procurement.fu_string }</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_update') > -1 }">
									<c:if test="${user.id eq procurement.fu && '5' eq procurement.state }">
										<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/procurement/input?id=${procurement.id }&proType=${model.type}&isCheck=no','修改${model.type_value_lest}订单信息')" />
										&nbsp;&nbsp;
									</c:if>
									<%-- <c:if test="${user.id ne procurement.fu && ('2' eq procurement.state || '3' eq procurement.state)}">
										<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/procurement/input?id=${procurement.id }&proType=${model.type}&isCheck=no','修改${model.type_value_lest}订单信息')" />
										&nbsp;&nbsp; 
									</c:if> --%>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_check') > -1 && '1' eq procurement.state }">
									<input type="button" value="审核" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/input?id=${procurement.id }&proType=${model.type}&isCheck=yes','审核${model.type_value_lest}订单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_proGoodsGoHome') > -1 && '2' eq procurement.state && '1' eq model.type }">
									<input type="button" value="采购到货" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/input?id=${procurement.id }&proType=${model.type}&isCheck=proGoodsGoHome','采购到货')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/procurement/view?id=${procurement.id }','查看${model.type_value_lest}订单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_printView') > -1 }">
									<c:if test="${'4' eq procurement.state}">
										<input type="button" value="打印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="window.open('${path}/procurement/procurementPrintView?procurementId=${procurement.id }','打印订单信息')" />
										&nbsp;&nbsp; 
									</c:if>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_printView') > -1 }">
									<c:if test="${'2' eq procurement.state}">
										<input type="button" value="打印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="window.open('${path}/procurement/procurementPrintView?procurementId=${procurement.id }','打印订单信息')" />
										&nbsp;&nbsp; 
									</c:if>
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'procurement_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.procurement.list.doDelete('${procurement.id }')">删除</a>
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
