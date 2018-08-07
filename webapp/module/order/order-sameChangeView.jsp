<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.procurement.view");
	com.yunt.procurement.view = {
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
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">换货单信息</label>
				</div>
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">同商品换货单号</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.code }</div>
					
					<label for="product-uuid" class="col-xs-2 control-label">导购编号</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.order.guideUser.username }</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
					<div class="col-xs-3" style="padding-top: 7px;">${model.order.store.storeCode }</div>
					
					<label for="product-uuid" class="col-xs-2 control-label">门店名</label>
					<div class="col-xs-3" style="padding-top:7px;">${model.order.store.name }</div>
				</div>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">客户名</label>
					<div class="col-xs-3" style="padding-top: 7px;">
						<c:if test="${empty model.order.customer.name}">
							空
						</c:if>
						<c:if test="${not empty model.order.customer.name}">
							${model.order.customer.name }
						</c:if>
					</div>

					<label for="product-uuid" class="col-xs-2 control-label">用户手机号</label>
					<div class="col-xs-3" style="padding-top:7px;">
						<c:if test="${empty model.order.customer.phone}">
							空
						</c:if>
						<c:if test="${not empty model.order.customer.phone}">
							${model.order.customer.phone }
						</c:if>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">原商品</label>
				</div>
				<div class="panel panel-default" id="all-device-detail">
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品二维码</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
							</tr>
						</thead>
						<tbody >
							<c:forEach items="${orderGoodsList }" var="orderGoods">
								<c:if test="${'2' eq orderGoods.type}">
									<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
										<tr >
											<td class="text-center" >${(i.index+1)}</td>
											<td class="text-center" >
													${oGQ.qrcode.id }
											</td>
											<td class="text-center" >
												<c:if test="${empty oGQ.qrcode.goods.name }">
													${oGQ.qrcode.goods.goods.name }
												</c:if>
												<c:if test="${not empty oGQ.qrcode.goods.name }">
													${oGQ.qrcode.goods.name }
												</c:if>
											</td>
											<td class="text-center" >${oGQ.qrcode.goods.other_attr_value }</td>
										</tr>
									</c:forEach>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">换货商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>换货商品</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderGoodsList }" var="orderGoods">
								<c:if test="${'1' eq orderGoods.type}">
								<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="j">
									<tr >
										<td class="text-center" >${(j.index+1)}</td>
										<td class="text-center" >
											<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
												${oGQ.qrcode.goods.goods.goodsCode }
											</c:if>
											<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
												${oGQ.qrcode.goods.goodsCode }
											</c:if>
										</td>
										<td class="text-center" >
											<c:if test="${empty oGQ.qrcode.goods.name }">
												${oGQ.qrcode.goods.goods.name }
											</c:if>
											<c:if test="${not empty oGQ.qrcode.goods.name }">
												${oGQ.qrcode.goods.name }
											</c:if>
										</td>
										<td class="text-center" >${oGQ.qrcode.goods.other_attr_value }</td>
									</tr>
								</c:forEach>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
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
