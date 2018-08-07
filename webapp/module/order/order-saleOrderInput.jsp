<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.saleOrderInput");
	com.yunt.order.saleOrderInput = {
		submit : function() {
			<c:if test="${'yes' eq isOptions }">$("#subMoney").blur();</c:if>
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if(0 >= $("#order_goods_all tr:not(:hidden)").length){
					toastr.error("请先添加产品哦~");
					// $("#ert").removeAttr("disabled");
					return false;
				}
				<c:if test="${'yes' eq isOptions }">
					if(null == $('input:radio[name="optionsRadios"]:checked').val()){
						toastr.error("请选择优惠人员类型~");
						// $("#ert").removeAttr("disabled");
						return false;
					}
					$("#subUserType").val($('input:radio[name="optionsRadios"]:checked').val());
				</c:if>
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/order/saveSaleOrderInpute" ,
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								if("yes" == data.obj.isNeedAddEticket){
									com.yunt.index.loadOnly("${path }/order/goAddEticket?orderId=" + data.obj.orderId);
								}else{
									window.open('${path}/order/salePrintView?id=' + data.obj.orderId);
									com.yunt.index.toPreIndex();
								}
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
				<form onsubmit="return com.yunt.order.saleOrderInput.submit()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>
					<input type="hidden" value="${user.store.id }" name="model.store.id"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
							<c:if test="${'yes' eq isOptions}">
								开具优惠小票
							</c:if>
							<c:if test="${'yes' ne isOptions}">
								开具购物小票
							</c:if>
						</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-1 control-label">添加商品</label>
						<div class="col-xs-3">
							<input type="text" value="" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="search_input" placeholder="商品二维码扫码框~"/>
						</div>
					</div>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>订单商品列表</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center"></th>
									<th class="text-center">所属门店</th>
									<th class="text-center">商品条码</th>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<th class="text-center">售价</th>
									<th class="text-center">数量</th>
									<!-- <th class="text-center" width="15%">成交价</th> -->
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody id="order_goods_all">
								<tr id="order_goods_one_copy" style="display: none;">
									<td class="text-center">
										<input type="checkbox" value="true" checked="checked" title="是否参与活动" <c:if test="${'yes' eq isOptions }">disabled="disabled"</c:if>/>
										<input type="hidden" value="" id="qrcode_id_input"/>
										<input type="hidden" value="" id="qrcode_goods_id_input"/>
										<input type="hidden" value="" id="qrcode_goods_salesPrice_input"/>
										<input type="hidden" value="no" id="qrcode_isOut_input"/>
									</td>
									<td class="text-center">${user.store.name }</td>
									<td class="text-center" id="goods_qrcode_id_td"></td>
									<td class="text-center" id="goods_code_td"></td>
									<td class="text-center" id="goods_name_td"></td>
									<td class="text-center" id="goods_sales_td"></td>
									<td class="text-center" id="goods_number_td">1</td>
<!-- 									<td class="text-center" id="goods_strikePrice_td">
										<div class="form-group" style="margin-bottom: 0px;">
											<div class="col-xs-12">
												<input type="text" class="form-control" onblur="strikePriceBlur(this);"
														onkeydown="if(event.keyCode==32) return false;"
														required data-bv-notempty-message="成交价不能为空"
														value="" pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
														data-bv-regexp-message="成交价格式不正确，参考格式：1688.88">
											</div>
										</div>
									</td> -->
									<td class="text-center">
										<a class="btn btn-danger btn-xs delete_order_goods_no_class" href="javascript:void(0);">删除</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="form-group" style="border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #0AA0D9">
						<label for="product-uuid" class="col-xs-3 control-label">商品数量：</label>
						<label for="product-uuid" class="col-xs-1 control-label" style="color: red;text-align: left;" id="order_count_label">0</label>

						<label for="product-uuid" class="col-xs-4 control-label">合计：</label>
						<label for="product-uuid" class="col-xs-1 control-label" style="color: red;text-align: left;" id="order_sumMoney_label">0</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">导购（开票人员）：</label>
						<div class="col-xs-3">
							<select name="model.guideUser.id" class="form-control" required data-bv-notempty-message="请选择导购">
								<option value=""selected="selected">请选择导购</option>
								<c:forEach var="storeUser" items="${storeUserList }">
									<c:if test="${'kaipiao' ne storeUser.role.roleKey }">
										<option value="${storeUser.id }">${storeUser.name }(${storeUser.username })</option>
									</c:if>
								</c:forEach>
							</select>
						</div>

						<c:if test="${'yes' eq isOptions }">
							<label for="product-uuid" class="col-xs-2 control-label">优惠人员类型：</label>
							<div class="col-xs-3">
								<div class="radio" style="float: left; margin-left: 15px;">
									<label>
									<input type="radio" name="optionsRadios" id="optionsRadios1" value="1" > 导购优惠
									</label>
								</div>
								<div class="radio" style="float: left; margin-left: 15px;">
									<label>
									<input type="radio" name="optionsRadios" id="optionsRadios2" value="2" > 主管优惠
									</label>
								</div>
								<div class="radio" style="float: left; margin-left: 15px;">
									<label>
									<input type="radio" name="optionsRadios" id="optionsRadios3" value="3" > 经理优惠
									</label>
								</div>
							</div>
							<input type="hidden" name="model.subUserType" id="subUserType"/>
						</c:if>
					</div>

					<c:if test="${'yes' eq isOptions }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">总优惠金额：</label>
							<div class="col-xs-3">
								<input type="text" class="form-control" onchange="updateOrderMoney();"
										onkeydown="if(event.keyCode==32) return false;" name="model.subMoney"
										required data-bv-notempty-message="请输入总优惠金额" id="subMoney"
										value="" pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
										data-bv-regexp-message="总优惠金额格式不正确，参考格式：1688.88" max="0"
										data-bv-lessthan-inclusive="true" data-bv-lessthan-message="输入值不能大于商品总金额"/>
							</div>
						</div>
					</c:if>

					<c:if test="${'yes' ne isOptions }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">会员手机号：</label>
							<div class="col-xs-3">
								<input type="hidden" value="" name="model.customer.id" id="customer_input_hidden"/>
								<input type="text" class="form-control" onblur="customerPhoneBlur(this);"
										onkeydown="if(event.keyCode==32) return false;" name="phoneValue"
										value="" pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$" 
										data-bv-regexp-message="请输入正确的手机号">
							</div>
	
							<label for="product-uuid" class="col-xs-2 control-label">会员昵称：</label>
							<div class="col-xs-3 control-label" id="customer_employee_name" style="text-align: left;"></div>
						</div>
	
						<c:if test="${not empty proGroupPayTypes }">
							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">支付方式：</label>
								<div class="col-xs-3">
									<select name="model.payType" class="form-control" required data-bv-notempty-message="请选择支付方式">
										<option value=""selected="selected">请选择支付方式</option>
										<option value="1">现金支付<c:if test="${0 <= fn:indexOf(proGroupPayTypes,'1') }">(有活动)</c:if></option>
										<option value="2">银行pos刷卡支付<c:if test="${0 <= fn:indexOf(proGroupPayTypes,'2') }">(有活动)</c:if></option>
										<option value="3">微信支付<c:if test="${0 <= fn:indexOf(proGroupPayTypes,'3') }">(有活动)</c:if></option>
										<option value="4">支付宝支付<c:if test="${0 <= fn:indexOf(proGroupPayTypes,'4') }">(有活动)</c:if></option>
										<option value="5">账户余额支付<c:if test="${0 <= fn:indexOf(proGroupPayTypes,'5') }">(有活动)</c:if></option>
									</select>
								</div>
							</div>
						</c:if>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control" name="model.remark" />
						</div>
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
		var qrcode_id_test = /^[0-9]{32}$/,
			qrcode_index = 0,
			phone_test = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/;
		/**
		 * 添加产品tr
		 */
		function add_order_goods_tr(search_input_value){
			$.ajax({
				url : "${path}/goods/getGoodsByQrcodeId?checkQrcode=yes&QRCodeID=" + search_input_value,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						if(0 >= (data.obj.goods_inventory - 0)){
							toastr.error("产品：" + data.obj.name + data.obj.other_attr_value + "库存为0，不可售卖~");
							return false;
						}
						var order_goods_one = $("#order_goods_one_copy").clone();
						order_goods_one.find(":input[type='checkbox']").attr("name","model.qrcodeList[" + qrcode_index + "].isJoin");
						order_goods_one.find("#qrcode_id_input").attr("name","model.qrcodeList[" + qrcode_index + "].id").val(search_input_value);
						order_goods_one.find("#qrcode_goods_id_input").attr("name","model.qrcodeList[" + qrcode_index + "].goods.id").val(data.obj.id);
						order_goods_one.find("#qrcode_goods_salesPrice_input").attr("name","model.qrcodeList[" + qrcode_index + "].goods.salesPrice").val(data.obj.salesPrice);
						order_goods_one.find("#qrcode_isOut_input").attr("name","model.qrcodeList[" + qrcode_index + "].isOutGoods");
						//order_goods_one.find("#goods_strikePrice_td input").attr("name","model.qrcodeList[" + qrcode_index + "].strikePrice").val(data.obj.salesPrice);
						order_goods_one.find("#goods_qrcode_id_td").html(search_input_value);
						order_goods_one.find("#goods_code_td").html(data.obj.goodsCode);
						order_goods_one.find("#goods_name_td").html(data.obj.name);
						order_goods_one.find("#goods_sales_td").html(data.obj.salesPrice);
						order_goods_one.removeAttr("id");
						$("#order_goods_all").append(order_goods_one.show());
						qrcode_index++;
						updateOrderMoney();
						bootstrapValidator_again();
					}else{
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
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
					$("#order_goods_all tr:not(:hidden)").each(function(){
						if($(this).find("#qrcode_id_input").val().trim() == search_input_value){
							isNeedAdd = false;
							// 退出循环
							return;
						}
					})
					if(!isNeedAdd){
						toastr.error("本产品已经添加过了哦~换一个添加吧~");
						return false;
					}
					// 添加产品节点
					add_order_goods_tr(search_input_value);
				}else{
					toastr.error("无法识别的信息");
				}
			}
		});
		/**
		 * 商品删除按钮的监听
		 */
		$(document).off("click", ".delete_order_goods_no_class").on("click", ".delete_order_goods_no_class", function(){
			$(this).parent().parent().find("input").val("").attr("disabled", "disabled");
			$(this).parent().parent().hide();
			updateOrderMoney();
			bootstrapValidator_again();
		});
		// 选择了优惠人员时，开放表单提交按钮
		$(document).off("click", ".radio").on("click", ".radio", function(){
			$("#ert").removeAttr("disabled");
		});
		/**
		 * 重新初始化验证
		 */
		function bootstrapValidator_again() {
			$(".form-control-feedback").remove();
			$(".help-block").remove();
			$('#theForm').data('bootstrapValidator', null);
			$('#theForm').bootstrapValidator('resetForm', false);
			$('#theForm').bootstrapValidator();//初始化验证
		}
		/**
		 * 商品信息变动的时候，刷新订单总数，总金额
		 */
		function updateOrderMoney(){
			var order_count = 0,
				order_sumMoey = 0.0;
			order_count = $("#order_goods_all tr:not(:hidden)").length;
			$("#order_goods_all tr:not(:hidden)").each(function (){
				// order_sumMoey = accAdd(parseFloat(order_sumMoey),parseFloat($(this).find(":input[type='text']").val().trim()));
				order_sumMoey = accAdd(parseFloat(order_sumMoey),parseFloat($(this).find("#goods_sales_td").html().trim()));
			});
			<c:if test="${'yes' eq isOptions }">
				$("#subMoney").attr("max",accAdd(order_sumMoey,"0.01"));
				var subMoney_value = $("#subMoney").val().trim();
				if("" != subMoney_value){
					if(0 <= Subtr(order_sumMoey, subMoney_value)){
						order_sumMoey = Subtr(order_sumMoey, subMoney_value);
					}
				}
			</c:if>
			$("#order_count_label").html(order_count);
			$("#order_sumMoney_label").html(order_sumMoey);
		}
		/**
		 * 产品成交价改变回调函数
		 */
		 /* function strikePriceBlur(this_){
			var strikePrice_value = $(this_).val().trim();
			var salesPrice_value = $(this_).parent().parent().parent().parent().find("#goods_sales_td").html();
			if(parseFloat(strikePrice_value) != parseFloat(salesPrice_value)){
				$(this_).parent().parent().parent().parent().attr("is_salec_change", "true");
			} else {
				$(this_).parent().parent().parent().parent().attr("is_salec_change", "false");
			}
			updateOrderMoney();
		} */
		/**
		 * 手机号改变的回调函数
		 */
		function customerPhoneBlur(this_){
			var phone_value = $(this_).val().trim();
			if(phone_test.test(phone_value)){
				$.ajax({
					url : "${path}/customer/getCustomerByPhone?phone=" + phone_value,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$("#customer_input_hidden").val(data.obj.id);
							try{
								var name_value = (null == data.obj.employee || null == data.obj.employee.name || "" == data.obj.employee.name) ? data.obj.name : data.obj.employee.name;
								$("#customer_employee_name").html(name_value);
							}catch (e) {
								$("#customer_employee_name").html("");
							}
						}else{
							$("#customer_input_hidden").val("");
							$("#customer_employee_name").html("");
							toastr.error(data.msg);
						}
					},
					error : function(xhr, type, exception) {
						$("#customer_input_hidden").val("");
						$("#customer_employee_name").html("");
						toastr.error("请检查网络设置");
					}
				});
			} else {
				$("#customer_input_hidden").val("");
				$("#customer_employee_name").html("");
				toastr.error("请输入正确的手机号~");
				return false;
			}
		}
		$(document).ready(function() {
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
