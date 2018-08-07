<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.finance.procurement.list");
	com.yunt.finance.procurement.list = {
		refresh : function(isSelect) {
			var href_string = "${path}/finance/procurementList"
				+ "?model.vende.name=" + $("#vendeName").val().trim()
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
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" procurement="form">
					<div class="form-group">
						<input type="text" id="vendeName" class="form-control" placeholder="供应商名字" maxlength="20">
						<input type="text" id="storeCode" class="form-control" placeholder="门店编号" maxlength="20">
						<input type="text" id="proCode" class="form-control" placeholder="单号" maxlength="20">
						<lable>申请日期：</lable>
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.finance.procurement.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/finance/procurementList?model.type=${model.type}&model.vende.name=${model.vende.name}&model.store.storeCode=${model.store.storeCode}&model.procurementCode=${model.procurementCode}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>供货采购订单</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">单号</th>
						<th class="text-center">供应商</th>
						<th class="text-center">门店</th>
						<th class="text-center">类型</th>
						<th class="text-center">件数总计</th>
						<th class="text-center">金额总计</th>
						<th class="text-center">状态</th>
						<th class="text-center">收发时间</th>
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
							<td class="text-center">${procurement.type_value_lest }</td>
							<td class="text-center">${procurement.buyCount }</td>
							<td class="text-center">${procurement.buySumMoney }</td>
							<td class="text-center">${procurement.stateValue }</td>
							<td class="text-center">
								<fmt:formatDate value="${procurement.procurementDate }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'finance_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/finance/procurementView?id=${procurement.id }&type=${procurement.type }','查看订单信息')" />
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
