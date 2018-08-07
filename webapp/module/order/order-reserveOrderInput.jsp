<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.order.reserveOrderInput");
	com.yunt.order.reserveOrderInput = {
		submit : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				<c:if test="${not empty model.cashierCode }">
					if(0 >= $("#order_goods_all tr:not(:hidden)").length){
						toastr.error("请先添加预约发货产品哦~");
						$("#theForm #ert").removeAttr("disabled");
						delEmbed();
						setEmbed();
						return false;
					}
				</c:if>
				<c:if test="${'yes' eq isOptions && empty model.id}">
					if(null == $('input:radio[name="optionsRadios"]:checked').val()){
						toastr.error("请选择优惠人员类型~");
						$("#theForm #ert").removeAttr("disabled");
						delEmbed();
						setEmbed();
						return false;
					}
					$("#subUserType").val($('input:radio[name="optionsRadios"]:checked').val());
				</c:if>
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/order/saveReserveOrderInpute",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								<c:if test="${empty model.id }">
									com.yunt.index.loadOnly("${path}/order/reserveOrderInput?isOptions=${isOptions}&orderId=" + data.obj);
								</c:if>
								<c:if test="${not empty model.id }">
									window.open('${path}/order/reservePrintView?id=${model.id}');
									com.yunt.index.toPreIndex();
								</c:if>
							} else {
								toastr.error(data.msg);
								$("#theForm #ert").removeAttr("disabled");
								delEmbed();
								setEmbed();
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
							$("#theForm #ert").removeAttr("disabled");
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
				<form onsubmit="return com.yunt.order.reserveOrderInput.submit()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
						<input type="hidden" name="model.sumMoney" value="${model.sumMoney}" />
						<input type="hidden" name="model.sumNumber" value="${model.sumNumber}" />
						<input type="hidden" name="model.payMoney" value="${model.payMoney}" />
						<input type="hidden" name="model.subMoney" value="${model.subMoney}" />
					</c:if>
					<input type="hidden" value="${user.store.id }" name="model.store.id"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">
							<c:if test="${'yes' eq isOptions}">
								开具优惠小票(预约)
							</c:if>
							<c:if test="${'yes' ne isOptions}">
								开具购物小票(预约)
							</c:if>
						</label>
					</div>

					<c:if test="${empty model.id }">
						<div class="form-group">
							<div class="col-xs-3">
								<input type="button" value="添加产品" class="btn btn-primary btn-xs" onclick="to_add_goods();"/>
							</div>
						</div>
					</c:if>

					<div class="panel panel-default" id="all-device-detail">
						<div class="panel-heading">
							<h5>订单商品列表</h5>
						</div>

						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center"></th>
									<th class="text-center">所属门店</th>
									<th class="text-center">商品编号</th>
									<th class="text-center">商品名称</th>
									<c:if test="${empty model.id }">
										<th class="text-center">售价</th>
									</c:if>
									<c:if test="${not empty model.id }">
										<th class="text-center">商品售价</th>
										<th class="text-center">优惠价</th>
										<th class="text-center">实售价</th>
									</c:if>
									<th class="text-center" width="10%">数量</th>
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody id="order_goods_all">
								<tr id="order_goods_one_copy" style="display: none;">
									<td class="text-center">
										<input type="checkbox" value="1" checked="checked" title="是否参与活动" <c:if test="${'yes' eq isOptions }">disabled="disabled"</c:if>/>
										<input type="hidden" value="" id="order_goods_id_input"/>
										<input type="hidden" value="" id="order_goods_salesPrice_input"/>
										<input type="hidden" value="no" id="order_isOut_input"/>
									</td>
									<td class="text-center">${user.store.name }</td>
									<td class="text-center" id="goods_code_td"></td>
									<td class="text-center" id="goods_name_td"></td>
									<td class="text-center" id="goods_sales_td"></td>
									<td class="text-center" id="goods_number_td">
										<div class="form-group">
											<div class="col-xs-12">
												<input type="text" class="form-control orderGoodsCountNoClass" onchange="updateOrderMoney();"
														onkeydown="if(event.keyCode==32) return false;" 
														required data-bv-notempty-message="请输入数量"
														value="1" pattern="^([1-9][0-9]{0,7})$" 
														data-bv-regexp-message="数量格式不正确，参考格式：18" />
											</div>
										</div>
									</td>
									<td class="text-center">
										<a class="btn btn-danger btn-xs delete_order_goods_no_class" href="javascript:void(0);">删除</a>
									</td>
								</tr>
								<c:forEach items="${model.orderList }" var="order_">
									<c:forEach items="${order_.orderGoodList }" var="orderGoods">
										<tr>
											<td class="text-center">
												<input type="checkbox" value="true" title="是否参与活动"
													<c:if test="${'nullOrder' ne order_.proType && 'otherOrder' ne order_.proType }">
														checked="checked" 
													</c:if>
													<c:if test="${not empty model.id }">disabled="disabled"</c:if>/>
											</td>
											<td class="text-center">${model.store.name }</td>
											<td class="text-center" >
												<c:if test="${empty orderGoods.goods.goodsCode }">
													${orderGoods.goods.goods.goodsCode }
												</c:if>
												<c:if test="${not empty orderGoods.goods.goodsCode }">
													${orderGoods.goods.goodsCode }
												</c:if>
											</td>
											<td class="text-center" >
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
											<c:if test="${empty model.id }">
												<td class="text-center">${orderGoods.salesPrice }</td>
											</c:if>
											<c:if test="${not empty model.id }">
												<td class="text-center" >${orderGoods.price } / 件</td>
												<td class="text-center" >${orderGoods.subMoneyOne } / 件</td>
												<td class="text-center" >${orderGoods.salesPrice } / 件</td>
											</c:if>
											<td class="text-center">${orderGoods.count }</td>
											<td class="text-center">
												<input type="button" class="btn btn-danger btn-xs" disabled="disabled" value="删除">
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<c:if test="${not empty model.cashierCode }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">预约发货</label>
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
									<c:forEach items="${model.orderList }" var="order_">
										<c:forEach items="${order_.orderGoodList }" var="orderGoods">
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
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>

					<div class="form-group" style="border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #0AA0D9">
						<label for="product-uuid" class="col-xs-3 control-label">商品数量：</label>
						<label for="product-uuid" class="col-xs-1 control-label" style="color: red;text-align: left;" id="order_count_label">
							<c:if test="${empty model.sumNumber }">0</c:if>
							${model.sumNumber }
						</label>

						<label for="product-uuid" class="col-xs-3 control-label">合计：</label>
						<label for="product-uuid" class="col-xs-1 control-label" style="color: red;text-align: left;" id="order_sumMoney_label">
							<c:if test="${empty model.sumMoney }">0.0</c:if>
							<fmt:formatNumber pattern="#,###.##" value="${model.sumMoney }"/>
						</label>
						
						<c:if test="${not empty model.id }">
							<label for="product-uuid" class="col-xs-3 control-label">实付合计：</label>
							<label for="product-uuid" class="col-xs-1 control-label" style="color: red;text-align: left;" id="order_payMoney_label">
								<c:if test="${empty model.payMoney }">0.0</c:if>
								<fmt:formatNumber pattern="#,###.##" value="${model.payMoney }"/>
							</label>
						</c:if>
					</div>

					<c:if test="${empty model.id }">
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
							<label for="product-uuid" class="col-xs-2 control-label">预约人 ：</label>
							<div class="col-xs-3">
								<input type="text" class="form-control"
									onkeydown="if(event.keyCode==32) return false;" name="model.reserveName" id="reserveName"
									value="" required data-bv-notempty-message="请输入预约人">
							</div>
	
							<label for="product-uuid" class="col-xs-2 control-label">预约电话：</label>
							<div class="col-xs-3">
								<input type="text" class="form-control" 
									onkeydown="if(event.keyCode==32) return false;" name="model.reservePhone"
									required data-bv-notempty-message="请输入预约电话" id="reservePhone"
									value="" pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$" 
									data-bv-regexp-message="请输入正确的手机号">
							</div>
						</div>
					</c:if>

					<c:if test="${not empty model.id }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">导购（开票人员）：</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.guideUser.name}</div>
	
							<c:if test="${'yes' eq isOptions }">
								<label for="product-uuid" class="col-xs-2 control-label">优惠人员类型：</label>
								<div class="col-xs-3" style="padding-top: 7px;">${model.subUserTypeValue }</div>
							</c:if>
						</div>
	
						<c:if test="${'yes' eq isOptions }">
							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">总优惠金额：</label>
								<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber pattern="#,###.##" value="${model.subMoney }"/></div>
							</div>
						</c:if>
	
						<c:if test="${'yes' ne isOptions }">
							<div class="form-group">
								<label for="product-uuid" class="col-xs-2 control-label">会员手机号：</label>
								<div class="col-xs-3" style="padding-top: 7px;">${model.customer.phone }</div>
		
								<label for="product-uuid" class="col-xs-2 control-label">会员昵称：</label>
								<div class="col-xs-3" style="padding-top: 7px;">${model.customer.employee.name }</div>
							</div>
		
							<c:if test="${not empty model.payType }">
								<div class="form-group">
									<label for="product-uuid" class="col-xs-2 control-label">支付方式：</label>
									<div class="col-xs-3" style="padding-top: 7px;">${model.payTypeValue }</div>
								</div>
							</c:if>
						</c:if>
	
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">预约人 ：</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.reserveName }</div>
	
							<label for="product-uuid" class="col-xs-2 control-label">预约电话：</label>
							<div class="col-xs-3" style="padding-top: 7px;">${model.reservePhone }</div>
						</div>
	
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">预约时间：</label>
							<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatDate value="${model.reserveTime }" pattern="yyyy-MM-dd HH:mm"/></div>

							<label for="product-uuid" class="col-xs-2 control-label">定金：</label>
							<c:if test="${not empty model.cashierCode }">
								<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatNumber pattern="#,###.##" value="${model.reserveMoney }"/></div>
							</c:if>
							<c:if test="${empty model.cashierCode }">
								<div class="col-xs-3">
									<input type="text" class="form-control" 
											onkeydown="if(event.keyCode==32) return false;" name="model.reserveMoney"
											required data-bv-notempty-message="请输入定金" id="reserveMoney"
											value="" pattern="^([1-9][0-9]{0,7})$" 
											data-bv-regexp-message="请输入正确的金额">
								</div>
							</c:if>
						</div>
					</c:if>

					<c:if test="${not empty model.cashierCode }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券使用明细</label>
						</div>
	
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">添加电子券</label>
							<div class="col-xs-4">
								<input type="text" value="" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="search_input_eticket" placeholder="电子券二维码扫码框~"/>
							</div>
						</div>
	
						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>电子券列表</h5>
							</div>
	
							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">电子券编号</th>
										<th class="text-center">电子券名称</th>
										<th class="text-center">抵扣金额</th>
										<th class="text-center">获得时间</th>
									</tr>
								</thead>
								<tbody id="eticket_all">
									<tr id="eticket_one_copy" style="display: none;">
										<td class="text-center" id="eticket_code_td"></td>
										<td class="text-center" id="eticket_name_td"></td>
										<td class="text-center" id="eticket_price_td"></td>
										<td class="text-center" id="eticket_time_td"></td>
									</tr>
									<c:forEach items="${model.orderList }" var="order_">
										<c:forEach items="${order_.eticketUseRecordList }" var="eticketUseRecord">
											<tr>
												<td class="text-center">${eticketUseRecord.eticketOutRecord.code }</td>
												<td class="text-center">${eticketUseRecord.eticketOutRecord.eticket.name }</td>
												<td class="text-center">${eticketUseRecord.eticketOutRecord.eticket.price }</td>
												<td class="text-center"><fmt:formatDate value="${eticketUseRecord.eticketOutRecord.createDate }" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</c:forEach>
								</tbody>
							</table>
						</div>
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
						<input type="hidden">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">产品</label>
							<div class="col-xs-3">
								<select id="goods_parent_id" onchange="goods_parent_change(this);" class="form-control">
									<option value="" selected="selected">请选择产品</option>
									<c:forEach var="goods" items="${goodsList }">
										<option value="${goods.id }" childrenSize="${goods.goodsChildList.size() }">${goods.name }</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-xs-3">
								<select id="goods_children_id" disabled="disabled" class="form-control" onchange="goods_children_change(this);">
									<option value="" selected="selected">请选择产品</option>
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
		var qrcode_id_test = /^[0-9]{32}$/,
			qrcode_index = 0,
			order_goods_index = 0,
			phone_test = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$/,
			eticket_code_test = /^[0-9]{18,32}$/,
			eticket_index = 0;;
		/**
		 * 添加电子券tr
		 */
		function add_eticket_tr(search_input_value){
			$.ajax({
				url : "${path}/order/bindEticket?orderId=${model.id}&eticketOutCode=" + search_input_value,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var eticket_one = $("#eticket_one_copy").clone();
						eticket_one.find("#eticket_code_td").html(data.obj.code);
						eticket_one.find("#eticket_name_td").html(data.obj.eticket.name);
						eticket_one.find("#eticket_price_td").html(data.obj.eticket.price);
						eticket_one.find("#eticket_time_td").html(data.obj.createDateString);
						eticket_one.removeAttr("id");
						$("#eticket_all").append(eticket_one.show());
						eticket_index++;
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
		 * 二维码扫码框监听--电子券
		 */
		$('#search_input_eticket').bind('keyup', function(event) {
			var search_input_value="";
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input_eticket").val().trim();
				$("#search_input_eticket").val("");
				if(eticket_code_test.test(search_input_value)){
					var isNeedAdd = true;
					$("#eticket_all tr:not(:hidden)").each(function(){
						if($(this).find("#eticket_code_td").html() == search_input_value){
							isNeedAdd = false;
							// 退出循环
							return;
						}
					})
					if(!isNeedAdd){
						toastr.error("本电子券已经添加过了哦~换一个添加吧~");
						return false;
					}
					// 添加电子券节点
					add_eticket_tr(search_input_value);
				}else{
					toastr.error("无法识别的信息");
				}
			}
		});
		/**
		 * 添加产品弹出框确认添加的回调
		 */
		function goAddGoods(this_){
			var goods_id_value = $(this_).parent().parent().parent().find(":input[type=hidden]").val().trim();
			if("" == goods_id_value){
				toastr.error("亲~请先选择一个产品哦~");
				delEmbed();
				setEmbed();
				return;
			} else {
				$("#addGoodseModal").modal("hide");
				var isNeedAddGoods = true;
				$("#order_goods_all tr:not(:hidden)").each(function(){
					if(goods_id_value == $(this).find("#order_goods_id_input").val().trim()){
						isNeedAddGoods = false;
						return;
					}
				});
				if(isNeedAddGoods)
					add_order_goods_tr(goods_id_value);
			}
		}
		/**
		 * 添加产品按钮回调，用于显示弹出框
		 */
		function to_add_goods(){
			$("#addGoodseModal").modal("show");
			$("#goods_parent_id").val("");
			$("#addGoodseModal :input[type=hidden]").val("");
			$("#goods_children_id").val("").attr("disabled","disabled");
		}
		
		function add_order_goods_tr(goods_id_value){
			$.ajax({
				url : "${path}/goods/getGoodsByGoodsId?goodsId=" + goods_id_value,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var order_goods_one = $("#order_goods_one_copy").clone();
						order_goods_one.find(":input[type=checkbox]").attr("name","model.orderGoodList[" + order_goods_index + "].isJoin");
						order_goods_one.find("#order_goods_id_input").attr("name","model.orderGoodList[" + order_goods_index + "].goods.id").val(data.obj.id);
						order_goods_one.find("#order_goods_salesPrice_input").attr("name","model.orderGoodList[" + order_goods_index + "].price").val(data.obj.salesPrice);
						order_goods_one.find("#goods_code_td").html(data.obj.goodsCode);
						order_goods_one.find("#goods_name_td").html(data.obj.name + data.obj.other_attr_value);
						order_goods_one.find("#goods_sales_td").html(data.obj.salesPrice);
						order_goods_one.find("#goods_number_td input").attr("name","model.orderGoodList[" + order_goods_index + "].count");
						order_goods_one.removeAttr("id");
						$("#order_goods_all").append(order_goods_one.show());
						order_goods_index++;
						bootstrapValidator_again();
						updateOrderMoney();
					}else{
						delEmbed();
						setEmbed();
						toastr.error(data.msg);
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
		 * 主产品下拉框值改变的回调
		 */
		function goods_parent_change(this_){
			var goods_parent_id_value = $(this_).val().trim();
			if("" == goods_parent_id_value){
				$(this_).parent().parent().parent().find(":input[type=hidden]").val("");
				$("#goods_children_id").val("").attr("disabled","disabled");
			} else {
				if(0 < ($(this_).find("option:selected").attr("childrenSize") - 0)){
					var option_list = "<option value='' selected='selected'>请选择产品</option>";
					$.ajax({
						url : "${path}/goods/getSubGoodsByGoodsId?goodsId=" + goods_parent_id_value,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								for(var i = 0; i < data.obj.length; i++){ 
									option_list += "<option value='" + data.obj[i].id + "'>" + data.obj[i].other_attr_value + "</option>";
								}
								$("#goods_children_id").html(option_list).val("").removeAttr("disabled");
							} else {
								toastr.error(data.msg);
								delEmbed();
								setEmbed();
							}
						},
						error : function(xhr, type, exception){
							toastr.error("请检查网络设置");
							delEmbed();
							setEmbed();
						}
					});
				} else {
					$("#goods_children_id").val("").attr("disabled","disabled");
					$(this_).parent().parent().parent().find(":input[type=hidden]").val(goods_parent_id_value);
				}
			}
		}
		/**
		 * 子产品下拉框值改变的回调
		 */
		function goods_children_change(this_){
			var goods_children_id_value = $(this_).val().trim();
			if("" != goods_children_id_value){
				$(this_).parent().parent().parent().find(":input[type=hidden]").val(goods_children_id_value);
			}
		}
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
						<c:if test="${'yes' eq isOptions }">
							var order_sumMoey = 0.0;
							$("#order_goods_all tr:not(:hidden)").each(function (){
								order_count_one = ($(this).find(".orderGoodsCountNoClass").val().trim() - 0)
								order_sumMoey = accAdd(parseFloat(order_sumMoey),accMul(parseFloat($(this).find("#goods_sales_td").html().trim()),parseFloat(order_count_one)));
								order_sumMoey = accAdd(parseFloat(order_sumMoey),parseFloat("0.01"));
							});
						$("#subMoney").attr("max",order_sumMoey);
					</c:if>
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
		/**
		 * 商品删除按钮的监听（预约添加产品）
		 */
		$(document).off("click", ".delete_order_goods_no_class").on("click", ".delete_order_goods_no_class", function(){
			$(this).parent().parent().find("input").val("").attr("disabled", "disabled");
			$(this).parent().parent().hide();
			updateOrderMoney();
			<c:if test="${'yes' eq isOptions }">
				var order_sumMoey = 0.0;
				$("#order_goods_all tr:not(:hidden)").each(function (){
					order_count_one = ($(this).find(".orderGoodsCountNoClass").val().trim() - 0)
					order_sumMoey = accAdd(parseFloat(order_sumMoey),accMul(parseFloat($(this).find("#goods_sales_td").html().trim()),parseFloat(order_count_one)));
					order_sumMoey = accAdd(parseFloat(order_sumMoey),parseFloat("0.01"));
				});
				$("#subMoney").attr("max",order_sumMoey);
			</c:if>
			bootstrapValidator_again();
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
				order_sumMoey = 0.0,
				order_count_one = 0;
			$("#order_goods_all tr:not(:hidden)").each(function (){
				order_count_one = ($(this).find(".orderGoodsCountNoClass").val().trim() - 0)
				order_count += order_count_one;
				order_sumMoey = accAdd(parseFloat(order_sumMoey),accMul(parseFloat($(this).find("#goods_sales_td").html().trim()),parseFloat(order_count_one)));
			});
			<c:if test="${'yes' eq isOptions }">
				$("#subMoney").attr("max",accAdd(parseFloat(order_sumMoey),parseFloat("0.01")));
				bootstrapValidator_again();
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
							delEmbed();
							setEmbed();
						}
					},
					error : function(xhr, type, exception) {
						$("#customer_input_hidden").val("");
						$("#customer_employee_name").html("");
						toastr.error("请检查网络设置");
						delEmbed();
						setEmbed();
					}
				});
			} else {
				$("#customer_input_hidden").val("");
				$("#customer_employee_name").html("");
				toastr.error("请输入正确的手机号~");
				delEmbed();
				setEmbed();
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
