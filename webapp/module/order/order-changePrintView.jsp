<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>换货单</title>
	<%-- <link rel="stylesheet" type="text/css" href="${path}/platform/common/css/bootstrap_user_to_print.css"> --%>
	<script src="${path }/platform/common/js/jquery-1.11.1.js"></script>
	<!-- jQuery打印插件 -->
	<script src="${path }/platform/common/js/jquery.PrintArea.js"></script>
	<script src="${path }/platform/common/js/NumberUtil.js"></script>
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
		$(function(){
			var old_sumMoney = 0;
			var old_sumPayMoney = 0;
			var old_sumSubMoney = 0;
			<c:forEach items="${orderGoodsList }" var="orderGoods">
				<c:if test="${'2' eq orderGoods.type}">
					old_sumMoney = accAdd(parseFloat(old_sumMoney),accMul(parseFloat("${orderGoods.price}"),parseFloat("${orderGoods.count}")));
					old_sumPayMoney = accAdd(parseFloat(old_sumPayMoney),accSub(accMul(parseFloat("${orderGoods.price}"),parseFloat("${orderGoods.count}")),parseFloat("${orderGoods.subMoney}")));
					old_sumSubMoney = accAdd(parseFloat(old_sumSubMoney), parseFloat("${orderGoods.subMoney}"));
				</c:if>
			</c:forEach>
			$("#old_sumMoney").html(old_sumMoney);
			$("#old_sumPayMoney").html(old_sumPayMoney);
			$("#old_sumSubMoney").html(old_sumSubMoney);

			var new_sumMoney = 0;
			var new_sumPayMoney = 0;
			var new_sumSubMoney = 0;
			<c:forEach items="${orderGoodsList }" var="orderGoods">
				<c:if test="${'1' eq orderGoods.type}">
					new_sumMoney = accAdd(parseFloat(new_sumMoney),accMul(parseFloat("${orderGoods.price}"),parseFloat("${orderGoods.count}")));
					new_sumPayMoney = accAdd(parseFloat(new_sumPayMoney),accSub(accMul(parseFloat("${orderGoods.price}"),parseFloat("${orderGoods.count}")),parseFloat("${orderGoods.subMoney}")));
					new_sumSubMoney = accAdd(parseFloat(new_sumSubMoney), parseFloat("${orderGoods.subMoney}"));
				</c:if>
			</c:forEach>
			$("#new_sumMoney").html(new_sumMoney);
			$("#new_sumPayMoney").html(new_sumPayMoney);
			$("#new_sumSubMoney").html(new_sumSubMoney);
		})
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
				border:none!important;
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
				font-family:"SimHei", 黑体;
				line-height: 40px;
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
				width: 33.3%;
				display: inline-block;
			}
			.print_title_font_size{
				font-size: 12px;
				font-family:"KaiTi", 楷体;
			}
			.print_end_font_size{
				font-size: 10px;
				font-family:"KaiTi", 楷体;
			}
		</style>
		
		
		<div class="print_index print_index_font_size">天和商城</div>
		
		<div>
			<div class="print_title_font_size">换货单号:${model.code }</div>
		</div>
		<div>
			<div class="print_title_font_size">门店编号:${model.store.storeCode }</div>
		</div>
		<div>
			<div class="print_title_font_size">日期:<fmt:formatDate value="${model.createTime }" pattern="yyyy-MM-dd" /></div>
		</div>
		
		
		<div>
			<hr/>
		</div>
		<div>
			<div class="print_title_font_size"style="text-align: center;margin-bottom: 10px;font-weight: bolder;font-size: 14px;">原商品</div>
		</div>
		
		<table style="border:none;" class="print_title_font_size table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
			<thead class="text-center">
				<tr>
					<th class="print_title_font_size" width="15%">编号</th>
					<th class="print_title_font_size" width="70%">名称</th>
					<th class="print_title_font_size" width="15%">金额</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderGoodsList }" var="orderGoods">
					<c:if test="${'2' eq orderGoods.type}">
						<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
							<tr>
								<td class="print_title_font_size">
									<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
										${oGQ.qrcode.goods.goods.goodsCode}
									</c:if>
									<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
										${oGQ.qrcode.goods.goodsCode }
									</c:if>
								</td>
								<td class="print_title_font_size">
									<c:if test="${empty oGQ.qrcode.goods.name }">
										${oGQ.qrcode.goods.goods.name }
										<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
											
										</c:if>
										<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
											${oGQ.qrcode.goods.other_attr_value }
										</c:if>
									</c:if>
									<c:if test="${not empty oGQ.qrcode.goods.name }">
										${oGQ.qrcode.goods.name }
										<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
											
										</c:if>
										<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
											${oGQ.qrcode.goods.other_attr_value }
										</c:if>
									</c:if>
								</td>
								<td class="print_title_font_size">${orderGoods.salesPrice }</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">总金额:</div><span style="text-align: right;width: 40%;display: inline-block;" id="old_sumMoney"></span><span style="width: 10%">元</span>
		</div>
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">总优惠:</div><span style="text-align: right;width: 40%;display: inline-block;" id="old_sumSubMoney"></span><span style="width: 10%">元</span>
		</div>
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">合计:</div><span style="text-align: right;width: 40%;display: inline-block;" id="old_sumPayMoney"></span><span style="width: 10%">元</span>
		</div>
		
		<div>
			<hr/>
		</div>
		<div>
			<div class="print_title_font_size"style="text-align: center;margin-bottom: 10px;font-weight: bolder;font-size: 14px;">换货商品</div>
		</div>
		<table style="border:none;" class="print_title_font_size table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
			<thead class="text-center">
				<tr>
					<th class="print_title_font_size" width="15%">编号</th>
					<th class="print_title_font_size" width="70%">名称</th>
					<th class="print_title_font_size" width="15%">金额</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderGoodsList }" var="orderGoods">
					<c:if test="${'1' eq orderGoods.type}">
						<c:forEach items="${orderGoods.oGQList }" var="oGQ" varStatus="i">
							<tr>
								<td class="print_title_font_size">
									<c:if test="${empty oGQ.qrcode.goods.goodsCode }">
										${oGQ.qrcode.goods.goods.goodsCode}
									</c:if>
									<c:if test="${not empty oGQ.qrcode.goods.goodsCode }">
										${oGQ.qrcode.goods.goodsCode }
									</c:if>
								</td>
								<td class="print_title_font_size">
									<c:if test="${empty oGQ.qrcode.goods.name }">
										${oGQ.qrcode.goods.goods.name }
										<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
											
										</c:if>
										<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
											${oGQ.qrcode.goods.other_attr_value }
										</c:if>
									</c:if>
									<c:if test="${not empty oGQ.qrcode.goods.name }">
										${oGQ.qrcode.goods.name }
										<c:if test="${empty oGQ.qrcode.goods.other_attr_value }">
											
										</c:if>
										<c:if test="${not empty oGQ.qrcode.goods.other_attr_value }">
											${oGQ.qrcode.goods.other_attr_value }
										</c:if>
									</c:if>
								</td>
								<td class="print_title_font_size">${orderGoods.salesPrice }</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">总金额:</div><span style="text-align: right;width: 40%;display: inline-block;" id="new_sumMoney"></span><span style="width: 10%">元</span>
		</div>
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">总优惠:</div><span style="text-align: right;width: 40%;display: inline-block;" id="new_sumSubMoney"></span><span style="width: 10%">元</span>
		</div>
		<div>
			<div class="print_title_font_size" style="width: 50%;display: inline-block;">合计:</div><span style="text-align: right;width: 40%;display: inline-block;" id="new_sumPayMoney"></span><span style="width: 10%">元</span>
		</div>
		
		<div>
			<hr/>
		</div>
			
		<div>
			<div class="print_center print_title_font_size">付款金额:</div>
			<div class="print_right print_title_font_size"><span style="font-size: 22px;font-weight: bolder;">${model.onePayMoney }</span>元</div>
		</div>
		<div>
			<img alt="" src="${path }/platform/qrcode/order/${model.code }.png" width="100%">
		</div>
		
		<div>
			<div class="print_end_font_size" style="text-align: center;">如有质量问题，凭所有销售凭证7日内退换，特价品不退换</div>
		</div>
		<div>
			<div class="print_end_font_size" style="text-align: center;margin-bottom: 10px">***谢谢惠顾，欢迎再次光临***</div>
		</div>
		
		<div>
			<div style="text-align: center;margin-bottom: 10px;font-size: 0.1px">.</div>
		</div>
	</div>
			<script type="text/javascript">
		$('img').error(function() {  
		    $(this).parent().hide();  
		})
		</script>
</body>
</html>