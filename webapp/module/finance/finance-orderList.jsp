<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.order.list");
	com.yunt.order.list = {
		refresh : function(isSelect) {
			var href_string ="${path}/finance/orderList"
				+ "?model.payType=" + $("#model_payType").val().trim()
				+ "&model.code=" + $("#orderCode").val().trim()
				+ "&model.startDate=" + $("#startDate").val().trim()
				+ "&model.endDate=" + $("#endDate").val().trim();
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
	$(function() {
		$('.form-control.date').datepicker({
			format : "yyyy-mm-dd",
			todayBtn : "linked",
			clearBtn : true,
			language : "zh-CN",
			todayHighlight : true
		});
	});
	
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-2">
			</div>
			<div class="col-xs-10">
				<form class="form-inline pull-right" action="" id="search" order="form">
					<div class="form-group">
						<label for="product-uuid" class="control-label">支付方式:</label>
						<select class="form-control" name="model.payType" id="model_payType">
							<option value="" >全部</option>
							<option value="3" <c:if test="${'3' eq model.payType}">selected="selected"</c:if>>微信</option>
							<option value="4" <c:if test="${'4' eq model.payType}">selected="selected"</c:if>>支付宝</option>
						</select>
						<input type="text" id="orderCode" class="form-control" value="${model.code}" placeholder="订单号" maxlength="20">
						<input class="form-control date" type="text" id="startDate" value="${model.startDate}" placeholder="开始日期">
						<input class="form-control date" type="text" id="endDate" value="${model.endDate}" placeholder="结束日期">
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.order.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/finance/orderList?model.payType=${model.payType}&model.code=${model.code}&model.startDate=${model.startDate}&model.endDate=${model.endDate}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>(微信/支付宝)订单</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center"
					id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">单号</th>
						<th class="text-center">门店</th>
						<th class="text-center">数量</th>
						<th class="text-center">金额</th>
						<th class="text-center">支付类型</th>
						<th class="text-center">类型</th>
						<th class="text-center">订单状态</th>
						<th class="text-center">订单日期</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="order" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">${order.code }</td>
							<td class="text-center">${order.store.name }</td>
							<td class="text-center">
								${order.sumNumber }
							</td>
							<td class="text-center">
								<c:if test="${'4' eq order.type }">
									1:
									<c:if test="${'4' eq order.onePayType || '3' eq order.onePayType}">
										${order.onePayMoney }
									</c:if>
									<c:if test="${'4' ne order.onePayType && '3' ne order.onePayType}">
										略
									</c:if> 
									&nbsp;︱&nbsp;
									2: 
									<c:if test="${'4' eq order.twoPayType || '3' eq order.twoPayType}">
										${order.twoPayMoney }
									</c:if>
									<c:if test="${'4' ne order.twoPayType && '3' ne order.twoPayType}">
										略
									</c:if> 
								</c:if>
								
								<c:if test="${'4' ne order.type }">
									${order.payMoney }
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${'4' eq order.type }">
									1: 
									<c:if test="${'4' eq order.onePayType || '3' eq order.onePayType}">
										${order.onePayTypeValue}
									</c:if>
									<c:if test="${'4' ne order.onePayType && '3' ne order.onePayType}">
										其他
									</c:if>
									&nbsp;︱&nbsp;
									2: 
									<c:if test="${'4' eq order.twoPayType || '3' eq order.twoPayType}">
										${order.twoPayTypeValue}
									</c:if>
									<c:if test="${'4' ne order.twoPayType && '3' ne order.twoPayType}">
										其他
									</c:if>
								</c:if>
								<c:if test="${'4' ne order.type }">
									${order.payTypeValue }
								</c:if>
							</td>
							<td class="text-center">${order.typeValue }</td>
							<td class="text-center">
								${order.stateValue}
							</td>
							<td class="text-center">
								<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd HH:mm:ss" />
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
	<script>
	</script>
</body>
</html>
