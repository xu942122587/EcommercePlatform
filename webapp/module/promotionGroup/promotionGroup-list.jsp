<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
<script src="${path}/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	Namespace.register("com.yunt.promotionGroup.list");
	com.yunt.promotionGroup.list = {
		refresh : function(isSelect) {
			var href_string = '${path}/promotionGroup/list?model.scope=' + $("#scope").val().trim()
					+"&model.payType=" + $("#payType").val().trim()
					+"&model.isOline=" + $("#isOline").val().trim();
			if(!isSelect){
				href_string+= '&page.pageNo=${pageObj.pageNo}&page.pageSize=${pageObj.pageSize}';
				href_string+= '&page.totalPage=${pageObj.totalPage}&page.totalRecord=${pageObj.totalRecord}';
			}
			com.yunt.index.load(href_string,menuIndexTemp, submenuIndexTemp);
		},
		doDelete : function(id){
			$('#deleteModal').modal('show');
			$("#deleteButton").unbind("click").click(function(){
				 $.ajax({
					url : "${path}/promotionGroup/doDelete?id="+id,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#deleteModal').modal('hide');
						 if (data.success) {
							toastr.success('删除活动组成功！');
							com.yunt.promotionGroup.list.refresh();
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
	$(function(){
		$("#scope").val("${model.scope}");
		$("#isOline").val("${model.isOline}");
		$("#payType").val("${model.payType}");
	});
</script>
</head>
<body>
	<!--the toolbar begin -->
	<div class="toolbar">
		<div class="row">
			<div class="col-xs-6">
				<c:if test="${fn:indexOf(user.role.operationCodes,'promotionGroup_input') > -1 }">
					<div class="quick-add-btn">
						<a href="javascript:void(0)"type="button" class="btn btn-danger" onclick="com.yunt.index.loadInner('${path}/promotionGroup/input','添加活动组')">
							<span class="glyphicon glyphicon-new-window"></span> 添加活动组
						</a>
					</div>
				</c:if>
			</div>
			<div class="col-xs-6">
				<form class="form-inline pull-right" action="" id="search" promotionGroup="form">
					<label for="product-uuid" class="control-label">针对范围:</label>
					<div class="form-group">
						<select class="form-control" name="scope" id="scope">
							<option value="" <c:if test="${empty model.scope || '' eq model.scope}">selected="selected"</c:if>>全部</option>
							<option value="1" <c:if test="${'1' eq model.scope}">selected="selected"</c:if>>产品</option>
							<option value="2" <c:if test="${'2' eq model.scope}">selected="selected"</c:if>>门店</option>
							<option value="3" <c:if test="${'3' eq model.scope}">selected="selected"</c:if>>天和全场</option>
							<option value="4" <c:if test="${'4' eq model.scope}">selected="selected"</c:if>>叠加活动</option>
						</select>
					</div>
					<label for="product-uuid" class="control-label">支付方式:</label>
					<div class="form-group">
						<select id="payType" name="payType" class="form-control">
							<option value="" <c:if test="${empty model.payType || '' eq model.payType }">selected="selected"</c:if>>全部</option>
							<option value="6" <c:if test="${not empty model.payType && '6' eq model.payType }">selected="selected"</c:if>>不限制</option>
							<option value="1" <c:if test="${not empty model.payType && '1' eq model.payType }">selected="selected"</c:if>>现金</option>
							<option value="2" <c:if test="${not empty model.payType && '2' eq model.payType }">selected="selected"</c:if>>刷卡</option>
							<option value="3" <c:if test="${not empty model.payType && '3' eq model.payType }">selected="selected"</c:if>>微信</option>
							<option value="4" <c:if test="${not empty model.payType && '4' eq model.payType }">selected="selected"</c:if>>支付宝</option>
							<option value="5" <c:if test="${not empty model.payType && '5' eq model.payType }">selected="selected"</c:if>>天和会员余额</option>
						</select>
					</div>
					<label for="product-uuid" class="control-label">是否线上:</label>
					<div class="form-group">
						<select id="isOline" name="isOline" class="form-control" >
							<option value="" selected="selected">全部</option>
							<option value="1">线上</option>
							<option value="2">线下</option>
							<option value="3">不限制</option>
						</select>
					</div>
					<button type="button" class="btn btn-default" onclick="com.yunt.promotionGroup.list.refresh(true)">筛选</button>
				</form>
			</div>
		</div>

	</div>
	<form id="theForm" action="${path}/promotionGroup/list?model.scope=${model.scope}&model.payType=${model.payType}&model.isOline=${model.isOline}">
		<!--all device detail begin -->
		<div class="panel panel-default" id="all-device-detail">
			<div class="panel-heading">
				<h5>活动组</h5>
			</div>

			<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
				<thead class="text-center">
					<tr>
						<th class="text-center">序号</th>
						<th class="text-center">活动开始时间</th>
						<th class="text-center">活动结束时间</th>
						<th class="text-center">针对范围</th>
						<th class="text-center">是否线上</th>
						<th class="text-center">支付方式</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageObj.results}" var="promotionGroup" varStatus="i">
						<tr>
							<td class="text-center">${(i.index+1)+((pageObj.pageNo-1) * pageObj.pageSize)}</td>
							<td class="text-center">
								<fmt:formatDate value="${promotionGroup.proStartDate }" pattern="yyyy-MM-dd HH:mm"/>
							</td>
							<td class="text-center">
								<fmt:formatDate value="${promotionGroup.proEndDate }" pattern="yyyy-MM-dd HH:mm"/>
							</td>
							<td class="text-center">${promotionGroup.scopeValue }</td>
							<td class="text-center">${promotionGroup.isOlineValue }</td>
							<td class="text-center">${promotionGroup.payTypeValue }</td>
							<td class="text-center">
								<c:if test="${fn:indexOf(user.role.operationCodes,'promotionGroup_input') > -1 }">
									<input type="button" value="修改" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/promotionGroup/input?id=${promotionGroup.id }','修改活动组信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'promotionGroup_view') > -1 }">
									<input type="button" value="查看" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#edit-device"
											onclick="com.yunt.index.loadInner('${path}/promotionGroup/view?id=${promotionGroup.id }','查看活动组信息')" />
									&nbsp;&nbsp; 
								</c:if>
								<c:if test="${fn:indexOf(user.role.operationCodes,'promotionGroup_delete') > -1 }">
									<a class="btn btn-default btn-xs" href="javascript:void(0);" onclick="com.yunt.promotionGroup.list.doDelete('${promotionGroup.id }')">删除</a>
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
