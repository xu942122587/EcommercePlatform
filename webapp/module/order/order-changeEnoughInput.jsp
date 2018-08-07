<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.changeEnough");
	com.yunt.order.changeEnough = {
			submit : function() {
				if ($('#theForm').data('bootstrapValidator').isValid()) {
					if(0 >= $("#putout_qrcode_all tr:not(:hidden)").length){
						toastr.error("请先添加换购产品哦~");
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
									window.open('${path}/order/changeEnoughPrintView?id=' + data.obj);
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
				<form onsubmit="return com.yunt.order.changeEnough.submit(); return false;"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">加钱换购</label>
					</div>

					<div class="form-group">
						<label for="device-description" class="col-xs-2 control-label">订单单号</label>
						<div class="col-xs-3">
							<input type="text" step="1" value="${orderCode }" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="orderCode_input" />
						</div>
					</div>

					<c:if test="${not empty orderCode && not empty model.id && ('1' eq model.type || '2' eq model.type || '4' eq model.type ) }">
						<c:if test="${empty model.proType && not empty changeEnoughGoodsList}">
							
							<input type="hidden" name="model.order.id" value="${model.id }"/>
						
							<div class="form-group">
								<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">可换购产品</label>
							</div>

							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">订单号</label>
								<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>

								<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
								<div class="col-xs-3" style="padding-top:7px;">${model.store.name }</div>
							</div>

							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>可换购产品列表</h5>
								</div>

								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">换购价</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${changeEnoughGoodsList }" var="goods_">
											<tr goods_id="${goods_.id }">
												<td id="code">${goods_.goodsCode }</td>
												<td id="name">${goods_.name }</td>
												<td id="price">${goods_.putOutNumber }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<div class="form-group">
								<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">换购明细</label>
							</div>

							<div class="form-group">
								<div class="col-xs-3">
									<input type="button" value="添加换购产品" class="btn btn-primary btn-xs" id="putOutGoods_input" />
								</div>
							</div>

							<div class="panel panel-default" id="all-device-detail">
								<div class="panel-heading">
									<h5>换购明细</h5>
								</div>

								<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
									<thead class="text-center">
										<tr>
											<th class="text-center">商品编号</th>
											<th class="text-center">商品名称</th>
											<th class="text-center">价格</th>
											<th class="text-center">操作</th>
										</tr>
									</thead>
									<tbody id="putout_qrcode_all">
										<tr id="putout_qrcode_one_copy" style="display: none;">
											<td id="goodsCode"></td>
											<td id="goodsName"></td>
											<td id="money"></td>
											<td>
												<input type="hidden" value="" id="order_goods_id_input"/>
												<input type="hidden" value="" id="OSM_ID_ONE_INPUT"/>
												<input type="hidden" value="" id="order_goods_salesPrice_input"/>
												<input type="button" qrcode_id="" class="btn btn-danger btn-xs delete_putout_qrcode" value="删除">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:if> 
					</c:if> 

					<div class="form-group col-xs-8 pull-right">
						<c:if test="${not empty orderCode && not empty model.id && ('1' eq model.type || '2' eq model.type || '4' eq model.type ) }">
							<c:if test="${empty model.proType && not empty changeEnoughGoodsList}">
								<button id="ert" type="submit" class="btn btn-primary">提交</button>
							</c:if> 
						</c:if> 
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
<!-- 弹出框 -->
	<div id="addGoodseModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加产品</h4>
				</div>
				<div class="modal-body row">
					<form onsubmit="return false;" class="form-horizontal"  id="theFormAddGoods" role="form" method="post"  >
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">产品</label>
							<div class="col-xs-3">
								<select id="goods_parent_id" class="form-control">
									<option value="" selected="selected">请选择产品</option>
									<c:forEach var="goods" items="${changeEnoughGoodsList }">
										<c:if test="${goods.store.id eq user.store.id}">
											<option value="${goods.id }" OSM_ID_ONE="${goods.OSM_ID }" GOODS_PRICE="${goods.putOutNumber }" childrenSize="${goods.goodsChildList.size() }">${goods.name }(${goods.putOutNumber }元换购)</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
	
						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="goAddGoods(this);" class="btn btn-primary btn-block" value="提交">
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
	
	<script type="text/javascript">
		var orderCode_test = /^[0-9]{16}$/,
			qrcode_id_test = /^[0-9]{32}$/,
			order_goods_index = 0;
		/**
		 * 二维码删除按钮的监听
		 */
		$(document).off("click", ".delete_putout_qrcode").on("click", ".delete_putout_qrcode", function(){
			var $_this = $(this);
			$_this.parent().parent().hide();
			$_this.parent().parent().find("input").val("").attr("disabled", "disabled");
		});
		/**
		 * 添加产品按钮的监听
		 */
		$(document).off("click", "#putOutGoods_input").on("click", "#putOutGoods_input", function(){
			$("#addGoodseModal").modal("show");
			$("#goods_parent_id").val("");
		});
		/**
		 * 添加产品弹出框确认添加的回调
		 */
		function goAddGoods(this_){
			var goods_id_value = $(this_).parent().parent().parent().find("#goods_parent_id").val().trim();
			if("" == goods_id_value){
				toastr.error("亲~请先选择一个产品哦~");
				delEmbed();
				setEmbed();
				return;
			} else {
				var goods_option = $(this_).parent().parent().parent().find("#goods_parent_id option:selected");
				var isNeedAddGoods = true;
				$("#putout_qrcode_all tr:not(:hidden)").each(function(){
					if(goods_option.attr("OSM_ID_ONE") == $(this).attr("OSM_ID_ONE")){
						isNeedAddGoods = false;
						return;
					}
				});
				if(isNeedAddGoods)
					add_order_goods_tr(goods_id_value, goods_option);
				$("#addGoodseModal").modal("hide");
			}
		}
		function add_order_goods_tr(goods_id_value, goods_option){
			var order_goods_one = $("#putout_qrcode_one_copy").clone(), tr_ = $("tr[goods_id="+goods_id_value+"]"), goods_option = $(goods_option);
			order_goods_one.find("#order_goods_id_input").attr("name","model.orderGoodList[" + order_goods_index + "].goods.id").val(goods_id_value);
			order_goods_one.find("#OSM_ID_ONE_INPUT").attr("name","model.orderGoodList[" + order_goods_index + "].OSM_ID").val(goods_option.attr("OSM_ID_ONE"));
			order_goods_one.find("#order_goods_salesPrice_input").attr("name","model.orderGoodList[" + order_goods_index + "].price").val(goods_option.attr("GOODS_PRICE"));
			order_goods_one.find("#goodsCode").html(tr_.find("#code").html());
			order_goods_one.find("#goodsName").html(tr_.find("#name").html());
			order_goods_one.find("#money").html(goods_option.attr("GOODS_PRICE"));
			order_goods_one.attr("OSM_ID_ONE", goods_option.attr("OSM_ID_ONE"));
			order_goods_one.removeAttr("id");
			$("#putout_qrcode_all").append(order_goods_one.show());
			order_goods_index++;
		}
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
					com.yunt.index.loadOnly("${path}/order/changeEnoughOrderInput?orderCode=" + search_input_value);
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});
		$(function(){
			<c:if test="${not empty orderCode && empty model.id }">
				toastr.error("订单暂时无法换购哦（只有完成的订单才能领取哦）~");
				delEmbed();
				setEmbed();
			</c:if>
			<c:if test="${not empty orderCode && not empty model.id && '1' ne model.type && '2' ne model.type && '4' ne model.type  }">
				toastr.error("退货、换货、换购类订单不可参与换购哦~");
				delEmbed();
				setEmbed();
			</c:if>
			<c:if test="${not empty orderCode && not empty model.id && ('1' eq model.type || '2' eq model.type || '4' eq model.type ) }">
				<c:if test="${not empty model.proType }">
					toastr.error("本订单不可参与换购~");
					delEmbed();
					setEmbed();
				</c:if>
				<c:if test="${empty model.proType && empty changeEnoughGoodsList }">
					toastr.error("本订单没有可换购产品~");
					delEmbed();
					setEmbed();
				</c:if>
			</c:if>
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
