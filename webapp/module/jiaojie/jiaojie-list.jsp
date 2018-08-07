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
			format : "yyyy-mm-dd",
			todayBtn : "linked",
			clearBtn : true,
			language : "zh-CN",
			todayHighlight : true
		});
	});
	Namespace.register("com.yunt.jiaojie.list");
	com.yunt.jiaojie.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/CashierUserLoginAndLogout/list?model.cashierUserCode=' + $("#cashierUserCode").val().trim()
			+ "&model.startDate=" + $("#startDate").val().trim()
			+ "&model.endDate=" + $("#endDate").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			} else{
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
		doFinish : function(id){
			$.ajax({
				url : "${path}/CashierUserLoginAndLogout/doLogoutStart?id="+id,
				type : "POST",
				dataType : "json",
				success : function(data) {
					 if (data.success) {
						toastr.success("结算成功!");
						com.yunt.jiaojie.list.refresh();
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					toastr.error(error);
				}
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
				<form class="form-inline pull-right" action="" id="search" jiaojie="form">
					<div class="form-group">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
						<input type="text" value="${model.cashierUserCode }" id="cashierUserCode" name="cashierUserCode" class="form-control" placeholder="收银工号……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.jiaojie.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/CashierUserLoginAndLogout/list?model.cashierUserCode=${model.cashierUserCode }&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>门店</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">日期</th>
						<th class="text-center">收银员工号</th>
						<th class="text-center">收银员姓名</th>
						<th class="text-center">登入时间</th>
						<th class="text-center">登出时间</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="jiaojie" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center"><fmt:formatDate value="${jiaojie.createTime }" pattern="yyyy-MM-dd"/></td>
							<td class="text-center">${jiaojie.cashierUser.username }</td>
							<td class="text-center">${jiaojie.cashierUser.name }</td>
							<td class="text-center"><fmt:formatDate value="${jiaojie.loginTime }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td class="text-center"><fmt:formatDate value="${jiaojie.logoutTime }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'jiaojie_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/CashierUserLoginAndLogout/view?id=${jiaojie.id }','查看门店信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'jiaojie_finish') > -1 && '2' eq jiaojie.state}">
									<input type="button" value="结算" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.jiaojie.list.doFinish('${jiaojie.id }')" />
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
