<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.sendGoodsOrder");
	com.yunt.order.sendGoodsOrder = {
		submit : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/order/updateSendGoodsOrder",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								com.yunt.index.toPreIndex();
							} else {
								toastr.error(data.msg);
								delEmbed();
								setEmbed();
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
							delEmbed();
							setEmbed();
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.order.sendGoodsOrder.submit(); return false;"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<input type="hidden" name="model.id" value="${model.id }"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">订单详情</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">订单号</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.store.storeCode }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.store.name }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">客户名</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.customer.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">客户手机号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.customer.phone }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">收货人</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.receiverName }</div>

						<label for="product-uuid" class="col-xs-2 control-label">收货电话</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.receiverPhone }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">收货地址</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.receiverAddress }</div>

						<label for="product-uuid" class="col-xs-2 control-label">邮费</label>
						<div class="col-xs-3" style="padding-top:7px;">暂无</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">快递姓名</label>
						<div class="col-xs-3">
							<input type="text" class="form-control" value="${model.expressName }" name="model.expressName">
						</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">快递电话</label>
						<div class="col-xs-3">
							<input type="text" class="form-control" value="${model.expressPhone }" name="model.expressPhone"
								pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$"
								data-bv-regexp-message="请输入正确的联系电话">
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">快递公司</label>
						<div class="col-xs-3">
							<input type="text" class="form-control" value="${model.logistics }" name="model.Logistics">
						</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">快递单号</label>
						<div class="col-xs-3">
							<input type="text" class="form-control" value="${model.logisticsCode }" name="model.LogisticsCode">
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">客户备注</label>
						<div class="col-xs-8" style="padding-top: 7px;">${model.leaveMessage }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">线上订单明细</label>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>发货产品</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<th class="text-center">数量</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${model.orderList }" var="childOrder">
									<c:forEach items="${childOrder.orderGoodList }" var="orderGoods">
										<tr >
											<td >
												<c:if test="${empty orderGoods.goods.goodsCode }">
													${orderGoods.goods.goods.goodsCode }
												</c:if>
												<c:if test="${not empty orderGoods.goods.goodsCode }">
													${orderGoods.goods.goodsCode }
												</c:if>
											</td>
											<td>
												<c:if test="${empty orderGoods.goods.name }">
													${orderGoods.goods.goods.name }
												</c:if>
												<c:if test="${not empty orderGoods.goods.name }">
													${orderGoods.goods.name }
												</c:if>
												<c:if test="${not empty orderGoods.goods.other_attr_value }">
													${orderGoods.goods.other_attr_value }
												</c:if>
											</td>
											<td id="count">${orderGoods.count }</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
	/**
	* 重新初始化验证
	*/
	function bootstrapValidator_again(){
		$(".form-control-feedback").remove();
		$(".help-block").remove();
		$('#theForm').data('bootstrapValidator', null);
		$('#theForm').bootstrapValidator('resetForm', false);
		$('#theForm').bootstrapValidator();//初始化验证
	}
	
	$(document).ready(function() {
		$('#theForm').bootstrapValidator();//初始化验证
	});
	</script>
</body>
</html>
