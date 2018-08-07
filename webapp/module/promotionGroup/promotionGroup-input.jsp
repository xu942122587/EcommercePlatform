<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>

<script>
	var isSuccess = true;
	Namespace.register("com.yunt.promotionGroup.input");
	com.yunt.promotionGroup.input = {
		submitStore : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				<c:if test="${empty model.scope }">
					if("1" == $("#scope").val().trim()){
						if(0 >= $("#goods_list_div_submit  input[type=checkbox]:checked").length){
							toastr.error("请先选中或添加产品~");
							$("#ert").removeAttr("disabled");
							return false;
						}
					}
				</c:if>
				<c:if test="${'1' eq model.scope }">
					if(0 >= $("#goods_list_div_submit  input[type=checkbox]:checked").length){
						toastr.error("请先选中或添加产品~");
						$("#ert").removeAttr("disabled");
						return false;
					}
				</c:if>
				var isNeedNext = true;
				$(".blueBorder_promotion:not(:hidden) .add_ladder_button_copy").each(function(){
					if(1 >= $(this).parent().parent().parent().find(".form-group:not(:hidden)").length){
						isNeedNext = false;
						return false;
					}
				});
				if(!isNeedNext){
					toastr.error("尚有活动未添加优惠级别哦~");
					return false;
				}
				var a = new Array();
				$(".blueBorder_promotion:not(:hidden) .sorting_input").each(function(){
					for (var i = 0; i < a.length; i++) {
						var a_ = a[i]
						if(parseFloat(a_) == parseFloat($(this).val().trim())){
							isNeedNext = false;
							return false;
						}
					}
					if(isNeedNext){
						a.push(parseFloat($(this).val().trim()));
					}else{
						return false;
					}
				});
				if(!isNeedNext){
					toastr.error("活动优先级不可有相同的哦~");
					return false;
				}
				$(".blueBorder_promotion:not(:hidden)").each(function(){
					var b = new Array();
					if(0 < $(this).find(".ladder_start_input").length){
						$(this).find(".ladder_start_input").each(function(){
							for (var i = 0; i < b.length; i++) {
								var b_ = b[i]
								if(parseFloat(b_) == parseFloat($(this).val().trim())){
									isNeedNext = false;
									return false;
								}
							}
							if(isNeedNext){
								b.push(parseFloat($(this).val().trim()));
							}else{
								return false;
							}
						})
					}
					if(!isNeedNext){
						//跳出外层循环
						return false;
					}
				});
				if(!isNeedNext){
					toastr.error("活动购买数量或购买金额不可有重复哦~");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/promotionGroup/saveOrUpdate",
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
	$(function(){
		$('.form-control.dateTimeChange').datetimepicker({
			format: "yyyy-mm-dd hh:ii",
			todayBtn: "linked",
			clearBtn: true,
			language: "zh-CN",
			todayHighlight: true,
			minuteStep:1
		});
	});
</script>
<style type="text/css">
	.blueBorder_promotion{
		border: 1px #0AA0D9 solid;
		padding: 10px 0px 0px;
		margin-bottom: 10px;
	}
</style>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.promotionGroup.input.submitStore()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
						<c:if test="${'2' eq model.scope }">
							<input type="hidden" name="model.scope" value="${model.scope}" />
						</c:if>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">活动开始时间</label>
						<div class="col-xs-3">
							<input type="text" value="<fmt:formatDate value="${model.proStartDate }" pattern="yyyy-MM-dd HH:mm"/>" class="form-control dateTimeChange"
									onkeydown="if(event.keyCode==32) return false;" onchange="$(this).blur()"
									id="proStartDate" name="model.proStartDateString" required data-bv-notempty-message="请选择活动开始时间">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">活动结束时间</label>
						<div class="col-xs-3">
							<input type="text" value="<fmt:formatDate value="${model.proEndDate }" pattern="yyyy-MM-dd HH:mm"/>" class="form-control dateTimeChange"
									onkeydown="if(event.keyCode==32) return false;" onchange="$(this).blur()"
									id="proEndDate" name="model.proEndDateString" required data-bv-notempty-message="请选择结束开始时间">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">针对范围</label>
						<c:if test="${empty model.id }">
							<div class="col-xs-3">
								<select id="scope" name="model.scope" class="form-control" 
										onchange="scopeCHange(this);"
										required data-bv-notempty-message="请选择针对范围">
									<option value="">请选择针对范围</option>
									<option value="1">产品</option>
									<option value="2">门店</option>
									<option value="3">天和全场</option>
									<option value="4">叠加活动</option>
								</select>
							</div>
						</c:if>
						<c:if test="${not empty model.id }">
							<div class="col-xs-3" style="padding-top: 7px;">${model.scopeValue }</div>
						</c:if>

						<div id="store_select_div"  style="display: none;">
							<label for="product-uuid" class="col-xs-2 control-label">门店</label>
							<div class="col-xs-3">
								<select class="form-control" id="store_select" required data-bv-notempty-message="请选择门店" name="model.ownerId">
									<option value="" data_type="" <c:if test="${empty model.ownerId }">selected="selected"</c:if>>请选择门店</option>
									<c:forEach items="${storeList }" var="store">
										<option value="${store.id }" data_type="${store.type }" <c:if test="${store.id eq model.ownerId }">selected="selected"</c:if>>${store.name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">是否线上</label>
						<div class="col-xs-3">
							<select id="isOline" name="model.isOline" onchange="isOlineChange(this);" class="form-control" required data-bv-notempty-message="请选择是否线上">
								<option value="" selected="selected">请选择是否线上</option>
								<option value="1">线上</option>
								<option value="2">线下</option>
								<option value="3">不限制</option>
							</select>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">支付方式</label>
						<div class="col-xs-3">
							<select id="payType" name="model.payType" class="form-control" required data-bv-notempty-message="请选择支付方式">
								<option value="" <c:if test="${empty model.payType || '' eq model.payType }">selected="selected"</c:if>>请选择支付方式</option>
								<option value="6" <c:if test="${not empty model.payType && '6' eq model.payType }">selected="selected"</c:if>>不限制</option>
								<option value="1" <c:if test="${not empty model.payType && '1' eq model.payType }">selected="selected"</c:if>>现金</option>
								<option value="2" <c:if test="${not empty model.payType && '2' eq model.payType }">selected="selected"</c:if>>刷卡</option>
								<option value="3" <c:if test="${not empty model.payType && '3' eq model.payType }">selected="selected"</c:if>>微信</option>
								<option value="4" <c:if test="${not empty model.payType && '4' eq model.payType }">selected="selected"</c:if>>支付宝</option>
								<option value="5" <c:if test="${not empty model.payType && '5' eq model.payType }">selected="selected"</c:if>>天和会员余额</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									id="name" name="model.remark"/>
						</div>
					</div>

					<div id="goods_list_div" <c:if test="${'1' ne model.scope }">style="display: none;"</c:if>>
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">产品列表</label>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-1 control-label">
								<input type="button" value="添加产品" class="btn btn-primary btn-xs" onclick="showGoodsModal();"/>
							</label>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-1 control-label"></label>
							<div class="col-xs-10" id="goods_list_div_submit">
								<c:forEach items="${parentGoodsList }" var="goods_">
									<c:if test="${0 <= fn:indexOf(model.ownerId,goods_.id) }">
										<div class="checkbox" style="float: left;margin-left: 10px;">
											<label>
												<input type="checkbox" name="model.ownerId" value="${goods_.id }" checked="checked">
												<span goodsName="yes">${goods_.name }(${goods_.goodsCode })</span>
												<span goodsPrice="yes" style="color: red;"><fmt:formatNumber value="${goods_.salesPrice }" pattern="#,###.##"/>元</span>
											</label>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">活动清单</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-1 control-label">
							<input type="button" value="新建活动内容" class="btn btn-primary btn-xs" onclick="newPromotion();"/>
						</label>
					</div>

					<div id="Promotion_div_all">
						<c:forEach items="${model.promotionList }" var="promotion" varStatus="i">
							<div promotion_type="${promotion.type }" ladder_index="0" class="blueBorder_promotion">
								<div class="form-group">
									<input type="hidden" value="${promotion.id }" id="promotion_id" name="model.promotionList[${i.index }].id"/>
									<input type="hidden" value="${model.id }" id="promotion_group_id" name="model.promotionList[${i.index }].promotionGroup.id"/>
									<input type="hidden" value="${promotion.type }" name="model.promotionList[${i.index }].type"/>
									<label for="product-uuid" class="col-xs-2 control-label">活动类型</label>
									<div class="col-xs-3 control-label" style="padding-top: 7px; text-align: left;" id="pro_type_value_div">
										${promotion.typeValue }
									</div>
			
									<label for="product-uuid" class="col-xs-2 control-label">优先级</label>
									<div class="col-xs-3">
										<input type="text" value="${promotion.sorting }" class="form-control sorting_input"
												onkeydown="if(event.keyCode==32) return false;"
												id="number" name="model.promotionList[${i.index }].sorting"
												required data-bv-notempty-message="优先级不能为空"
												pattern="^[1-9][0-9]{0,7}$"
												data-bv-regexp-message="请输入正确优先级" />
									</div>

									<div class="col-xs-2" style="padding-top: 7px;">
										<input type="button" value="删除活动" title="删除一本活动" class="btn btn-danger btn-xs promotion_delete_button"/>
										<c:if test="${'4' ne promotion.type && '5' ne promotion.type && '6' ne promotion.type && '10' ne promotion.type && '11' ne promotion.type}">
											<input type="button" value="添加优惠级别" class="btn btn-primary btn-xs add_ladder_button_copy" id="add_ladder_button_copy"
													data-toggle="modal" data-target="#edit-device" onclick="addLadder(this)" />
										</c:if>
									</div>
								</div>

								<c:if test="${'4' ne promotion.type && '5' ne promotion.type && '6' ne promotion.type && '10' ne promotion.type && '11' ne promotion.type }">
									<c:forEach items="${promotion.promotionLadderList }" var="ladder" varStatus="j">
										<div class="form-group">
											<input type="hidden" id="ladder_id" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].id" value="${ladder.id }">
											<c:if test="${'8' ne promotion.type }">
												<label for="product-uuid" class="col-xs-2 control-label">购物金额</label>
												<div class="col-xs-3">
													<input type="text" value="${ladder.ladderStart }" class="form-control ladder_start_input"
															onkeydown="if(event.keyCode==32) return false;"
															id="number" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].ladderStart"
															required data-bv-notempty-message="购物金额不能为空"
															pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" data-bv-regexp-message="请输入正确购物金额" />
												</div>
											</c:if>
											<c:if test="${'8' eq promotion.type}">
												<label for="product-uuid" class="col-xs-2 control-label">购买产品数量 </label>
												<div class="col-xs-3">
													<input type="text" value="${ladder.goodsNumberBuy }" class="form-control ladder_start_input"
															placeholder="购买产品数量"
															onkeydown="if(event.keyCode==32) return false;"
															id="number" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].goodsNumberBuy"
															required data-bv-notempty-message="购买数量不能为空"
															pattern="^[1-9][0-9]{0,7}$" data-bv-regexp-message="请输入正确购买产品数量" />
												</div>
											</c:if>

											<c:if test="${'7' eq promotion.type || '8' eq promotion.type || '9' eq promotion.type  }">
												<label for="product-uuid" class="col-xs-2 control-label">
													<c:if test="${'7' eq promotion.type || '8' eq promotion.type }">
														赠送产品
													</c:if>
													<c:if test="${'9' eq promotion.type  }">
														换购产品
													</c:if>
												</label>
												<div class="col-xs-2">
													<select id="city" class="form-control" 
															name="model.promotionList[${i.index }].promotionLadderList[${j.index }].goods.id"
															required data-bv-notempty-message="请选择产品">
														<option value="">请选择产品</option>
														<%-- <c:forEach items="${gaveGoodsList }" var="goods_">
															<option value="${goods_.id }" <c:if test="${goods_.id eq ladder.goods.id }">selected="selected"</c:if>>${goods_.name }</option>
														</c:forEach> --%>
														<c:forEach items="${parentGoodsList }" var="goods_">
															<option value="${goods_.id }" <c:if test="${goods_.id eq ladder.goods.id }">selected="selected"</c:if>>${goods_.name }</option>
														</c:forEach>
													</select>
												</div>
												<div class="col-xs-1">
													<input type="text"  class="form-control"
															onkeydown="if(event.keyCode==32) return false;"
															<c:if test="${'7' eq promotion.type || '8' eq promotion.type   }">
																value="${ladder.goodsNumber }"
																id="number" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].goodsNumber"
																required data-bv-notempty-message="数量不能为空" placeholder="数量"
																pattern="^[1-9][0-9]{0,7}$" data-bv-regexp-message="请输入正确数量" 
															</c:if>
															<c:if test="${ '9' eq promotion.type  }">
																value="${ladder.goodsPrice }"
																id="number" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].goodsPrice"
																required data-bv-notempty-message="换购价不能为空" placeholder="换购价"
																pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1){0,1}|([0-9]{1}\.{1}[1-9]))$"
																data-bv-regexp-message="请输入正确换购价" 
															</c:if>/>
												</div>
											</c:if>
											<c:if test="${'7' ne promotion.type && '8' ne promotion.type && '9' ne promotion.type }">
												<label for="product-uuid" class="col-xs-2 control-label">
													<c:if test="${'1' eq promotion.type }">
														折扣率（%）
													</c:if>
													<c:if test="${'1' ne promotion.type }">
														优惠金额
													</c:if>
												</label>
												<div class="col-xs-3">
													<input type="text" value="${ladder.promotionMoney }" class="form-control"
															onkeydown="if(event.keyCode==32) return false;"
															id="number" name="model.promotionList[${i.index }].promotionLadderList[${j.index }].promotionMoney"
															<c:if test="${'1' eq promotion.type }">
																required data-bv-notempty-message="优折扣率不能为空"
																pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
																data-bv-regexp-message="请输入正确折扣率" 
															</c:if>
															<c:if test="${'1' ne promotion.type }">
																required data-bv-notempty-message="优惠金额不能为空"
																pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$"
																data-bv-regexp-message="请输入正确优惠金额" 
															</c:if>/>
												</div>
											</c:if>
											<div class="col-xs-2" style="padding-top: 7px;" >
												<input type="button" value="删除优惠级别" title="删除一个优惠级别，不删除整个活动" class="btn btn-danger btn-xs lable_delete_button"/>
											</div>
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${'4' eq promotion.type || '10' eq promotion.type || '11' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">
											<c:if test="${'4' eq promotion.type }">特价价格</c:if>
											<c:if test="${'10' eq promotion.type || '11' eq promotion.type }">折扣率（%）</c:if>
										</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro1 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro1" name="model.promotionList[${i.index }].otherPro1" 
													<c:if test="${'4' eq promotion.type }">
														required data-bv-notempty-message="特价价格不能为空"
														pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
														data-bv-regexp-message="请输入正确特价价格"
													</c:if>
													<c:if test="${'10' eq promotion.type }">
														required data-bv-notempty-message="折扣率（%）不能为空"
														pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
														data-bv-regexp-message="请输入正确折扣率（%）"
													</c:if>
													/>
										</div>
									</div>
								</c:if>
								<c:if test="${'5' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第一件折扣</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro1 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro1" name="model.promotionList[${i.index }].otherPro1" 
													required data-bv-notempty-message="折扣率（%）不能为空"
													pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
													data-bv-regexp-message="请输入正确折扣率（%）" />
										</div>

										<label for="product-uuid" class="col-xs-2 control-label">第二件折扣</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro2 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro2" name="model.promotionList[${i.index }].otherPro2" 
													required data-bv-notempty-message="折扣率（%）不能为空"
													pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
													data-bv-regexp-message="请输入正确折扣率（%）" />
										</div>
									</div>
								</c:if>
								<c:if test="${'6' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第一件折扣</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro1 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro1" name="model.promotionList[${i.index }].otherPro1" 
													required data-bv-notempty-message="折扣率（%）不能为空"
													pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
													data-bv-regexp-message="请输入正确折扣率（%）" />
										</div>

										<label for="product-uuid" class="col-xs-2 control-label">第二件折扣</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro2 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro2" name="model.promotionList[${i.index }].otherPro2" 
													required data-bv-notempty-message="折扣率（%）不能为空"
													pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
													data-bv-regexp-message="请输入正确折扣率（%）" />
										</div>
									</div>

									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第三件折扣</label>
										<div class="col-xs-3">
											<input type="text" value="${promotion.otherPro3 }" class="form-control"
													onkeydown="if(event.keyCode==32) return false;"
													id="otherPro3" name="model.promotionList[${i.index }].otherPro3" 
													required data-bv-notempty-message="折扣率（%）不能为空"
													pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
													data-bv-regexp-message="请输入正确折扣率（%）" />
										</div>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<!-- 添加活动时，选择活动类型，弹框--start -->
	<div id="selectPromotionTypeModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加活动</h4>
				</div>
				<div class="modal-body row">
					<form onsubmit="return false;" class="form-horizontal"  id="theFormSelectPromotionType" role="form" method="post"  >
						<input type="hidden">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">活动类型</label>
							<div class="col-xs-3">
								<select id="promotion_type_select" class="form-control" name="pro_type_select"> 
									<option value="" selected="selected">请选择活动类型</option>
								</select>
							</div>
						</div>
	
						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="goAddPromotion();" class="btn btn-primary btn-block" value="提交">
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
<!-- 添加活动时，选择活动类型，弹框--end -->

	<input type="hidden" id="del_id_hidden_input_copy" value="">

	<div style="display: none;" id="goods_promotion">
		<option value="" selected="selected">请选择活动类型</option>
		<option value="1">满折</option>
		<option value="2">满减</option>
		<option value="3">满返</option>
		<option value="4">特价</option>
		<option value="8">买赠促销</option>
		<option value="11">单品折扣</option>
	</div>
<!-- 直营店活动类型备选项 -->
	<div style="display: none;" id="store_promotion_1">
		<option value="" selected="selected">请选择活动类型</option>
		<option value="1">满折</option>
		<option value="2">满减</option>
		<option value="3">满返</option>
		<option value="5">前2件折扣</option>
		<option value="6">前3件折扣</option>
		<option value="7">满送促销</option>
		<option value="9">加钱换购</option>
		<option value="10">第二件折扣</option>
	</div>
<!-- 商家店活动类型备选项 -->
	<div style="display: none;" id="store_promotion_2">
		<option value="" selected="selected">请选择活动类型</option>
		<option value="1">满折</option>
		<option value="2">满减</option>
		<option value="3">满返</option>
		<option value="7">满送促销</option>
		<option value="9">加钱换购</option>
	</div>
	<div style="display: none;" id="all_promotion">
		<option value="" selected="selected">请选择活动类型</option>
		<option value="1">满折</option>
		<option value="2">满减</option>
		<option value="3">满返</option>
		<option value="5">前2件折扣</option>
		<option value="6">前3件折扣</option>
		<option value="7">满送促销</option>
		<option value="9">加钱换购</option>
		<option value="10">第二件折扣</option>
	</div>
	<div style="display: none;" id="other_promotion">
		<option value="" selected="selected">请选择活动类型</option>
		<option value="9">加钱换购</option>
	</div>

<!-- 活动基本信息--复制用节点--start -->
	<div id="promotion_one_copy" promotion_type="" ladder_index="0" class="blueBorder_promotion" style="display: none;">
		<div class="form-group">
			<input type="hidden" value="" id="promotion_id" />
			<input type="hidden" value="" id="promotion_type"/>
			<label for="product-uuid" class="col-xs-2 control-label">活动类型</label>
			<div class="col-xs-3 control-label" style="padding-top: 7px; text-align: left;" id="pro_type_value_div"></div>

			<label for="product-uuid" class="col-xs-2 control-label">优先级</label>
			<div class="col-xs-3">
				<input type="text" value="" class="form-control sorting_input" id="sorting"
						onkeydown="if(event.keyCode==32) return false;"
						required data-bv-notempty-message="优先级不能为空"
						pattern="^[1-9][0-9]{0,7}$"
						data-bv-regexp-message="请输入正确优先级" />
			</div>

			<div class="col-xs-2" style="padding-top: 7px;">
				<input type="button" value="删除活动" title="删除一本活动" class="btn btn-danger btn-xs promotion_delete_button"/>
				<input type="button" value="添加优惠级别" class="btn btn-primary btn-xs add_ladder_button_copy" id="add_ladder_button_copy"
						data-toggle="modal" data-target="#edit-device" onclick="addLadder(this)" />
			</div>
		</div>
	</div>
<!-- 活动基本信息--复制用节点--end -->

	<div class="form-group" id="empty_form_group_copy" style="display: none;"></div>

<!-- 购物金额--复制用节点--start -->
	<div id="buy_money_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">购物金额</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control ladder_start_input"
					onkeydown="if(event.keyCode==32) return false;"
					id="number"
					required data-bv-notempty-message="购物金额不能为空"
					pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" data-bv-regexp-message="请输入正确购物金额" />
		</div>
	</div>
<!-- 购物金额--复制用节点--start -->

<!-- 购买产品数量--复制用节点--start -->
	<div id="buy_goods_number_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">购买产品数量 </label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control ladder_start_input"
					placeholder="购买产品数量"
					onkeydown="if(event.keyCode==32) return false;"
					id="number" 
					required data-bv-notempty-message="购买数量不能为空"
					pattern="^[1-9][0-9]{0,7}$" data-bv-regexp-message="请输入正确购买产品数量" />
		</div>
	</div>
<!-- 购买产品数量--复制用节点--start -->

<!-- 赠送产品数量--复制用节点--start -->
	<div id="goods_number_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">赠送产品 </label>
		<div class="col-xs-2">
			<select id="city" class="form-control"
					required data-bv-notempty-message="请选择产品">
				<option value="" selected="selected">请选择产品</option>
<%-- 				<c:forEach items="${gaveGoodsList }" var="goods_">
					<option value="${goods_.id }" >${goods_.name }</option>
				</c:forEach> --%>
				<c:forEach items="${parentGoodsList }" var="goods_">
					<option value="${goods_.id }" >${goods_.name }</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-xs-1">
			<input type="text" value="" class="form-control"
					 placeholder="数量"
					onkeydown="if(event.keyCode==32) return false;"
					id="number" 
					required data-bv-notempty-message="数量不能为空"
					pattern="^[1-9][0-9]{0,7}$" data-bv-regexp-message="请输入正确数量" />
		</div>
	</div>
<!-- 赠送产品数量--复制用节点--start -->

<!-- 换购产品数量--复制用节点--start -->
	<div id="goods_huangou_number_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">换购产品 </label>
		<div class="col-xs-2">
			<select id="city" class="form-control" 
					required data-bv-notempty-message="请选择产品">
				<option value="" selected="selected">请选择产品</option>
<%-- 				<c:forEach items="${gaveGoodsList }" var="goods_">
					<option value="${goods_.id }" >${goods_.name }</option>
				</c:forEach> --%>
				<c:forEach items="${parentGoodsList }" var="goods_">
					<option value="${goods_.id }">${goods_.name }</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-xs-1">
			<input type="text" value="" class="form-control"
					placeholder="换购价" onkeydown="if(event.keyCode==32) return false;"
					id="number" required data-bv-notempty-message="换购价不能为空"
					pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1}){0,1}|([0-9]{1}\.{1}[1-9]))$"
					data-bv-regexp-message="请输入正确换购价"  />
		</div>
	</div>
