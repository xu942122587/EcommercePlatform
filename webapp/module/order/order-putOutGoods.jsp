<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.putOutGoods");
	com.yunt.order.putOutGoods = {
		
	};
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">领取赠品</label>
					</div>

					<div class="form-group">
						<label for="device-description" class="col-xs-2 control-label">订单单号</label>
						<div class="col-xs-3">
							<input type="text" step="1" value="${orderCode }" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="orderCode_input" />
						</div>
					</div>

					<c:if test="${not empty orderCode && not empty model.id && ('1' eq model.type || '2' eq model.type || '4' eq model.type ) }">
						<c:if test="${empty model.proType && not empty putOutGoodsList}">
							<div class="form-group">
								<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">可领赠品</label>
							</div>

							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">订单号</label>
								<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>

								<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
								<div class="col-xs-3" style="padding-top:7px;">${model.store.name }</div>
							</div>

							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>可领赠品列表</h5>
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
										<c:forEach items="${putOutGoodsList }" var="goods_">
											<tr>
												<td>${goods_.goodsCode }</td>
												<td>${goods_.name }</td>
												<td>${goods_.putOutNumber }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>


							<div class="form-group">
								<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">领取明细</label>
							</div>

							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">赠品二维码</label>
								<div class="col-xs-3">
									<input type="text" step="1" value="" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="putOutGoods_input" />
								</div>
							</div>

							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>领取明细</h5>
								</div>

								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">商品二维码</th>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">数量</th>
											<th class="text-center">操作</th>
										</tr>
									</thead>
									<tbody id="putout_qrcode_all">
										<tr id="putout_qrcode_one_copy" style="display: none;">
											<td id="qrcode_id"></td>
											<td id="goodsCode"></td>
											<td id="goodsName"></td>
											<td>1</td>
											<td><input type="button" qrcode_id="" class="btn btn-danger btn-xs delete_putout_qrcode"  value="删除"></td>
										</tr>
										<c:forEach items="${putOutQrcodeList }" var="qrcode">
											<tr>
												<td id="qrcode_id">${qrcode.id }</td>
												<td id="goodsCode">${qrcode.goods.goodsCode }<c:if test="${empty qrcode.goods.goodsCode }">${qrcode.goods.goods.goodsCode }</c:if></td>
												<td id="goodsName">${qrcode.goods.name }<c:if test="${empty qrcode.goods.name }">${qrcode.goods.goods.name }</c:if></td>
												<td>1</td>
												<td><input type="button" qrcode_id="${qrcode.id }" class="btn btn-danger btn-xs delete_putout_qrcode" value="删除"></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<div class="form-group col-xs-8 pull-right">
								<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
							</div>
						</c:if> 
					</c:if> 

				</form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var orderCode_test = /^[0-9]{16}$/,
			qrcode_id_test = /^[0-9]{32}$/;
		/**
		 * 二维码删除按钮的监听
		 */
		$(document).off("click", ".delete_putout_qrcode").on("click", ".delete_putout_qrcode", function(){
			var $_this = $(this);
			$.ajax({
				url : "${path}/order/orderDeletePutOutGoods?orderId=${model.id}&QRCodeID=" + $_this.attr("qrcode_id"),
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
		/**
		 * 二维码扫码框监听
		 */
		$('#orderCode_input').bind('keyup', function(event) {
			var search_input_value="";
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#orderCode_input").val().trim();
				$("#orderCode_input").val("");
				if(orderCode_test.test(search_input_value)){
					com.yunt.index.loadOnly("${path}/order/putOutGoods?orderCode=" + search_input_value);
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});
		/**
		 * 二维码扫码框监听
		 */
		$('#putOutGoods_input').bind('keyup', function(event) {
			var search_input_value="";
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#putOutGoods_input").val().trim();
				$("#putOutGoods_input").val("");
				if(qrcode_id_test.test(search_input_value)){
					$.ajax({
						url : "${path}/order/orderAddPutOutGoods?orderId=${model.id}&QRCodeID=" + search_input_value,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								var order_goods_one = $("#putout_qrcode_one_copy").clone();
								order_goods_one.find("#qrcode_id").html(search_input_value);
								order_goods_one.find("#goodsCode").html(data.obj.goodsCode);
								order_goods_one.find(".delete_putout_qrcode").attr("qrcode_id",search_input_value);
								order_goods_one.find("#goodsName").html(data.obj.name + data.obj.other_attr_value);
								order_goods_one.removeAttr("id");
								$("#putout_qrcode_all").append(order_goods_one.show());
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
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});
		$(function(){
			<c:if test="${not empty orderCode && empty model.id }">
				toastr.error("订单暂时无法领取哦（只有完成的订单才能领取哦）~");
				delEmbed();
				setEmbed();
			</c:if>
			<c:if test="${not empty orderCode && not empty model.id && '1' ne model.type && '2' ne model.type && '4' ne model.type  }">
				toastr.error("退货、换货、换购类订单不可领取赠品哦~");
				delEmbed();
				setEmbed();
			</c:if>
			<c:if test="${not empty orderCode && not empty model.id && ('1' eq model.type || '2' eq model.type || '4' eq model.type ) }">
				<c:if test="${not empty model.proType }">
					toastr.error("本订单不可领取赠品~");
					delEmbed();
					setEmbed();
				</c:if>
				<c:if test="${empty model.proType && empty putOutGoodsList }">
					toastr.error("本订单没有可领取赠品~");
					delEmbed();
					setEmbed();
				</c:if>
			</c:if>
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
