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
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/procurement/saveOrUpdate?isCheck=${isCheck}",
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
					<input type="hidden" name="model.id" value="${model.id}" />
					<input type="hidden" name="model.state" value="6" />
					<input type="hidden" name="model.buyCount" value="${model.count}" id="pro_all_goods_count_input"/>
					<input type="hidden" name="model.buySumMoney" value="${model.sumMoney}" id="pro_all_goods_sumMoney_input"/>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.vende.name }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.store.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.store.storeCode }</div>
					</div>

					<c:if test="${'yes' eq isCheck }">
						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">审核结果</label>
							<div class="col-xs-3" ></div>
	
							<label for="device-description" class="col-xs-2 control-label">原因</label>
							<div class="col-xs-3">
								<input type="text" value="" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="checkRemark" name="model.checkRemark"/>
							</div>
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
						<label for="product-uuid" class="col-xs-2 control-label">申请件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.count }</div>

						<label for="product-uuid" class="col-xs-2 control-label">申请金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.sumMoney }" pattern="#,##0.00"/>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">到货件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;" id="pro_all_goods_count_div">${model.count }</div>

						<label for="product-uuid" class="col-xs-2 control-label">到货金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;" id="pro_all_goods_sumMoney_div"><fmt:formatNumber value="${model.sumMoney }" pattern="#,##0.00"/>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">${proType_value_lest}产品</label>
					</div>

					<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center" width="3%">序号</th>
								<th class="text-center" width="10%">产品编号</th>
								<th class="text-center" width="10%">产品名称</th>
								<th class="text-center" width="10%">吊牌价</th>
								<th class="text-center" width="10%">申请数量</th>
								<th class="text-center" width="10%">到货数量</th>
								<th class="text-center" width="7%">当前库存</th>
								<th class="text-center" width="10%">采购价</th>
								<th class="text-center" width="10%">采购折扣</th>
								<th class="text-center" width="10%">售价</th>
								<th class="text-center" width="10%">销售折扣</th>
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
									<td class="text-center" id="goodsPrice">${proGoods_.goodsPrice }</td>
									<td class="text-center" id="count">
										${proGoods_.count }
										<input type="hidden" id="proGoodsId" value="${proGoods_.id }" name="model.procurementGoodsList[${i.index }].id">
									</td>
									<td class="text-center" id="buyCount">
										<div class="form-group" style="margin-bottom: 0px;">
											<div class="col-xs-12">
												<input type="text" class="form-control" onblur="set_pro_goods_count_msg();"
														onkeydown="if(event.keyCode==32) return false;"
														required data-bv-notempty-message="到货数量不能为空"
														value="${proGoods_.count }"
														name="model.procurementGoodsList[${i.index }].buyCount"
														pattern="^(([1-9][0-9]{0,7})|0)$" 
														data-bv-regexp-message="到货数量格式不正确，参考格式：168">
											</div>
										</div>
									</td>
									<td class="text-center" id="inventory">${proGoods_.goods.goods_inventory}</td>
									<td class="text-center" id="buyPrice">${proGoods_.buyPrice }</td>
									<td class="text-center" id="buyAgio">${proGoods_.buyAgio }</td>
									<td class="text-center" id="salseMoney">${proGoods_.salseMoney }</td>
									<td class="text-center" id="salseAgio">${proGoods_.salseAgio }</td>
								</tr>
							</c:forEach>
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
	<div id="embed_div"></div>


	<script type="text/javascript">
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});

		/**
		* 设置采购单总件数，总金额
		*/
		function set_pro_goods_count_msg(){
			var pro_all_goods_count_number = 0,
				pro_all_goods_sumMoney_number = 0.0;
			$("#proGoods_All tr:not(:hidden)").each(function(){
				var pro_one_goods_count = $(this).find("#buyCount :input[type=text]").val().trim(),
						pro_one_goods_buyPrice = $(this).find("#buyPrice").html();
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
