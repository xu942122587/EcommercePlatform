<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
 <title>数量统计</title>
</head>
<style>
	.nav-tabs li {
		 border-radius:6px;
		 padding-left: 15px;
		 margin-top: 4px;
	 }
	 .nav-tabs li a {
		 border-radius:6px;
		 padding: 6px 15px;
		 background: #ddd;
	 }
	 .nav-tabs li a:hover,.nav-tabs li a:focus {
		 border-radius:6px;
		 background: #337ab7!important;
		 color:#fff!important;
	 }
	 .nav-tabs .active a{
		 background: #337ab7!important;
		 color:#fff!important;
	 }
	 .col-lg-3{
		 padding:10px 15px;
	 }
	 .card{
		 padding:10px 15px;
		 color: #fff;
		 border-radius:6px;
		 height: 236px
	 }
	 .card-title{
		 font-size: 1.4em;
		 margin-top: 4%;
		 font-weight: bold;
	 }
	 .card_total{
		 overflow: hidden;
		 margin-top: 16px;
		 font-size: 1.2em;
		 padding: 0 8%;
	 }
	 .card_total .left{
		 float: left;
	 }
	 .card_total .right{
		 float: right
	 }
	 
	 .new_customer_title{
		 padding-top:20px;
		 height: 90px;
		 color: #4dbd74;
		 text-align: center;
		 font-size: 20px;
		 background: #fff;
		 border: 2px solid #4dbd74;
		 font-weight: bold;
	 }
	 .new_customer_title .num{
		 font-size:14px;
		 display: block;
	 }
	 .customer_ul{
		 background: #4dbd74;
		 overflow: hidden;
		 padding: 0;
	 }
	 .customer_ul li{
		 list-style: none;
		 width:50%;
		 text-align:center;
		 float: left;
		 padding: 30px 0;
		 font-size: 20px;
		 color:#fff;
	 }
	 .customer_ul li span{
		 font-size: 14px;
		 display: block;
	 }
	 .table_list_show{
		 border: 1px solid #ddd; 
	 } 
	 .table_list_show thead {
		 background:#4ad2cc;
		 color: #fff
	 } 
