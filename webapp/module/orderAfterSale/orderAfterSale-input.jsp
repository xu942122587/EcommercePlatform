<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12 display">
			<form onsubmit="return false;"
				class="form-horizontal" id="theForm" role="form" method="POST"
				data-bv-message="This value is not valid"
				data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
				data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
				data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
				
				<input type="hidden" id="model_order_id" name="order.id">
				
				<input type="hidden" id="order_payMoney">
				<input type="hidden" id="order_subMoney">
				<input type="hidden" id="order_sumMoney">
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入售后订单号</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input_three" placeholder="售后订单扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入售后商品</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input_two" placeholder="售后商品二维码扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">售后商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>售后商品</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="Two" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">商品价格</th>
								<th class="text-center">补偿金额</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_Two">
							<tr id="qrcodeGoods_Two_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeTwo_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeTwo_goods_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeTwo_strikePrice">
								</td>
								<td class="text-center" id="qrcodeTwo_number"></td>
								<td class="text-center" id="qrcodeTwo_goods_goodsCode"></td>
								<td class="text-center" id="qrcodeTwo_goods_name"></td>
								<td class="text-center" id="qrcodeTwo_goods_other_attr_value"></td>
								<td class="text-center" id="qrcodeTwo_sale_price"></td>
								<td class="text-center" style="width: 10%">
									<div class="form-group" style="margin-bottom: 0px;">
										<div class="col-xs-12">
											<input type="text" id="qrcodeTwo_subMoney" value="" class="form-control updateMoney"
											onkeydown="if(event.keyCode==32) return false;"
											required data-bv-notempty-message="补偿金额不能为空,需大于0"
											pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00)$" 
											data-bv-regexp-message="补偿金额不正确，参考格式：1688.88">
										</div>
									</div>
								</td>
								<td class="text-center">
									<div class="col-xs-12" style="padding-top: 7px;">
										<input type="button" value="删除" class="btn btn-danger btn-xs qrcode_goods_two_delete_button"/>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">图片信息</label>
				</div>

				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">图片上传</label>
					<div class="col-xs-8">
						<div id="fileDiv" style="overflow:hidden"></div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">状况描述</label>
				</div>
				<div class="form-group">
					<label for="product-uuid" class="col-xs-2 control-label">描述</label>
					<div class="col-xs-9">
						<input type="text" value="${model.remark }" class="form-control" maxlength="200"
								onkeydown="if(event.keyCode==32) return false;"
								required data-bv-notempty-message="描述不能为空"
								id="name" name="model.remark"/>
					</div>
				</div>
				
				<div class="form-group col-xs-8 pull-right">
					<button type="button" class="btn btn-primary" onclick="toSave();">确认补偿金额</button>
					<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
				</div>
			</form>
		</div>
	</div>
	<input type="hidden" id="qrcodeGoods_delete_copy" value="" name="">
	<div id="embed_div"></div>
	
	<!-- 新增弹框 -->
	<div id="order_add_list_div" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">补偿金额确认</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_order"
							role="form" onsubmit="return false;">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">补偿金额</label>
							<div class="col-xs-6" style="padding-top: 7px;">
								<span id="order_goods_qrcode_id"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="toProcurement()" class="btn btn-primary btn-block" value="确认赔偿">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	var number = 0;
	/**
	 * 设置优惠价
	 */
	$(document).on('blur', '.updateMoney', function(){
		var sumTwoPrice = 0;
		$("#qrcodeGoods_Two tr:not(:hidden)").each(function(){
			var subMoney = $(this).find("#qrcodeTwo_subMoney").val().trim() - 0;
			var price = $(this).find("#qrcodeTwo_sale_price").html().trim() - 0;
			sumTwoPrice += (price - subMoney)
		})
		$("#sumTwoPrice").html(sumTwoPrice);
	});
	
	function toProcurement() {
		if ($('#theForm').data('bootstrapValidator').validate().isValid()) {
			if(!$.hz.swfupload.validateAttachment("fileDiv", true)){
				$("#ert").removeAttr("disabled");
				return false;
			}
			var formData = $("#theForm").serialize();
			$.ajax({
				url : "${path}/orderAfterSale/saveOrUpdate",
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						toastr.success(data.msg);
						$("#order_add_list_div").modal("hide");
						setTimeout(function(){
							com.yunt.index.loadInner('${path}/orderAfterSale/list','查看换货单信息');
							},800);
					} else {
						//setEmbed();
						toastr.error(data.msg);
						$("#search_input").val("");
					}
				},
				error : function(xhr, type, exception) {
					//setEmbed();
					toastr.error("请检查网络设置");
				}
			});
		}
	}
	
	function toSave() {
		$('#testForm_save_order')[0].reset();
		//只能清除验证，无法清除不带验证input标签的数据
		$('#testForm_save_order').bootstrapValidator('resetForm', true);
		var subMoney = 0;
		if(0 < number){
			$("#qrcodeGoods_Two tr:not(:hidden)").each(function(){
				if(0 >= $(this).find("#qrcodeTwo_subMoney").val().trim()){
					toastr.error("补偿金额必须大于0");
				}else{
					subMoney = $(this).find("#qrcodeTwo_subMoney").val().trim() - 0;
					$("#order_goods_qrcode_id").html(subMoney);
					$("#order_add_list_div").modal("show");
				}
			})
		}else{
			toastr.error("售后商品不能为空!");
		}
	}
	
	var qrcode_id_test = /^[0-9]{32}$/,order_id_test = /^[0-9]{16,32}$/,
		buyAgio_test = /^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$/;
	var qrcode_goods_new_one_index = 0 , qrcode_goods_new_two_index = 0 ,qrcodeOne_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1 ,qrcodeTwo_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1;
	var goods_new_index = 0 , goods_number_index = ("${qrcodeGoodsList.size()}" - 0) + 1 ;

		/**
		* 重新初始化验证
		*/
		function bootstrapValidator_again(){
			$(".form-control-feedback").remove();
			$(".help-block").remove();
			$('#theForm').data('bootstrapValidator', null);
			$('#theForm').bootstrapValidator('resetForm', false);
			$('#theForm').bootstrapValidator();//初始化验证
		}

		$(function(){
			$('#theForm').bootstrapValidator();//初始化验证
			<c:if test="${empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.orderAfterSale.model.OrderAfterSale,id",required:true});
			</c:if>
		})
		
		/**
		 * 二维码扫码框监听
		 */
		$('#search_input_three').bind('keyup', function(event) {
			var search_input_value="";
			if (event.keyCode == "13") {
				search_input_value = $("#search_input_three").val().trim();
				$("#search_input_three").val("");
				if(order_id_test.test(search_input_value)){
					$.ajax({
						url : "${path}/order/getOrderIdByCode?code="+search_input_value,
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								$("#model_order_id").val(data.obj);
								toastr.success(data.msg);
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
						}
					});
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		})
		
		/**
		 * 二维码扫码框监听
		 */
		$('#search_input_two').bind('keyup', function(event) {
			isSuccess = true;
			var search_input_value="";
			var isNeedAdd = true
			if (event.keyCode == "13") {
				search_input_value = $("#search_input_two").val().trim();
				$("#search_input_two").val("");
				if(qrcode_id_test.test(search_input_value)){
					var qrcodeId = search_input_value;
					if(1 <= number){
						toastr.error("只可以添加一个商品");
					}else{
						$("#qrcodeGoods_Two tr:not(:hidden)").each(function(){
							if($(this).find("#qrcodeTwo_id").val().trim() == search_input_value){
								isNeedAdd = false;
								// 退出循环
								return;
							}
						})
						if(!isNeedAdd){
							toastr.error("本产品已经添加过了哦~换一个添加吧~");
							return false;
						}
						if(isNeedAdd){
							var orderId = $("#model_order_id").val();
							$.ajax({
								url : "${path}/order/qrcodeIsSaleByAfterSale?qrcodeId="+qrcodeId+"&orderId="+orderId,
								data : null,
								type : "POST",
								dataType : "json",
								success : function(data) {
									if (data.success) {
										if("2" == data.obj[0]){
											if(data.obj[1] == $("#model_order_id").val()){
												add_qrcode_goods_tr(search_input_value,2);
											}else{
												toastr.error("请先输入订单号或输入同一订单的商品!");
											}
										}else{
											toastr.error("该商品未售出,请重试");
										}
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
				}else{
					toastr.error("无法识别的信息");
				}
			}
		});
		
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
		
		/**
		 * 添加待换产品（采购退货产品）到产品table中
		 * @param ownerId 产品ID或二维码ID
		 * @param ownerType ID类型1：待换，2：换货
		 */
		function add_qrcode_goods_tr(ownerId,ownerType){
			var ajax_url = "";
			var isNeedAdd = true;
				ajax_url = "${path}/qrcode/getQrcodeByQrcodeIdForOrder?QrcodeID=" + ownerId;
			$.ajax({
				url : ajax_url,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						if(2 == ownerType){
							$("#qrcodeGoods_Two tr:not(:hidden)").each(function(){
								if($(this).find("#qrcodeTwo_id").val().trim() == data.obj.id){
									isNeedAdd = false;
									// 退出循环
									return;
								}
							})
							if(!isNeedAdd){
								toastr.error("本产品已经添加过了哦~换一个添加吧~");
								return false;
							}
							if(isNeedAdd){
								// 获取成功，拼接页面节点
								var qrcode_goods_one = $("#qrcodeGoods_Two_tr_copy").clone();
								var sumTwoPrice= $("#sumTwoPrice").html() - 0;
								var sumTwoCount= $("#sumTwoCount").html() - 0;
								qrcode_goods_one.find("#qrcodeTwo_id").val(data.obj.id);
								qrcode_goods_one.find("#qrcodeTwo_id").attr("name","model.orderGoodsQrcode.qrcode.id");
								
								qrcode_goods_one.find("#qrcodeTwo_goods_id").val(data.obj.goodsId);
								
								qrcode_goods_one.find("#qrcodeTwo_strikePrice").val(data.obj.goodsSalePrice);
								
								qrcode_goods_one.find("#qrcodeTwo_number").html(qrcodeTwo_goods_number_index);
								
								qrcode_goods_one.find("#qrcodeTwo_goods_goodsCode").html(data.obj.goodsCode);

								qrcode_goods_one.find("#qrcodeTwo_goods_name").html(data.obj.goodsName);

								qrcode_goods_one.find("#qrcodeTwo_goods_other_attr_value").html(data.obj.other_attr_value);
								
								qrcode_goods_one.find("#qrcodeTwo_sale_price").html(accSub(data.obj.goodsSalePrice,data.obj.subMoney));
								
								qrcode_goods_one.find("#qrcodeTwo_subMoney").val(0);
								qrcode_goods_one.find("#qrcodeTwo_subMoney").attr("name","model.sendMoney");

								qrcode_goods_one.removeAttr("id");
								sumTwoCount++;
								$("#sumTwoCount").html(sumTwoCount);
								$("#sumTwoPrice").html(accAdd(sumTwoPrice, accSub(data.obj.goodsSalePrice,data.obj.subMoney)));
								qrcode_goods_new_two_index++;
								qrcodeTwo_goods_number_index++;
								$("#qrcodeGoods_Two").append(qrcode_goods_one.show());
								number++;
								bootstrapValidator_again();
							}
						}
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});
		}
		
		/**
		 * 删除按钮--监听
		 */
		$(document).on('click', '.qrcode_goods_two_delete_button', function(){
			var this_=$(this);
			deleteTwoTr(this_);
		});
		var delete_IsDelete = true;
		function deleteTwoTr(this_){
			if(delete_IsDelete){
				delete_IsDelete=false;
				var qrcode_goods_number_index_tmp = 1;
				var order_add_list_index_tmp = 1;
				var Twoprice = this_.parent().parent().parent().find("#qrcodeTwo_sale_price").html() - 0;
				var qrcodeId = this_.parent().parent().parent().find("#qrcodeTwo_id").val();
				this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
				$("#qrcodeGoods_Two tr").each(function(){
					if(!$(this).is(":hidden")){
						$(this).find("#qrcodeTwo_number").html(qrcode_goods_number_index_tmp);
						qrcode_goods_number_index_tmp++;
					}
				})
				
				var sumTwoCount= 0;
				var sumTwoPrice = 0;
				$("#qrcodeGoods_Two tr:not(:hidden)").each(function(){
					var subMoney = $(this).find("#qrcodeTwo_subMoney").val().trim() - 0;
					var price = $(this).find("#qrcodeTwo_sale_price").html().trim() - 0;
					sumTwoPrice += (price - subMoney)
					sumTwoCount++;
				})
				
				qrcodeTwo_goods_number_index--;
				number=sumTwoCount;
				$("#sumTwoCount").html(sumTwoCount);
				$("#sumTwoPrice").html(sumTwoPrice);
				bootstrapValidator_again();
				delete_IsDelete=true;
			}
		}
	</script>
</body>
</html>
