<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.procurement.input");
	com.yunt.procurement.input = {
		submitStore : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var buyPriceNoEquals = false;
				if(0 >= $("#proGoods_All tr:not(:hidden)").size()){
					toastr.error("请至少录入一条产品信息~");
					return false;
				} else {
					<c:if test="${'1' eq proType }">
						$("#proGoods_All tr:not(:hidden)").each(function(){
							var parentId = $(this).find("#goodsId").attr("parentId");
							if("" != parentId){
								var this_goods_buyPrice = $(this).find("#buyPrice :input[type=text]").val().trim();
								var this_goods_salseMoney = $(this).find("#salseMoney :input[type=text]").val().trim();
								$("#proGoods_All :input[parentId=" + parentId + "]").each(function(){
									if(this_goods_buyPrice != $(this).parent().parent().parent().parent().find("#buyPrice :input[type=text]").val().trim()){
										toastr.error("同一商品，采购价需相同~");
										buyPriceNoEquals = true;
										// 退出内层循环
										return false;
									}
									if(this_goods_salseMoney != $(this).parent().parent().parent().parent().find("#salseMoney :input[type=text]").val().trim()){
										toastr.error("同一商品，售价需相同~");
										buyPriceNoEquals = true;
										// 退出内层循环
										return false;
									}
								})
								if(buyPriceNoEquals){
									// 退出外层循环
									return false;
								}
							}
						});
					</c:if>
				}
				if(buyPriceNoEquals){
					// 拦截代码继续执行
					return false;
				}
				<c:if test="${'yes' eq isCheck }">
					if("" == $("#checkRemark").val().trim() && "5" == $("#check_select").val().trim()){
						toastr.error("请填写不通过原因~");
						$("#checkRemark").focus();
						return false;
					}
				</c:if>
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/procurement/saveOrUpdate",
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
				<form onsubmit="return com.yunt.procurement.input.submitStore()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
						<c:if test="${'yes' eq isCheck }">
							<input type="hidden" name="model.user.id" value="${user.id}" />
						</c:if>
					</c:if>
					<c:if test="${empty model.id }">
						<input type="hidden" name="model.type" value="${proType}" />
					</c:if>
					<input type="hidden" name="model.count" value="0" id="pro_all_goods_count_input"/>
					<input type="hidden" name="model.sumMoney" value="0.0" id="pro_all_goods_sumMoney_input"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商</label>
						<c:if test="${'yes' eq isCheck }">
							<div class="col-xs-3" style="padding-top: 7px;">${model.vende.name }</div>
						</c:if>
						<c:if test="${'no' eq isCheck }">
							<c:if test="${not empty model.id && '5' eq model.state && user.id eq model.fu}">
								<input type="hidden" name="model.state" value="1" />
							</c:if>
							<div class="col-xs-3">
								<select id="vendeId" name="model.vende.id" class="form-control" required data-bv-notempty-message="请选择供应商">
									<option value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择供应商</option>
									<c:forEach var="vende" items="${vendeList }">
										<option value="${vende.id }" <c:if test="${vende.id eq model.vende.id }">selected="selected"</c:if>>${vende.name }</option>
									</c:forEach>
								</select>
							</div>
						</c:if>
						
						<label for="product-uuid" class="col-xs-2 control-label">发货类型</label>
						<div class="col-xs-3">
							<input type="text" value="${model.shipType }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.shipType" />
						</div>
					</div>

					<c:if test="${empty user.store.id && empty model.id}">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
							<c:if test="${'yes' eq isCheck }">
								<div class="col-xs-3" style="padding-top: 7px;">${model.store.name }</div>
							</c:if>
							<c:if test="${'no' eq isCheck }">
								<div class="col-xs-3">
									<select id="storeId" onchange="store_change(this)" name="model.store.id" class="form-control" required data-bv-notempty-message="请选择门店">
										<option value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择门店</option>
										<c:forEach var="store" items="${storeList }">
											<option value="${store.id }" storeCode="${store.storeCode }" <c:if test="${store.id eq model.store.id }">selected="selected"</c:if>>${store.name }</option>
										</c:forEach>
									</select>
								</div>
							</c:if>

							<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
							<div class="col-xs-3" style="padding-top:7px;" id="store_code_div">${model.store.storeCode }</div>
						</div>
					</c:if>

					<c:if test="${!(empty user.store.id && empty model.id)}">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
							<div class="col-xs-3" style="padding-top: 7px;">
								<c:if test="${empty model.id }">
									${user.store.name }
									<input type="hidden" value="${user.store.id }" name="model.store.id"/>
								</c:if>
								<c:if test="${not empty model.id }">
									${model.store.name }
								</c:if>
							</div>

							<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
							<div class="col-xs-3" style="padding-top:7px;">
								<c:if test="${empty model.id }">
									${user.store.storeCode }
								</c:if>
								<c:if test="${not empty model.id }">
									${model.store.storeCode }
								</c:if>
							</div>
						</div>
					</c:if>
					
					<c:if test="${'yes' eq isCheck }">
						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">审核结果</label>
							<div class="col-xs-3">
								<select id="check_select" name="model.state" class="form-control" required data-bv-notempty-message="请选择审核结果">
									<option value="" selected="selected">请选择审核结果</option>
									<option value="5">不通过</option>
									<c:if test="${'1' eq model.type }">
										<option value="2">通过</option>
									</c:if>
									<c:if test="${'2' eq model.type }">
										<option value="3">通过</option>
									</c:if>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">原因</label>
							<div class="col-xs-8">
								<input type="text" value="" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="checkRemark" name="model.checkRemark"/>
							</div>
						</div>
					</c:if>

					<c:if test="${'yes' ne isCheck && not empty model.id && '5' eq model.state}">
						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">审核结果</label>
							<div class="col-xs-3" style="padding-top:7px;">${model.stateValue }</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">原因</label>
							<div class="col-xs-8" style="padding-top:7px;">${model.checkRemark }</div>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.remark" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;" id="pro_all_goods_count_div">0</div>

						<label for="product-uuid" class="col-xs-2 control-label">金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;" id="pro_all_goods_sumMoney_div">0.0元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">${proType_value_lest}产品</label>
					</div>

					<c:if test="${'no' eq isCheck }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-1 control-label">
								<input type="button" value="添加${proType_value_lest}产品" class="btn btn-primary btn-xs"
										data-toggle="modal" data-target="#edit-device"
										onclick="to_add_goods();" />
							</label>
							<div class="col-xs-2">
								<input type="text" value="" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="search_input" placeholder="商品二维码扫码框~"/>
							</div>
						</div>
					</c:if>

					<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center" width="3%">序号</th>
								<th class="text-center" width="10%">产品编号</th>
								<th class="text-center" width="10%">产品名称</th>
								<th class="text-center" width="10%">吊牌价</th>
								<th class="text-center" width="10%">${proType_value_lest}数量</th>
								<th class="text-center" width="10%">当前库存</th>
								<th class="text-center" width="10%">采购价</th>
								<th class="text-center" width="10%">采购折扣</th>
								<c:if test="${'1' eq proType }">
									<th class="text-center" width="10%">售价</th>
									<th class="text-center" width="10%">折扣</th>
								</c:if>
								<c:if test="${'no' eq isCheck }">
									<th class="text-center" width="7%">操作</th>
								</c:if>
							</tr>
						</thead>
						<tbody id="proGoods_All">
							<c:forEach items="${model.procurementGoodsList }" var="proGoods_" varStatus="i">
								<tr>
									<td class="text-center" id="number">${i.index + 1 }</td>
									<td class="text-center" id="goodsCode">
										<c:if test="${empty proGoods_.goods.goods.id }">
											${proGoods_.goods.goodsCode }
										</c:if>
										<c:if test="${not empty proGoods_.goods.goods.id }">
											${proGoods_.goods.goods.goodsCode }
										</c:if>
									</td>
									<td class="text-center" id="goodsName">
										<c:if test="${empty proGoods_.goods.goods.id }">
											${proGoods_.goods.name }
										</c:if>
										<c:if test="${not empty proGoods_.goods.goods.id }">
											${proGoods_.goods.goods.name }
										</c:if>
										<c:if test="${not empty proGoods_.goods.other_attr_value }">
											${proGoods_.goods.other_attr_value }
										</c:if>
									</td>
									<td class="text-center" id="goodsPrice">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="goodsPriceOnBlur(this);"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="吊牌价不能为空"
															value="${proGoods_.goodsPrice }"
															name="model.procurementGoodsList[${i.index }].goodsPrice"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
															data-bv-regexp-message="吊牌价格式不正确，参考格式：1688.88">
												</div>
											</div>
										</c:if>
									</td>
									<td class="text-center" id="count">
										<div class="form-group"  style="margin-bottom: 0px;">
											<div class="col-xs-12">
												<input type="hidden" id="goodsId" value="${proGoods_.goods.id }" parentId="<c:if test="${not empty proGoods_.goods.goods.id }">${proGoods_.goods.goods.id }</c:if>" name="model.procurementGoodsList[${i.index }].goods.id">
												<input type="hidden" id="proId" value="${model.id }" name="model.procurementGoodsList[${i.index }].procurement.id">
												<input type="hidden" id="proGoodsId" value="${proGoods_.id }" name="model.procurementGoodsList[${i.index }].id">
												<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);set_pro_goods_count_msg();"
														onkeydown="if(event.keyCode==32) return false;"
														required data-bv-notempty-message="${proType_value_lest}数量不能为空"
														pattern="^(([1-9][0-9]{0,7}))$" 
														<c:if test="${'2' eq proType }">
															data-bv-lessthan-inclusive="false" data-bv-lessthan-message="输入值必须小于等于现有库存"
														</c:if>
														value="${proGoods_.count }"
														name="model.procurementGoodsList[${i.index }].count"
														data-bv-regexp-message="${proType_value_lest}数量格式不正确，参考格式：168">
											</div>
										</div>
									</td>
									<td class="text-center" id="inventory">${proGoods_.goods.goods_inventory}</td>
									<td class="text-center" id="buyPrice">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);set_pro_goods_count_msg();"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="采购价不能为空"
															value="${proGoods_.buyPrice }"
															name="model.procurementGoodsList[${i.index }].buyPrice"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|([0-9]{1}\.{1}[1-9][0-9]{0,1}))$" 
															data-bv-regexp-message="采购价金额格式不正确，参考格式：168.88">
												</div>
											</div>
										</c:if>
									</td>
									<td class="text-center" id="buyAgio">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control"
															onkeydown="if(event.keyCode==32) return false;" onblur="changeBuyMoney(this);"
															value="${proGoods_.buyAgio }"
															name="model.procurementGoodsList[${i.index }].buyAgio"
															pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$" 
															data-bv-regexp-message="采购折扣格式不正确，参考格式：16.88">
												</div>
											</div>
										</c:if>
									</td>
									<c:if test="${'1' eq proType }">
										<td class="text-center" id="salseMoney">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="售价不能为空" 
															value="${proGoods_.salseMoney }"
															name="model.procurementGoodsList[${i.index }].salseMoney"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|([0-9]{1}\.{1}[1-9][0-9]{0,1}))$" 
															data-bv-regexp-message="售价金额格式不正确，参考格式：168.88">
												</div>
											</div>
										</td>
										<td class="text-center" id="salseAgio">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control"
															value="${proGoods_.salseAgio }"
															name="model.procurementGoodsList[${i.index }].salseAgio"
															onkeydown="if(event.keyCode==32) return false;" onblur="changeSalseMoney(this);"
															pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$" 
															data-bv-regexp-message="售价折扣格式不正确，参考格式：16.88">
												</div>
											</div>
										</td>
									</c:if>
									<c:if test="${'no' eq isCheck }">
										<td class="text-center">
											<div class="col-xs-12" style="padding-top: 7px;">
												<input type="button" value="删除" class="btn btn-danger btn-xs pro_goods_one_delete_button"/>
											</div>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${'no' eq isCheck }">
								<tr id="proGoods_tr_copy" style="display: none;">
									<td class="text-center" id="number"></td>
									<td class="text-center" id="goodsCode"></td>
									<td class="text-center" id="goodsName"></td>
									<td class="text-center" id="goodsPrice">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="goodsPriceOnBlur(this);"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="吊牌价不能为空"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
															data-bv-regexp-message="吊牌价格式不正确，参考格式：1688.88">
												</div>
											</div>
										</c:if>
									</td>
									<td class="text-center" id="count">
										<div class="form-group"  style="margin-bottom: 0px;">
											<div class="col-xs-12">
												<input type="hidden" id="goodsId" value="">
												<input type="hidden" id="proId" value="${model.id }">
												<input type="hidden" id="proGoodsId" value="">
												<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);set_pro_goods_count_msg();"
														onkeydown="if(event.keyCode==32) return false;"
														required data-bv-notempty-message="${proType_value_lest}数量不能为空"
														pattern="^(([1-9][0-9]{0,7}))$" 
														<c:if test="${'2' eq proType }">
															data-bv-lessthan-inclusive="false" data-bv-lessthan-message="输入值必须小于等于现有库存"
														</c:if>
														data-bv-regexp-message="${proType_value_lest}数量格式不正确，参考格式：168">
											</div>
										</div>
									</td>
									<td class="text-center" id="inventory"></td>
									<td class="text-center" id="buyPrice">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);set_pro_goods_count_msg();"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="采购价不能为空"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|([0-9]{1}\.{1}[1-9][0-9]{0,1}))$" 
															data-bv-regexp-message="采购价金额格式不正确，参考格式：168.88">
												</div>
											</div>
										</c:if>
									</td>
									<td class="text-center" id="buyAgio">
										<c:if test="${'1' eq proType }">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control"
															onkeydown="if(event.keyCode==32) return false;" onblur="changeBuyMoney(this);"
															pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$" 
															data-bv-regexp-message="采购折扣格式不正确，参考格式：16.88">
												</div>
											</div>
										</c:if>
									</td>
									<c:if test="${'1' eq proType }">
										<td class="text-center" id="salseMoney">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" onblur="update_goods_input_by_parentId(this);"
															onkeydown="if(event.keyCode==32) return false;"
															required data-bv-notempty-message="售价不能为空" 
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|([0-9]{1}\.{1}[1-9][0-9]{0,1}))$" 
															data-bv-regexp-message="售价金额格式不正确，参考格式：168.88">
												</div>
											</div>
										</td>
										<td class="text-center" id="salseAgio">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control"
															onkeydown="if(event.keyCode==32) return false;" onblur="changeSalseMoney(this);"
															pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$" 
															data-bv-regexp-message="售价折扣格式不正确，参考格式：16.88">
												</div>
											</div>
										</td>
									</c:if>
									<td class="text-center">
										<div class="col-xs-12" style="padding-top: 7px;">
											<input type="button" value="删除" class="btn btn-danger btn-xs pro_goods_one_delete_button"/>
										</div>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<c:if test="${'no' eq isCheck }">

	<input type="hidden" id="proGoods_delete_copy" value="" name="">

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
</c:if>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});
		var qrcode_id_test = /^[0-9]{32}$/,
			buyAgio_test = /^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$/;
		var pro_goods_new_index = 0, pro_goods_delete_index = 0, pro_goods_number_index = "${model.procurementGoodsList.size()}" - 0;
		if(0 >= pro_goods_number_index){
			pro_goods_number_index = 1;
		}
		/**
		 * 门店下拉框值改变的回调
		 * 拉取所属门店的一级产品列表
		 */
		function store_change(this_){
			var store_id_value = $(this_).val().trim();
			$('#store_code_div').html($(this_).find('option:selected').attr('storeCode'));
			var option_list = "<option value='' selected='selected'>请选择产品</option>";
			if("" == store_id_value){
				$("#addGoodseModal :input[type=hidden]").val("");
				$("#goods_children_id").val("").attr("disabled","disabled");
				$("#goods_parent_id").html(option_list).val("");
			} else {
				$.ajax({
					url : "${path}/goods/getGoodsByStoreId?storeId=" + store_id_value,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							for(var i = 0; i < data.obj.length; i++){ 
								option_list += "<option value='" + data.obj[i].id + "' childrenSize='" + data.obj[i].goodsChildList_size + "'>" + data.obj[i].name + "</option>";
							}
							$("#goods_parent_id").html(option_list).val("");
							// 重新初始化产品列表
							$("#proGoods_All tr:not(:hidden) input").val("").attr("disabled","disabled");
							$("#proGoods_All tr:not(:hidden)").hide();
							pro_goods_number_index = 1;
						} else {
							setEmbed();
							toastr.error(data.msg);
						}
					},
					error : function(xhr, type, exception){
						setEmbed();
						toastr.error("请检查网络设置");
					}
				});
			}
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
								setEmbed();
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception){
							setEmbed();
							toastr.error("请检查网络设置");
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
		 * 添加产品弹出框确认添加的回调
		 */
		function goAddGoods(this_){
			var goods_id_value = $(this_).parent().parent().parent().find(":input[type=hidden]").val().trim();
			if("" == goods_id_value){
				toastr.error("亲~请先选择一个产品哦~");
				return;
			} else {
				$("#addGoodseModal").modal("hide");
				add_pro_goods_tr(goods_id_value, 1);
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
		<c:if test="${'1' eq proType }">
			/**
			 * 采购折扣值改变时回调--设置采购价格等
			 */
			function changeBuyMoney(this_){
				var goods_price = $(this_).parent().parent().parent().parent().find("#goodsPrice :input[type=text]").val().trim();
				if("" == goods_price){
					toastr.error("请先输入产品吊牌价~");
					$(this_).val("");
					$(this_).parent().parent().parent().parent().find("#goodsPrice :input[type=text]").focus();
					return;
				}
				var buyAgio_nember = $(this_).val().trim()
				if(buyAgio_test.test(buyAgio_nember)){
					var buyPrice_number = accDiv(accMul(parseFloat(goods_price),parseFloat(buyAgio_nember)),parseFloat(100));
					$(this_).parent().parent().parent().parent().find("#buyPrice :input[type=text]").val(buyPrice_number.toFixed(2));
					update_goods_input_by_parentId(this_);
					set_pro_goods_count_msg();
				}
			}
			/**
			 * 商品吊牌价改变时回调--设置采购价格等
			 */
			function goodsPriceOnBlur(this_){
				var buyAgio_nember = $(this_).parent().parent().parent().parent().find("#buyAgio :input[type=text]").val().trim();
				var salseAgio_nember = $(this_).parent().parent().parent().parent().find("#salseAgio :input[type=text]").val().trim();
				var goods_price = $(this_).val().trim();
				if("" != goods_price){
					if("" != buyAgio_nember){
						if(buyAgio_test.test(buyAgio_nember)){
							var buyPrice_number = accDiv(accMul(parseFloat(goods_price),parseFloat(buyAgio_nember)),parseFloat(100));
							$(this_).parent().parent().parent().parent().find("#buyPrice :input[type=text]").val(buyPrice_number.toFixed(2));
						}
					}
					if("" != salseAgio_nember){
						if(buyAgio_test.test(salseAgio_nember)){
							var salsePrice_nember = accDiv(accMul(parseFloat(goods_price),parseFloat(salseAgio_nember)),parseFloat(100));
							$(this_).parent().parent().parent().parent().find("#salseMoney :input[type=text]").val(salsePrice_nember.toFixed(2));
						}
					}
				}
				update_goods_input_by_parentId(this_);
				set_pro_goods_count_msg();
			}
			/**
			 * 商品销售折扣改变回调
			 */
			function changeSalseMoney(this_){
				var goods_price = $(this_).parent().parent().parent().parent().find("#goodsPrice :input[type=text]").val().trim();
				if("" == goods_price){
					toastr.error("请先输入产品吊牌价~");
					$(this_).val("");
					$(this_).parent().parent().parent().parent().find("#goodsPrice :input[type=text]").focus();
					return;
				}
				var salseAgio_nember = $(this_).val().trim()
				if(buyAgio_test.test(salseAgio_nember)){
					var salsePrice_nember = accDiv(accMul(parseFloat(goods_price),parseFloat(salseAgio_nember)),parseFloat(100));
					$(this_).parent().parent().parent().parent().find("#salseMoney :input[type=text]").val(salsePrice_nember.toFixed(2));
					update_goods_input_by_parentId(this_);
				}
			}
			/**
			 * 同一商品不同子产品，各输入框值同步更新
			 */
			function update_goods_input_by_parentId(this_){
				var tr_goods_one = $(this_).parent().parent().parent().parent();
				var parentId = tr_goods_one.find("#goodsId").attr("parentId");
				if("" != parentId){
					var buyPrice_value = tr_goods_one.find("#buyPrice :input[type=text]").val().trim();
					var buyAgio_value = tr_goods_one.find("#buyAgio :input[type=text]").val().trim();
					var salseMoney_value = tr_goods_one.find("#salseMoney :input[type=text]").val().trim();
					var salseAgio_value = tr_goods_one.find("#salseAgio :input[type=text]").val().trim();
					var goodsPrice_value = tr_goods_one.find("#goodsPrice :input[type=text]").val().trim();
	
					$("#proGoods_All :input[parentId=" + parentId + "]").each(function(){
						var tr_goods_this = $(this).parent().parent().parent().parent();
						tr_goods_this.find("#buyPrice :input[type=text]").val(buyPrice_value);
						tr_goods_this.find("#buyAgio :input[type=text]").val(buyAgio_value);
						tr_goods_this.find("#salseMoney :input[type=text]").val(salseMoney_value);
						tr_goods_this.find("#salseAgio :input[type=text]").val(salseAgio_value);
						tr_goods_this.find("#goodsPrice :input[type=text]").val(goodsPrice_value);
					});
				}
			}
		</c:if>

		/**
		 * 添加采购产品（采购退货产品）到产品table中
		 * @param ownerId 产品ID或二维码ID
		 * @param ownerType ID类型1：产品ID，2：二维码ID
		 */
		function add_pro_goods_tr(ownerId,ownerType){
			var ajax_url = "", isNeedAdd = true;
			<c:if test="${empty user.store.id && empty model.id}">
				if("" == $("#storeId").val().trim()){
					toastr.error("请先选择门店~");
					return false;
				}
			</c:if>
			if(1 == ownerType){
				ajax_url = "${path}/goods/getGoodsByGoodsId?goodsId=" + ownerId;
			}else if(2 == ownerType){
				ajax_url = "${path}/goods/getGoodsByQrcodeId?QRCodeID=" + ownerId;
				<c:if test="${empty user.store.id && empty model.id}">
					ajax_url += "&storeId=" + $("#storeId").val().trim() 
				</c:if>
			}else{
				toastr.error("error--ID类型不明确，请检查代码实现~");
				return;
			}
			$.ajax({
				url : ajax_url,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						<c:if test="${'2' eq proType }">
							if(0 >= (data.obj.goods_inventory - 0)){
								setEmbed();
								toastr.error("产品：" + data.obj.name + data.obj.other_attr_value + "库存为0，不可退货~");
								return false;
							}
						</c:if>
						$("#proGoods_All tr:not(:hidden)").each(function(){
							if($(this).find("#goodsId").val().trim() == data.obj.id){
								isNeedAdd = false;
								// 退出循环
								return;
							}
						})
						if(!isNeedAdd){
							toastr.error("本产品已经添加过了哦~换一个添加吧~");
							return false;
						}
						// 获取成功，拼接页面节点
						var pro_goods_one = $("#proGoods_tr_copy").clone(),parentId = "" + data.obj.goods.id;
						pro_goods_one.find("#number").html(pro_goods_number_index);
						pro_goods_one.find("#goodsId").val(data.obj.id);
						pro_goods_one.find("#goodsId").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].goods.id");
						pro_goods_one.find("#goodsId").attr("parentId", data.obj.goods.id);
						pro_goods_one.find("#goodsCode").html(data.obj.goodsCode);
						pro_goods_one.find("#goodsName").html(data.obj.name + data.obj.other_attr_value);
						<c:if test="${'2' eq proType }">
							pro_goods_one.find("#goodsPrice").html(data.obj.price + "元");
							pro_goods_one.find("#count :input[type=text]").attr("max","" + data.obj.goods_inventory);
						</c:if>
						pro_goods_one.find("#count :input[type=text]").val("");
						pro_goods_one.find("#count :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].count");
						pro_goods_one.find("#inventory").html(data.obj.goods_inventory);
						<c:if test="${'2' eq proType }">
							pro_goods_one.find("#buyPrice").html(data.obj.buyPrice);
							pro_goods_one.find("#buyAgio").html(data.obj.buyAgio);
						</c:if>
						<c:if test="${'1' eq proType }">
							var buyPrice_value = ("" == parentId ) ? "" : ((0 >= $("#proGoods_All :input[parentId=" + parentId + "]").size()) ? "" : $("#proGoods_All :input[parentId=" + parentId + "]:first").parent().parent().parent().parent().find("#buyPrice :input[type=text]").val().trim());
							var buyAgio_value = ("" == parentId ) ? "" : ((0 >= $("#proGoods_All :input[parentId=" + parentId + "]").size()) ? "" : $("#proGoods_All :input[parentId=" + parentId + "]:first").parent().parent().parent().parent().find("#buyAgio :input[type=text]").val().trim());
							var salseMoney_value = ("" == parentId ) ? ("" + data.obj.salesPrice) : ((0 >= $("#proGoods_All :input[parentId=" + parentId + "]").size()) ? ("" + data.obj.salesPrice) : $("#proGoods_All :input[parentId=" + parentId + "]:first").parent().parent().parent().parent().find("#salseMoney :input[type=text]").val().trim());
							var salseAgio_value = ("" == parentId ) ? "" : ((0 >= $("#proGoods_All :input[parentId=" + parentId + "]").size()) ? "" : $("#proGoods_All :input[parentId=" + parentId + "]:first").parent().parent().parent().parent().find("#salseAgio :input[type=text]").val().trim());
							var goodsPrice_value = ("" == parentId ) ? ("" + data.obj.price) : ((0 >= $("#proGoods_All :input[parentId=" + parentId + "]").size()) ? ("" + data.obj.price) : $("#proGoods_All :input[parentId=" + parentId + "]:first").parent().parent().parent().parent().find("#goodsPrice :input[type=text]").val().trim());
							
							pro_goods_one.find("#goodsPrice :input[type=text]").val(goodsPrice_value);
							pro_goods_one.find("#goodsPrice :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].goodsPrice");
							pro_goods_one.find("#buyPrice :input[type=text]").val(buyPrice_value);
							pro_goods_one.find("#buyPrice :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].buyPrice");
							pro_goods_one.find("#buyAgio :input[type=text]").val(buyAgio_value);
							pro_goods_one.find("#buyAgio :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].buyAgio");
							pro_goods_one.find("#salseMoney :input[type=text]").val(salseMoney_value);
							pro_goods_one.find("#salseMoney :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].salseMoney");
							pro_goods_one.find("#salseAgio :input[type=text]").val(salseAgio_value);
							pro_goods_one.find("#salseAgio :input[type=text]").attr("name","model.procurementGoodsListNew[" + pro_goods_new_index + "].salseAgio");
						</c:if>
						pro_goods_one.removeAttr("id");
						pro_goods_new_index++;
						pro_goods_number_index++;
						$("#proGoods_All").append(pro_goods_one.show());
						bootstrapValidator_again();
					} else {
						setEmbed();
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					setEmbed();
					toastr.error("请检查网络设置");
				}
			});
		}

		/**
		 * 删除按钮--监听
		 */
		$(document).on('click', '.pro_goods_one_delete_button', function(){
			var pro_goods_number_index_tmp = 1;
			var pro_goods_id_value = $(this).parent().parent().parent().find("#proGoodsId").val().trim();
			if("" != pro_goods_id_value){
				var proGoods_delete = $("#proGoods_delete_copy").clone();
				proGoods_delete.val(pro_goods_id_value).attr("name","model.procurementGoodsListDel[" + pro_goods_delete_index + "].id").removeAttr("id");
				pro_goods_delete_index++;
				$("#proGoods_All").append(proGoods_delete);
			}
			$(this).parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
			$(this).parent().parent().parent().find("#goodsId").attr("parentId","");
			$("#proGoods_All tr").each(function(){
				if(!$(this).is(":hidden")){
					$(this).find("#number").html(pro_goods_number_index_tmp);
					pro_goods_number_index_tmp++;
				}
			})
			pro_goods_number_index--;
			bootstrapValidator_again();
		});
		/**
		 * 二维码扫码框监听
		 */
		$('#search_input').bind('keyup', function(event) {
			<c:if test="${empty user.store.id }">
				if("" == $("#storeId").val().trim()){
					toastr.error("请先选择门店~");
					return false;
				}
			</c:if>
			var search_input_value="";
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input").val().trim();
				$("#search_input").val("");
				if(qrcode_id_test.test(search_input_value)){
					// 添加产品节点
					add_pro_goods_tr(search_input_value, 2);
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});

		/**
		* 重新初始化验证
		*/
		function bootstrapValidator_again(){
			$(".form-control-feedback").remove();
			$(".help-block").remove();
			$('#theForm').data('bootstrapValidator', null);
			$('#theForm').bootstrapValidator('resetForm', false);
			$('#theForm').bootstrapValidator();//初始化验证
			set_pro_goods_count_msg();
		}
		/**
		* 设置采购单总件数，总金额
		*/
		function set_pro_goods_count_msg(){
			var pro_all_goods_count_number = 0,
				pro_all_goods_sumMoney_number = 0.0;
			$("#proGoods_All tr:not(:hidden)").each(function(){
				var pro_one_goods_count = $(this).find("#count :input[type=text]").val().trim(),
					<c:if test="${'1' eq proType }">
						pro_one_goods_buyPrice = $(this).find("#buyPrice :input[type=text]").val().trim();
					</c:if>
					<c:if test="${'2' eq proType }">
						pro_one_goods_buyPrice = $(this).find("#buyPrice").html();
					</c:if>
				if("" == pro_one_goods_count){
					pro_one_goods_count = "0";
				}
				if("" == pro_one_goods_buyPrice){
					pro_one_goods_buyPrice = "0.0";
				}
				var pro_one_goods_sumMoney = accMul(parseFloat(pro_one_goods_count),parseFloat(pro_one_goods_buyPrice));
				pro_all_goods_count_number += (pro_one_goods_count - 0);
				pro_all_goods_sumMoney_number = accAdd(parseFloat(pro_all_goods_sumMoney_number),parseFloat(pro_one_goods_sumMoney));
			});
			$("#pro_all_goods_count_div").html(pro_all_goods_count_number);
			$("#pro_all_goods_sumMoney_div").html(pro_all_goods_sumMoney_number + "元");
			$("#pro_all_goods_count_input").val(pro_all_goods_count_number);
			$("#pro_all_goods_sumMoney_input").val(pro_all_goods_sumMoney_number);
		}
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
		set_pro_goods_count_msg();
	</script>
</body>
</html>
