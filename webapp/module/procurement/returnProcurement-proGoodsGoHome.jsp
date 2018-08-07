<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.procurement.input");
	com.yunt.procurement.input = {
		submitStore : function() {
			var	isCheck = true
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				$("#qrcodeGoods_All tr:not(:hidden)").each(function(){
					if("isCheck" != $(this).attr("isCheck")){
						isCheck = false;
						return false;
					}
				})
				if(!isCheck){
					toastr.error("请校验全部商品!");
					$("#ert").removeAttr("disabled");
					return false;
				}
				if (isSuccess) {
					$.ajax({
						url : "${path}/procurement/returnSaveOrUpdate",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success(data.msg);
								com.yunt.index.toPreIndex();
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.procurement.input.submitStore()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<input type="hidden" name="model.id" value="${model.id}" />
					<input type="hidden" name="model.vende.name" value="${model.vende.name }" />
					<input type="hidden" name="model.state" value="4" />


					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">验证商品</label>
					</div>
					<div class="col-xs-3">
						<div class="form-group">
							<input type="text" value="" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="search_input" placeholder="商品二维码扫码框~"/>
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.vende.name }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.store.name }</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3" style="padding-top:7px;">${model.store.storeCode }</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.remark" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">申请件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;">${model.buyCount }</div>

						<label for="product-uuid" class="col-xs-2 control-label">申请金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;"><fmt:formatNumber value="${model.buySumMoney }" pattern="#,###.##"/>元</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">退货产品(商品未校验为红色,校验完毕为天蓝色)</label>
					</div>

					<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">现所存库</th>
								<th class="text-center">商品进价</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${qrcodeVOList}" var="qrcodeVO" varStatus="i">
								<tr style="background-color: #f05b47;color: #fff;" isCheck="">
									<td class="text-center" style="display: none;">
										<input type="hidden" id="qrcode_id" value="${qrcodeVO.id}" >
									</td>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="procurementQrcode_id" value="${qrcodeVO.procurementQrcodeId}" >
									</td>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="qrcode_goods_id" value="${qrcodeVO.goodsId}" >
									</td>
									<td class="text-center" id="qrcode_number">${i.index + 1 }</td>
									<td class="text-center" id="qrcode_goods_goodsCode">${qrcodeVO.goodsCode }</td>
									<td class="text-center" id="qrcode_goods_name">${qrcodeVO.goodsName }</td>
									<td class="text-center" id="qrcode_goods_other_attr_value">${qrcodeVO.other_attr_value}</td>
									<td class="text-center" id="qrcode_storage_name">${qrcodeVO.storageName}</td>
									<td class="text-center" id="qrcode_procurementPrice">${qrcodeVO.procurementPrice}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="embed_div"></div>


	<script type="text/javascript">
		var qrcode_id_test = /^[0-9]{32}$/;
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});

		/**
		 * 二维码扫码框监听
		 */
		$('#search_input').bind('keyup', function(event) {
			isSuccess = true;
			var search_input_value="";
			var Store_id="";
			var isNeedAdd = true
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input").val().trim();
				$("#search_input").val("");
				if(qrcode_id_test.test(search_input_value)){
					// 添加产品节点
					$("#qrcodeGoods_All tr:not(:hidden)").each(function(){
						if($(this).find("input").first().val().trim() == search_input_value){
							isNeedAdd = false;
							return;
						}
					})
					if(!isNeedAdd){
						checkGoods(search_input_value);
					}
					if(isNeedAdd){
						toastr.error("此商品不在退货列表中,请检查!");
						return false;
					}
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});
		
		function checkGoods(search_input_value){
			$("#qrcodeGoods_All tr:not(:hidden)").each(function(){
				if($(this).find("input").first().val().trim() == search_input_value){
					$(this).css("background-color","#00aeff");
					$(this).css("color","white");
					$(this).attr("isCheck","isCheck");
				}
			})
		}
		
		/**
		 * 去掉页面所有的input的回车监听
		 */
		$(document).on('keyup','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		}).on('keypress','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		}).on('keydown','#theForm input', function(event){
			if (event.keyCode == "13") {
				return false;
			}
		});
	</script>
</body>
</html>