</style>
<script type="text/javascript">
	Namespace.register("com.yunt.statistics.list");
	com.yunt.statistics.list = {
		refresh : function(isSelect) {
			var href_string ='${path}/statistics/amountList?storeId='+ $("#storeId").val().trim()
				+'&startDate=' + $("#startDate").val().trim()
				+'&endDate=' + $("#endDate").val().trim().trim();
			if($("#endDate").val().trim() == '' ||$("#startDate").val().trim() == ''){
				toastr.warning('开始或结束日期不能为空！');
				return;
			}
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
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
			,day : function(isSelect) {
				var href_string ='${path}/statistics/amountList?selectDay=true'+'&storeId=' + $("#storeId").val().trim();
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
			,month : function(isSelect) {
				var href_string ='${path}/statistics/amountList?selectMonth=true'+'&storeId=' + $("#storeId").val().trim();
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
			,year : function(isSelect) {
				var href_string ='${path}/statistics/amountList?selectYear=true'+'&storeId=' + $("#storeId").val().trim();
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
	}
</script>
<body>
	<ul id="myTab" class="nav nav-tabs" style="margin-top: 20px;padding-bottom: 12px">
		<li><a data-toggle="tab" style="cursor: pointer;" onclick="com.yunt.statistics.list.day(true)">今日合计</a></li>
		<li><a data-toggle="tab" style="cursor: pointer;" onclick="com.yunt.statistics.list.month(true)">本月合计</a></li>
		<li><a data-toggle="tab" style="cursor: pointer;" onclick="com.yunt.statistics.list.year(true)">本年合计</a></li>
		<form class="form-inline pull-right" action="" id="search" style="margin-top: 4px">
			<label for="product-uuid" class="control-label">门店：</label>
			<select class="form-control" name="storeId" id="storeId">
				<option value="" selected="selected">全部</option>
				<c:forEach items="${storeList}" var="store">
					<option value="${store.id}" <c:if test="${selectStore.id eq store.id }">selected="selected"</c:if>>${store.name}</option>
				</c:forEach>
			</select>
			<input type="text" name="startDate" class="form-control date_input_no_class" placeholder="开始日期" id="startDate" value="${startDate}" />
			<input type="text" name="endDate" class="form-control date_input_no_class" placeholder="结束日期" id="endDate" value="${endDate}" />
			<button type="button" class="btn btn-default"
			onclick="com.yunt.statistics.list.refresh(true)">查询</button>
		</form>
	</ul>
		<c:if test="${not empty selectStore }">
			<div class="social-box facebook col-sm-12 col-lg-6" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >销售数量合计
					<span class="num">${statisticsMap.saleSumNumberSum}</span>
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>线上销售数量总计</span>
						<strong>${statisticsMap.saleSumNumberInLine}</strong>
					</li>
					<li>
						<span>线下销售数量总计</span>
						<strong>${statisticsMap.saleSumNumber}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-6" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >退货数量总计
				</div>
				<ul class="customer_ul">
					<li style="width: 100%">
						<span>退货数量合计</span>
						<strong>${statisticsMap.returnSumNumber}</strong>
					</li>
				</ul>
			</div>
		</c:if>
		<c:if test="${empty selectStore }">
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >销售数量合计
					<span class="num">${statisticsMap.saleSumNumberSum}</span>
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>线上销售数量合计</span>
						<strong>${statisticsMap.saleSumNumberInLine}</strong>
					</li>
					<li>
						<span>线下销售数量合计</span>
						<strong>${statisticsMap.saleSumNumber}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >退货数量总计
				</div>
				<ul class="customer_ul">
					<li style="width: 100%">
						<span>退货数量合计</span>
						<strong>${statisticsMap.returnSumNumber}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >会员用户合计
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>用户总数合计</span>
						<strong>${statisticsMap.customerCount}</strong>
					</li>
					<li >
						<span>新注册用户合计</span>
						<strong>${statisticsMap.timeCustomerCount}</strong>
					</li>
				</ul>
			</div>
		</c:if>
		
			<br />
		<c:if test="${empty selectStore }">
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">仓库存量及总价值</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center col-xs-1">序号</th>
							<th class="text-center col-xs-2">仓库名称</th>
							<th class="text-center col-xs-4">存量</th>
							<th class="text-center col-xs-2">价值</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.storageSumMoneyAndCount}" var="storageId" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${storageId.value.name }
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${storageId.value.count}"/>
								</td>
								<td class="text-center">
									<fmt:formatNumber value="${storageId.value.sumMoney }" pattern="###.##"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">商品销量排名</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center ">序号</th>
							<th class="text-center ">商品编号</th>
							<th class="text-center ">商品名称</th>
							<th class="text-center ">销售量</th>
							<th class="text-center ">退货量</th>
							<th class="text-center ">实际销售量</th>
							<th class="text-center ">所属门店</th>
							<th class="text-center ">门店编号</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.goodsGroupOrderBySumCount}" var="goodsCode" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${goodsCode.value.goodsCode }
								</td>
								<td class="text-center">
									${goodsCode.value.goodsName}
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.saleCount }"/>
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.returnCount }"/>
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.sumCount }"/>
								</td>
								<td class="text-center">
									${goodsCode.value.storeName }
								</td>
								<td class="text-center">
									${goodsCode.value.storeCode }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">预约商品销量排名</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center ">序号</th>
							<th class="text-center ">商品编号</th>
							<th class="text-center ">商品名称</th>
							<th class="text-center ">销售量</th>
							<th class="text-center ">退货量</th>
							<th class="text-center ">实际销售量</th>
							<th class="text-center ">所属门店</th>
							<th class="text-center ">门店编号</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.typeFourgoodsGroupOrderBySumCount}" var="goodsCode" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${goodsCode.value.goodsCode }
								</td>
								<td class="text-center">
									${goodsCode.value.goodsName}
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.saleCount }"/>
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.returnCount }"/>
								</td>
								<td class="text-center">
									<fmt:formatNumber type="Number" value="${goodsCode.value.sumCount }"/>
								</td>
								<td class="text-center">
									${goodsCode.value.storeName }
								</td>
								<td class="text-center">
									${goodsCode.value.storeCode }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		
	<script type="text/javascript">
	$(function(){
		$('.date_input_no_class').datepicker({
			format: "yyyy-mm-dd",
			todayBtn: "linked",
			clearBtn: true,
			language: "zh-CN",
			todayHighlight: true,
		});
	});
	</script>
</body>
</html>