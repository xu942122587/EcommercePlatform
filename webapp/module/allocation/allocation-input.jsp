<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	function submitAllocation(){
		if(0 >= $("#qrcodeGoods_All tr:not(:hidden)").size()){
			toastr.error("请至少录入一条产品信息~");
			return false;
		} else {
			$('#submitModal').modal('show');
			$("#submitButton").unbind("click").click(function() {
				$.ajax({
					url : "${path}/allocation/submitAllocation?allocationId=${allocationId}",
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#submitModal').modal('hide');
						if (data.success) {
							toastr.success('提交库存调拨成功！');
							com.yunt.index.toPreIndex();
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
	}
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12 display">
			<form onsubmit="return com.yunt.allocation.add.submitAllocation()"
				class="form-horizontal" id="theForm" role="form" method="POST"
				data-bv-message="This value is not valid"
				data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
				data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
				data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">录入商品</label>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="search_input" placeholder="商品二维码扫码框~"/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">商品统计</label>
				</div>
				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>商品统计</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">商品数量</th>
							</tr>
						</thead>
						<tbody id="goodsCount_All">
							<c:forEach items="${qrcodeGoodsList}" var="qrcodeGoods" varStatus="j">
								<c:if test="${'' eq qrcodeGoods.goods.name}">
									<tr>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="goods_id" value="${qrcodeGoods.goods.id}" >
										</td>
										<td class="text-center" id="goods_number">${j.index + 1 }</td>
										<td class="text-center" id="goods_goodsCode">${qrcodeGoods.goods.goods.goodsCode }</td>
										<td class="text-center" id="goods_name">${qrcodeGoods.goods.goods.name }</td>
										<td class="text-center" id="goods_other_attr_value">
											<c:if test="${'' eq qrcodeGoods.goods.other_attr_value}">
												空
											</c:if>
											<c:if test="${'' ne qrcodeGoods.goods.other_attr_value}">
												${qrcodeGoods.goods.other_attr_value}
											</c:if>
										</td>
										<td class="text-center" id="goods_qrcodeCount">${qrcodeGoods.qrcodeCount}"</td>
									</tr>
								</c:if>
								<c:if test="${'' ne qrcodeGoods.goods.name}">
									<tr>
										<td class="text-center" style="display: none;">
											<input type="hidden" id="goods_id" value="${qrcodeGoods.goods.id}" >
										</td>
										<td class="text-center" id="goods_number">${j.index + 1 }</td>
										<td class="text-center" id="goods_goodsCode">${qrcodeGoods.goods.goodsCode }</td>
										<td class="text-center" id="goods_name">${qrcodeGoods.goods.name }</td>
										<td class="text-center" id="goods_other_attr_value">
											<c:if test="${'' eq qrcodeGoods.goods.other_attr_value}">
												空
											</c:if>
											<c:if test="${'' ne qrcodeGoods.goods.other_attr_value}">
												${qrcodeGoods.goods.other_attr_value}
											</c:if>
										</td>
										<td class="text-center" id="goods_qrcodeCount">${qrcodeGoods.qrcodeCount}</td>
									</tr>
								</c:if>
							</c:forEach>
							<tr id="goodsCount_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="goods_id">
								</td>
								<td class="text-center" id="goods_number"></td>
								<td class="text-center" id="goods_goodsCode"></td>
								<td class="text-center" id="goods_name"></td>
								<td class="text-center" id="goods_other_attr_value"></td>
								<td class="text-center" id="goods_qrcodeCount"></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">调库商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>库存调拨</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">现所存库</th>
								<th class="text-center">商品进价</th>
								<th class="text-center">商品流向</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${qrcodeVOList}" var="qrcodeVO" varStatus="i">
								<tr>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="qrcode_id" value="${qrcodeVO.id}" >
									</td>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="allocationQrcode_id" value="${qrcodeVO.allocationQrcodeId}" >
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
									<td class="text-center" id="qrcode_logistics">${qrcodeVO.logistics}</td>
									<td class="text-center">
										<div class="col-xs-12" style="padding-top: 7px;">
											<input type="button" value="删除" class="btn btn-danger btn-xs qrcode_goods_one_delete_button"/>
										</div>
									</td>
								</tr>
							</c:forEach>
							<tr id="qrcode_goods_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="allocationQrcode_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_goods_id" >
								</td>
								<td class="text-center" id="qrcode_number"></td>
								<td class="text-center" id="qrcode_goods_goodsCode"></td>
								<td class="text-center" id="qrcode_goods_name"></td>
								<td class="text-center" id="qrcode_goods_other_attr_value"></td>
								<td class="text-center" id="qrcode_storage_name"></td>
								<td class="text-center" id="qrcode_procurementPrice"></td>
								<td class="text-center" id="qrcode_logistics"></td>
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
				if(qrcode_id_test.test(search_input_value)){
					// 添加产品节点
					$("#qrcodeGoods_All tr:not(:hidden)").each(function(){
						if($(this).find("input").first().val().trim() == search_input_value){
							isNeedAdd = false;
							return;
						}
					})
					if(!isNeedAdd){
						toastr.error("此商品已经在列表了哦~换一个添加吧~");
						return false;
					}
					if(isNeedAdd){
						add_qrcode_goods_tr(search_input_value, 2);
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
		 * 添加采购产品（采购退货产品）到产品table中
		 * @param ownerId 产品ID或二维码ID
		 * @param ownerType ID类型1：产品ID，2：二维码ID
		 */
		function add_qrcode_goods_tr(ownerId,ownerType){
			var ajax_url = "";
				ajax_url = "${path}/qrcode/getQrcodeByQrcodeId?QrcodeID=" + ownerId+"&storeId=${storeId}&allocationId=${allocationId}&storageId=${outStorageId}";
			$.ajax({
				url : ajax_url,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						// 获取成功，拼接页面节点
						var qrcode_goods_one = $("#qrcode_goods_tr_copy").clone();

						qrcode_goods_one.find("#qrcode_id").val(data.obj.id);
						qrcode_goods_one.find("#qrcode_id").attr("name","allocationQrcodeIdList[" + qrcode_goods_new_index + "].id");

						qrcode_goods_one.find("#allocationQrcode_id").val(data.obj.allocationQrcodeId);
						qrcode_goods_one.find("#allocationQrcode_id").attr("name","allocationQrcodeIdList[" + qrcode_goods_new_index + "].allocationQrcodeId");
						
						qrcode_goods_one.find("#qrcode_goods_id").val(data.obj.goodsId);
						qrcode_goods_one.find("#qrcode_goods_id").attr("name","allocationQrcodeIdList[" + qrcode_goods_new_index + "].goods.id");

						qrcode_goods_one.find("#qrcode_number").html(qrcode_goods_number_index);

						qrcode_goods_one.find("#qrcode_goods_goodsCode").html(data.obj.goodsCode);

						qrcode_goods_one.find("#qrcode_goods_name").html(data.obj.goodsName);

						qrcode_goods_one.find("#qrcode_goods_other_attr_value").html(data.obj.other_attr_value);

						qrcode_goods_one.find("#qrcode_storage_name").html(data.obj.storageName);

						qrcode_goods_one.find("#qrcode_procurementPrice").html(data.obj.procurementPrice);

						qrcode_goods_one.find("#qrcode_logistics").html(data.obj.logistics);

						qrcode_goods_one.removeAttr("id");
						qrcode_goods_new_index++;
						qrcode_goods_number_index++;
						$("#qrcodeGoods_All").append(qrcode_goods_one.show());
						addGoodsCount(data.obj);
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
			var qrcode_goods_number_index_tmp = 1;
			var allocationQrcode_id_delete = $(this).parent().parent().parent().find("input:eq(1)").val()
			var qrcode_id_delete = $(this).parent().parent().parent().find("input:eq(0)").val()
			var goods_id_delete = $(this).parent().parent().parent().find("input:eq(2)").val()
			$.ajax({
				url : "${path}/allocation/doDelete?allocationQrcodeId="+allocationQrcode_id_delete+"&qrcodeId="+qrcode_id_delete,
				data : null,
				type : "POST",
				async : false,
				dataType : "json",
				success : function(data) {
					if (data.success) {
						deleteTr(this_);
						deleteGoodsCount(goods_id_delete);
						toastr.success(data.msg);
					} else {
						toastr.error(data.msg);
					}
				},
				error : function(xhr, type, exception) {
					alert("请检查网络设置");
				}
			});
		});
		
		function deleteTr(this_){
			this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
			$("#qrcodeGoods_All tr").each(function(){
				if(!this_.is(":hidden")){
					this_.find("#qrcode_number").html(qrcode_goods_number_index_tmp);
					qrcode_goods_number_index_tmp++;
				}
			})
			qrcode_goods_number_index--;
			bootstrapValidator_again();
		}
		/**
		 * 播放警告音
		 */
		function setEmbed(){
			$("#embed_div").append("<audio id='embed_audio_mp3' src='${basePath}/module/procurement/2730.mp3' autoplay='true' playcount='1'></audio>");
		}
		/**
		 * 停止播放警告音
		 */
		function delEmbed(){
			$("#embed_audio_mp3").remove();
			$("#embed_div").html();
		}
		/**
		 * 添加商品统计
		 */
		function addGoodsCount(qrcodeVO){
			var ishave = false;
			$("#goodsCount_All tr:not(:hidden)").each(function(){
				if($(this).find("input").val().trim() == qrcodeVO.goodsId){
					$(this).find("td:eq(5)").html(($(this).find("td:eq(5)").html().trim() - 0) + 1);
					ishave = true;
				}
			})
			if(!ishave){
				var goods_one = $("#goodsCount_tr_copy").clone();
				goods_one.find("#goods_id").val(qrcodeVO.goodsId);
				goods_one.find("#goods_id").attr("name","allocationQrcode[" + goods_new_index + "].id");
				goods_one.find("#goods_number").html(goods_number_index);
				goods_one.find("#goods_goodsCode").html(qrcodeVO.goodsCode);
				goods_one.find("#goods_name").html(qrcodeVO.goodsName);
				goods_one.find("#goods_other_attr_value").html(qrcodeVO.other_attr_value);
				goods_one.find("#goods_qrcodeCount").html(1);
				goods_one.removeAttr("id");
				goods_new_index++;
				goods_number_index++;
				$("#goodsCount_All").append(goods_one.show());
			}
		}
		function deleteGoodsCount(goodsId){
			var goods_number_index_tmp = 1;
			$("#goodsCount_All tr:not(:hidden)").each(function(){
				if($(this).find("input").val().trim() == goodsId){
					$(this).find("td:eq(5)").html(($(this).find("td:eq(5)").html().trim() - 0) - 1);
					ishave = true;
				}
				if(0 == $(this).find("td:eq(5)").html()){
					$(this).hide().find("input").val("").attr("disabled","disabled");
					$("#goodsCount_All tr").each(function(){
						if(!$(this).is(":hidden")){
							$(this).find("#goods_number").html(goods_number_index_tmp);
							goods_number_index_tmp++;
						}
					})
					goods_number_index--;
				}
			})
		}
	</script>
</body>
</html>
