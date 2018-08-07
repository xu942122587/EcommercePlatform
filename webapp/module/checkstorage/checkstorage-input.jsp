<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>

	function submitCheckstorage(){
		if(0 >= $("#checkstorageGoods_All tr:not(:hidden)").size()){
			toastr.error("请至少录入一条产品信息~");
			return false;
		} else {
			var isSubmitOK = true;
			$("#checkstorageGoods_All tr:not(:hidden)").each(function(){
				if(!$(this).find(":input[type=text]").prop("disabled") ){
					toastr.error("请先对比所有商品后再提交~");
					isSubmitOK = false;
					//退出循环
					return;
				}
			})
			if(isSubmitOK){
				$('#submitModal').modal('show');
				$("#submitButton").unbind("click").click(function() {
					$.ajax({
						url : "${path}/checkstorage/submitCheckstorage?checkstorageId=${checkstorageId}",
						type : "POST",
						dataType : "json",
						success : function(data) {
							$('#submitModal').modal('hide');
							if (data.success) {
								toastr.success('提交库存盘点成功！');
								com.yunt.index.toPreIndex();
							} else {
								toastr.error(data.msg);
							}
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							toastr.error("请检查网络设置");
						}
					});
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
						<div class="quick-add-btn">
							<a href="javascript:void(0)" type="button" class="btn btn-danger"
								onclick="toAdd()"> <span
								class="glyphicon glyphicon-new-window"></span> 添加商品
							</a>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">盘点商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>库存盘点</h5>
					</div>
		
					<table class="table table-striped table-hover table-bordered text-center"
						id="ggg" data-striped="true" data-smart-display="true">
						<thead class="text-center">
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">商品编号</th>
								<th class="text-center">商品名称</th>
								<th class="text-center">商品属性</th>
								<th class="text-center">所属仓库</th>
								<th class="text-center">所属门店</th>
								<th class="text-center">盘点数量</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody id="checkstorageGoods_All">
							<c:forEach items="${checkstorageGoodsVOList}" var="checkstorageGoodsVO" varStatus="i">
								<tr>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="checkstorageGoods_id" value="${checkstorageGoodsVO.id}" >
									</td>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="checkstorage_id" value="${checkstorageGoodsVO.checkstorageId}" >
									</td>
									<td class="text-center" style="display: none;">
										<input type="hidden" id="checkstorage_goods_id" value="${checkstorageGoodsVO.goodsId}" >
									</td>
									<td class="text-center" id="checkstorageGoods_number">${i.index + 1 }</td>
									<td class="text-center" id="checkstorageGoods_goods_goodsCode">${checkstorageGoodsVO.goodsCode }</td>
									<td class="text-center" id="checkstorageGoods_goods_name">${checkstorageGoodsVO.goodsName }</td>
									<td class="text-center" id="checkstorageGoods_goods_other_attr_value">${checkstorageGoodsVO.other_attr_value}</td>
									<td class="text-center" id="checkstorageGoods_storage_name">${checkstorageGoodsVO.storageName}</td>
									<td class="text-center" id="checkstorageGoods_store_name">${checkstorageGoodsVO.storeName}</td>
									<td class="text-center" style="width: 10%">
										<c:if test="${'2' eq checkstorageGoodsVO.state}">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" 
															name="model.checkstorageGoodsVOList[${i.index }].checkNumber"
															id="checkstorage_checkNumber" value="" 
															required data-bv-notempty-message="数量不能为空"
															pattern="^(([1-9][0-9]{0,7})|0)$" 
															data-bv-regexp-message="数量格式不正确，参考格式：168">
												</div>
											</div>
										</c:if>
										<c:if test="${'1' eq checkstorageGoodsVO.state}">
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="col-xs-12">
													<input type="text" class="form-control" 
															name="model.checkstorageGoodsVOList[${i.index }].checkNumber"
															id="checkstorage_checkNumber" disabled="disabled" value="${checkstorageGoodsVO.checkNumber}" 
															required data-bv-notempty-message="数量不能为空"
															pattern="^(([1-9][0-9]{0,7})|0)$" 
															data-bv-regexp-message="数量格式不正确，参考格式：168">
												</div>
											</div>
										</c:if>
									</td>
									<td class="text-center">
										<div class="col-xs-12">
											<c:if test="${'2' eq checkstorageGoodsVO.state}">
												<input type="button" value="对比" class="btn btn-primary btn-xs" onclick="doCheckstorage(this)" />
												<input type="button" value="删除" class="btn btn-danger btn-xs checkstorageGoods_goods_one_delete_button"/>
											</c:if>
											<c:if test="${'1' eq checkstorageGoodsVO.state}">
												<input type="button" disabled="disabled" value="对比" class="btn btn-primary btn-xs" onclick="doCheckstorage(this)" />
												<input type="button" disabled="disabled" value="删除" class="btn btn-danger btn-xs checkstorageGoods_goods_one_delete_button"/>
											</c:if>
										</div>
									</td>
								</tr>
							</c:forEach>
							<tr id="checkstorageGoods_goods_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="checkstorageGoods_id">
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="checkstorage_id">
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="checkstorage_goods_id">
								</td>
								<td class="text-center" id="checkstorageGoods_number"></td>
								<td class="text-center" id="checkstorageGoods_goods_goodsCode"></td>
								<td class="text-center" id="checkstorageGoods_goods_name"></td>
								<td class="text-center" id="checkstorageGoods_goods_other_attr_value"></td>
								<td class="text-center" id="checkstorageGoods_storage_name"></td>
								<td class="text-center" id="checkstorageGoods_store_name"></td>
								<td class="text-center"  style="width: 10%">
									<div class="form-group" style="margin-bottom: 0px;">
										<div class="col-xs-12">
											<input type="text" class="form-control" id="checkstorage_checkNumber" value="" 
													required data-bv-notempty-message="数量不能为空"
													pattern="^(([1-9][0-9]{0,7})|0)$" 
													data-bv-regexp-message="数量格式不正确，参考格式：168">
										</div>
									</div>
								</td>
								<td class="text-center">
									<div class="col-xs-12">
										<input type="button" value="对比" class="btn btn-primary btn-xs" onclick="doCheckstorage(this)" />
										<input type="button" value="删除" class="btn btn-danger btn-xs checkstorageGoods_goods_one_delete_button"/>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="form-group col-xs-8 pull-right">
					<button id="ert" type="button" class="btn btn-primary" onclick="submitCheckstorage();">提交</button>
					<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
				</div>
			</form>
		</div>
	</div>
	<input type="hidden" id="qrcodeGoods_delete_copy" value="" name="">
	<div id="embed_div"></div>
	
	<!-- 新增弹框 -->
	<div id="checkstorage_add_list" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">盘点商品</h4>
				</div>
				<div class="modal-body row">
					<form class="form-horizontal" id="testForm_save_checkstorage"
							role="form" onsubmit="return false;">
						<input type="hidden">
						<div class="form-group">
							<label for="device-description" class="col-xs-2 control-label">选择商品:</label>
							<div class="col-xs-4">
								<select class="form-control" id="goods_parent_id" onchange="goods_parent_change(this)">
									<option value="" selected="selected">请选择盘点商品</option>
									<c:forEach items="${storageGoodsList}" var="storageGoods">
										<option value="${storageGoods.goods.id}" childrenSize="${storageGoods.goods.goodsChildList.size() }">${storageGoods.goods_name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-xs-4">
								<select class="form-control" id="goods_children_id" disabled="disabled" onchange="goods_children_change(this);">
									<option value="" selected="selected">选择商品</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="ert" class="col-xs-2 control-label"></label>
							<div class="col-xs-8">
								<input id="ert" type="button" onclick="goAddGoods(this)" class="btn btn-primary btn-block" value="添加商品">
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
	var goods_number_test = /^([1-9]{0,32}[0-9]{1}|0)$/;
	var qrcode_goods_new_index = 0 , qrcode_goods_number_index = ("${qrcodeVOList.size()}" - 0) + 1 ;
	var goods_new_index = 0 , goods_number_index = ("${qrcodeGoodsList.size()}" - 0) + 1 ;

		/**
		 * 添加产品弹出框确认添加的回调
		 */
		function goAddGoods(this_){
			var isNeedAdd = true;
			var goods_id_value = $(this_).parent().parent().parent().find(":input[type=hidden]").val().trim();
			if("" == goods_id_value){
				toastr.error("亲~请先选择一个产品哦~");
				return;
			} else {
				// 添加产品节点
				$("#checkstorageGoods_All tr:not(:hidden)").each(function(){
					if($(this).find("input:eq(2)").val().trim() == goods_id_value){
						isNeedAdd = false;
						return;
					}
				})
				if(!isNeedAdd){
					toastr.error("此商品已经在列表了哦~换一个添加吧~");
					return false;
				}
				if(isNeedAdd){
					add_pro_goods_tr(goods_id_value, 1);
					$("#checkstorage_add_list").modal("hide");
					$(this_).parent().parent().parent().find(":input[type=hidden]").val("");
				}
			}
		}

		/**
		 * 添加采购产品（采购退货产品）到产品table中
		 * @param ownerId 产品ID或二维码ID
		 * @param ownerType ID类型1：产品ID，2：二维码ID
		 */
		function add_pro_goods_tr(ownerId,ownerType){
			var ajax_url = "";
				ajax_url = "${path}/checkstorage/saveCheckstorageGoodsByGoodsId?goodsId=" + ownerId+"&checkstorageId=${checkstorageId}";
			$.ajax({
				url : ajax_url,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						// 获取成功，拼接页面节点
						var checkstorageGoods_goods_one = $("#checkstorageGoods_goods_tr_copy").clone();

						checkstorageGoods_goods_one.find("#checkstorageGoods_id").val(data.obj.id);
						checkstorageGoods_goods_one.find("#checkstorageGoods_id").attr("name","checkstorageGoodsList[" + qrcode_goods_new_index + "].id");

						checkstorageGoods_goods_one.find("#checkstorage_id").val(data.obj.checkstorageId);
						checkstorageGoods_goods_one.find("#checkstorage_id").attr("name","checkstorageGoodsList[" + qrcode_goods_new_index + "].checkstorageId");
						
						checkstorageGoods_goods_one.find("#checkstorage_goods_id").val(data.obj.goodsId);
						checkstorageGoods_goods_one.find("#checkstorage_goods_id").attr("name","checkstorageGoodsList[" + qrcode_goods_new_index + "].goods.id");

						checkstorageGoods_goods_one.find("#checkstorageGoods_number").html(qrcode_goods_number_index);

						checkstorageGoods_goods_one.find("#checkstorageGoods_goods_goodsCode").html(data.obj.goodsCode);

						checkstorageGoods_goods_one.find("#checkstorageGoods_goods_name").html(data.obj.goodsName);

						checkstorageGoods_goods_one.find("#checkstorageGoods_goods_other_attr_value").html(data.obj.other_attr_value);

						checkstorageGoods_goods_one.find("#checkstorageGoods_storage_name").html(data.obj.storageName);

						checkstorageGoods_goods_one.find("#checkstorageGoods_store_name").html(data.obj.storeName);

						checkstorageGoods_goods_one.find("#checkstorage_checkNumber").attr("name","checkstorageGoodsList[" + qrcode_goods_new_index + "].checkNumber");
						checkstorageGoods_goods_one.removeAttr("id");
						qrcode_goods_new_index++;
						qrcode_goods_number_index++;
						$("#checkstorageGoods_All").append(checkstorageGoods_goods_one.show());
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
		var isDelete=true;
		var qrcode_goods_number_index_tmp = 0;
		/**
		 * 删除按钮--监听
		 */
		$(document).off('click', '.checkstorageGoods_goods_one_delete_button').on('click', '.checkstorageGoods_goods_one_delete_button', function(){
			var this_=$(this);
			var qrcode_goods_number_index_tmp = 1;
			var checkstorageGoods_id_delete = $(this).parent().parent().parent().find("input:eq(0)").val();
			var checkstorage_id_delete = $(this).parent().parent().parent().find("input:eq(1)").val();
			var checkstorage_goods_id_delete = $(this).parent().parent().parent().find("input:eq(2)").val();
			if(isDelete){
				isDelete=false;
				$.ajax({
					url : "${path}/checkstorage/doDelete?checkstorageGoodsId="+checkstorageGoods_id_delete,
					data : null,
					type : "POST",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							isDelete=true;
							deleteTr(this_);
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
							isDelete=true;
						}
					},
					error : function(xhr, type, exception) {
						isDelete=true;
						toastr.error("请检查网络设置");
					}
				});
			}
		});
		
		function deleteTr(this_){
			if(isDelete){
				isDelete=false;
				this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
				$("#checkstorageGoods_All tr").each(function(){
					if(!$(this).is(":hidden")){
						$(this).find("#qrcode_number").html(qrcode_goods_number_index_tmp);
						qrcode_goods_number_index_tmp++;
					}
				})
				qrcode_goods_number_index--;
				isDelete=true;
			}
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
		
		function toAdd() {
			$('#testForm_save_checkstorage')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#testForm_save_checkstorage').bootstrapValidator('resetForm', true);
			$("#checkstorage_add_list").modal("show");
		}
		
		/**
		 * 主产品下拉框值改变的回调
		 */
		function goods_parent_change(this_){
			var goods_parent_id_value = $(this_).val().trim();
			if("" == goods_parent_id_value){
				$(this_).parent().parent().parent().find(":input[type=hidden]").val("");
				$("#goods_children_id").val("").attr("disabled","disabled");
			} else {
				if(0 < ($(this_).find("option:selected").attr("childrenSize") - 0)){
					var option_list = "<option value='' selected='selected'>请选择产品</option>";
					$.ajax({
						url : "${path}/goods/getGoodsChildListByInventoryGoodsId?id="+goods_parent_id_value+"&storageId=${storageId}",
						data : null,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								for(var i = 0; i < data.obj.length; i++){ 
									option_list += "<option value='" + data.obj[i].id + "'>" + data.obj[i].other_attr_value + "</option>";
								}
								$("#goods_children_id").html(option_list).val("").removeAttr("disabled");
							} else {
								setEmbed();
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception){
							setEmbed();
							toastr.error("请检查网络设置");
						}
					});
				} else {
					$("#goods_children_id").val("").attr("disabled","disabled");
					$(this_).parent().parent().parent().find(":input[type=hidden]").val(goods_parent_id_value);
				}
			}
		}
		/**
		 * 子产品下拉框值改变的回调
		 */
		function goods_children_change(this_){
			var goods_children_id_value = $(this_).val().trim();
			if("" != goods_children_id_value){
				$(this_).parent().parent().parent().find(":input[type=hidden]").val(goods_children_id_value);
			}
		}
		
		function doCheckstorage(this_){
			var checkNumber = $(this_).parent().parent().parent().find("input:eq(3)").val().trim();
			if("" == checkNumber){
				$(this_).parent().parent().parent().find("input:eq(3)").focus();
				toastr.error("请先输入盘点数量~");
				return false;
			}
			if(goods_number_test.test(checkNumber)){
				var checkstorageGoodsId = $(this_).parent().parent().parent().find("input:eq(0)").val().trim();
				$.ajax({
					url : "${path}/checkstorage/doCheckstorage?checkstorageGoodsId=" + checkstorageGoodsId
								+ "&checkNumber=" + checkNumber,
					data : null,
					type : "POST",
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$(this_).parent().parent().parent().find("input").attr("disabled","disabled");
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
						}
					},
					error : function(xhr, type, exception) {
						alert("请检查网络设置");
					}
				});
			}else{
				$(this_).parent().parent().parent().find("input:eq(3)").focus().val("");
				toastr.error("请输入正确的数字（参考格式：168）~");
				return false;
			}
		}
	</script>
</body>
</html>
