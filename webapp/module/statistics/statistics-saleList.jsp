<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
 <title>金额统计</title>
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
			var href_string ='${path}/statistics/saleList?storeId='+ $("#storeId").val().trim()
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
				var href_string ='${path}/statistics/saleList?selectDay=true'+'&storeId=' + $("#storeId").val().trim();
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
			,month : function(isSelect) {
				var href_string ='${path}/statistics/saleList?selectMonth=true'+'&storeId=' + $("#storeId").val().trim();
				com.yunt.index.load(href_string,menuIndexTemp,submenuIndexTemp);
		}
			,year : function(isSelect) {
				var href_string ='${path}/statistics/saleList?selectYear=true'+'&storeId=' + $("#storeId").val().trim();
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
				<div class="chart-wrapper new_customer_title" >销售合计
					<span class="num">${statisticsMap.saleSumMoney}</span>
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>线上销售额合计</span>
						<strong>${statisticsMap.saleSumMoneyInLine}</strong>
					</li>
					<li>
						<span>线下销售额合计</span>
						<strong>${statisticsMap.saleSumMoneyDown}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-6" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >预约支付合计
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>定金总计</span>
						<strong>${statisticsMap.dingjin}</strong>
					</li>
					<li >
						<span>尾款总计</span>
						<strong>${statisticsMap.weikuan}</strong>
					</li>
				</ul>
			</div>
		</c:if>
		<c:if test="${empty selectStore }">
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >销售合计
					<span class="num" style="font-size: 21px;color: #bd8741;">${statisticsMap.saleSumMoney}</span>
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>线上销售额合计</span>
						<strong>${statisticsMap.saleSumMoneyInLine}</strong>
					</li>
					<li>
						<span>线下销售额合计</span>
						<strong>${statisticsMap.saleSumMoneyDown}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >预约支付合计
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>定金总计</span>
						<strong>${statisticsMap.dingjin}</strong>
					</li>
					<li >
						<span>尾款总计</span>
						<strong>${statisticsMap.weikuan}</strong>
					</li>
				</ul>
			</div>
			
			<div class="social-box facebook col-sm-12 col-lg-4" >
				<i class="fa fa-facebook"></i>
				<div class="chart-wrapper new_customer_title" >充值金额合计
				</div>
				<ul class="customer_ul">
					<li style="border-right: 1px solid #fff;">
						<span>充值金额合计</span>
						<strong>${statisticsMap.rechargeMoney}</strong>
					</li>
					<li >
						<span>充值返现合计</span>
						<strong>${statisticsMap.rechargeBackCash}</strong>
					</li>
				</ul>
			</div>
		</c:if>
		
		<div class="row" style="padding: 0 15px">
			<div class="col-sm-6 col-lg-4">
				<div class="card card-inverse card-primary" style="background: #41a5bd;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							现金支付合计
						</div>
						<div class="card_total">
							<span class="left">线下-现金支付合计</span>
							<span class="right">${statisticsMap.moneyPayOne}</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-6 col-lg-4" >
				<div class="card card-inverse card-info" style="background: #41a5bd;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							银行卡支付合计
						</div>
						<div class="card_total">
							<span class="left">线下-银行卡支付合计</span>
							<span class="right">${statisticsMap.cardPayOne}</span>
						</div>
					</div>
				</div>
			</div>
			<!--/.col-->

			<div class="col-sm-6 col-lg-4">
				<div class="card card-inverse card-warning" style="background: #41a5bd;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							微信支付合计
						</div>
						<div class="card_total">
							<span class="left">线下-微信支付合计</span>
							<span class="right">${statisticsMap.weChatPayOne}</span>
						</div>
						<div class="card_total">
							<span class="left">线上-微信支付合计</span>
							<span class="right">${statisticsMap.weChatPayOneInLine}</span>
						</div>
					</div>
				</div>
			</div>
			<br/>
			<HR style="border:1 dashed #987cb9" width="80%" color=#987cb9 SIZE=1>
			<div class="col-sm-6 col-lg-4">
				<div class="card card-inverse card-primary" style="background: #41a5bd;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							支付宝支付合计
						</div>
						<div class="card_total">
							<span class="left">线下-支付宝支付合计</span>
							<span class="right">${statisticsMap.aliPayOne}</span>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-6 col-lg-4" >
				<div class="card card-inverse card-info" style="background: #41a5bd;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							余额支付合计
						</div>
						<div class="card_total">
							<span class="left">线下-余额支付合计</span>
							<span class="right">${statisticsMap.tianhePayOne}</span>
						</div>
						<div class="card_total">
							<span class="left">线上-余额支付合计</span>
							<span class="right">${statisticsMap.tianhePayOneInLine}</span>
						</div>
					</div>
				</div>
			</div>
			<!--/.col-->

			<div class="col-sm-6 col-lg-4">
				<div class="card card-inverse card-warning" style="background: #f05b47;">
					<div class="card-block pb-0">
						<div class="text-center card-title">
							退款合计
						</div>
						<div class="card_total">
							<span class="left">退款合计</span>
							<span class="right">${statisticsMap.returnMoney}</span>
						</div>
					</div>
				</div>
			</div>

			<!--/.col-->
		</div>
			<br />
		<c:if test="${empty selectStore }">
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">门店销售额</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center col-xs-1">序号</th>
							<th class="text-center col-xs-2">门店编号</th>
							<th class="text-center col-xs-4">门店名称</th>
							<th class="text-center col-xs-2">销售额</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.storeSumMoneyOne}" var="storeCode" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${storeCode.value.storeCode }
								</td>
								<td class="text-center">
									${storeCode.value.storeName}
								</td>
								<td class="text-center">
									${storeCode.value.oneSumMoney }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">门店采购统计</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center col-xs-1">序号</th>
							<th class="text-center col-xs-2">门店编号</th>
							<th class="text-center col-xs-4">门店名称</th>
							<th class="text-center col-xs-2">数量</th>
							<th class="text-center col-xs-2">总价</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.procurementOneType}" var="storeId" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${storeId.value.storeCode }
								</td>
								<td class="text-center">
									${storeId.value.name}
								</td>
								<td class="text-center">
									${storeId.value.buyCount }
								</td>
								<td class="text-center">
									${storeId.value.buySumMoney }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div style="padding: 15px">
				<p style="font-weight: bold;font-size: 22px">门店采购退货统计</p>
				<table class="table table-hover table-outline mb-0 hidden-sm-down table_list_show">
					<thead class="thead-default">
						<tr>
							<th class="text-center col-xs-1">序号</th>
							<th class="text-center col-xs-2">门店编号</th>
							<th class="text-center col-xs-4">门店名称</th>
							<th class="text-center col-xs-2">数量</th>
							<th class="text-center col-xs-2">总价</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${statisticsMap.procurementTwoType}" var="storeId" varStatus="i">
							<tr>
								<td class="text-center">
									${i.index+1}
								</td>
								<td class="text-center">
									${storeId.value.storeCode }
								</td>
								<td class="text-center">
									${storeId.value.name}
								</td>
								<td class="text-center">
									${storeId.value.buyCount }
								</td>
								<td class="text-center">
									${storeId.value.buySumMoney }
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