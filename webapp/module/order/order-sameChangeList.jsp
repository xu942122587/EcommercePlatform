<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.order.sameChange.list");
	com.yunt.order.sameChange.list = {
		refresh : function(isSelect) {
			var href_string = "${path}/order/sameChangeList"
				+ "?model.code=" + $("#orderCode").val().trim()
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
						com.yunt.order.sameChange.list.refresh();
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
				<c:if test="${fn:indexOf(user.role.operationCodes,'order_sameChangeInput') > -1 }">
					<c:if test="${not empty user.store.id }">
						<div class="quick-add-btn">
							<a href="javascript:void(0)"type="button" class="btn btn-danger" onclick="toSave()">
								<span class="glyphicon glyphicon-new-window"></span> 添加同商品换货单
							</a>
						</div>
					</c:if>
				</c:if>
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" order="form">
					<div class="form-group">
						<%-- <label for="product-uuid" class="control-label">订单状态:</label>
						<select class="form-control" name="model.state" id="model_state">
							<option value="" >全部</option>
							<option value="1" <c:if test="${'1' eq model.state}">selected="selected"</c:if>>未支付</option>
							<option value="6" <c:if test="${'6' eq model.state}">selected="selected"</c:if>>完成</option>
							<option value="7" <c:if test="${'7' eq model.state}">selected="selected"</c:if>>放弃</option>
						</select> --%>
						<input type="text" id="orderCode" class="form-control" value="${model.code}" placeholder="换货单号" maxlength="20">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.order.sameChange.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/order/sameChangeList?model.code=${model.code}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
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
						<th class="text-center">客户</th>
						<th class="text-center">联系电话</th>
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
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_sameChangeView') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/order/sameChangeView?id=${order.id }','查看换货单信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'order_print') > -1 }">
										<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="window.open('${path}/order/sameChangePrintView?id=${order.id }','打印换货单信息')" />
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
							<label for="device-description" class="col-xs-4 control-label">换货订单</label>
							<div class="col-xs-6">
								<input type="text" name="order_id" value="" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="search_input_one" placeholder="订单二维码扫码框~"/>
							</div>
						</div>
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">原单商品</label>
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
	$(document).ready(function() {
			//$('#testForm_save_attachment').bootstrapValidator();//初始化验证
			$('#testForm_save_order').bootstrapValidator({
				messagse : '此值无效',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					'order_goods_qrcode_id' : {
						message : '请输入换货商品',
						validators : {
							notEmpty : {
								message : '请输入换货商品!'
							}
						}
					}
				}
			});
		});
	
	function toProcurement() {
		if ($('#testForm_save_order').data('bootstrapValidator').validate().isValid()) {
			var qrcodeId = $("#search_input").val().trim();
			var orderId = $("#search_input_one").val().trim();
			$.ajax({
				url : "${path}/order/getOrderIdByCode?code="+orderId,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						orderId=data.obj;
						toastr.success(data.msg);
						$.ajax({
							url : "${path}/order/qrcodeIsSaleByChange?qrcodeId="+qrcodeId+"&orderId="+orderId,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									$("#order_add_list").modal("hide");
									if(orderId == data.obj[1]){
										setTimeout(function(){
											com.yunt.index.loadInner('${path}/order/sameChangeInput?qrcodeId='+qrcodeId+"&orderId="+orderId,'查看换货单信息');
											},500);
									}else{
										toastr.error("该商品不属于该订单!");
									}
								} else {
									//setEmbed();
									toastr.error(data.msg);
									$("#search_input").val("");
									$("#search_input_one").val("");
								}
							},
							error : function(xhr, type, exception) {
								//setEmbed();
								toastr.error("请检查网络设置");
							}
						});
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
	
	function toSave() {
		$('#testForm_save_order')[0].reset();
		//只能清除验证，无法清除不带验证input标签的数据
		$('#testForm_save_order').bootstrapValidator('resetForm', true);
		$("#order_add_list").modal("show");
	}
	
	/**
	 * 二维码扫码框监听
	 */
	$('#search_input').bind('keyup', function(event) {
		isSuccess = true;
		var search_input_value="";
		if (event.keyCode == "13") {
			search_input_value = $("#search_input").val().trim();
		}
	});
	
	/**
	 * 去掉页面所有的input的回车监听
	 */
	$(document).on('keyup','#theForm input', function(event){
		if (event.keyCode == "13") {
			return false;
		}
	}).on('keypress','#theForm input', function(event){
		if (event.keyCode == "13") {
			return false;
		}
	}).on('keydown','#theForm input', function(event){
		if (event.keyCode == "13") {
			return false;
		}
	});
	</script>
</body>
</html>
