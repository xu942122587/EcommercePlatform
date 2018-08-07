<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function() {
		//初始化表格，中文显示必须要使用js初始化
		/* $('#ggg').bootstrapTable({
			//url:'${path}/platform/ui/bootstrap/aaa.json'
		}); */
	});
	Namespace.register("com.yunt.inventory.list");
	com.yunt.inventory.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/inventory/list?model.goods.name='
				+ $("#name").val().trim()
				+ '&model.goods.brand.id=' + $("#model_goods_brand_id").val().trim()
				+ '&model.downCount=' + $("#model_downCount").val().trim()
				+ '&model.upCount=' + $("#model_upCount").val().trim()
				<c:if test="${empty user.store.id}">
					+ '&model.goods.store.id=' + $("#model_goods_store_id").val().trim()
				</c:if>
				+ '&model.storage.id=' + $("#model_storage_id").val().trim()
				+ '&model.goods.classification.name=' + $("#model_goods_classification_name").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/inventory/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除通告成功！');
							com.yunt.inventory.list.refresh();
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
	};
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-12">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
					仓库:	<select class="form-control" name="model.storage.id"
							id="model_storage_id">
							<option value="" selected="selected">全部仓库</option>
							<c:forEach items="${storageList}" var="storage">
								<option value="${storage.id}" <c:if test="${model.storage.id eq storage.id }">selected="selected"</c:if>>${storage.name}</option>
							</c:forEach>
						</select>
						
					<c:if test="${empty user.store.id}">
					商店:	<select class="form-control" name="model.goods.store.id"
							id="model_goods_store_id">
							<option value="" selected="selected">全部商店</option>
							<c:forEach items="${storeList}" var="store">
								<option value="${store.id}" <c:if test="${model.goods.store.id eq store.id }">selected="selected"</c:if>>${store.name}</option>
							</c:forEach>
						</select>
					</c:if>
					
					品牌:	<select class="form-control" name="model.goods.brand.id"
							id="model_goods_brand_id">
							<option value="" selected="selected">全部品牌</option>
							<c:forEach items="${brandList}" var="brand">
								<option value="${brand.id}" <c:if test="${model.goods.brand.id eq brand.id }">selected="selected"</c:if>>${brand.name}</option>
							</c:forEach>
						</select>
						<input type="text" id="model_goods_classification_name" name="model.goods.classification.name" class="form-control"
								placeholder="分类名称……" maxlength="20"  value="${model.goods.classification.name }">
						<input type="text" id="name" name="model.goods.name" class="form-control"
								placeholder="商品名称……" maxlength="20"  value="${model.goods.name }">
						<input type="text" id="model_downCount" name="model.downCount" class="form-control"
								placeholder="最低库存" maxlength="20"  value="${model.downCount }">
						<input type="text" id="model_upCount" name="model.upCount" class="form-control"
								placeholder="最高库存" maxlength="20"  value="${model.upCount }">
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.inventory.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" 
		action="${path}/inventory/list?model.goods.name=${model.goods.name}&model.goods.brand.id=${model.goods.brand.id}&model.downCount=${model.downCount}&model.upCount=${model.upCount}&model.goods.store.id=${model.goods.store.id}&model.storage.id=${model.storage.id}&model.goods.classification.name=${model.goods.classification.name}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>库存 (总数量:<c:if test="${empty sumInventoryVO.allCount }">0</c:if> ${sumInventoryVO.allCount},总金额:<c:if test="${empty sumInventoryVO.allMoney }">0.0</c:if>${sumInventoryVO.allMoney})</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">仓库</th>
						<th class="text-center">商品编号</th>
						<th class="text-center">商品名称</th>
						<th class="text-center">所属品牌</th>
						<th class="text-center">所属类别</th>
						<th class="text-center">销售价</th>
						<th class="text-center">库存上限预警</th>
						<th class="text-center">库存下限预警</th>
						<th class="text-center">当前库存</th>
						<th class="text-center">单位</th>
						<th class="text-center">库存金额</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="inventory" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${inventory.storage.name}</td>
							<td class="text-center">${inventory.goods.goodsCode}</td>
							<td class="text-center">${inventory.goods.name}</td>
							<td class="text-center">${inventory.goods.brand.name}</td>
							<td class="text-center">${inventory.goods.classification.name}</td>
							<td class="text-center">${inventory.goods.salesPrice}</td>
							<td class="text-center">
								<c:if test="${'1' eq inventory.warningUpValue}">
									<span class="glyphicon glyphicon-alert" style="color: red;font-size: 20px"></span>
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${'1' eq inventory.warningDownValue}">
									<span class="glyphicon glyphicon-alert" style="color: red;font-size: 20px"></span>
								</c:if>
							</td>
							<td class="text-center">
								${inventory.count}
							</td>
							<%-- <c:if test="${3 eq user.role.type}">
								<td class="text-center">
								约<fmt:formatNumber type="number" value="${inventory.count/10}" maxFractionDigits="0"/>0
								<c:if test="${10 gt inventory.count-0}">
									-
								</c:if>
								<c:if test="${10 lt inventory.count-0}">
									+
								</c:if>
								<c:if test="${10 eq inventory.count-0}">
									+
								</c:if>
								</td>
							</c:if> --%>
							<td class="text-center">${inventory.goods.specification.name}</td>
							<td class="text-center"><fmt:formatNumber value="${inventory.money}" pattern="###.##"/></td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'inventory_view') > -1 }">
									<c:if test="${0 eq inventory.goods.goodsChildList_size}">
									<input type="button" value="查看" class="btn btn-primary btn-xs" disabled="disabled" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/inventory/view?id=${inventory.goods.id }&storageId=${inventory.storage.id}','查看子产品库存')" />
									&nbsp;&nbsp;
									</c:if> 
									<c:if test="${0 ne inventory.goods.goodsChildList_size}">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/inventory/view?id=${inventory.goods.id }&storageId=${inventory.storage.id}','查看子产品库存')" />
									&nbsp;&nbsp;
									</c:if> 
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="fixed-table-footer"></div>
			<div class="clearfix">
				<pager:createPager pageSize="${pageObj.pageSize}"
						totalPage="${pageObj.totalPage}"
						totalCount="${pageObj.totalRecord}" curPage="${pageObj.pageNo}"
						formId="theForm" pageName="com.yunt.index"/>
			</div>
		</div>
	</form>	
</body>
</html>
