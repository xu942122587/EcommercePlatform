<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.goods.list");
	var isSuccess = true;
	com.yunt.goods.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/goods/list?model.name='
				+ $("#name").val().trim()
				+ '&model.brand.id=' + $("#model_brand_id").val().trim()
				+ '&model.store.id=' + $("#model_store_id").val().trim()
				+ '&model.classification.name=' + $("#model_classification_name").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id) {
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function() {
				$.ajax({
					url : "${path}/goods/doDelete?id=" + id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						if (data.success) {
							toastr.success('删除商品信息成功！');
							com.yunt.goods.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						toastr.error(error);
					}
				});
			});
		},
		doSetVisible : function(goodsId, flag) {
			if (isSuccess) {
				isSuccess = false;
				$.ajax({
					url : "${path}/goods/doSetVisible?goodsId=" + goodsId
							+ "&flag=" + flag,
					type : "POST",
					dataType : "json",
					success : function(data) {
						isSuccess = true;
						if (data.success) {
							toastr.success(data.msg);
							com.yunt.goods.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						isSuccess = false;
						alert(XMLHttpRequest.status);
						alert(XMLHttpRequest.readyState);
						alert(textStatus);
						toastr.error(data.msg);
					}
				});
			}
		},
		doSetRecommed : function(goodsId, flag) {
			if (isSuccess) {
				isSuccess = false;
				$.ajax({
					url : "${path}/goods/doSetRecommed?goodsId=" + goodsId
							+ "&flag=" + flag,
					type : "POST",
					dataType : "json",
					success : function(data) {
						isSuccess = true;
						if (data.success) {
							toastr.success(data.msg);
							com.yunt.goods.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						isSuccess = false;
						toastr(XMLHttpRequest.status);
						toastr(XMLHttpRequest.readyState);
						toastr(textStatus);
						toastr.error(data.msg);
					}
				});
			}
		},
		doSetAbnormal : function(goodsId, flag) {
			if (isSuccess) {
				isSuccess = false;
				$.ajax({
					url : "${path}/goods/doSetAbnormal?goodsId=" + goodsId
							+ "&flag=" + flag,
					type : "POST",
					dataType : "json",
					success : function(data) {
						isSuccess = true;
						if (data.success) {
							toastr.success(data.msg);
							com.yunt.goods.list.refresh();
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						isSuccess = false;
						toastr(XMLHttpRequest.status);
						toastr(XMLHttpRequest.readyState);
						toastr(textStatus);
						toastr.error(data.msg);
					}
				});
			}
		}
	};
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-2">
				<c:if
					test="${fn:indexOf(user.role.operationCodes,'goods_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)" type="button" class="btn btn-danger"
							onclick="com.yunt.index.loadInner('${path}/goods/input','添加商品')">
							<span class="glyphicon glyphicon-new-window"></span> 添加商品
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" goods="form">
					<div class="form-group">
						<label for="product-uuid" class="control-label">门店：</label>
						<select class="form-control" name="model.store.id" id="model_store_id">
							<option value="" selected="selected">全部</option>
							<c:forEach items="${storeList}" var="store">
								<option value="${store.id}" <c:if test="${model.store.id eq store.id }">selected="selected"</c:if>>${store.name}</option>
							</c:forEach>
						</select>
						<label for="product-uuid" class="control-label">品牌：</label>
						<select class="form-control" name="model.brand.id" id="model_brand_id">
							<option value="" selected="selected">全部</option>
							<c:forEach items="${brandList}" var="brand">
								<option value="${brand.id}" <c:if test="${model.brand.id eq brand.id }">selected="selected"</c:if>>${brand.name}</option>
							</c:forEach>
						</select>
						<input type="text" id="model_classification_name" name="model.classification.name" class="form-control"
							placeholder="分类名称……" maxlength="20"  value="${model.classification.name }">
						<input type="text" id="name" name="name" class="form-control"
							placeholder="商品名称……" maxlength="20"  value="${model.name }">
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.goods.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>

	<form id="theForm"
		action="${path}/goods/list?model.name=${model.name }&model.brand.id=${model.brand.id}&model.store.id=${model.store.id}&model.classification.name=${model.classification.name}">
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>商品列表</h5>
			</div>

			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">商品编号</th>
						<th class="text-center">商品名称</th>
						<th class="text-center">所属品牌</th>
						<th class="text-center">所属门店</th>
						<th class="text-center">所属类别</th>
						<th class="text-center">所用单位</th>
						<th class="text-center">吊牌价</th>
						<th class="text-center">售价</th>
						<th class="text-center">异常状态</th>
						<th class="text-center">创建时间</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="goods" varStatus="i">
						<c:if test="${'1' eq goods.isAbnormal }">
							<tr style="background-color: rgba(181, 26, 5, 0.65)">
								<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
								<td class="text-center">${goods.goodsCode }</td>
								<td class="text-center">${goods.name }</td>
								<td class="text-center">${goods.brand.name }</td>
								<td class="text-center">${goods.store.name }</td>
								<td class="text-center">${goods.classification.name }</td>
								<td class="text-center">${goods.specification.name }</td>
								<td class="text-center">${goods.price }</td>
								<td class="text-center">${goods.salesPrice }</td>
								<td class="text-center">
									<c:if test="${not empty goods.isAbnormal }">
										${goods.isAbnormalVlaue }
									</c:if>
									<c:if test="${empty goods.isAbnormal }">
										正常
									</c:if>
								</td>
								<td class="text-center"><fmt:formatDate
										value="${goods.createTime}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center">
									<c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_input') > -1 }">
										<input type="button" value="修改" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/goods/input?id=${goods.id }','修改商品信息')" />
										&nbsp;&nbsp; 
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_view') > -1 }">
										<input type="button" value="查看" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/goods/view?id=${goods.id }','查看商品信息')" />
										&nbsp;&nbsp; 
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_delete') > -1 }">
										<a class="btn btn-default btn-xs" href="javascript:void(0);"
											onclick="com.yunt.goods.list.doDelete('${goods.id }')">删除</a>
									</c:if></td>
							</tr>
						</c:if>
						<c:if test="${'2' eq goods.isAbnormal }">
							<tr>
								<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
								<td class="text-center">${goods.goodsCode }</td>
								<td class="text-center">${goods.name }</td>
								<td class="text-center">${goods.brand.name }</td>
								<td class="text-center">${goods.store.name }</td>
								<td class="text-center">${goods.classification.name }</td>
								<td class="text-center">${goods.specification.name }</td>
								<td class="text-center">${goods.price }</td>
								<td class="text-center">${goods.salesPrice }</td>
								<td class="text-center">
									<c:if test="${not empty goods.isAbnormal }">
										${goods.isAbnormalVlaue }
									</c:if>
									<c:if test="${empty goods.isAbnormal }">
										正常
									</c:if>
								</td>
								<td class="text-center"><fmt:formatDate
										value="${goods.createTime}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center">
									<c:if test="${fn:indexOf(user.role.operationCodes,'goods_doRecommed') > -1 }">
										<c:if test="${'2' eq goods.isRecommed }">
											<input type="button" value="推荐" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.goods.list.doSetRecommed('${goods.id}',1)" />
											&nbsp;&nbsp;
										</c:if>
										<c:if test="${'1' eq goods.isRecommed }">
											<input type="button" value="取消推荐"
												class="btn btn-primary btn-xs" data-toggle="modal"
												data-target="#edit-device"
												onclick="com.yunt.goods.list.doSetRecommed('${goods.id}',2)" />
											&nbsp;&nbsp;
										</c:if>
									</c:if>
									<c:if test="${fn:indexOf(user.role.operationCodes,'goods_doVisible') > -1 }">
										<c:if test="${'2' eq goods.isVisible }">
											<input type="button" value="上架" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.goods.list.doSetVisible('${goods.id}',1)" />
											&nbsp;&nbsp;
										</c:if>
										<c:if test="${'1' eq goods.isVisible }">
											<button class="btn btn-primary btn-xs" disabled="disabled">上架</button>
											&nbsp;&nbsp;
										</c:if>
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_doVisible') > -1 }">
										<c:if test="${'1' eq goods.isVisible }">
											<input type="button" value="下架" class="btn btn-primary btn-xs"
												data-toggle="modal" data-target="#edit-device"
												onclick="com.yunt.goods.list.doSetVisible('${goods.id}',2)" />
											&nbsp;&nbsp;
										</c:if>
										<c:if test="${'2' eq goods.isVisible }">
											<button class="btn btn-primary btn-xs" disabled="disabled">下架</button>
											&nbsp;&nbsp;
										</c:if>
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_input') > -1 }">
										<input type="button" value="修改" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/goods/input?id=${goods.id }','修改商品信息')" />
										&nbsp;&nbsp; 
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_view') > -1 }">
										<input type="button" value="查看" class="btn btn-primary btn-xs"
											data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/goods/view?id=${goods.id }','查看商品信息')" />
										&nbsp;&nbsp; 
									</c:if> <c:if
										test="${fn:indexOf(user.role.operationCodes,'goods_delete') > -1 }">
										<a class="btn btn-default btn-xs" href="javascript:void(0);"
											onclick="com.yunt.goods.list.doDelete('${goods.id }')">删除</a>
									</c:if></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
			<div class="clearfix">
				<pager:createPager pageSize="${pageObj.pageSize}"
					totalPage="${pageObj.totalPage}"
					totalCount="${pageObj.totalRecord}" curPage="${pageObj.pageNo}"
					formId="theForm" pageName="com.yunt.index" />
			</div>
		</div>
	</form>
</body>
</html>
