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
	Namespace.register("com.yunt.customer.list");
	com.yunt.customer.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/customer/list?model.phone=' + $("#phone").val().trim()
				+"&model.startDate=" + $("#customer_startDate_select").val().trim()
				+"&model.endDate=" + $("#customer_endDate_select").val().trim().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}else{
				if($("#customer_endDate_select").val().trim() != ''){
					if(compareCurrentDate($("#customer_endDate_select").val())){
						toastr.warning('结束日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#customer_startDate_select").val().trim() != ''){
					if(compareCurrentDate($("#customer_startDate_select").val())){
						toastr.warning('开始日期应当小于或等于当前日期！');
						return;
					}
				}
				if($("#customer_startDate_select").val().trim() != '' && $("#customer_endDate_select").val().trim() != ''){
					if(!compareDate($("#customer_endDate_select").val(),$("#customer_startDate_select").val())){
						toastr.warning('结束日期应当大于或等于开始日期！');
						return;
					}
				}
			}
			com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		},
		doIsBlank : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/customer/doIsBlank?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('拉黑成功！');
							com.yunt.customer.list.refresh();
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
				<c:if test="${fn:indexOf(user.role.operationCodes,'customer_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger"
								onclick="com.yunt.index.loadInner('${path}/customer/input','添加通告')">
							<span class="glyphicon glyphicon-new-window"></span> 添加通告
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" >
					<div class="form-group">
						<input type="text" value="${model.phone }" id="phone" name="phone" class="form-control" placeholder="手机号码" maxlength="20">
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="生日开始日期" id="customer_startDate_select" value="${model.startDate }" />
						<input type="text" name="bday" class="form-control date_input_no_class" placeholder="生日结束日期" id="customer_endDate_select" value="${model.endDate }" />
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.customer.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/customer/list?model.phone=${model.phone }&model.startDate=${model.startDate }&model.endDate=${model.endDate }">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>会员列表</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">姓名</th>
						<th class="text-center">生日</th>
						<th class="text-center">手机号码</th>
						<th class="text-center">申请日期</th>
						<th class="text-center">线上购买量</th>
						<th class="text-center">线上消费额</th>
						<th class="text-center">线下购买量</th>
						<th class="text-center">线下销售额</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="customer" varStatus="i">
						<!-- 系统管理员 -->
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${customer.name }</td>
							<td class="text-center"><fmt:formatDate value="${customer.birthday }" pattern="yyyy-MM-dd"/></td>
							<td class="text-center">${customer.phone }</td>
							<td class="text-center"><fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd"/></td>
							<td class="text-center">
								<c:if test="${empty customer.upSumNumber }">
									无
								</c:if>
								<c:if test="${not empty customer.upSumNumber }">
									${customer.upSumNumber }
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${empty customer.upPayMoney }">
									无
								</c:if>
								<c:if test="${not empty customer.upPayMoney }">
									<fmt:formatNumber value="${customer.upPayMoney }" pattern="#,###.##"/>
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${empty customer.downSumNumber }">
									无
								</c:if>
								<c:if test="${not empty customer.downSumNumber }">
									${customer.downSumNumber }
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${empty customer.downPayMoney }">
									无
								</c:if>
								<c:if test="${not empty customer.downPayMoney }">
									<fmt:formatNumber value="${customer.downPayMoney }" pattern="#,###.##"/>
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'customer_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/customer/view?customerId=${customer.id }','查看会员信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'customer_isBlank') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.customer.list.doIsBlank('${customer.id }')">拉黑</a>
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
