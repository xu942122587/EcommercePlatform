<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>

<script type="text/javascript">
	$(function() {
		$('.form-control.date').datepicker({
			format: "yyyy-mm-dd",
		    todayBtn: "linked",
		    clearBtn: true,
			language: "zh-CN",
			todayHighlight: true
		});
	});
	Namespace.register("com.yunt.qrcode.list");
	com.yunt.qrcode.list = {
		refresh : function(isSelect) {
			var href_string = "${path}/qrcode/list?model.id=" + $("#qrcodeId").val().trim()
				+ "&model.storeId=" + $("#storeId").val().trim()
				+ "&model.startDate=" + $("#startDate").val().trim()
				+ "&model.endDate=" + $("#endDate").val().trim()
				+ "&isList=fasle&model.qrcodeBatch=${model.qrcodeBatch }";
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#endDate").val().trim() != ''){
					if(compareCurrentDate($("#endDate").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#startDate").val().trim() != ''){
					if(compareCurrentDate($("#startDate").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#startDate").val().trim() != '' && $("#endDate").val().trim() != ''){
					if(!compareDate($("#endDate").val(),$("#startDate").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		printQrcode : function(id){
			$("#printQRCodeModal #printQRCodeModal_QRCodeBatch").html(id);
			$('#printQRCodeModal').modal('show');
			$("#printQRCodeModal #deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/qrcode/printQrcode?qrcodeBatch="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						//$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('操作成功！');
							com.yunt.qrcode.list.refresh();
						} else {
							toastr.error('操作失败！');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.status);
	                    alert(XMLHttpRequest.readyState);
	                    alert(textStatus);
					}
				});
			});
		} 
	};
	$(function(){
		$("#storeId").val("${model.storeId }");
	})
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-12">
				<form class="form-inline pull-right" action="" id="search" user="form">
					<div class="form-group">
						<input type="text" id="qrcodeId" name="qrcodeId" value="${model.id }" class="form-control" placeholder="二维码编号" maxlength="32">
						<c:if test="${'3' eq user.role.type }">
							<input type="hidden" id="storeId" name="goods.name" value="${user.store.id }" class="form-control" placeholder="${user.store.name }" readonly="readonly" maxlength="20">
						</c:if>
						<c:if test="${'3' ne user.role.type }">
							<lable>门店：</lable>
							<select class="form-control" id="storeId">
								<option value="" selected="selected">全部</option>
								<c:forEach var="store" items="${storeList }">
									<option value="${store.id }">${store.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
						<button type="button" class="btn btn-default" onclick="com.yunt.qrcode.list.refresh(true)">筛选</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<form id="theForm" action="${path}/qrcode/list?model.id=${model.id }&model.startDate=${model.startDate }&model.endDate=${model.endDate }&isList=${isList }&model.storeId=${model.storeId }&model.qrcodeBatch=${model.qrcodeBatch }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>二维码生成记录</h5>
			</div>
			<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">采购单号</th>
						<th class="text-center">批次号</th>
						<th class="text-center">商品编号</th>
						<th class="text-center" width="30%">商品名称</th>
						<th class="text-center">采购价</th>
						<th class="text-center">销售价</th>
						<th class="text-center">单位</th>
						<th class="text-center">生成日期</th>
						<c:if test="${'true' ne isList }">
							<th class="text-center">采购到货数量</th>
							<th class="text-center">印刷量</th>
						</c:if> 
						<c:if test="${'true' eq isList }">
							<th class="text-center">二维码编号</th>
							<th class="text-center">状态</th>
							<th class="text-center">流向</th>
						</c:if> 
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="qrcode" varStatus="i">
						<tr>
							<td class="">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td>${qrcode.procurement.procurementCode }</td>
							<td>${qrcode.qrcodeBatch }</td>
							<td>
								<c:if test="${empty qrcode.goods.goods.id }">
									${qrcode.goods.goodsCode }
								</c:if>
								<c:if test="${not empty qrcode.goods.goods.id }">
									${qrcode.goods.goods.goodsCode }
								</c:if>
							</td>
							<td>
								<c:if test="${empty qrcode.goods.goods.id }">
									${qrcode.goods.name }${qrcode.goods.other_attr_value }
								</c:if>
								<c:if test="${not empty qrcode.goods.goods.id }">
									${qrcode.goods.goods.name }${qrcode.goods.other_attr_value }
								</c:if>
							</td>
							<td>${qrcode.procurementPrice }</td>
							<td>
								<c:if test="${empty qrcode.goods.goods.id }">
									${qrcode.goods.salesPrice }
								</c:if>
								<c:if test="${not empty qrcode.goods.goods.id }">
									${qrcode.goods.goods.salesPrice }
								</c:if>
							</td>
							<td>
								<c:if test="${empty qrcode.goods.goods.id }">
									${qrcode.goods.specification.name }
								</c:if>
								<c:if test="${not empty qrcode.goods.goods.id }">
									${qrcode.goods.goods.specification.name }
								</c:if>
							</td>
							<td><fmt:formatDate value="${qrcode.createTime }" pattern="yyyy-MM-dd"/></td>
							<c:if test="${'true' ne isList }">
								<td>${qrcode.procurementBuyCount }</td>
								<td>${qrcode.printCount }</td>
							</c:if> 
							<c:if test="${'true' eq isList }">
								<td>${qrcode.id}</td>
								<td>${qrcode.stateValue }</td>
								<td>${qrcode.logistics }</td>
							</c:if>
							<td>
								<c:if test="${'true' ne isList }">
									<input type="button" value="查看明细" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
										onclick="com.yunt.index.load('${path}/qrcode/list?model.id=${model.id }&model.startDate=${model.startDate }&model.endDate=${model.endDate }&isList=true&model.storeId=${model.storeId }&model.qrcodeBatch=${qrcode.qrcodeBatch }',menuIndexTemp,submenuIndexTemp)" />
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'qrcode_print_one_again') > -1 && 'true' eq isList }">
									<c:if test="${'1' eq qrcode.state }">
										<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
												onclick="window.open('${path }/qrcode/printQRCode?qrcodeId=${qrcode.id }','_target')" />
									</c:if>
									<c:if test="${'1' ne qrcode.state }">
										<input type="button" value="补印" class="btn btn-primary btn-xs" data-toggle="modal" disabled="disabled" data-target="#edit-device"
												onclick="window.open('${path }/qrcode/printQRCode?qrcodeId=${qrcode.id }','_target')" />
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
