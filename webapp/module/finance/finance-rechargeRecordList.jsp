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
	Namespace.register("com.yunt.rechargeRecord.list");
	com.yunt.rechargeRecord.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/rechargeRecord/list?model.customer.phone=' + $("#phone").val().trim()
			+"&model.id=" + $("#rechargeRecord_id").val().trim()
			+"&model.startDate=" + $("#rechargeRecord_startDate_select").val().trim()
			+"&model.endDate=" + $("#rechargeRecord_endDate_select").val().trim().trim();
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
			<div class="col-xs-1">
				<c:if test="${fn:indexOf(user.role.operationCodes,'rechargeRecord_input') > -1 }">
					<div class="quick-add-btn">
					</div>
				</c:if>
			</div>
			<div class="col-xs-11">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
						<input type="text" value="${model.id }" id="rechargeRecord_id" name="model.id" class="form-control" placeholder="订单编号" maxlength="20">
						<input type="text" value="${model.customer.phone }" id="phone" name="model.phone" class="form-control" placeholder="用户电话" maxlength="20">
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="开始日期" id="rechargeRecord_startDate_select" value="${model.startDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="结束日期" id="rechargeRecord_endDate_select" value="${model.endDate }" />
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.rechargeRecord.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/rechargeRecord/list?model.customer.phone=${model.customer.phone }&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>(微信/支付宝)充值记录</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">订单号</th>
						<th class="text-center">用户名</th>
						<th class="text-center">手机号</th>
						<th class="text-center">充值金额</th>
						<th class="text-center">返现金额</th>
						<th class="text-center">支付方式</th>
						<th class="text-center">支付时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="rechargeRecord" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${rechargeRecord.id }</td>
							<td class="text-center">${rechargeRecord.customer.name }</td>
							<td class="text-center">${rechargeRecord.customer.phone }</td>
							<td class="text-center">${rechargeRecord.money }</td>
							<td class="text-center">${rechargeRecord.backCash }</td>
							<td class="text-center">${rechargeRecord.payTypeValue }</td>
							<td class="text-center"><fmt:formatDate value="${rechargeRecord.payTime}" pattern="yyyy-MM-dd"/></td>
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
