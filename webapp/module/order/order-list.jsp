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
			var href_string = "${path}/order/list?model.customer.id=${model.customer.id}&pageName=${pageName}"
				+ "&model.type=${model.type}&model.state=" + $("#model_state").val().trim()
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
			<c:if test="${not empty pageName}">
				${pageName}.load(href_string);
			</c:if>
			<c:if test="${empty pageName}">
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
			</c:if>
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
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" order="form">
					<div class="form-group">
						<label for="product-uuid" class="control-label">订单状态:</label>
						<select class="form-control" name="model.state" id="model_state">
							
							<c:if test="${not empty pageName}">
								<option value="" >全部</option>
								<option value="1" <c:if test="${'1' eq model.state}">selected="selected"</c:if>>未支付</option>
								<option value="2" <c:if test="${'2' eq model.state}">selected="selected"</c:if>>未发货</option>
								<option value="3" <c:if test="${'3' eq model.state}">selected="selected"</c:if>>已出库</option>
								<option value="4" <c:if test="${'4' eq model.state}">selected="selected"</c:if>>已发货</option>
								<option value="5" <c:if test="${'5' eq model.state}">selected="selected"</c:if>>待评价</option>
								<option value="6" <c:if test="${'6' eq model.state}">selected="selected"</c:if>>完成</option>
								<option value="7" <c:if test="${'7' eq model.state}">selected="selected"</c:if>>放弃</option>
							</c:if>
							<c:if test="${empty pageName}">
								<option value="" >全部</option>
								<option value="1" <c:if test="${'1' eq model.state}">selected="selected"</c:if>>未支付</option>
								<c:if test="${'1' eq model.type}">
									<option value="2" <c:if test="${'2' eq model.state}">selected="selected"</c:if>>未发货</option>
									<option value="3" <c:if test="${'3' eq model.state}">selected="selected"</c:if>>已出库</option>
									<option value="4" <c:if test="${'4' eq model.state}">selected="selected"</c:if>>已发货</option>
									<option value="5" <c:if test="${'5' eq model.state}">selected="selected"</c:if>>待评价</option>
								</c:if>
								<option value="6" <c:if test="${'6' eq model.state}">selected="selected"</c:if>>完成</option>
								<option value="7" <c:if test="${'7' eq model.state}">selected="selected"</c:if>>放弃</option>
							</c:if>
						</select>
						<input type="text" id="orderCode" class="form-control" value="${model.code}" placeholder="订单号" maxlength="20">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.order.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>
	<form id="theForm" action="${path}/order/list?model.customer.id=${model.customer.id}&pageName=${pageName}&model.type=${model.type}&model.state=${model.state}&model.code=${model.code}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>订单</h5>
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
						<c:if test="${'1' ne model.type}">
							<th class="text-center">导购</th>
						</c:if>
						<th class="text-center">支付类型</th>
						<th class="text-center">会员</th>
						<th class="text-center">会员联系电话</th>
						<c:if test="${'4' eq model.type }">
							<th class="text-center">预约人</th>
							<th class="text-center">预约人联系电话</th>
						</c:if>
						<th class="text-center">订单状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="order" varStatus="i">
						<c:if test="${empty order.order }">
							<tr>
								<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
								<td class="text-center">${order.code }</td>
								<td class="text-center">${order.store.name }</td>
								<td class="text-center">${order.typeValue }</td>
								<td class="text-center">
									<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd" />
								</td>
								<c:if test="${'1' ne model.type}">
									<td class="text-center">${order.guideUser.username }</td>
								</c:if>
								<td class="text-center">
									<c:if test="${'4' eq order.type && not empty order.onePayTypeValue}">
										1: 
											${order.onePayTypeValue}
										<c:if test="${not empty order.twoPayType}">
											&nbsp;︱&nbsp;
										2: 
										</c:if>
										<c:if test="${not empty order.onePayTypeValue}">
											${order.twoPayTypeValue}
										</c:if>
									</c:if>
									<c:if test="${'4' eq order.type &&empty order.onePayTypeValue}">
										无
									</c:if>
									<c:if test="${'4' ne order.type && not empty order.onePayTypeValue}">
										${order.onePayTypeValue }
									</c:if>
								</td>
								<td class="text-center">
									${order.customer.name }
								</td>
								<td class="text-center">
									${order.customer.phone }
								</td>
								<c:if test="${'4' eq model.type }">
									<td class="text-center">${order.reserveName }</td>
									<td class="text-center">${order.reservePhone }</td>
								</c:if>
								<td class="text-center">
									${order.stateValue}
								</td>
								<td class="text-center">
									<c:if test="${not empty pageName}">
										<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.index.loadInner('${path}/order/view?id=${order.id }','查看订单信息')" />
										&nbsp;&nbsp; 
									</c:if>
									<c:if test="${empty pageName}">
										<c:if test="${fn:indexOf(user.role.operationCodes,'order_changeView') > -1 }">
											<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
													onclick="com.yunt.index.loadInner('${path}/order/view?id=${order.id }','查看订单信息')" />
											&nbsp;&nbsp; 
										</c:if>
										<c:if test="${'4' eq order.type }">
											<c:if test="${'1' eq order.state}">
												<c:if test="${empty order.reserveMoney }">
													<c:if test="${fn:indexOf(user.role.operationCodes,'update_reserveOrder') > -1 }">
														<input type="button" value="补录定金" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
																onclick="com.yunt.index.loadInner('${path}/order/reserveOrderInput?orderId=${order.id }','补录定金')" />
														&nbsp;&nbsp; 
													</c:if>
												</c:if>
												<c:if test="${not empty order.reserveMoney }">
													<c:if test="${not empty order.cashierCode }">
														<c:if test="${order.qrcodeCount ne order.sumNumber  }">
															<c:if test="${fn:indexOf(user.role.operationCodes,'update_reserveOrder') > -1 }">
																<input type="button" value="预约发货" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
																		onclick="com.yunt.index.loadInner('${path}/order/reserveOrderInput?orderId=${order.id }','预约发货')" />
																&nbsp;&nbsp; 
															</c:if>
														</c:if>
													</c:if>
												</c:if>
											</c:if>
											<c:if test="${fn:indexOf(user.role.operationCodes,'order_print') > -1 }">
												<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
														onclick="window.open('${path}/order/reservePrintView?id=${order.id }','打印预约单')" />
												&nbsp;&nbsp; 
											</c:if>
										</c:if>
										<c:if test="${'1' eq order.type }">
											<c:if test="${'2' eq order.state}">
												<c:if test="${fn:indexOf(user.role.operationCodes,'update_receiverOrder') > -1 }">
													<input type="button" value="线上出库" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
															onclick="com.yunt.index.loadInner('${path}/order/receiverOrderInput?orderId=${order.id }','线上出库')" />
													&nbsp;&nbsp; 
												</c:if>
											</c:if>
											<c:if test="${fn:indexOf(user.role.operationCodes,'order_print') > -1 || '4' eq model.state || '5' eq model.state || '6' eq model.state}">
												<input type="button" value="补印发货单" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
														onclick="window.open('${path}/order/receiverPrintView?id=${order.id }','打印发货单')" />
												&nbsp;&nbsp; 
											</c:if>
											<c:if test="${'3' eq order.state}">
												<c:if test="${fn:indexOf(user.role.operationCodes,'update_sendGoodsOrder') > -1 }">
													<input type="button" value="线上发货" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
															onclick="com.yunt.index.loadInner('${path}/order/sendGoodsOrder?orderId=${order.id }','线上发货')" />
													&nbsp;&nbsp; 
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${'2' eq order.type }">
											<c:if test="${fn:indexOf(user.role.operationCodes,'order_print') > -1 }">
												<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
														onclick="window.open('${path}/order/salePrintView?id=${order.id }','打印订单信息')" />
												&nbsp;&nbsp; 
											</c:if>
										</c:if>
										<c:if test="${fn:indexOf(user.role.operationCodes,'order_updateOrderStateBySeven') > -1 && '2' ne order.store.type}">
												<input type="button" value="放弃" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
													onclick="updateOrderStateBySeven('${order.id}')"
													<c:if test="${'1' ne order.state}">
														disabled="disabled"	
													</c:if>/>
												&nbsp;&nbsp;
										</c:if>
									</c:if>
									
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
			<div class="clearfix">
				<c:if test="${not empty pageName}">
					<pager:createPager pageSize="${pageObj.pageSize}"
							totalPage="${pageObj.totalPage}"
							totalCount="${pageObj.totalRecord}" curPage="${pageObj.pageNo}"
							formId="theForm" 
							pageName="${pageName}"/>
				</c:if>
				<c:if test="${empty pageName}">
					<pager:createPager pageSize="${pageObj.pageSize}"
							totalPage="${pageObj.totalPage}"
							totalCount="${pageObj.totalRecord}" curPage="${pageObj.pageNo}"
							formId="theForm" 
							pageName="com.yunt.index"/>
				</c:if>
			</div>
		</div>
	</form>
	
	<script>
	</script>
</body>
</html>
