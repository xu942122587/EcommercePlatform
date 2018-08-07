<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>采购单</title>
	<%-- <link rel="stylesheet" type="text/css" href="${path}/platform/common/css/bootstrap_user_to_print.css"> --%>
	<script src="${path }/platform/common/js/jquery-1.11.1.js"></script>
	<!-- jQuery打印插件 -->
	<script src="${path }/platform/common/js/jquery.PrintArea.js"></script>
	<style type="text/css">
		.myPrintArea{
			width: 900px;
			margin: 0 auto;
		}
		.table-striped > tbody > tr:nth-of-type(odd) {
			background-color: #f9f9f9;
		}
		.print_index{
			width: 900px;
			margin: 0 auto;
		}
		#biuuu_button{
			color: #fff;
			background-color: #337ab7;
			border-color: #2e6da4;
			display: inline-block;
			padding: 6px 12px;
			margin-bottom: 0;
			font-size: 14px;
			font-weight: normal;
			line-height: 1.42857143;
			text-align: center;
			white-space: nowrap;
			vertical-align: middle;
			-ms-touch-action: manipulation;
			touch-action: manipulation;
			cursor: pointer;
			-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
			user-select: none;
			background-image: none;
			border: 1px solid transparent;
			border-radius: 4px;
			position: fixed;
			top: 100px;
			left: 100px;
		}
		.print_remark{
			display: block;
			width: 230px;
			font-size: 14px;
			font-weight: normal;
			color: red;
			line-height: 1.42857143;
			position: fixed;
			top: 150px;
			left: 30px;
		}
	</style>
	<script>  
		$(document).ready(function(){  
			$("input#biuuu_button").click(function(){
				printLoan();
			});
			setTimeout(printLoan, 1000);
		});
		function printLoan(){
			var options = { mode : 'iframe', popClose : false, extraCss : '', retainAttr : ["id","class","style"], extraHead : '<meta charset="utf-8" />,<meta http-equiv="X-UA-Compatible" content="IE=edge"/>' };
			var print = $(".myPrintArea");
			$( print ).printArea( options );
		}
	</script>
</head>
<body>
	<input id="biuuu_button" type="button" value="打印"></input>  
	<span class="print_remark">系统将在3秒内自动调起打印，若未调起打印，请点击打印按钮~</span>
	<div class="myPrintArea">
		<style type="text/css" needPrint>
