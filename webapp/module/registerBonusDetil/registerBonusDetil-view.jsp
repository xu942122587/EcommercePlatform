<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	function sendMoney(registerBonusDetilId,guideUserId){
		$('#sendMoney').modal('show');
		$("#sendMoneyButton").unbind("click").click(function(){
			 $.ajax({
				url : "${path}/registerBonusDetil/sendMoney?registerBonusDetilId="+registerBonusDetilId,
				type : "POST",
				dataType : "json",
				success : function(data) {
					$('#sendMoney').modal('hide');
					 if (data.success) {
						toastr.success(data.msg);
						com.yunt.index.load("${path}/registerBonusDetil/view?guideUserId="+guideUserId);
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					toastr.error(error);
				}
			});
		});
	}
</script>
<style type="text/css">
.placehold::-webkit-input-placeholder {
	font-weight: 600;
	font-size: 8px;
}

.placehold::-moz-placeholder {
	font-weight: 600;
	font-size: 14px;
}

.placehold::-ms-placeholder {
	font-weight: 600;
	font-size: 14px;
}

.placehold::placeholder {
	font-weight: 600;
	font-size: 14px;
}
</style>
</head>
<body>
	<!--new device from begin-->
	<div class="row" style="">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;" class="form-horizontal" id="theForm"
					role="form" method="POST" data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid"
							class="col-xs-12 control-label lantiao_lable">通告信息</label>
					</div>

					<table class="table table-striped table-hover table-bordered text-center"
							id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">月份</th>
								<th class="text-center">注册提成人数</th>
								<th class="text-center">注册提成金额</th>
								<th class="text-center">是否发放</th>
								<c:if test="${fn:indexOf(user.role.operationCodes,'registerBonusDetil_send') > -1 }">
									<th class="text-center">操作</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${registerBonusDetilList}" var="registerBonusDetil" varStatus="i">
								<!-- 系统管理员 -->
								<tr>
									<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
									<td class="text-center">${registerBonusDetil.month }</td>
									<td class="text-center">${registerBonusDetil.count }</td>
									<td class="text-center">${registerBonusDetil.money }</td>
									<td class="text-center">${registerBonusDetil.isPayMoneyValue }</td>
									<c:if test="${fn:indexOf(user.role.operationCodes,'registerBonusDetil_send') > -1 }">
										<td class="text-center">
											<c:if test="${'2' eq registerBonusDetil.isPayMoney }">
												<input type="button" value="发放提成" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
														onclick="sendMoney('${registerBonusDetil.id}','${registerBonusDetil.guideUser.id}')" />
											</c:if>
											<c:if test="${'1' eq registerBonusDetil.isPayMoney }">
												<input type="button" value="发放提成" class="btn btn-primary btn-xs" disabled="disabled"/>
											</c:if>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div class="form-group col-xs-8 pull-right">
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.load('${path}/registerBonusDetil/list')">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
