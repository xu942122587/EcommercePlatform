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
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入赔偿订单号</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input_three" placeholder="待退订单扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入赔偿商品</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input_one" placeholder="赔偿商品二维码扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">赔偿商品 </label>
				</div>
				<div class="panel panel-default" id="all-device-detail">
				
					<table class="table table-striped table-hover table-bordered text-center"
						id="One" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_One">
							<tr id="qrcodeGoods_One_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeOne_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeOne_goods_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeOne_isOutGoods" value="2">
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeOne_strikePrice">
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcodeOne_subMoney">
								</td>
								<td class="text-center" id="qrcodeOne_number"></td>
								<td class="text-center" id="qrcodeOne_goods_goodsCode"></td>
								<td class="text-center" id="qrcodeOne_goods_name"></td>
								<td class="text-center" id="qrcodeOne_goods_other_attr_value"></td>
								<td class="text-center">
									<div class="col-xs-12" style="padding-top: 7px;">
										<input type="button" value="删除" class="btn btn-danger btn-xs qrcode_goods_one_delete_button"/>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="form-group col-xs-8 pull-right">
					<button type="button" class="btn btn-primary" onclick="toSave();">赔偿确认</button>
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
					<h4 class="modal-title">赔偿确认</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_order"
							role="form" onsubmit="return false;">
						
						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="toProcurement()" class="btn btn-primary btn-block" value="打印赔偿单">
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
	
	var sumCount = 0;
	
	function toProcurement() {
		var formData = $("#theForm").serialize();
		$.ajax({
			url : "${path}/order/reparationSaveOrUpdate",
			data : formData,
			type : "POST",
			dataType : "json",
			success : function(data) {
				if (data.success) {
					toastr.success(data.msg);
					$("#order_add_list_div").modal("hide");
					setTimeout(function(){
						window.open('${path}/order/reparationPrintView?id='+data.obj);
						com.yunt.index.toPreIndex();
					},800);
				} else {
					//delEmbed();
					//setEmbed();
					toastr.error(data.msg);
					$("#search_input").val("");
				}
			},
			error : function(xhr, type, exception) {
				//delEmbed();
				//setEmbed();
				toastr.error("请检查网络设置");
			}
		});
	}
	
	function toSave() {
		$('#testForm_save_order')[0].reset();
		//只能清除验证，无法清除不带验证input标签的数据
		$('#testForm_save_order').bootstrapValidator('resetForm', true);
		if(0 < sumCount){
				$("#order_add_list_div").modal("show");
		}else{
			toastr.error("赔偿商品不能为空!");
		}
	}
	
	var qrcode_id_test = /^[0-9]{32}$/,order_id_test = /^[0-9]{16,32}$/,
		buyAgio_test = /^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$/;
	var qrcode_goods_new_one_index = 0 , qrcode_goods_new_two_index = 0 ,qrcodeOne_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1 ,qrcodeTwo_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1;
	var goods_new_index = 0 , goods_number_index = 1 ;
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
		$('#search_input_one').bind('keyup', function(event) {
			isSuccess = true;
			var search_input_value="";
			var isNeedAdd = true
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input_one").val().trim();
				$("#search_input_one").val("");
				if(qrcode_id_test.test(search_input_value)){
					var qrcodeId = search_input_value;
					$("#qrcodeGoods_One tr:not(:hidden)").each(function(){
						if($(this).find("#qrcodeOne_id").val().trim() == search_input_value){
							isNeedAdd = false;
							// 退出循环
							return;
						}
					})
					if(!isNeedAdd){
						toastr.error("本产品已经添加过了哦~换一个添加吧~");
						return false;
					}
					if("" == $("#model_order_id").val() || null == $("#model_order_id").val()){
						isNeedAdd = false;
						toastr.error("请先录入订单！");
					}
					if(isNeedAdd){
						var orderId = $("#model_order_id").val();
						$.ajax({
							url : "${path}/order/qrcodeIsSaleByReparation?qrcodeId="+qrcodeId+"&orderId="+orderId,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									if("2" == data.obj[0]){
										add_qrcode_goods_tr(search_input_value,1);
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
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
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
		 * 添加待换产品（采购赔偿产品）到产品table中
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
						if(1 == ownerType){
							$("#qrcodeGoods_One tr:not(:hidden)").each(function(){
								if($(this).find("#qrcodeOne_id").val().trim() == data.obj.id){
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
								var qrcode_goods_one = $("#qrcodeGoods_One_tr_copy").clone();
								qrcode_goods_one.find("#qrcodeOne_id").val(data.obj.id);
								qrcode_goods_one.find("#qrcodeOne_id").attr("name","oldQrcodeVOList[" + qrcode_goods_new_one_index + "].id");

								qrcode_goods_one.find("#qrcodeOne_goods_id").val(data.obj.goodsId);
								qrcode_goods_one.find("#qrcodeOne_goods_id").attr("name","oldQrcodeVOList[" + qrcode_goods_new_one_index + "].goodsId");
								
								qrcode_goods_one.find("#qrcodeOne_isOutGoods").attr("name","oldQrcodeVOList[" + qrcode_goods_new_one_index + "].isOutGoods");
								
								qrcode_goods_one.find("#qrcodeOne_strikePrice").val(data.obj.goodsSalePrice);
								qrcode_goods_one.find("#qrcodeOne_strikePrice").attr("name","oldQrcodeVOList[" + qrcode_goods_new_one_index + "].strikePrice");

								qrcode_goods_one.find("#qrcodeOne_subMoney").val(data.obj.subMoney);
								qrcode_goods_one.find("#qrcodeOne_subMoney").attr("name","oldQrcodeVOList[" + qrcode_goods_new_one_index + "].subMoney");
								
								qrcode_goods_one.find("#qrcodeOne_number").html(qrcodeOne_goods_number_index);

								qrcode_goods_one.find("#qrcodeOne_goods_goodsCode").html(data.obj.goodsCode);

								qrcode_goods_one.find("#qrcodeOne_goods_name").html(data.obj.goodsName);

								qrcode_goods_one.find("#qrcodeOne_goods_other_attr_value").html(data.obj.other_attr_value);

								qrcode_goods_one.removeAttr("id");
								sumCount++;
								qrcode_goods_new_one_index++;
								qrcodeOne_goods_number_index++;
								$("#qrcodeGoods_One").append(qrcode_goods_one.show());
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
		$(document).on('click', '.qrcode_goods_one_delete_button', function(){
			var this_=$(this);
			deleteOneTr(this_);
		});
		var delete_IsDelete = true;
		function deleteOneTr(this_){
			if(delete_IsDelete){
				delete_IsDelete=false;
				var qrcode_goods_number_index_tmp = 1;
				var Oneprice = this_.parent().parent().parent().find("#qrcodeOne_sale_price").html() - 0;
				this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
				$("#qrcodeGoods_One tr:not(:hidden)").each(function(){
					$(this).find("#qrcodeOne_number").html(qrcode_goods_number_index_tmp);
					qrcode_goods_number_index_tmp++;
				})
				sumCount=qrcode_goods_number_index_tmp - 1;
				qrcodeOne_goods_number_index=qrcode_goods_number_index_tmp;
				bootstrapValidator_again();
				delete_IsDelete=true;
			}
		}
		
	</script>
</body>
</html>