<!-- 换购产品数量--复制用节点--start -->

<!-- 优惠金额--复制用节点--start -->
	<div id="goods_yh_price_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">优惠金额</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="promotionMoney" 
					required data-bv-notempty-message="优惠金额不能为空"
					pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$"
					data-bv-regexp-message="请输入正确优惠金额" />
		</div>
	</div>
<!-- 优惠金额--复制用节点--start -->

<!-- 特价价格--复制用节点--start -->
	<div id="yh_tj_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">特价价格</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					required data-bv-notempty-message="特价价格不能为空"
					pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$"
					data-bv-regexp-message="请输入正确特价价格" />
		</div>
	</div>
<!-- 优惠金额--复制用节点--start -->

<!-- 优惠折扣--复制用节点--start -->
	<div id="yh_zk_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">折扣率（%）</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					required data-bv-notempty-message="折扣率（%）不能为空"
					pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
					data-bv-regexp-message="请输入正确折扣率（%）" />
		</div>
	</div>
<!-- 优惠折扣--复制用节点--start -->

<!-- 前2件打折--复制用节点--start -->
	<div class="form-group" id="qlj_dz_div_copy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">第一件折扣</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="otherPro1"
					required data-bv-notempty-message="折扣率（%）不能为空"
					pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
					data-bv-regexp-message="请输入正确折扣率（%）" />
		</div>

		<label for="product-uuid" class="col-xs-2 control-label">第二件折扣</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="otherPro2"
					required data-bv-notempty-message="折扣率（%）不能为空"
					pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
					data-bv-regexp-message="请输入正确折扣率（%）" />
		</div>
	</div>
