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
						<label for="product-uuid" class="col-xs-3 control-label">门店名称</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.storeCode }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">负责人</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.chargeName }</div>

						<label for="product-uuid" class="col-xs-2 control-label">联系电话</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.chargePhone }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">门店类型</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.typeValue }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店面积</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.acreage }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">门店地址</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.address }</div>

						<label for="product-uuid" class="col-xs-2 control-label">所属品牌</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.brandString }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">状态</label>
						<div class="col-xs-2" style="padding-top: 7px;">${model.stateValue }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-3 control-label">备注</label>
						<div class="col-xs-6" style="padding-top: 7px;">${model.remark }</div>
					</div>

					<c:if test="${not empty model.storePropertieList}">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">道具清单</label>
						</div>
	
						<div id="StoreProperty_div_all">
							<c:forEach items="${model.storePropertieList }" var="storeProperty" varStatus="i">
								<div class="form-group">
									<label for="product-uuid" class="col-xs-3 control-label">名称</label>
									<div class="col-xs-2" style="padding-top: 7px;">${storeProperty.name }</div>
			
									<label for="product-uuid" class="col-xs-2 control-label">数量</label>
									<div class="col-xs-2" style="padding-top: 7px;">${storeProperty.number }</div>
								</div>
							</c:forEach>
						</div>
					</c:if>

					<c:if test="${not empty model.userList}">
						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label  lantiao_lable">员工信息</label>
						</div>
	
						<table class="table table-striped table-hover table-bordered text-center"
								id="ggg" data-striped="true" data-smart-display="true" style="width: 98%;margin: 0px 0 15px 1%;">
							<thead class="text-center">
								<tr>
									<th class="text-center">序号</th>
									<th class="text-center">姓名</th>
									<th class="text-center">工号</th>
									<th class="text-center">职位</th>
									<th class="text-center">角色</th>
									<th class="text-center">手机号码</th>
									<th class="text-center">入职时间</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${model.userList}" var="user_" varStatus="i">
									<tr>
										<td class="">${i.index + 1 }</td>
										<td class="">${user_.name }</td>
										<td class="">${user_.username }</td>
										<td class="">${user_.job }</td>
										<td class="">${user_.role.name }</td>
										<td class="">${user_.phone }</td>
										<td class=""><fmt:formatDate value="${user_.joinTime }" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
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
