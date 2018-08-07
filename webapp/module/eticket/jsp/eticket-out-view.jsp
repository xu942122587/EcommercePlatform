<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	var isAlert = true;
	Namespace.register("com.yunt.eticket.out.view");
	com.yunt.eticket.out.view = {
	};
</script>
<style type="text/css">
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
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券发放详情</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">电子券名称</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.eticket.name }
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">发放方式</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.eticket.outTypeValue }
						</div>
					</div>

					<c:if test="${'2' eq model.eticket.outType }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-3 control-label">电子券发放阀值</label>
							<div class="col-xs-2" style="padding-top:7px;">
								满<fmt:formatNumber value="${model.eticket.outLimit }" pattern="#,###.##"/>元发放
							</div>

							<c:if test="${not empty model.eticket.outStore.name }">
								<label for="product-uuid" class="col-xs-2 control-label">发放门店</label>
								<div class="col-xs-2" style="padding-top:7px;">
									${model.eticket.outStore.name }
								</div>
							</c:if>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">电子券有效期</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.eticket.dateLimit }天
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券价值</label>
						<div class="col-xs-2" style="padding-top:7px;">
							<fmt:formatNumber value="${model.eticket.price }" pattern="#,###.##"/>元
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">类型</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.eticket.typeValue }
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券使用阀值</label>
						<div class="col-xs-2" style="padding-top:7px;">
							满<fmt:formatNumber value="${model.eticket.useLimit }" pattern="#,###.##"/>元可用
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">电子券发放日期</label>
						<div class="col-xs-2" style="padding-top:7px;">
							<fmt:formatDate value="${model.createDate }" pattern="yyyy-MM-dd"/>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">状态</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.stateValue }
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">客户昵称</label>
						<div class="col-xs-2" style="padding-top:7px;">
							${model.customer.employee.name }
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券到期日期</label>
						<div class="col-xs-2" style="padding-top:7px;">
							<fmt:formatDate value="${model.endDate }" pattern="yyyy-MM-dd"/>前可用
						</div>
					</div>

					<c:if test="${not empty model.eticket.useStore.name }">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-3 control-label">电子券可用门店</label>
							<div class="col-xs-6" style="padding-top:7px;">
								${model.eticket.useStore.name } 店内订单可用
							</div>
						</div>
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">发放备注</label>
						<div class="col-xs-6" style="padding-top:7px;">
							${model.remark }
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
