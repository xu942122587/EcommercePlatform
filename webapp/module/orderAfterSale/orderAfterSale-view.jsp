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
<style type="text/css">

.placehold::-webkit-input-placeholder {font-weight: 600;font-size:8px; }
.placehold::-moz-placeholder {font-weight: 600;font-size:14px; }
.placehold::-ms-placeholder {font-weight: 600;font-size:14px; }
.placehold::placeholder {font-weight: 600;font-size:14px; }

</style>
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
						<label for="product-uuid" class="col-xs-3 control-label">商品名称</label>
						<div class="col-xs-2" style="padding-top: 7px;">
							<c:if test="${empty model.orderGoodsQrcode.qrcode.goods.name}">
								${model.orderGoodsQrcode.qrcode.goods.goods.name}
							</c:if>
							<c:if test="${not empty model.orderGoodsQrcode.qrcode.goods.name}">
								${model.orderGoodsQrcode.qrcode.goods.name}
							</c:if>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">商品编号</label>
						<div class="col-xs-2" style="padding-top: 7px;">
							<c:if test="${empty model.orderGoodsQrcode.qrcode.goods.goodsCode}">
								${model.orderGoodsQrcode.qrcode.goods.goods.goodsCode}
							</c:if>
							<c:if test="${not empty model.orderGoodsQrcode.qrcode.goods.goodsCode}">
								${model.orderGoodsQrcode.qrcode.goods.goodsCode}
							</c:if>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">主管</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.user.username }</div>

						<label for="product-uuid" class="col-xs-2 control-label">联系电话</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.user.phone }</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">售后金额</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.sendMoney }</div>

					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">状况描述</label>
						<div class="col-xs-6" style="padding-top: 7px;">${model.remark }</div>
					</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">图片信息</label>
						</div>
	
						<div class="form-group">
							<label for="product-uuid" class="col-xs-3 control-label">相关图片</label>
							<div class="col-xs-6 imgList" style="padding-top:7px;">
								<c:forEach items="${model.imgUrl }" var="imgName">
									<img src="${path }/platform/images/${imgName }" style="width:28%;margin:2%"/>
								</c:forEach>
							</div>
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