/* 			body {
				font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
				font-size: 14px;
				line-height: 1.42857143;
				color: #333;
				background-color: #fff;
			} */
			.table > thead > tr > th,
			.table > tbody > tr > th,
			.table > tfoot > tr > th,
			.table > thead > tr > td,
			.table > tbody > tr > td,
			.table > tfoot > tr > td {
				padding: 8px;
				line-height: 1.42857143;
				vertical-align: top;
			}
			.table > thead > tr > th {
				vertical-align: bottom;
			}
			.table-bordered > thead > tr > th,
			.table-bordered > thead > tr > td {
				border-bottom-width: 2px;
			}
			.table {
				width: 100%;
				max-width: 100%;
				margin-bottom: 20px;
				border-spacing: 0;
				border-collapse: collapse;
				/* page-break-after: always; /*在标签后换页*/ */
			}
			.text-center {
				text-align: center;
				font-weight: bold;
			}
			.table-bordered,
			.table-bordered > thead > tr > th, 
			.table-bordered > tbody > tr > th,
			.table-bordered > tfoot > tr > th, 
			.table-bordered > thead > tr > td, 
			.table-bordered > tbody > tr > td, 
			.table-bordered > tfoot > tr > td {
				border: 1px solid #000;
				border-collapse: collapse;
			}
			.print_index{
				font-family:  微软雅黑;
				/* page-break-after: always; /*在标签后换页*/ */
				padding: 18px;
				font-weight:bold;
				text-align: center;
			}
			.print_index_font_size{
				font-size: 20px;
				line-height: 50px;
			}
			.print_index_title{
				font-size: 24px;
			}
			.print_left{
				text-align: left;
				width: 33.3%;
				display: inline-block;
			}
			.print_center{
				text-align: center;
				width: 32%;
				display: inline-block;
			}
			.print_right{
				text-align: right;
				width: 32%;
				display: inline-block;
			}
			.print_title_font_size{
				font-size: 14px;
			}
		</style>
		
		
		<div class="print_index print_index_font_size">
		<c:if test="${'2' eq model.state}">
			采购申请单
		</c:if>
		<c:if test="${'4' eq model.state}">
			采购到货单
		</c:if>
		</div>
		
		<div>
			<div class="print_left print_title_font_size">采购单号:${model.procurementCode }</div>
			
			<div class="print_center print_title_font_size">
				<c:if test="${'2' eq model.state}">
					申请日期:<fmt:formatDate value="${model.createTime }" pattern="yyyy-MM-dd" />
				</c:if>
				<c:if test="${'4' eq model.state}">
					到货日期:<fmt:formatDate value="${model.procurementDate }" pattern="yyyy-MM-dd" />
				</c:if>
			</div>
			
			<div class="print_right print_title_font_size">采购门店:${model.store.name }</div>
		</div>
		<div>
			<div class="print_left print_title_font_size">门店负责人:${model.store.chargeName }</div>
			
			<c:if test="${'2' eq model.state}">
				<div class="print_center print_title_font_size">采购数量合计:${model.count }</div>
			</c:if>
			<c:if test="${'4' eq model.state}">
				<div class="print_center print_title_font_size">实到数量合计:${model.buyCount }</div>
			</c:if>
			
			<c:if test="${'2' eq model.state}">
				<div class="print_right print_title_font_size">采购金额合计:${model.sumMoney }</div>
			</c:if>
			<c:if test="${'4' eq model.state}">
				<div class="print_right print_title_font_size">实到金额合计:${model.buySumMoney }</div>
			</c:if>
		</div>
		<div>
			<div class="print_left print_title_font_size">备注:${model.remark }</div>
			<div class="print_center print_title_font_size">发货类型:${model.shipType }</div>
		</div>
		<table class="print_title_font_size table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
			<thead class="text-center">
				<tr>
					<th class="print_title_font_size" width="10%">商品编号</th>
					<th class="print_title_font_size" width="25%">商品名称</th>
					<th class="print_title_font_size" width="25%">商品属性</th>
					<th class="print_title_font_size" width="10%">
						<c:if test="${'2' eq model.state}">
							采购数量
						</c:if>
						<c:if test="${'4' eq model.state}">
							实到数量
						</c:if>
					</th>
					<th class="print_title_font_size" width="10%">参考售价</th>
					<th class="print_title_font_size" width="5%">折扣</th>
					<th class="print_title_font_size" width="5%">单价</th>
					<th class="print_title_font_size" width="10%">金额</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${model.procurementGoodsList}" var="procurementGoods" varStatus="i">
					<tr>
						<td class="print_title_font_size">
						<c:if test="${empty procurementGoods.goods.goodsCode }">
							${procurementGoods.goods.goods.goodsCode}
						</c:if>
						<c:if test="${not empty procurementGoods.goods.goodsCode }">
							${procurementGoods.goods.goodsCode }
						</c:if>
						</td>
						<td class="print_title_font_size">
							<c:if test="${empty procurementGoods.goods.name }">
								${procurementGoods.goods.goods.name }
							</c:if>
							<c:if test="${not empty procurementGoods.goods.name }">
								${procurementGoods.goods.name }
							</c:if>
						</td>
						<td class="print_title_font_size">
							<c:if test="${empty procurementGoods.goods.other_attr_value }">
								空
							</c:if>
							<c:if test="${not empty procurementGoods.goods.other_attr_value }">
								${procurementGoods.goods.other_attr_value }
							</c:if>
						</td>
						<c:if test="${'2' eq model.state}">
							<td class="print_title_font_size">${procurementGoods.count }</td>
						</c:if>
						<c:if test="${'4' eq model.state}">
							<td class="print_title_font_size">${procurementGoods.buyCount }</td>
						</c:if>
						
						<td class="print_title_font_size">${procurementGoods.goodsPrice }</td>
						<td class="print_title_font_size">
							<c:if test="${empty procurementGoods.buyAgio }">
								无
							</c:if>
							<c:if test="${not empty procurementGoods.buyAgio }">
								${procurementGoods.buyAgio }
							</c:if>
						</td>
						<td class="print_title_font_size">${procurementGoods.buyPrice }</td>
						<td class="print_title_font_size">${procurementGoods.buySumMoney }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div>
			<div class="print_left">审核人:${model.user.name }</div>
			<div class="print_center">签字:</div>
		</div>
	</div>
</body>
</html>