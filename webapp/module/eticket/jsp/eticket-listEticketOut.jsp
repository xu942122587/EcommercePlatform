<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.eticketoutRecord.listEticketOutByStore");
	com.yunt.eticketoutRecord.listEticketOutByStore = {
		refresh : function(isSelect) {
			var href_string = '${path}/eticketoutRecord/getListEticketOut'
				+ "?model.startDate_select=" + $("#startDate").val().trim()
				+ "&model.endDate_select=" + $("#endDate").val().trim()
				+ "&model.state=" + $("#state").val().trim()
				+ "&model.eticket.outType=" + $("#eticketType").val().trim();
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
	}
	$(function() {
		$('.form-control.date').datepicker({
			format: "yyyy-mm-dd",
		    todayBtn: "linked",
		    clearBtn: true,
			language: "zh-CN",
			todayHighlight: true
		});
	});
</script>
</head>
<body>
	<div class="toolbar">
		<div class="row">
			<div class="pull-right col-xs-12">
				<form class="form-inline pull-right" action="" id="search" user="form">
					<div class="form-group">
						<lable class="control-label" for="product-uuid">发放方式</lable>
						<select class="form-control" id="eticketType">
								<option class="level-0" value="" <c:if test="${empty model.eticket.outType }">selected="selected"</c:if>>请选择发放方式</option>
								<option class="level-0" value="1" <c:if test="${'1' eq model.eticket.outType }">selected="selected"</c:if>>手动</option>
								<option class="level-0" value="2" <c:if test="${'2' eq model.eticket.outType }">selected="selected"</c:if>>自动发放（交易）</option>
								<option class="level-0" value="3" <c:if test="${'3' eq model.eticket.outType }">selected="selected"</c:if>>自动发放（注册）</option>
								<%-- <option class="level-0" value="4" <c:if test="${'4' eq model.eticket.outType }">selected="selected"</c:if>>自动发放（充值）</option> --%>
								<option class="level-0" value="5" <c:if test="${'5' eq model.eticket.outType }">selected="selected"</c:if>>自动发放（生日）</option>
						</select>
						<lable class="control-label" for="product-uuid">发放日期</lable>
						<input class="form-control date" type="text" id="startDate" value="${model.startDate_select}" placeholder="开始日期">
						<lable class="control-label" for="product-uuid">到</lable>
						<input class="form-control date" type="text" id="endDate" value="${model.endDate_select}" placeholder="结束日期">
						<lable class="control-label" for="product-uuid">状态</lable>
						<select class="form-control" id="state">
							<option class="level-0" value="" <c:if test="${empty model.state }">selected="selected"</c:if>>全部</option>
							<option class="level-0" value="1" <c:if test="${'1' eq model.state }">selected="selected"</c:if>>未使用</option>
							<option class="level-0" value="2" <c:if test="${'2' eq model.state }">selected="selected"</c:if>>已使用</option>
							<option class="level-0" value="3" <c:if test="${'3' eq model.state }">selected="selected"</c:if>>已失效</option>
						</select>
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.eticketoutRecord.listEticketOutByStore.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>
	<form id="theForm" action="${path}/eticketoutRecord/getListEticketOut?model.startDate_select=${model.startDate_select }&model.endDate_select=${model.endDate_select }&model.state=${model.state }&model.eticket.outType=${model.eticket.outType}">
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>发放记录</h5>
			</div>
			<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">电子券名称</th>
						<th class="text-center">电子券编号</th>
						<th class="text-center">客户昵称</th>
						<th class="text-center">金额</th>
						<th class="text-center">发放日期</th>
						<th class="text-center">状态</th>
						<th class="text-center">发放方式</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="eticketoutRecord" varStatus="i">
						<tr>
							<td class="">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td>${eticketoutRecord.eticket.name }</td>
							<td>${eticketoutRecord.code }</td>
							<td>${eticketoutRecord.customer.employee.name }</td>
							<td>${eticketoutRecord.eticket.price }</td>
							<td><fmt:formatDate value="${eticketoutRecord.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${eticketoutRecord.stateValue }</td>
							<td>${eticketoutRecord.eticket.outTypeValue }</td>
							<td>
								<c:if test="${fn:indexOf(user.role.operationCodes,'eticket_out_view') > -1  }">
									<a class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="com.yunt.index.loadInner('${path}/eticketoutRecord/view?id=${eticketoutRecord.id}','查看发放详情');">&nbsp;&nbsp;查&nbsp;看&nbsp;&nbsp;</a>
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
						formId="theForm" pageName="com.yunt.index" loadFunction="loadOnly" />
			</div>
		</div>
	</form>
</body>
</html>
