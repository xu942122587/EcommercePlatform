<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.order.changeEnough");
	com.yunt.order.changeEnough = {
		refresh : function(isSelect) {
			var href_string = "${path}/order/changeEnoughList"
				+ "?model.type=${model.type}&model.state=" + $("#model_state").val().trim()
				+ "&model.code=" + $("#orderCode").val().trim()
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
		updateOrderStateBySeven : function(id) {
			$('#update_order_state').modal('show');
			$("#update_order_state_button").unbind("click").click(function() {
				$.ajax({
					url : "${path}/order/updateOrderStateBySeven?id=" + id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						if (data.success) {
							toastr.success(data.msg);
							com.yunt.order.changeEnough.refresh();
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
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" order="form">
					<div class="form-group">
						<label for="product-uuid" class="control-label">订单状态:</label>
						<select class="form-control" name="model.state" id="model_state">
							<option value="" >全部</option>
							<option value="1" <c:if test="${'1' eq model.state}">selected="selected"</c:if>>未支付</option>
							<option value="6" <c:if test="${'6' eq model.state}">selected="selected"</c:if>>完成</option>
							<option value="7" <c:if test="${'7' eq model.state}">selected="selected"</c:if>>放弃</option>
						</select>
						<input type="text" id="orderCode" class="form-control" value="${model.code}" placeholder="订单号" maxlength="20">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.order.changeEnough.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>

	<form id="theForm" action="${path}/order/changeEnoughList?model.type=${model.type}&model.state=${model.state}&model.code=${model.code}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>换购订单</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">单号</th>
						<th class="text-center">门店</th>
						<th class="text-center">类型</th>
						<th class="text-center">订单日期</th>
						<th class="text-center">会员</th>
						<th class="text-center">联系电话</th>
						<th class="text-center">订单状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="order" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${order.code }</td>
							<td class="text-center">${order.store.name }</td>
							<td class="text-center">${order.typeValue }</td>
							<td class="text-center">
								<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">
									${order.customer.name }
							</td>
							<td class="text-center">
									${order.customer.phone }
							</td>
							<td class="text-center">
								${order.stateValue}
							</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_changeEnoughView') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/order/changeEnoughView?id=${order.id }','查看换购单信息')" />
									&nbsp;&nbsp;
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_changeEnoughPrint') > -1 && '1' eq order.state}">
									<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="window.open('${path}/order/changeEnoughPrintView?id=${order.id }','打印换购单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'update_changeEnoughDelivery') > -1 && '2' eq order.state}">
									<input type="button" value="换购发货" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/order/changeEnoughDelivery?id=${order.id }','换购发货')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_updateOrderStateBySeven') > -1 }">
									<input type="button" value="放弃" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.order.changeEnough.updateOrderStateBySeven('${order.id}')"
											<c:if test="${'1' ne order.state}">
												disabled="disabled"	
											</c:if>/>
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
