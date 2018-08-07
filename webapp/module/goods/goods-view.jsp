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
						<label for="product-uuid" class="col-xs-2 control-label">商品名称</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">商品编号</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.goodsCode }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">所属类别</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.classification.name}</div>

						<label for="product-uuid" class="col-xs-2 control-label">所属品牌</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.brand.name}</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">所属门店</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.store.name}</div>

						<label for="product-uuid" class="col-xs-2 control-label">上市时间</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.marketTime }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">吊牌价</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.price }</div>

						<label for="product-uuid" class="col-xs-2 control-label">实际售价</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.salesPrice }</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">库存预警上限</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.warningUp }</div>

						<label for="product-uuid" class="col-xs-2 control-label">库存预警下限</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.warningDown }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">所用单位</label>
						<div class="col-xs-4" style="padding-top: 7px;">${model.specification.name}</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-9" style="padding-top: 7px;">${model.remark }</div>
					</div>
					
					<c:if test="${not empty model.goodsChildList}">
					
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">商品属性</label>
						</div>
						
						<c:forEach items="${model.goodsChildList}" var="goodsChild" varStatus="i">
							<div class="col-xs-5" style="background-color: #20a1d2;margin: 10px">
								<c:forEach items="${classStringList}" var="classString" >
									<div class="form-group">
										<label for="product-uuid" class="col-xs-4 control-label">${classString.attr}</label>
										<div class="col-xs-8" style="padding-top: 7px;">
											${model.goodsChildList[i.index].other_map[classString.attrCode]}
										</div>
									</div>
								</c:forEach>
							</div>
						</c:forEach>
					</c:if>
					
					<c:if test="${not empty model.imgUrl}">
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
					</c:if>
					
					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
