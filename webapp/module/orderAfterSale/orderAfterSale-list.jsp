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
	Namespace.register("com.yunt.orderAfterSale.list");
	com.yunt.orderAfterSale.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/orderAfterSale/list?model.user.username=' + $("#username").val().trim()
			+"&model.startDate=" + $("#orderAfterSale_startDate_select").val().trim()
			+"&model.endDate=" + $("#orderAfterSale_endDate_select").val().trim().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#orderAfterSale_endDate_select").val().trim() != ''){
					if(compareCurrentDate($("#orderAfterSale_endDate_select").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#orderAfterSale_startDate_select").val().trim() != ''){
					if(compareCurrentDate($("#orderAfterSale_startDate_select").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#orderAfterSale_startDate_select").val().trim() != '' && $("#orderAfterSale_endDate_select").val().trim() != ''){
					if(!compareDate($("#orderAfterSale_endDate_select").val(),$("#orderAfterSale_startDate_select").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/orderAfterSale/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除通告成功！');
							com.yunt.orderAfterSale.list.refresh();
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
	
	//-----------------日期统计初始化 -- start---------------
	$(function(){
		$('.date_input_no_class').datepicker({
			format: "yyyy-mm-dd",
			todayBtn: "linked",
			clearBtn: true,
			language: "zh-CN",
			todayHighlight: true,
		});
	});
	//-----------------日期统计初始化 -- end ---------------
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<c:if test="${fn:indexOf(user.role.operationCodes,'orderAfterSale_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger"
								onclick="com.yunt.index.loadInner('${path}/orderAfterSale/input','添加售后')">
							<span class="glyphicon glyphicon-new-window"></span> 添加售后
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
						<input type="text" value="${model.user.username }" id="username" name="username" class="form-control" placeholder="主管编号" >
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="开始日期" id="orderAfterSale_startDate_select" value="${model.startDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="结束日期" id="orderAfterSale_endDate_select" value="${model.endDate }" />
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.orderAfterSale.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/orderAfterSale/list?model.user.username=${model.user.username }&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>售后</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">商品名</th>
						<th class="text-center">属性</th>
						<th class="text-center">状况</th>
						<th class="text-center">主管</th>
						<th class="text-center">创建时间</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="orderAfterSale" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">
								<c:if test="${empty orderAfterSale.orderGoodsQrcode.qrcode.goods.name}">
									${orderAfterSale.orderGoodsQrcode.qrcode.goods.goods.name}
								</c:if>
								<c:if test="${not empty orderAfterSale.orderGoodsQrcode.qrcode.goods.name}">
									${orderAfterSale.orderGoodsQrcode.qrcode.goods.name}
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${empty orderAfterSale.orderGoodsQrcode.qrcode.goods.other_attr_value}">
									${orderAfterSale.orderGoodsQrcode.qrcode.goods.goods.other_attr_value}
								</c:if>
								<c:if test="${not empty orderAfterSale.orderGoodsQrcode.qrcode.goods.other_attr_value}">
									${orderAfterSale.orderGoodsQrcode.qrcode.goods.other_attr_value}
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${26 lt fn:length(orderAfterSale.remark)}">
									${fn:substring(orderAfterSale.remark, 0, 25)}....
								</c:if>
								<c:if test="${26 gt fn:length(orderAfterSale.remark)}">
									${orderAfterSale.remark}
								</c:if>
							</td>
							<td class="text-center">${orderAfterSale.user.username }</td>
							<td class="text-center"><fmt:formatDate value="${orderAfterSale.createTime}" pattern="yyyy-MM-dd"/></td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'orderAfterSale_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/orderAfterSale/view?id=${orderAfterSale.id }','查看通告信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'orderAfterSale_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.orderAfterSale.list.doDelete('${orderAfterSale.id }')">删除</a>
									&nbsp;&nbsp; 
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
