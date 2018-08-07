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
	Namespace.register("com.yunt.storeBonusDetil.list");
	com.yunt.storeBonusDetil.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/storeBonusDetil/list?model.store.name=' + $("#model_store_username").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
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
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
						<input type="text" value="${model.store.name }" id="model_store_username" name="model.store.name" class="form-control" placeholder="店铺名" maxlength="20">
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.storeBonusDetil.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/storeBonusDetil/list?model.store.name=${model.store.name }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>服务费统计</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">店铺名</th>
						<th class="text-center">负责人</th>
						<th class="text-center">联系电话</th>
						<th class="text-center">销售总金额</th>
						<th class="text-center">服务费总额</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="storeBonusDetil" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${storeBonusDetil.store.name }</td>
							<td class="text-center">${storeBonusDetil.store.chargeName }</td>
							<td class="text-center">${storeBonusDetil.store.chargePhone }</td>
							<td class="text-center">${storeBonusDetil.sumTargetMoney }</td>
							<td class="text-center">${storeBonusDetil.sumMoney }</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'storeBonusDetil_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/storeBonusDetil/view?storeId=${storeBonusDetil.store.id }','查看服务费详情')" />
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
