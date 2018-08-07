<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.store.view");
	com.yunt.store.view = {
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
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">活动开始时间</label>
						<div class="col-xs-2" style="padding-top: 7px;">
							<fmt:formatDate value="${model.proStartDate }" pattern="yyyy-MM-dd HH:mm"/>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">活动结束时间</label>
						<div class="col-xs-2" style="padding-top: 7px;">
							<fmt:formatDate value="${model.proEndDate }" pattern="yyyy-MM-dd HH:mm"/>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">线上线下</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.isOlineValue }</div>

						<label for="product-uuid" class="col-xs-2 control-label">支付方式</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.payTypeValue }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">针对范围</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.scopeValue }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店</label>
						<div class="col-xs-2" style="padding-top: 7px;">
							<c:if test="${'2' eq model.scope }">
								${storeName.name }
							</c:if>
							<c:if test="${'2' ne model.scope }">
								无
							</c:if>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-6" style="padding-top: 7px;">${model.remark }</div>
					</div>

					<div id="goods_list_div" <c:if test="${'1' ne model.scope }">style="display: none;"</c:if>>
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">产品列表</label>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-1 control-label"></label>
							<div class="col-xs-10" id="goods_list_div_submit">
								<c:forEach items="${parentGoodsList }" var="goods_">
									<c:if test="${0 <= fn:indexOf(model.ownerId,goods_.id) }">
										<label>
											<span goodsName="yes">${goods_.name }(${goods_.goodsCode })</span>
											<span goodsPrice="yes" style="color: red;"><fmt:formatNumber value="${goods_.salesPrice }" pattern="#,###.##"/>元</span>
										</label>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">活动清单</label>
					</div>

					<div id="Promotion_div_all">
						<c:forEach items="${model.promotionList }" var="promotion" varStatus="i">
							<div promotion_type="${promotion.type }" ladder_index="0" class="blueBorder_promotion">
								<div class="form-group">
									<label for="product-uuid" class="col-xs-2 control-label">活动类型</label>
									<div class="col-xs-3 control-label" style="padding-top: 7px; text-align: left;" id="pro_type_value_div">
										${promotion.typeValue }
									</div>
			
									<label for="product-uuid" class="col-xs-2 control-label">优先级</label>
									<div class="col-xs-3"  style="padding-top: 7px;">
										${promotion.sorting }
									</div>

								</div>

								<c:if test="${'4' ne promotion.type && '5' ne promotion.type && '6' ne promotion.type && '10' ne promotion.type && '11' ne promotion.type }">
									<c:forEach items="${promotion.promotionLadderList }" var="ladder" varStatus="j">
										<div class="form-group">
											<c:if test="${'8' ne promotion.type }">
												<label for="product-uuid" class="col-xs-2 control-label">购物金额</label>
												<div class="col-xs-3" style="padding-top: 7px;">
													${ladder.ladderStart }
												</div>
											</c:if>
											<c:if test="${'8' eq promotion.type}">
												<label for="product-uuid" class="col-xs-2 control-label">购买产品数量 </label>
												<div class="col-xs-3" style="padding-top: 7px;">
													${ladder.goodsNumberBuy }
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
												<div class="col-xs-3" style="padding-top: 7px;">
													<div  style="width: 65%;float: left;">
														${ladder.goods.name }
													</div>
													<div  style="width: 30%; margin-left:4%; float: left;" >
														<c:if test="${'7' eq promotion.type || '8' eq promotion.type   }">
															${ladder.goodsNumber }个
														</c:if>
														<c:if test="${ '9' eq promotion.type  }">
															${ladder.goodsPrice }元
														</c:if>
													</div>
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
												<div class="col-xs-3" style="padding-top: 7px;">
													<c:if test="${'1' eq promotion.type }">
														${ladder.promotionMoney }%
													</c:if>
													<c:if test="${'1' ne promotion.type }">
														${ladder.promotionMoney }元
													</c:if>
												</div>
											</c:if>
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${'4' eq promotion.type || '10' eq promotion.type || '11' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">
											<c:if test="${'4' eq promotion.type }">特价价格</c:if>
											<c:if test="${'10' eq promotion.type || '11' eq promotion.type }">折扣率（%）</c:if>
										</label>
										<div class="col-xs-3"  style="padding-top: 7px;">
											<c:if test="${'4' eq promotion.type }">
												${promotion.otherPro1 }元
											</c:if>
											<c:if test="${'10' eq promotion.type || '11' eq promotion.type }">
												${promotion.otherPro1 }%
											</c:if>
										</div>
									</div>
								</c:if>
								<c:if test="${'5' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第一件折扣</label>
										<div class="col-xs-3" style="padding-top: 7px;">
											${promotion.otherPro1 }%
										</div>

										<label for="product-uuid" class="col-xs-2 control-label">第二件折扣</label>
										<div class="col-xs-3" style="padding-top: 7px;">
											${promotion.otherPro2 }%
										</div>
									</div>
								</c:if>
								<c:if test="${'6' eq promotion.type }">
									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第一件折扣</label>
										<div class="col-xs-3" style="padding-top: 7px;">
											${promotion.otherPro1 }%
										</div>

										<label for="product-uuid" class="col-xs-2 control-label">第二件折扣</label>
										<div class="col-xs-3" style="padding-top: 7px;">
											${promotion.otherPro2 }%
										</div>
									</div>

									<div class="form-group">
										<label for="product-uuid" class="col-xs-2 control-label">第三件折扣</label>
										<div class="col-xs-3" style="padding-top: 7px;">
											${promotion.otherPro3 }%
										</div>
									</div>
								</c:if>
							</div>
							<hr style="border-top:1px solid #a9a9a9" />
						</c:forEach>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
