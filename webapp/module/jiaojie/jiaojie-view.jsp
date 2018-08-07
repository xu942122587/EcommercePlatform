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
						<label for="product-uuid" class="col-xs-12 lantiao_lable">基本信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">收银员工号</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.cashierUser.username }</div>

						<label for="product-uuid" class="col-xs-2 control-label">收银员姓名</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.cashierUser.name }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">登入时间</label>
						<div class="col-xs-2" style="padding-top: 7px;"><fmt:formatDate value="${model.loginTime }" pattern="yyyy-MM-dd HH:mm"/></div>

						<label for="product-uuid" class="col-xs-2 control-label">登出时间</label>
						<div class="col-xs-2" style="padding-top: 7px;"><fmt:formatDate value="${model.logoutTime }" pattern="yyyy-MM-dd HH:mm"/></div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">备用金</label>
						<div class="col-xs-2" style="padding-top: 7px;">200</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 lantiao_lable">
							<span onclick="$('#minxi_div').hide();$('#huizong_div').show();">汇总</span>
							<span onclick="$('#huizong_div').hide();$('#minxi_div').show();">明细</span>
						</label>
					</div>

					<div id="huizong_div">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-3 control-label">总笔数：</label>
							<div class="col-xs-2" style="padding-top: 7px;"><span>${jiaojie_map.huizongMap.submitMoneyMsg_Number }</span></div>
	
							<label for="product-uuid" class="col-xs-2 control-label">总销售额：</label>
							<div class="col-xs-2" style="padding-top: 7px;"><span>${jiaojie_map.huizongMap.submitMoneyMsg_sumMoney }</span></div>
						</div>

						<div class="form-group">
							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">现金</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_money }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_money_number }</span></label>
							</div>

							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">银联卡</label>
								<label for="product-uuid" class="col-xs-12 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_card }</span></label>
								<label for="product-uuid" class="col-xs-12 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_card_number }</span></label>
							</div>
						</div>

						<div class="form-group">
							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">微信</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_weChat }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_weChat_number }</span></label>
							</div>

							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">支付宝</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_aliPay }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_aliPay_number }</span></label>
							</div>
						</div>

						<div class="form-group">
							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">钱包余额</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_tianhe }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_tianhe_number }</span></label>
							</div>

							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">充值</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_recharge }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_recharge_number }</span></label>
							</div>
						</div>

						<div class="form-group">
							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px">
								<label class="col-xs-12">小商品</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_otherGoods }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_otherGoods }</span></label>
							</div>

							<div class="col-xs-5" style="background-color: #FFCC66;margin: 10px; color:red;">
								<label class="col-xs-12">退款</label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金额：<span>${jiaojie_map.huizongMap.all_returnMoney }</span></label>
								<label for="product-uuid" class="col-xs-12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;笔数：<span>${jiaojie_map.huizongMap.all_returnMoney_number }</span></label>
							</div>
						</div>
					</div>

					<div id="minxi_div" style="display: none;">
						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>充值</h5>
							</div>
							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">总收入</th>
										<th class="text-center">总笔数</th>
										<th class="text-center">现金支付</th>
										<th class="text-center">银行卡支付</th>
										<th class="text-center">微信支付</th>
										<th class="text-center">支付宝支付</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-center">${jiaojie_map.map_recharge.sumMoney }</td>
										<td class="text-center">${jiaojie_map.map_recharge.number }</td>
										<td class="text-center">${jiaojie_map.map_recharge.money }</td>
										<td class="text-center">${jiaojie_map.map_recharge.card }</td>
										<td class="text-center">${jiaojie_map.map_recharge.weChatPay }</td>
										<td class="text-center">${jiaojie_map.map_recharge.aliPay }</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>小商品</h5>
							</div>
							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">门店编号</th>
										<th class="text-center">门店名称</th>
										<th class="text-center">总收入</th>
										<th class="text-center">总笔数</th>
										<th class="text-center">现金消费</th>
										<th class="text-center">银行卡消费</th>
										<th class="text-center">微信消费</th>
										<th class="text-center">支付宝消费</th>
										<th class="text-center">余额消费</th>
										<th class="text-center">退款单数</th>
										<th class="text-center">退款金额</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${jiaojie_map.map_otherStore}" var="otherStore" >
										<tr>
											<td class="text-center">${otherStore.storeCode }</td>
											<td class="text-center">${otherStore.storeName }</td>
											<td class="text-center">${otherStore.storeMoneyAll }</td>
											<td class="text-center">${otherStore.storeNumber }</td>
											<td class="text-center">${otherStore.storeMoneyPay }</td>
											<td class="text-center">${otherStore.storeCardPay }</td>
											<td class="text-center">${otherStore.storeWeChatPay }</td>
											<td class="text-center">${otherStore.storeAliPay }</td>
											<td class="text-center">${otherStore.storeTianhePay }</td>
											<td class="text-center">${otherStore.storeReturnNumber }</td>
											<td class="text-center">${otherStore.storeReturnMoney }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>直营店</h5>
							</div>
							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">门店编号</th>
										<th class="text-center">门店名称</th>
										<th class="text-center">总收入</th>
										<th class="text-center">总笔数</th>
										<th class="text-center">现金消费</th>
										<th class="text-center">银行卡消费</th>
										<th class="text-center">微信消费</th>
										<th class="text-center">支付宝消费</th>
										<th class="text-center">余额消费</th>
										<th class="text-center">定金收入</th>
										<th class="text-center">尾款收入</th>
										<th class="text-center">退款单数</th>
										<th class="text-center">退款金额</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${jiaojie_map.map_tianheStore}" var="tianheStore" >
										<tr>
											<td class="text-center">${tianheStore.storeCode }</td>
											<td class="text-center">${tianheStore.storeName }</td>
											<td class="text-center">${tianheStore.storeMoneyAll }</td>
											<td class="text-center">${tianheStore.storeNumber }</td>
											<td class="text-center">${tianheStore.storeMoneyPay }</td>
											<td class="text-center">${tianheStore.storeCardPay }</td>
											<td class="text-center">${tianheStore.storeWeChatPay }</td>
											<td class="text-center">${tianheStore.storeAliPay }</td>
											<td class="text-center">${tianheStore.storeTianhePay }</td>
											<td class="text-center">${tianheStore.storeDingjin }</td>
											<td class="text-center">${tianheStore.storeWeikuan }</td>
											<td class="text-center">${tianheStore.storeReturnNumber }</td>
											<td class="text-center">${tianheStore.storeReturnMoney }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class="panel panel-default" id="all-device-detail">
							<div class="panel-heading">
								<h5>商家店</h5>
							</div>
							<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
								<thead class="text-center">
									<tr>
										<th class="text-center">门店编号</th>
										<th class="text-center">门店名称</th>
										<th class="text-center">总收入</th>
										<th class="text-center">总笔数</th>
										<th class="text-center">现金消费</th>
										<th class="text-center">银行卡消费</th>
										<th class="text-center">微信消费</th>
										<th class="text-center">支付宝消费</th>
										<th class="text-center">余额消费</th>
										<th class="text-center">退款单数</th>
										<th class="text-center">退款金额</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${jiaojie_map.map_noTianheStore}" var="noTianheStore" >
										<tr>
											<td class="text-center">${noTianheStore.storeCode }</td>
											<td class="text-center">${noTianheStore.storeName }</td>
											<td class="text-center">${noTianheStore.storeMoneyAll }</td>
											<td class="text-center">${noTianheStore.storeNumber }</td>
											<td class="text-center">${noTianheStore.storeMoneyPay }</td>
											<td class="text-center">${noTianheStore.storeCardPay }</td>
											<td class="text-center">${noTianheStore.storeWeChatPay }</td>
											<td class="text-center">${noTianheStore.storeAliPay }</td>
											<td class="text-center">${noTianheStore.storeTianhePay }</td>
											<td class="text-center">${noTianheStore.storeReturnNumber }</td>
											<td class="text-center">${noTianheStore.storeReturnMoney }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$("#minxi_div td").each(function(){
				if("" == $(this).html())
					$(this).html("0");
			});
			$("#huizong_div span").each(function(){
				if("" == $(this).html())
					$(this).html("0");
			});
		});
	</script>
</body>
</html>
