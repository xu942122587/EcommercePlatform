<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.changeEnoughDelivery");
	com.yunt.order.changeEnoughDelivery = {
			submit : function() {
				if ($('#theForm').data('bootstrapValidator').isValid()) {
					if(0 >= $("#order_goods_qrcode_all tr:not(:hidden)").length){
						toastr.error("请先添加换购发货产品哦~");
						$("#ert").removeAttr("disabled");
						delEmbed();
						setEmbed();
						return false;
					}
					var formData = $("#theForm").serialize();
					if (isSuccess) {
						$.ajax({
							url : "${path}/order/saveChangeEnough",
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
				<form onsubmit="return com.yunt.order.changeEnoughDelivery.submit(); return false;"
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
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">换购明细</label>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>换购产品</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<th class="text-center">价格</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${model.orderGoodList }" var="orderGoods">
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
										<td id="money">${orderGoods.salesPrice }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">发货明细</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">发货</label>
						<div class="col-xs-3">
							<input type="text" value="" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="search_input" placeholder="商品二维码扫码框~"/>
						</div>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>商品二维码列表</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center">所属门店</th>
									<th class="text-center">商品条码</th>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<th class="text-center">售价</th>
									<th class="text-center">数量</th>
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody id="order_goods_qrcode_all">
								<tr id="order_goods_qrcode_one_copy" style="display: none;">
									<td class="text-center">${model.store.name }</td>
									<td class="text-center" id="goods_qrcode_id_td_qrcode"></td>
									<td class="text-center" id="goods_code_td_qrcode"></td>
									<td class="text-center" id="goods_name_td_qrcode"></td>
									<td class="text-center" id="goods_sales_td_qrcode"></td>
									<td class="text-center" id="goods_number_td_qrcode">1</td>
									<td class="text-center">
										<a class="btn btn-danger btn-xs delete_order_goods_qrcode_no_class" href="javascript:void(0);">删除</a>
									</td>
								</tr>
								<c:forEach items="${model.orderGoodList }" var="orderGoods">
									<c:forEach items="${orderGoods.oGQList }" var="ogqrcode">
										<tr>
											<td class="text-center">
												${model.store.name }
											</td>
											<td class="text-center">${ogqrcode.qrcode.id }</td>
											<td class="text-center">
												<c:if test="${empty ogqrcode.qrcode.goods.goodsCode }">
													${ogqrcode.qrcode.goods.goods.goodsCode }
												</c:if>
												<c:if test="${not empty ogqrcode.qrcode.goods.goodsCode }">
													${ogqrcode.qrcode.goods.goodsCode }
												</c:if>
											</td>
											<td class="text-center">
												<c:if test="${empty ogqrcode.qrcode.goods.name }">
													${ogqrcode.qrcode.goods.goods.name }
												</c:if>
												<c:if test="${not empty ogqrcode.qrcode.goods.name }">
													${ogqrcode.qrcode.goods.name }
												</c:if>
												<c:if test="${not empty orderGoods.goods.other_attr_value }">
													${orderGoods.goods.other_attr_value }
												</c:if>
											</td>
											<td class="text-center">${ogqrcode.qrcode.goods.salesPrice }</td>
											<td class="text-center">1</td>
											<td class="text-center">
												<a qrcode_id="${ogqrcode.qrcode.id }" class="btn btn-danger btn-xs delete_order_goods_qrcode_no_class" href="javascript:void(0);">删除</a>
											</td>
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
		var orderCode_test = /^[0-9]{16}$/,
			qrcode_id_test = /^[0-9]{32}$/,
			order_goods_index = 0;
			/**
			 * 添加产品tr(预约发货)
			 */
			function add_order_goods__tr(search_input_value){
				$.ajax({
					url : "${path}/order/receiverAddQrcode?orderId=${model.id}&QRCodeID=" + search_input_value,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							if(0 >= (data.obj.goods_inventory - 0)){
								toastr.error("产品：" + data.obj.name + data.obj.other_attr_value + "库存为0，不可售卖~");
								return false;
							}
							var order_goods_one = $("#order_goods_qrcode_one_copy").clone();
							order_goods_one.find("#goods_qrcode_id_td_qrcode").html(search_input_value);
							order_goods_one.find("#goods_code_td_qrcode").html(data.obj.goodsCode);
							order_goods_one.find("#goods_name_td_qrcode").html(data.obj.name+data.obj.other_attr_value);
							order_goods_one.find("#goods_sales_td_qrcode").html(data.obj.salesPrice);
							order_goods_one.find(".delete_order_goods_qrcode_no_class").attr("qrcode_id",search_input_value);
							order_goods_one.removeAttr("id");
							$("#order_goods_qrcode_all").append(order_goods_one.show());
							qrcode_index++;
						}else{
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
			/**
			 * 二维码扫码框监听
			 */
			$('#search_input').bind('keyup', function(event) {
				var search_input_value="";
				var number = -1;
				if (event.keyCode == "13") {
					search_input_value = $("#search_input").val().trim();
					$("#search_input").val("");
					if(qrcode_id_test.test(search_input_value)){
						var isNeedAdd = true;
						$("#order_goods_qrcode_all tr:not(:hidden)").each(function(){
							if($(this).find("#goods_qrcode_id_td_qrcode").html() == search_input_value){
								isNeedAdd = false;
								// 退出循环
								return;
							}
						})
						if(!isNeedAdd){
							toastr.error("本产品已经添加过了哦~换一个添加吧~");
							delEmbed();
							setEmbed();
							return false;
						}
						// 添加产品节点
						add_order_goods__tr(search_input_value);
					}else{
						toastr.error("无法识别的信息");
						delEmbed();
						setEmbed();
					}
				}
			});
			/**
			 * 二维码删除按钮的监听（预约发货）
			 */
			$(document).off("click", ".delete_order_goods_qrcode_no_class").on("click", ".delete_order_goods_qrcode_no_class", function(){
				var $_this = $(this);
				$.ajax({
					url : "${path}/order/receiverDeleteQrcode?orderId=${model.id}&QRCodeID=" + $_this.attr("qrcode_id"),
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$_this.parent().parent().hide();
							$_this.parent().parent().find("input").val("").attr("disabled", "disabled");
						}else{
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
			});
		$(function(){
			$('#theForm').bootstrapValidator();//初始化验证
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
