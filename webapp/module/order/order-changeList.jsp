<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.order.list");
	com.yunt.order.list = {
		refresh : function(isSelect) {
			var href_string = "${path}/order/changeList"
				+ "?model.state=" + $("#model_state").val().trim()
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
	
	function updateOrderStateBySeven(id) {
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
						com.yunt.order.list.refresh();
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
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-2">
				<c:if test="${fn:indexOf(user.role.operationCodes,'order_changeInput') > -1 }">
					<c:if test="${not empty user.store.id }">
						<div class="quick-add-btn">
							<a href="javascript:void(0)"type="button" class="btn btn-danger" onclick="com.yunt.index.loadInner('${path}/order/changeInput','添加换货单');">
								<span class="glyphicon glyphicon-new-window"></span> 添加换货单
							</a>
						</div>
					</c:if>
				</c:if>
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
						<input type="text" id="orderCode" class="form-control" value="${model.code}" placeholder="换货单号" maxlength="20">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.order.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/order/changeList?model.state=${model.state}&model.code=${model.code}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>换货单</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">单号</th>
						<th class="text-center">门店</th>
						<th class="text-center">类型</th>
						<th class="text-center">换货日期</th>
						<th class="text-center">导购</th>
						<th class="text-center">换货人</th>
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
							<td class="text-center">${order.order.store.name }</td>
							<td class="text-center">${order.typeValue }</td>
							<td class="text-center">
								<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">${order.order.guideUser.username }</td>
							<td class="text-center">
								<c:if test="${empty order.customer.name}">
									空
								</c:if>
								<c:if test="${not empty order.customer.name}">
									${order.customer.name }
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${empty order.customer.phone}">
									空
								</c:if>
								<c:if test="${not empty order.customer.phone}">
									${order.customer.phone }
								</c:if>
							</td>
							<td class="text-center">
								${order.stateValue}
							</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_changeView') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/order/changeView?id=${order.id }','查看换货单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_print') > -1 }">
									<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="window.open('${path}/order/changePrintView?id=${order.id }','打印单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_updateOrderStateBySeven') > -1 }">
										<input type="button" value="放弃" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="updateOrderStateBySeven('${order.id}')"
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
	
	<!-- 新增弹框 -->
	<div id="order_add_list" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">换货商品录入</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_order"
							role="form" onsubmit="return false;">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">换货商品</label>
							<div class="col-xs-6">
								<input type="text" name="order_goods_qrcode_id" value="" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="search_input" placeholder="商品二维码扫码框~"/>
							</div>
						</div>

						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="toProcurement()" class="btn btn-primary btn-block" value="前往换货">
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
	</script>
</body>
</html>
