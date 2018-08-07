<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.customer.view");
	com.yunt.customer.view = {
		load : function(href_string) {
			$("#order_list").load(href_string);
		}
	};
	com.yunt.customer.view.load("${path}/order/list?model.customer.id=${customer.id}&pageName=com.yunt.customer.view");
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;"
					class="form-horizontal" id="the_Form" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">会员信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">姓名</label>
						<div class="col-xs-4" style="padding-top: 7px;">${customer.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">生日</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatDate value="${customer.birthday }" pattern="yyyy-MM-dd"/></div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">手机号</label>
						<div class="col-xs-4" style="padding-top: 7px;">${customer.phone}</div>

						<label for="product-uuid" class="col-xs-2 control-label">钱包余额</label>
						<div class="col-xs-3" style="padding-top: 7px;">
							<c:if test="${empty customer.money}">
								无
							</c:if>
							<c:if test="${not empty customer.money}">
								${customer.money}
							</c:if>
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">注册推荐人</label>
						<div class="col-xs-4" style="padding-top: 7px;">
							<c:if test="${empty customer.guideUser}">
								无
							</c:if>
							<c:if test="${not empty customer.guideUser}">
								${customer.guideUser.name}
							</c:if>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">创建时间</label>
						<div class="col-xs-3" style="padding-top: 7px;"><fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd"/></div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">线上购买量</label>
						<div class="col-xs-4" style="padding-top: 7px;">
							<c:if test="${empty customer.upSumNumber }">
								无
							</c:if>
							<c:if test="${not empty customer.upSumNumber }">
								${customer.upSumNumber }
							</c:if>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">线上消费额</label>
						<div class="col-xs-3" style="padding-top: 7px;">
							<c:if test="${empty customer.upPayMoney }">
								无
							</c:if>
							<c:if test="${not empty customer.upPayMoney }">
								<fmt:formatNumber value="${customer.upPayMoney }" pattern="#,###.##"/>
							</c:if>
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">线下购买量</label>
						<div class="col-xs-4" style="padding-top: 7px;">
							<c:if test="${empty customer.downSumNumber }">
								无
							</c:if>
							<c:if test="${not empty customer.downSumNumber }">
								${customer.downSumNumber }
							</c:if>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">线下消费额</label>
						<div class="col-xs-3" style="padding-top: 7px;">
							<c:if test="${empty customer.downPayMoney }">
								无
							</c:if>
							<c:if test="${not empty customer.downPayMoney }">
								<fmt:formatNumber value="${customer.downPayMoney }" pattern="#,###.##"/>
							</c:if>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">会员订单</label>
					</div>
				</form>
				<div id="order_list">
				
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
