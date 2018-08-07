<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.eticket.list");
	com.yunt.eticket.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/eticket/list?model.name=' + $("#model_name").val();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete :function(id_value){
			$.ajax({
				url : "${path}/eticket/doDelete?id=" + id_value,
				data : null,
				type : "POST",
				success : function(data) {
					if (data.success) {
						toastr.success('刪除电子券成功！');
						com.yunt.eticket.list.refresh();
					} else {
						toastr.error('刪除电子券失败！');
					}
				},
				error : function(xhr, type, exception) {
					alert("请检查网络设置");
				}
			});
		}
	}
</script>
</head>
<body>
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<div class="quick-add-btn">
					<c:if test="${fn:indexOf(user.role.operationCodes,'eticket_add') > -1  }">
						<a href="javascript:void(0)" onclick="com.yunt.index.loadInner('${path}/eticket/goAddEticket?inputKind=save','添加电子券')" type="button" class="btn btn-danger">
							<span class="glyphicon glyphicon-new-window"></span> 添加电子券
						</a>
					</c:if>
				</div>
			</div>
			<div class="pull-right col-xs-6">
				<form class="form-inline pull-right" action="" id="search" user="form">
					<div class="form-group">
						<input type="text" id="model_name" name="model.name" value="" class="form-control" placeholder="电子券名称……" maxlength="20">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.eticket.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>
	</div>
	<form id="theForm" action="${path}/eticket/list?model.name=${model.name }">
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>电子券</h5>
			</div>
			<table
				class="table table-striped table-hover table-bordered text-center"
				id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">名称</th>
						<th class="text-center">创建时间</th>
						<th class="text-center">有效期</th>
						<th class="text-center">价值</th>
						<th class="text-center">发放门店</th>
						<th class="text-center">发放阀值</th>
						<th class="text-center">发放方式</th>
						<th class="text-center">发放截止时间</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="eticket" varStatus="i">
						<tr>
							<td class="">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td>${eticket.name }</td>
							<td><fmt:formatDate value="${eticket.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${eticket.dateLimit }</td>
							<td>${eticket.price }</td>
							<td>
								<c:if test="${not empty eticket.outStore.name }">
									${eticket.outStore.name }
								</c:if>
								<c:if test="${empty eticket.outStore.name }">
									——
								</c:if>
							</td>
							<td>
								<c:if test="${'2' eq eticket.outType }">
									${eticket.outLimit }
								</c:if>
								<c:if test="${'2' ne eticket.outType }">
									——
								</c:if>
							</td>
							<td>${eticket.outTypeValue }</td>
							<td><fmt:formatDate value="${eticket.stopSendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${fn:indexOf(user.role.operationCodes,'eticket_view') > -1  }">
									<a class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="com.yunt.index.loadInner('${path}/eticket/view?id=${eticket.id}','查看电子券');">&nbsp;&nbsp;查&nbsp;看&nbsp;&nbsp;</a>
									&nbsp;&nbsp;
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'eticket_add') > -1  }">
									<a class="btn btn-primary btn-xs" href="javascript:void(0)" onclick="com.yunt.index.loadInner('${path}/eticket/goAddEticket?id=${eticket.id}','修改电子券');">&nbsp;&nbsp;修&nbsp;改&nbsp;&nbsp;</a>
									&nbsp;&nbsp;
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'eticket_delete') > -1  }">
									&nbsp;&nbsp;
									<a class="btn btn-default btn-xs" href="javascript:void(0)" onclick="com.yunt.eticket.list.doDelete('${eticket.id}')">刪除</a>
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