<!-- 前2件打折--复制用节点--end -->

<!-- 前3件打折--第3件--复制用节点--start -->
	<div class="form-group" id="dsj_dz_div_poy" style="display: none;">
		<label for="product-uuid" class="col-xs-2 control-label">第三件折扣</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="otherPro3" 
					required data-bv-notempty-message="折扣率（%）不能为空"
					pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|100)$"
					data-bv-regexp-message="请输入正确折扣率（%）" />
		</div>
	</div>
<!-- 前3件打折--第3件--复制用节点--end -->

<!-- 删除优惠级别--复制用节点--start -->
	<div class="col-xs-2" style="padding-top: 7px; display: none;" id="delete_ladder_div_copy">
		<input type="button" value="删除优惠级别" title="删除一个优惠级别，不删除整个活动" class="btn btn-danger btn-xs lable_delete_button"/>
	</div>
<!-- 删除优惠级别--第3件--复制用节点--end -->

<!-- 非线上活动，支付方式备选项--复制用节点--start -->
<div id="noOnline_pay_option" style="display: none;">
	<option value="">请选择支付方式</option>
	<option value="6">不限制</option>
	<option value="1">现金</option>
	<option value="2">刷卡</option>
	<option value="3">微信</option>
	<option value="4">支付宝</option>
	<option value="5">天和会员余额</option>
