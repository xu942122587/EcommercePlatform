<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.qrcode.input");
	com.yunt.qrcode.input = {
		select : function() {
			var proCode_value = $("#proCode_input").val().trim();
			if(/[0-9]{10,50}$/.test(proCode_value)){
				com.yunt.index.loadOnly("${path}/qrcode/input?proCode=" + proCode_value);
			} else {
				toastr.error("请输入有效的采购单ID~");
				$("#proCode_input").focus();
				delEmbed();
				setEmbed();
			}
		},
		goPrintQrcode : function(proGoodsId){
			//能清除所有数据，无法清除验证错误提示，不能清除掉type为hidden类型的input的数据
			$('#theFormPrintQrcode')[0].reset();
			//只能清除验证，无法清除不带验证input标签的数据
			$('#theFormPrintQrcode').bootstrapValidator('resetForm', true);
			$("#theFormPrintQrcode #pro_id_input_hidden").val(proGoodsId);
			$("#printQrcodeModal").modal("show");
		},
		doPrintQrcode : function(){
			if($('#theFormPrintQrcode').data('bootstrapValidator').validate().isValid()){
				var formData = $("#theFormPrintQrcode").serialize();
				if(isSuccess){
					$.ajax({
						url : "${path}/qrcode/saveOrUpdate",
						data : formData,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;
								$('#theFormPrintQrcode')[0].reset();
								$('#printQrcodeModal').modal('hide');
								toastr.success(data.msg);
								setTimeout(function(){
									window.open('${path }/qrcode/printQRCode?qrcodeBatch=' + data.obj,'_target');
									com.yunt.qrcode.input.select();
								},1000);
							} else {
								toastr.error(data.msg);
								console.log(data.msg);
								delEmbed();
								setEmbed();
							}
						},
						error : function(xhr, type, exception) {
							toastr.error("请检查网络设置");
							delEmbed();
							setEmbed();
						}
					});
				}
			}
		}
	};
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return false;"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">打印二维码</label>
					</div>

					<div class="form-group">
						<label for="device-description" class="col-xs-2 control-label">采购单号</label>
						<div class="col-xs-3">
							<input type="text" step="1" value="${proCode }" class="form-control" onkeydown="if(event.keyCode==32) return false;" id="proCode_input" />
						</div>
						<div class="col-xs-1">
							<button type="button" class="btn btn-default" onclick="com.yunt.qrcode.input.select()">查询</button>
						</div>
					</div>

					<c:if test="${not empty model.id && '6' eq model.state}">
						<c:set value="no" var="is_disabled"/>
						<table class="table table-striped table-hover table-bordered text-center" id="ggg" data-striped="true" data-smart-display="true">
							<thead class="text-center">
								<tr>
									<th class="text-center" width="10%">产品编号</th>
									<th class="text-center" width="10%">产品名称</th>
									<th class="text-center" width="10%">所属品牌</th>
									<th class="text-center" width="10%">所属门店</th>
									<th class="text-center" width="10%">所属类别</th>
									<th class="text-center" width="10%">单位</th>
									<th class="text-center" width="10%">采购到货数量</th>
									<th class="text-center" width="10%">已印刷数量</th>
									<th class="text-center" width="10%">印刷人</th>
									<th class="text-center" width="7%">操作</th>
								</tr>
							</thead>
							<tbody id="proGoods_All">
								<c:forEach items="${model.procurementGoodsList }" var="proGoods_" varStatus="i">
									<tr>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goodsCode }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.goodsCode }
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.other_attr_value }">
												${proGoods_.goods.other_attr_value }
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.brand.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.brand.name }
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.store.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.store.name }
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.classification.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.classification.name }
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${empty proGoods_.goods.goods.id }">
												${proGoods_.goods.specification.name }
											</c:if>
											<c:if test="${not empty proGoods_.goods.goods.id }">
												${proGoods_.goods.goods.specification.name }
											</c:if>
										</td>
										<td class="text-center">${proGoods_.buyCount }</td>
										<td class="text-center">${proGoods_.printCount}</td>
										<td class="text-center">${proGoods_.printUser_String}</td>
										<td class="text-center">
											<c:if test="${'yes' eq is_disabled }">
												<input type="button" value="印刷" disabled="disabled" class="btn btn-danger btn-xs pro_goods_one_delete_button"/>
											</c:if>
											<c:if test="${'no' eq is_disabled }">
												<c:if test="${'yes' eq proGoods_.isNeedPrint }">
													<c:set value="yes" var="is_disabled"/>
													<input type="button" value="印刷" onclick="com.yunt.qrcode.input.goPrintQrcode('${proGoods_.id }');" class="btn btn-danger btn-xs "/>
												</c:if>
												<c:if test="${'no' eq proGoods_.isNeedPrint }">
													<input type="button" value="印刷" disabled="disabled" class="btn btn-danger btn-xs "/>
												</c:if>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 弹出框 -->
	<div id="printQrcodeModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">印刷</h4>
				</div>
				<div class="modal-body row">
					<form onsubmit="return false;" class="form-horizontal"  id="theFormPrintQrcode" role="form" method="post"  >
						<input type="hidden" name="procurementGoodsId" id="pro_id_input_hidden">
						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">打印数量</label>
							<div class="col-xs-4">
								<input type="text" name="number" class="form-control" placeholder="打印数量">
							</div>
						</div>

						<div class="form-group">
							<label for="device-description" class="col-xs-4 control-label">仓库</label>
							<div class="col-xs-4">
								<select class="form-control" name="storageId">
									<option value="" selected="selected">请选择仓库</option>
									<c:forEach var="storage" items="${storageList }">
										<option value="${storage.id }">${storage.name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
	
						<div class="form-group">
							<label for="ert" class="col-xs-4 control-label"></label>
							<div class="col-xs-6">
								<input id="ert" type="button" onclick="com.yunt.qrcode.input.doPrintQrcode();" class="btn btn-primary btn-block" value="提交">
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
		$('#theFormPrintQrcode').bootstrapValidator({
			message: '此值无效',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				'number': {
					message: '打印数量无效',
					validators: {
						notEmpty: {
							message: '打印数量不可为空！'
						},
						regexp: {
							regexp: "^([1-9]{1}[0-9]{0,7})$",
							message: '打印数量格式有误,参考格式18'
						}
					}
				},
				'storageId': {
					message: '仓库无效',
					validators: {
						notEmpty: {
							message: '请选择仓库！'
						}
					}
				}
			}
		});
		<c:if test="${not empty proCode }">
			<c:if test="${empty model.id }">
				toastr.error("无此订单~");
				delEmbed();
				setEmbed();
			</c:if>
			<c:if test="${not empty model.id }">
				<c:if test="${'1' eq model.type }">
					<c:if test="${'4' eq model.state }">
						toastr.error("本采购单已全部打印完成，补印请去二维码列表执行~");
						delEmbed();
						setEmbed();
					</c:if>
					<c:if test="${'4' ne model.state && '6' ne model.state}">
						toastr.error("采购单暂未进入可打印阶段（可能原因：未审核、审核未通过或采购商品暂时未到货）~");
						delEmbed();
						setEmbed();
					</c:if>
				</c:if>
				<c:if test="${'2' eq model.type }">
					toastr.error("退货单不可打印哦~");
					delEmbed();
					setEmbed();
				</c:if>
			</c:if>
		</c:if>
	</script>
</body>
</html>
