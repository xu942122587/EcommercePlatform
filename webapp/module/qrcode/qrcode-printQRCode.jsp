<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>二维码</title>
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

		<c:forEach items="${qrcodeList }" var="qrcode">
			<div style="page-break-before: always;">
				<div  style="width: 15%;display: block;float:left;">编号:</div>
				<span style="text-align: right;width: 83%;display: inline-block;"><c:if test="${empty qrcode.goods.goodsCode }">${qrcode.goods.goods.goodsCode }</c:if><c:if test="${not empty qrcode.goods.goodsCode }">${qrcode.goods.goodsCode }</c:if></span>
			</div>
			<div>
				<div  style="width: 15%;display: block;float:left;">名称:</div>
				<span style="text-align: right;width: 83%;display:inline-block;"><c:if test="${empty qrcode.goods.name }">${qrcode.goods.goods.name }</c:if><c:if test="${not empty qrcode.goods.name }">${qrcode.goods.name }</c:if></span>
			</div>
			<div>
				<div  style="width: 15%;display: block;float:left;">属性:</div>
				<span style="text-align: right;width: 83%;display: inline-block;">${qrcode.goods.other_attr_value }</span>
			</div>
			<div>
				<div class="print_end_font_size" style="text-align: center;margin: 20px auto 0">${qrcode.id }</div>
			</div>
			<div style="text-align: center;">
				<img alt="" src="${path }/platform/qrcode/${qrcode.goods.id }/${qrcode.qrcodeBatch }/${qrcode.id }.png" width="60%">
			</div>
		</c:forEach>
		<script type="text/javascript">
		$('img').error(function() {  
		    $(this).parent().hide();  
		})
		</script>
	</div>
</body>
</html>