</div>
<!-- 非线上活动，支付方式备选项--第3件--复制用节点--end -->

<!-- 线上活动，支付方式备选项--复制用节点--start -->
<div id="online_pay_option" style="display: none;">
	<option value="">请选择支付方式</option>
	<option value="6">不限制</option>
	<option value="3">微信</option>
	<option value="5">天和会员余额</option>
</div>
<!-- 线上活动，支付方式备选项--第3件--复制用节点--end -->

<!-- 弹出框 -->
	<div id="goodsSelectModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加产品</h4>
				</div>
				<div class="modal-body row">
					<form onsubmit="return false;" class="form-horizontal"  id="theFormGoodsSelect" role="form" method="post"  >
						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">门店</label>
							<div class="col-xs-3">
								<select class="form-control" id="store_id_select" onchange="getGoodsListWithGroup();">
									<option value="" selected="selected">请选择门店</option>
									<c:forEach items="${storeList }" var="store">
										<c:if test="${'1' eq store.type }">
											<option value="${store.id }">${store.name }</option>
										</c:if>
									</c:forEach>
								</select>
							</div>

							<label for="device-description" class="col-xs-3 control-label">商品编号</label>
							<div class="col-xs-3">
								<input type="text" id="goodsCode" class="form-control" onblur="getGoodsListWithGroup();" placeholder="商品编号">
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">分类</label>
							<div class="col-xs-3">
								<select class="form-control"  id="class_select_1" onchange="getTwoClassification(this);getGoodsListWithGroup();" nextClass_index="2">
									<option value="" selected="selected">请选择一级分类</option>
									<c:forEach var="classification" items="${classificationList }">
										<option value="${classification.id }">${classification.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-xs-3">
								<select class="form-control"  id="class_select_2" onchange="getTwoClassification(this);getGoodsListWithGroup();" nextClass_index="3">
									<option value="" selected="selected">请选择二级分类</option>
								</select>
							</div>
							<div class="col-xs-3">
								<select class="form-control" id="class_select_3" onchange="getGoodsListWithGroup();">
									<option value="" selected="selected">请选择三级分类</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">产品列表</label>
							<div class="col-xs-9" id="goods_checkbox_list_div"></div>
						</div>

						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="addGoodsCheckNode();" class="btn btn-primary btn-block" value="提交">
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

	<div class="checkbox" style="display: none;float: left;margin-left: 10px;" id="goods_checkbox_one_copy">
		<label>
			<input type="checkbox" name="model.ownerId">
			<span goodsName="yes"></span>
			<span goodsPrice="yes" style="color: red;"></span>
		</label>
	</div>

	<script type="text/javascript">
		var promotion_delete_index = 0, ladder_delete_index = 0, promotio_new_index = 0;
		/**
		 * 添加产品回调函数--显示弹窗
		 */
		function showGoodsModal() {
			//能清除所有数据，无法清除验证错误提示，不能清除掉type为hidden类型的input的数据
			$('#theFormGoodsSelect')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#theFormGoodsSelect').bootstrapValidator('resetForm', true);
			$("#goods_checkbox_list_div").html("");
			$("#goodsSelectModal").modal("show");
		}
		/**
		 * 添加产品回调函数--拼接节点
		 */
		function addGoodsCheckNode(){
			if(0 >= $("#theFormGoodsSelect input[type=checkbox]:checked").length){
				toastr.error("请先选择产品~");
				return false;
			}
			$("#theFormGoodsSelect input[type=checkbox]:not(:checked)").parent().parent().remove();
			$("#goods_checkbox_list_div .checkbox").each(function (){
				var this_value = $(this).find("input[type=checkbox]").val().trim();
				if(0 >= $("#goods_list_div_submit input[value=" + this_value + "]").length){
					$("#goods_list_div_submit").append($(this).clone());
				} else {
					$("#goods_list_div_submit input[value=" + this_value + "]").prop("checked", true);
				}
			});
			$("#goods_checkbox_list_div").html("");
			$("#goodsSelectModal").modal("hide");
		}
		/**
		 * 添加产品回调函数--获取符合条件的产品列表
		 */
		function getGoodsListWithGroup(){
			var store_id_value = $("#theFormGoodsSelect #store_id_select").val().trim(),
				goodsCode_value = $("#theFormGoodsSelect #goodsCode").val().trim(),
				class_1_value = $("#theFormGoodsSelect #class_select_1").val().trim(),
				class_2_value = $("#theFormGoodsSelect #class_select_2").val().trim(),
				class_3_value = $("#theFormGoodsSelect #class_select_3").val().trim();
			var class_id_value = ("" != class_3_value) ? class_3_value : (("" != class_2_value) ? class_2_value : (("" != class_1_value) ? class_1_value : "" ));
			$.ajax({
				url : "${path}/goods/getGoodsListWhithProGroup?store_id=" + store_id_value + "&goodsCode=" + goodsCode_value + "&class_id=" + class_id_value,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						toastr.success(data.msg);
						$("#goods_checkbox_list_div").html("");
						for(var i = 0; i < data.obj.length; i++){ 
							var goods_checkbox_one = $("#goods_checkbox_one_copy").clone();
							goods_checkbox_one.find("input[type=checkbox]").val(data.obj[i].id);
							goods_checkbox_one.find("span[goodsName=yes]").html(data.obj[i].name + "(" + data.obj[i].goodsCode + ")");
							goods_checkbox_one.find("span[goodsPrice=yes]").html(data.obj[i].salesPrice + "元");
							goods_checkbox_one.removeAttr("id");
							$("#goods_checkbox_list_div").append(goods_checkbox_one.show());
						}
					} else {
						toastr.error(data.msg);
						console.log(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});
		}
		/**
		* 新建优惠级别--回调函数
		*/
		function addLadder(this_){
			var promotion_one = $(this_).parent().parent().parent();
			var promotion_type =promotion_one.attr("promotion_type");
			var ladder_index = promotion_one.attr("ladder_index") - 0;
			var name_start = promotion_one.find("#promotion_id").attr("name");
			name_start = name_start.substring(0,name_start.lastIndexOf("."));
			var empty_form_group = $("#empty_form_group_copy").clone(), isNeedAddPromotion = true;
			switch (promotion_type) {
			case "1"://折扣
				var buy_money_div = $("#buy_money_div_copy").clone(),
					yh_zk_div = $("#yh_zk_div_copy").clone();
				buy_money_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].ladderStart");
				yh_zk_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].promotionMoney");
				empty_form_group.append(buy_money_div.html());
				empty_form_group.append(yh_zk_div.html());
				break;
			case "2"://满减
				var buy_money_div = $("#buy_money_div_copy").clone(),
					goods_yh_price_div = $("#goods_yh_price_div_copy").clone();
				buy_money_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].ladderStart");
				goods_yh_price_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].promotionMoney");
				empty_form_group.append(buy_money_div.html());
				empty_form_group.append(goods_yh_price_div.html());
				break;
			case "3"://满返
				var buy_money_div = $("#buy_money_div_copy").clone(),
					goods_yh_price_div = $("#goods_yh_price_div_copy").clone();
				buy_money_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].ladderStart");
				goods_yh_price_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].promotionMoney");
				empty_form_group.append(buy_money_div.html());
				empty_form_group.append(goods_yh_price_div.html());
				break;
			case "4"://特价
				isNeedAddPromotion = false;
				break;
			case "5"://前2件折扣
				isNeedAddPromotion = false;
				break;
			case "6"://前3件折扣
				isNeedAddPromotion = false;
				break;
			case "7"://满送促销
				var buy_money_div = $("#buy_money_div_copy").clone(),
					goods_number_div = $("#goods_number_div_copy").clone();
				buy_money_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].ladderStart");
				goods_number_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goodsNumber");
				goods_number_div.find("select").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goods.id");
				empty_form_group.append(buy_money_div.html());
				empty_form_group.append(goods_number_div.html());
				break;
			case "8"://买赠促销
				var buy_goods_number_div = $("#buy_goods_number_div_copy").clone(),
					goods_number_div = $("#goods_number_div_copy").clone();
				buy_goods_number_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goodsNumberBuy");
				goods_number_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goodsNumber");
				goods_number_div.find("select").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goods.id");
				empty_form_group.append(buy_goods_number_div.html());
				empty_form_group.append(goods_number_div.html());
				break;
			case "9"://加钱换购
				var buy_money_div = $("#buy_money_div_copy").clone(),
					goods_number_div = $("#goods_huangou_number_div_copy").clone();
				buy_money_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].ladderStart");
				goods_number_div.find("input").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goodsPrice");
				goods_number_div.find("select").attr("name", name_start + ".promotionLadderListNew[" + ladder_index + "].goods.id");
				//goods_number_div.find("label").html("换购产品");
				empty_form_group.append(buy_money_div.html());
				empty_form_group.append(goods_number_div.html());
				break;
			case "10"://第二件折扣
				isNeedAddPromotion = false;
				break;
			case "11"://单品折扣
				isNeedAddPromotion = false;
				break;
			default:
				isNeedAddPromotion = false;
				break;
			}
			if(isNeedAddPromotion){
				var delete_ladder_div = $("#delete_ladder_div_copy").clone();
				delete_ladder_div.removeAttr("id");
				empty_form_group.append(delete_ladder_div.show());
				empty_form_group.append("<input type='hidden' id='ladder_id' name='" + name_start + ".promotionLadderListNew[" + ladder_index + "].id' value=''>");
				promotion_one.attr("ladder_index", (ladder_index + 1) + "");
				empty_form_group.removeAttr("id");
				promotion_one.append(empty_form_group.show());
				bootstrapValidator_again();
			}else{
				empty_form_group = null;
			}
		}
		/**
		* 新建活动--活动类型选择弹框中确定按钮的回调
		*/
		var promotion_one = null;
		function goAddPromotion(){
			if($('#theFormSelectPromotionType').data('bootstrapValidator').validate().isValid()){
				var promotion_type_value = $("#promotion_type_select").val().trim();
				if(0 < $(".blueBorder_promotion[promotion_type=" + promotion_type_value + "]:not(:hidden)").length){
					toastr.error("不可添加重复的活动类型");
					return false;
				}
				promotion_one = $("#promotion_one_copy").clone();
				var isNeedAddLadder = true;
				promotion_one.attr("promotion_type", promotion_type_value);
				promotion_one.find("#promotion_id").attr("name","model.promotionListNew["+promotio_new_index+"].id");
				promotion_one.find("#promotion_type").val(promotion_type_value).attr("name","model.promotionListNew["+promotio_new_index+"].type");
				promotion_one.find("#sorting").attr("name","model.promotionListNew["+promotio_new_index+"].sorting");
				switch (promotion_type_value) {
				case "1"://折扣
					promotion_one.find("#pro_type_value_div").html("满折");
					break;
				case "2"://满减
					promotion_one.find("#pro_type_value_div").html("满减");
					break;
				case "3"://满返
					promotion_one.find("#pro_type_value_div").html("满返");
					break;
				case "4"://特价
					isNeedAddLadder = false;
					promotion_one.find("#pro_type_value_div").html("特价促销");
					var empty_form_group = $("#empty_form_group_copy").clone(),
						yh_tj_div = $("#yh_tj_div_copy").clone();
					yh_tj_div.find("input").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro1");
					yh_tj_div.find("input").attr("id","otherPro1");
					yh_tj_div.removeAttr("id");
					empty_form_group.append(yh_tj_div.html());
					empty_form_group.removeAttr("id");
					promotion_one.append(empty_form_group.show());
					break;
				case "5"://前2件折扣
					isNeedAddLadder = false;
					promotion_one.find("#pro_type_value_div").html("前二件折扣");
					var qlj_dz_div = $("#qlj_dz_div_copy").clone();
					qlj_dz_div.find("#otherPro1").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro1");
					qlj_dz_div.find("#otherPro2").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro2");
					qlj_dz_div.removeAttr("id");
					promotion_one.append(qlj_dz_div.show());
					break;
				case "6"://前3件折扣
					isNeedAddLadder = false;
					promotion_one.find("#pro_type_value_div").html("前三件折扣");
					var qlj_dz_div = $("#qlj_dz_div_copy").clone();
					qlj_dz_div.find("#otherPro1").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro1");
					qlj_dz_div.find("#otherPro2").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro2");
					qlj_dz_div.removeAttr("id");
					promotion_one.append(qlj_dz_div.show());
					var dsj_dz_div = $("#dsj_dz_div_poy").clone();
					dsj_dz_div.removeAttr("id");
					dsj_dz_div.find("#otherPro3").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro3");
					promotion_one.append(dsj_dz_div.show());
					break;
				case "7"://满送促销
					promotion_one.find("#pro_type_value_div").html("满送促销");
					break;
				case "8"://买赠促销
					promotion_one.find("#pro_type_value_div").html("买赠促销");
					break;
				case "9"://加钱换购
					promotion_one.find("#pro_type_value_div").html("加钱换购");
					break;
				case "10"://第二件折扣
					isNeedAddLadder = false;
					promotion_one.find("#pro_type_value_div").html("第二件折扣");
					var empty_form_group = $("#empty_form_group_copy").clone(),
						yh_zk_div = $("#yh_zk_div_copy").clone();
					yh_zk_div.find("input").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro1");
					yh_zk_div.find("input").attr("id","otherPro1");
					yh_zk_div.removeAttr("id");
					empty_form_group.append(yh_zk_div.html());
					empty_form_group.removeAttr("id");
					promotion_one.append(empty_form_group.show());
					break;
				case "11"://单品折扣
					isNeedAddLadder = false;
					promotion_one.find("#pro_type_value_div").html("单品折扣");
					var empty_form_group = $("#empty_form_group_copy").clone(),
						yh_zk_div = $("#yh_zk_div_copy").clone();
					yh_zk_div.find("input").attr("name","model.promotionListNew["+promotio_new_index+"].otherPro1");
					yh_zk_div.find("input").attr("id","otherPro1");
					yh_zk_div.removeAttr("id");
					empty_form_group.append(yh_zk_div.html());
					empty_form_group.removeAttr("id");
					promotion_one.append(empty_form_group.show());
					break;
				default:
					isNeedAddLadder = false;
					toastr.error("添加活动出错，原因：不识别的活动类型~");
					break;
				}
				if(!isNeedAddLadder){
					//不需要优惠级别的，删除掉添加优惠级别的按钮
					promotion_one.find("#add_ladder_button_copy").remove();
				}
				promotio_new_index++;
				promotion_one.removeAttr("id");
				$("#Promotion_div_all").append(promotion_one.show());
				bootstrapValidator_again();
				$("#selectPromotionTypeModal").modal("hide");
			}
		}
		//删除活动监听
		$(document).off("click",".promotion_delete_button").on("click", ".promotion_delete_button", function(){
			var promotion_id_value = $(this).parent().parent().find("#promotion_id").val().trim();
			if("" != promotion_id_value){
				var promotion_del_id_input = $("#del_id_hidden_input_copy").clone();
				promotion_del_id_input.val(promotion_id_value);
				promotion_del_id_input.attr("name","model.promotionListDel[" + promotion_delete_index + "].id");
				promotion_del_id_input.removeAttr("id");
				$("#Promotion_div_all").append(promotion_del_id_input);
				promotion_delete_index++;
			}
			$(this).parent().parent().parent().find("input").attr("disabled", "disabled");
			$(this).parent().parent().parent().hide();
		});
		//删除档位监听
		$(document).off("click",".lable_delete_button").on("click", ".lable_delete_button", function(){
			var ladder_id_value = $(this).parent().parent().find("#ladder_id").val().trim();
			if("" != ladder_id_value){
				var ladder_del_id_input = $("#del_id_hidden_input_copy").clone();
				ladder_del_id_input.val(ladder_id_value);
				ladder_del_id_input.attr("name","model.promotionLadderListDel[" + ladder_delete_index + "].id");
				ladder_del_id_input.removeAttr("id");
				$("#Promotion_div_all").append(ladder_del_id_input);
				ladder_delete_index++;
			}
			$(this).parent().parent().find("input").attr("disabled", "disabled");
			$(this).parent().parent().hide();
		});
		/**
		* 新建活动--按钮回调函数
		*/
		function newPromotion(){
			var isAddPromotion = true,
				scope_value = "",
				isShowModal_type_select = true
				store_type = $("#store_select option:selected").attr("data_type");
			<c:if test="${empty model.id }">
				scope_value = $("#scope").val().trim();
				if("" == scope_value){
					isAddPromotion = false;
				}else {
					isAddPromotion = true;
				}
			</c:if>
			<c:if test="${not empty model.id }">
				scope_value = "${model.scope}";
			</c:if>
			if(isAddPromotion){
				// 可以添加活动节点--显示要添加的活动类型下拉选择弹框
				switch (scope_value) {
				case "1":
					$("#promotion_type_select").html($("#goods_promotion").html());
					isShowModal_type_select = true
					break;
				case "2":
					if("" == store_type){
						toastr.error("请先选择门店~");
						isShowModal_type_select = false;
					}else{
						$("#promotion_type_select").html($("#store_promotion_" + store_type).html());
						isShowModal_type_select = true
					}
					break;
				case "3":
					$("#promotion_type_select").html($("#all_promotion").html());
					isShowModal_type_select = true
					break;
				case "4":
					$("#promotion_type_select").html($("#other_promotion").html());
					isShowModal_type_select = true
					break;
				default:
					isShowModal_type_select = false;
					break;
				}
				if(isShowModal_type_select){
					//能清除所有数据，无法清除验证错误提示，不能清除掉type为hidden类型的input的数据
					$('#theFormSelectPromotionType')[0].reset();
					//只能清除验证，无法清除不带验证input标签的数据
					$('#theFormSelectPromotionType').bootstrapValidator('resetForm', true);
					$("#selectPromotionTypeModal").modal("show");
				}
			} else {
				// 不可以添加活动节点
				toastr.error("请先选择活动针对范围~");
				return false;
			}
		}
		$("#scope").val("${model.scope}");
		$("#isOline").val("${model.isOline}");
		$("#payType").val("${model.payType}");
		<c:if test="${'2' eq model.scope }">
			$("#store_select_div").show();
		</c:if>
		<c:if test="${empty model.id }">
			/**
			 * 针对范围改变时的回调函数
			 */
			function scopeCHange(this_){
				var scope_value = $(this_).val().trim();
				if("1" == scope_value){
					$("#goods_list_div").show();
					$("#store_select_div").hide();
					$("#store_select").attr("disabled","disabled");
					$("#isOline").val("").parent().parent().show();
					$("#payType").val("").parent().parent().show();
				} else if("2" == scope_value){
					$("#goods_list_div").hide();
					$("#store_select_div").show();
					$("#store_select").removeAttr("disabled");
					$("#isOline").val("").parent().parent().show();
					$("#payType").val("").parent().parent().show();
				} else if("3" == scope_value){
					$("#goods_list_div").hide();
					$("#store_select_div").hide();
					$("#store_select").attr("disabled","disabled");
					$("#isOline").val("").parent().parent().show();
					$("#payType").val("").parent().parent().show();
				}else if("4" == scope_value){
					$("#goods_list_div").hide();
					$("#store_select_div").hide();
					$("#store_select").attr("disabled","disabled");
					$("#isOline").val("3").parent().parent().hide();
					$("#payType").val("6").parent().parent().hide();
				}
				$("#Promotion_div_all").find("input").attr("disabled","disabled");
				$("#Promotion_div_all div").hide();
				$("#goods_list_div_submit").html("");
				bootstrapValidator_again();
			}
		</c:if>
		/**
		 * 线上线下选项值改变的回调函数
		 */
		function isOlineChange(this_){
			var isOnline_value = $(this_).val().trim();
			if("" == isOnline_value){//未选择
				$("#payType").html($("#noOnline_pay_option").html()).val("");
			} else if("1" == isOnline_value){//线上
				$("#payType").html($("#online_pay_option").html()).val("");
			} else if("2" == isOnline_value){//线下
				$("#payType").html($("#noOnline_pay_option").html()).val("");
			} else if("3" == isOnline_value){//全部
				$("#payType").html($("#noOnline_pay_option").html()).val("");
			}
		}
		$('#theFormSelectPromotionType').bootstrapValidator({
			message: '此值无效',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				'pro_type_select': {
					message: '活动类型无效',
					validators: {
						notEmpty: {
							message: '请选择活动类型！'
						}
					}
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
		}
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});
		/**
		 * 获取下一级分类
		 */
		function getTwoClassification(this_){
			var classification_id = $(this_).val().trim(),nextClass_index = $(this_).attr("nextClass_index") - 0;
			if("" == classification_id){
				if(2 == nextClass_index){
					$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择二级分类</option>").val("").attr("disabled","disabled");
					$("#class_select_" + (nextClass_index + 1)).html("<option value='' selected='selected'>请选择三级分类</option>").val("").attr("disabled","disabled");
				} else if(3 == nextClass_index){
					$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择三级分类</option>").val("").attr("disabled","disabled");
				}
				return;
			}
			$.ajax({
				url : "${path}/classification/getTwoClassification?classificationId=" + classification_id,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var twoClassificationArray = eval(data.msg);
						if(0 < twoClassificationArray.length){
							var twoClassification_tring = "";
							for(var i = 0; i < twoClassificationArray.length; i++){
								var value_String = twoClassificationArray[i].name,
									id_String = twoClassificationArray[i].id,
									isEmptyAttr = ("" == twoClassificationArray[i].otherAttrJson);
								twoClassification_tring += "<option value='" + id_String + "' isEmptyAttr= "+isEmptyAttr +">" + value_String + "</option>";
							}
							if(2 == nextClass_index){
								$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择二级分类</option>" + twoClassification_tring).val("");
							} else if(3 == nextClass_index){
								$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择三级分类</option>" + twoClassification_tring).val("");
							}
							$("#class_select_" + nextClass_index).removeAttr("disabled");
						}else{
							if(2 == nextClass_index){
								$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择二级分类</option>").val("");
							} else if(3 == nextClass_index){
								$("#class_select_" + nextClass_index).html("<option value='' selected='selected'>请选择三级分类</option>").val("");
							}
							$("#class_select_" + nextClass_index).attr("disabled","disabled");
						}
					} else {
						toastr.error('拉取下级分类出错，请重试或联系管理员！');
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});
		}
	</script>
</body>
</html>
