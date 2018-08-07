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
					$.ajax({
						url : "${path}/procurement/submitProcurement?procurementId=${procurementId}",
						type : "POST",
						dataType : "json",
						success : function(data) {
							$('#submitModal').modal('hide');
							if (data.success) {
								toastr.success('提交退货单成功！');
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
	function save(){
		if ($('#theForm').data('bootstrapValidator').validate().isValid()) {
			<c:if test="${'1' eq model.state}">
				if("" == $("#checkRemark").val().trim() && "5" == $("#check_select").val().trim()){
					toastr.error("请填写不通过原因~");
					$("#checkRemark").focus();
					return false;
				}
			</c:if>
			$('#submitModal').modal('show');
			$("#submitButton").unbind("click").click(function() {
				var formData = $("#theForm").serialize();
				$.ajax({
					url : "${path}/procurement/returnSaveOrUpdate",
					data : formData,
					type : "POST",
					dataType : "json",
					success : function(data) {
						$('#submitModal').modal('hide');
						if (data.success) {
							toastr.success('审核完成！');
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
				<c:if test="${'7' eq model.state}">
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
				</c:if>
				<c:if test="${'5' eq model.state}">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">审核未通过</label>
					</div>
					<label for="device-description" style="color: red;float: left;margin-right: 6px;" class=" control-label" >原因 :</label>
					<div class="col-xs-8">
						<div class="form-group" style="padding-top:7px;">
							${model.checkRemark }
						</div>
					</div>
				</c:if>
				<c:if test="${'5' eq model.state}">
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
				</c:if>
				<c:if test="${'1' eq model.state}">
					<input type="hidden" name="model.id" value="${model.id}" />
					<input type="hidden" name="model.user.id" value="${user.id}" />
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
						<div class="col-xs-3" style="padding-top:7px;" id="store_code_div">${model.store.storeCode }</div>
					</div>
	
					<div class="form-group">
						<label for="device-description" class="col-xs-2 control-label">审核结果</label>
						<div class="col-xs-3">
							<select id="check_select" name="model.state" class="form-control" required data-bv-notempty-message="请选择审核结果">
								<option value="" selected="selected">请选择审核结果</option>
								<option value="5">不通过</option>
								<c:if test="${'1' eq model.type }">
									<option value="2">通过</option>
								</c:if>
								<c:if test="${'2' eq model.type }">
									<option value="3">通过</option>
								</c:if>
							</select>
						</div>
	
						<label for="device-description" class="col-xs-2 control-label">原因</label>
						<div class="col-xs-3">
							<input type="text" value="" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="checkRemark" name="model.checkRemark"/>
						</div>
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
						<label for="product-uuid" class="col-xs-2 control-label">件数总计</label>
						<div class="col-xs-3" style="padding-top: 7px;" >${model.buyCount }</div>
	
						<label for="product-uuid" class="col-xs-2 control-label">金额总计</label>
						<div class="col-xs-3" style="padding-top:7px;" >${model.buySumMoney }元</div>
					</div>
				</c:if>
				
				<div class="form-group">
					<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">退货商品</label>
				</div>

				<div class="panel panel-default" id="all-device-detail">
					<div class="panel-heading">
						<h5>采购退货</h5>
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
								<c:if test="${'7' eq model.state}">
									<th class="text-center">操作</th>
								</c:if>
								<c:if test="${'5' eq model.state}">
									<th class="text-center">操作</th>
								</c:if>
							</tr>
						</thead>
						<tbody id="qrcodeGoods_All">
							<c:forEach items="${qrcodeVOList}" var="qrcodeVO" varStatus="i">
								<tr>
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
									<c:if test="${'7' eq model.state}">
										<td class="text-center">
											<div class="col-xs-12" >
												<input type="button" value="删除" onclick="deleteThis(this)" class="btn btn-danger btn-xs qrcode_goods_one_delete_button"/>
											</div>
										</td>
									</c:if>
									<c:if test="${'5' eq model.state}">
										<td class="text-center">
											<div class="col-xs-12" >
												<input type="button" value="删除" onclick="deleteThis(this)" class="btn btn-danger btn-xs qrcode_goods_one_delete_button"/>
											</div>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<tr id="qrcode_goods_tr_copy" style="display: none">
								<td class="text-center" style="display: none;">
									<input type="hidden" id="qrcode_id" >
								</td>
								<td class="text-center" style="display: none;">
									<input type="hidden" id="procurementQrcode_id" >
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
								<td class="text-center">
									<div class="col-xs-12" >
										<input type="button" value="删除" onclick="deleteThis(this)" class="btn btn-danger btn-xs qrcode_goods_one_delete_button"/>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<c:if test="${'1' eq model.state}">
					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="button" class="btn btn-primary" onclick="save();">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</c:if>
				<c:if test="${'7' eq model.state}">
					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="button" class="btn btn-primary" onclick="submitAllocation();">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</c:if>
				<c:if test="${'5' eq model.state}">
					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="button" class="btn btn-primary" onclick="submitAllocation();">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</c:if>
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
				ajax_url = "${path}/qrcode/getQrcodeByQrcodeIdForProcurement?QrcodeID=" + ownerId+"&storeId=${storeId}&procurementId=${procurementId}";
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
						qrcode_goods_one.find("#qrcode_id").attr("name","procurementQrcodeIdList[" + qrcode_goods_new_index + "].id");

						qrcode_goods_one.find("#procurementQrcode_id").val(data.obj.procurementQrcodeId);
						qrcode_goods_one.find("#procurementQrcode_id").attr("name","procurementQrcodeIdList[" + qrcode_goods_new_index + "].procurementQrcodeId");
						
						qrcode_goods_one.find("#qrcode_goods_id").val(data.obj.goodsId);
						qrcode_goods_one.find("#qrcode_goods_id").attr("name","procurementQrcodeIdList[" + qrcode_goods_new_index + "].goods.id");

						qrcode_goods_one.find("#qrcode_number").html(qrcode_goods_number_index);

						qrcode_goods_one.find("#qrcode_goods_goodsCode").html(data.obj.goodsCode);

						qrcode_goods_one.find("#qrcode_goods_name").html(data.obj.goodsName);

						qrcode_goods_one.find("#qrcode_goods_other_attr_value").html(data.obj.other_attr_value);

						qrcode_goods_one.find("#qrcode_storage_name").html(data.obj.storageName);

						qrcode_goods_one.find("#qrcode_procurementPrice").html(data.obj.procurementPrice);

						qrcode_goods_one.removeAttr("id");
						qrcode_goods_new_index++;
						qrcode_goods_number_index++;
						$("#qrcodeGoods_All").append(qrcode_goods_one.show());
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
		var isSuccess = true;
		function deleteThis(this_){
			var this_=$(this_);
			var qrcode_goods_number_index_tmp = 1;
			var procurementQrcode_id_delete = $(this_).parent().parent().parent().find("input:eq(1)").val()
			var qrcode_id_delete = $(this_).parent().parent().parent().find("input:eq(0)").val()
			var goods_id_delete = $(this_).parent().parent().parent().find("input:eq(2)").val()
			if(isSuccess){
				isSuccess = false;
				$.ajax({
					url : "${path}/procurement/returnDoDelete?procurementQrcodeId="+procurementQrcode_id_delete+"&qrcodeId="+qrcode_id_delete,
					data : null,
					type : "POST",
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.success) {
							isSuccess = true;
							deleteTr(this_);
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
							isSuccess = true;
						}
					},
					error : function(xhr, type, exception) {
						isSuccess = true;
						alert("请检查网络设置");
					}
				});
			}
		};
		
		function deleteTr(this_){
			this_.parent().parent().parent().hide().find("input").val("").attr("disabled","disabled");
			$("#qrcodeGoods_All tr").each(function(){
				if(!$(this).is(":hidden")){
					$(this).find("#qrcode_number").html(qrcode_goods_number_index_tmp);
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
		
	</script>
</body>
</html>
