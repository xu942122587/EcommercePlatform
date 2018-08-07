<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	function submitAllocation(){
		if ($('#theForm').data('bootstrapValidator').validate().isValid()) {
			if(0 >= $("#qrcodeGoods_All tr:not(:hidden)").size()){
				toastr.error("请至少录入一条产品信息~");
				return false;
			} else {
				$('#submitModal').modal('show');
				$("#submitButton").unbind("click").click(function() {
					var newQrcodeId = $("#qrcodeGoods_All tr:not(:hidden)").find("input:eq(0)").val().trim();
					if("" != newQrcodeId && null != newQrcodeId){
						$.ajax({
							url : "${path}/order/sameChangeSaveOrUpdate?orderId=${order.id}&oldQrcodeId=${qrcode.id}&newQrcodeId="+newQrcodeId,
							type : "POST",
							dataType : "json",
							success : function(data) {
								$('#submitModal').modal('hide');
								if (data.success) {
									toastr.success('提交换货单成功！');
									window.open('${path}/order/sameChangePrintView?id='+data.obj);
									com.yunt.index.toPreIndex();
								} else {
									toastr.error(data.msg);
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								toastr.error("请检查网络设置");
							}
						});
					}else{
						toastr.error("换货商品出错!");
						return false;
					}
				});
			}
		}
	}
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
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入新商品</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input" placeholder="新商品二维码扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">待换商品</label>
				</div>
				<div class="panel panel-default" id="all-device-detail">
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_One">
							<tr style="background-color: #f05b47;color: #fff;" isCheck="">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_id" value="${qrcode.id }">
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="order_id" value="${order.id }">
								</td>
								<td class="text-center" >
									<c:if test="${empty qrcode.goods.goodsCode }">
										${qrcode.goods.goods.goodsCode }
									</c:if>
									<c:if test="${not empty qrcode.goods.goodsCode }">
										${qrcode.goods.goodsCode }
									</c:if>
								</td>
								<td class="text-center" >
									<c:if test="${empty qrcode.goods.name }">
										${qrcode.goods.goods.name }
									</c:if>
									<c:if test="${not empty qrcode.goods.name }">
										${qrcode.goods.name }
									</c:if>
								</td>
								<td class="text-center" >${qrcode.goods.other_attr_value }</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">换货商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>换货商品</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<tr id="qrcode_goods_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_goods_id" >
								</td>
								<td class="text-center" id="qrcode_number"></td>
								<td class="text-center" id="qrcode_goods_goodsCode"></td>
								<td class="text-center" id="qrcode_goods_name"></td>
								<td class="text-center" id="qrcode_goods_other_attr_value"></td>
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
					<button id="ert" type="button" class="btn btn-primary" onclick="submitAllocation();">提交</button>
					<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
				</div>
			</form>
		</div>
	</div>
	<input type="hidden" id="qrcodeGoods_delete_copy" value="" name="">
	<div id="embed_div"></div>
	<script type="text/javascript">
	var qrcode_id_test = /^[0-9]{32}$/,
		buyAgio_test = /^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$/;
	var qrcode_goods_new_index = 0 , qrcode_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1 ;
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
		$('#search_input').bind('keyup', function(event) {
			isSuccess = true;
			var search_input_value="";
			var Store_id="";
			var isNeedAdd = true
			var number = -1;
			if (event.keyCode == "13") {
				search_input_value = $("#search_input").val().trim();
				$("#search_input").val("");
				if(qrcode_id_test.test(search_input_value) && '${qrcode.id}' != search_input_value){
					add_qrcode_goods_tr(search_input_value,2);
				}else if ('${qrcode.id}' == search_input_value){
					toastr.error("待退商品无法录入!");
				}else{
					toastr.error("无法识别的信息");
					delEmbed();
					setEmbed();
				}
			}
		});
		
		function checkGoods(search_input_value){
			$("#qrcodeGoods_One tr:not(:hidden)").each(function(){
				if($(this).find("input:eq(0)").val().trim() == search_input_value){
					$(this).css("background-color","#00aeff");
					$(this).css("color","white");
					$(this).attr("isCheck","isCheck");
				}
			})
		}
		
		function noCheckGoods(search_input_value){
			$("#qrcodeGoods_One tr:not(:hidden)").each(function(){
				if($(this).find("input").first().val().trim() == search_input_value){
					$(this).css("background-color","#f05b47");
					$(this).css("color","fff");
					$(this).attr("isCheck","");
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
		
		/**
		 * 添加采购产品（采购退货产品）到产品table中
		 * @param ownerId 产品ID或二维码ID
		 * @param ownerType ID类型1：产品ID，2：二维码ID
		 */
		function add_qrcode_goods_tr(ownerId,ownerType){
			var ajax_url = "";
				ajax_url = "${path}/qrcode/getQrcodeByQrcodeIdForOrder?QrcodeID=" + ownerId;
			$.ajax({
				url : ajax_url,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						if(<c:if test="${empty qrcode.goods.name }">
								'${qrcode.goods.goods.id }'
							</c:if>
							<c:if test="${not empty qrcode.goods.name }">
								'${qrcode.goods.id }'
							</c:if>
							!= data.obj.parentGoodsId){
							toastr.error("换货商品必须与待换商品相同!");
						}else if ("isCheck" == $("#qrcodeGoods_One").find("tr").attr("isCheck")){
							toastr.error("已有换货商品,请先将其删除!");
						}else{
							// 获取成功，拼接页面节点
							var qrcode_goods_one = $("#qrcode_goods_tr_copy").clone();

							qrcode_goods_one.find("#qrcode_id").val(data.obj.id);
							qrcode_goods_one.find("#qrcode_id").attr("name","orderQrcodeIdList[" + qrcode_goods_new_index + "].id");

							qrcode_goods_one.find("#qrcode_goods_id").val(data.obj.goodsId);
							qrcode_goods_one.find("#qrcode_goods_id").attr("name","orderQrcodeIdList[" + qrcode_goods_new_index + "].goods.id");

							qrcode_goods_one.find("#qrcode_number").html(qrcode_goods_number_index);

							qrcode_goods_one.find("#qrcode_goods_goodsCode").html(data.obj.goodsCode);

							qrcode_goods_one.find("#qrcode_goods_name").html(data.obj.goodsName);

							qrcode_goods_one.find("#qrcode_goods_other_attr_value").html(data.obj.other_attr_value);

							qrcode_goods_one.removeAttr("id");
							qrcode_goods_new_index++;
							qrcode_goods_number_index++;
							$("#qrcodeGoods_All").append(qrcode_goods_one.show());
							checkGoods('${qrcode.id}');
						}
					} else {
						//setEmbed();
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					//setEmbed();
					toastr.error("请检查网络设置");
				}
			});
		}
		
		/**
		 * 删除按钮--监听
		 */
		$(document).on('click', '.qrcode_goods_one_delete_button', function(){
			var this_=$(this);
			noCheckGoods('${qrcode.id}');
			deleteTr(this_);
		});
		var delete_IsDelete = true;
		function deleteTr(this_){
			if(delete_IsDelete){
				var qrcode_goods_number_index_tmp = 1;
				delete_IsDelete=false;
				this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
				$("#qrcodeGoods_All tr").each(function(){
					if(!$(this).is(":hidden")){
						$(this).find("#qrcode_number").html(qrcode_goods_number_index_tmp);
						qrcode_goods_number_index_tmp++;
					}
				})
				qrcode_goods_number_index=qrcode_goods_number_index_tmp;
				bootstrapValidator_again();
				delete_IsDelete=true;
			}
		}
	</script>
</body>
</html>
