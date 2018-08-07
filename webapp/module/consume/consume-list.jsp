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
	Namespace.register("com.yunt.consume.list");
	com.yunt.consume.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/consume/list?model.customer.name=' + $("#customer_name").val().trim()
				+'&model.guideUser.username=' + $("#guideUser_username").val().trim()
				+"&model.startDate=" + $("#consume_startDate_select").val().trim()
				+"&model.endDate=" + $("#consume_endDate_select").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#consume_endDate_select").val().trim() != ''){
					if(compareCurrentDate($("#consume_endDate_select").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#consume_startDate_select").val().trim() != ''){
					if(compareCurrentDate($("#consume_startDate_select").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#consume_startDate_select").val().trim() != '' && $("#consume_endDate_select").val().trim() != ''){
					if(!compareDate($("#consume_endDate_select").val(),$("#consume_startDate_select").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
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
			<div class="col-xs-3">
			</div>
			<div class="col-xs-9">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
						<input type="text" value="${model.guideUser.username}" id="guideUser_username" name="guideUser_username" class="form-control" placeholder="导购编号……" maxlength="20">
						<input type="text" value="${model.customer.name}" id="customer_name" name="customer_name" class="form-control" placeholder="用户名……" maxlength="20">
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="开始日期" id="consume_startDate_select" value="${model.startDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="结束日期" id="consume_endDate_select" value="${model.endDate }" />
					</div>
					<button type="button" class="btn btn-default"
						onclick="com.yunt.consume.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/consume/list?model.id=${model.id }&model.customer.name=${model.customer.name}&model.guideUser.username=${model.guideUser.username}&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>流水记录</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">用户名</th>
						<th class="text-center">金额</th>
						<th class="text-center">流水记录</th>
						<th class="text-center">类别</th>
						<th class="text-center">创建时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="consume" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${consume.customer.name }</td>
							<td class="text-center">${consume.money }</td>
							<td class="text-center">
								<c:if test="${not empty consume.remark}">
									${consume.remark}
								</c:if>
								<c:if test="${empty consume.remark}">
									空
								</c:if>
							</td>
							<td class="text-center">${consume.typeValue}</td>
							<td class="text-center"><fmt:formatDate value="${consume.createTime}" pattern="yyyy-MM-dd"/></td>
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
