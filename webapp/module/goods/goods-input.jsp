<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.goods.add");
	com.yunt.goods.add = {
		submitGoods : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if(!$.hz.swfupload.validateAttachment("fileDiv", false)){
					$("#ert").removeAttr("disabled");
					return false;
				}
				if("disabled" ==$("#two_classification").attr("disabled")){
					$("#model_classification_id").val($("#one_classification").val().trim());
				}else if("disabled" ==$("#three_classification").attr("disabled")){
					$("#model_classification_id").val($("#two_classification").val().trim());
				}else{
					$("#model_classification_id").val($("#three_classification").val().trim());
				}
				var warningUp = $("#warningUp").val().trim() - 0;
				var warningDown = $("#warningDown").val().trim() - 0;
				if(warningDown > warningUp){
					toastr.error("库存预警上限需大于下限!");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					isSuccess = false;
					$.ajax({
						url : "${path}/goods/saveOrUpdate",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								if('${inputKind}' == "update"){
									toastr.success(data.msg);
								}else{
									toastr.success(data.msg);
								}
								com.yunt.index.toPreIndex();
							} else {
								isSuccess = true;
								toastr.error(data.msg);
							}
						},
						error : function(xhr, type, exception) {
							isSuccess = true;
							alert("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
	function selectClassification(this_){
		var isEmptyAttr_string = $(this_).find("option:selected").attr("isEmptyAttr");
		if( "true" == isEmptyAttr_string){
			$("#input_childGoods").html("");
		}else{
			var Classification_id = $(this_).val();
			$("#input_childGoods").load(
					"${path}/classification/goodsChild?id="+Classification_id+"&goodsId=${model.id}");
		}
	}
	
	function getTwoClassification(this_){
		var classification_id = $(this_).val().trim() ,nextClass_index = $(this_).attr("nextClass_index") - 0;
		if("" == classification_id){
			if(2 == nextClass_index){
				$("#two_classification").html("<option value='' selected='selected'>请选择二级分类</option>").val("");
				$('#theForm').bootstrapValidator('resetForm', false);
				$('#theForm').bootstrapValidator(); 
			} else if(3 == nextClass_index){
				$("#three_classification").html("<option value='' selected='selected'>请选择三级分类</option>").val("");
				$('#theForm').bootstrapValidator('resetForm', false);
				$('#theForm').bootstrapValidator(); 
			}
			return;
		}
		$.ajax({
			url : "${path}/classification/getTwoClassification?classificationId=" + classification_id,
			data : null,
			type : "POST",
			dataType : "json",
			success : function(data) {
				if (data.success) {
					var twoClassificationArray = eval(data.msg);
					if(0 < twoClassificationArray.length){
						var twoClassification_tring = "";
						for(var i = 0; i < twoClassificationArray.length; i++){
							var value_String = twoClassificationArray[i].name,
								id_String = twoClassificationArray[i].id,
								isEmptyAttr = ("" == twoClassificationArray[i].otherAttrJson);
									
							twoClassification_tring += "<option value='" + id_String + "' isEmptyAttr= "+isEmptyAttr +">" + value_String + "</option>";
						}
						if(2 == nextClass_index){
							$("#two_classification").html(
									"<option value='' selected='selected'>请选择二级分类</option>"
									+ twoClassification_tring
							).val("");
							$("#two_classification").removeAttr("disabled");
							$("#three_classification").removeAttr("disabled");
							$('#theForm').bootstrapValidator('resetForm', false);
							$('#theForm').bootstrapValidator();
						} else if(3 == nextClass_index){
							$("#three_classification").html(
									"<option value='' selected='selected'>请选择三级分类</option>"
									+ twoClassification_tring
							).val("");
							$("#three_classification").removeAttr("disabled");
							$('#theForm').bootstrapValidator('resetForm', false);
							$('#theForm').bootstrapValidator();
						}
						bootstrapValidator_again();
						/* $("#two_classification").html(
								"<option value='' selected='selected'>请选择二级分类</option>"
								+ twoClassification_tring
						).val("");
						$("#two_classification").removeAttr("disabled");
						$('#theForm').bootstrapValidator('resetForm', false);
						$('#theForm').bootstrapValidator(); */
					}else{
						if(2 == nextClass_index){
							$("#two_classification").html("<option value='' selected='selected'>请选择二级分类</option>").val("");
							$("#two_classification").attr("disabled","disabled");
							$("#three_classification").html("<option value='' selected='selected'>请选择三级分类</option>").val("");
							$("#three_classification").attr("disabled","disabled");
							selectClassification(this_);
						} else if(3 == nextClass_index){
							$("#three_classification").html("<option value='' selected='selected'>请选择三级分类</option>").val("");
							$("#three_classification").attr("disabled","disabled");
							selectClassification(this_);
						}
						bootstrapValidator_again();
						/* $("#two_classification").html("<option value='' selected='selected'>请选择二级分类</option>").val("");
						$("#two_classification").attr("disabled","disabled");
						selectClassification(this_); */
					}
				} else {
					toastr.error('拉取分类出错，请重试或联系管理员！');
				}
			},
			error : function(xhr, type, exception) {
				alert("请检查网络设置");
			}
		});
	}
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.goods.add.submitGoods()"
					class="form-horizontal" id="theForm" role="form" method="POST"
					data-bv-message="This value is not valid"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">基本信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">商品名称</label>
						<div class="col-xs-4">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.name"
									required data-bv-notempty-message="商品名称不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$" 
									data-bv-regexp-message="商品名称格式不正确"
									>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">商品编号</label>
						<div class="col-xs-3">
							<c:if test="${not empty model.id }">
								<input type="text" value="${model.goodsCode }"
										onkeydown="if(event.keyCode==32) return false;"
										pattern="^-?[a-zA-Z0-9]{1,30}$" 
										data-bv-regexp-message="商品编号格式不正确"
										class="form-control" id="goodsCode" name="model.goodsCode" required
										data-bv-notempty-message="商品编号不能为空"
										data-bv-remote="true"
										data-bv-remote-url="${path}/goods/validateGoodsIsExist?goodsId=${model.id}"
										data-bv-remote-message="商品编号已经存在">
							</c:if>
							<c:if test="${empty model.id }">
								<input type="text" value="${model.goodsCode }"
										onkeydown="if(event.keyCode==32) return false;"
										pattern="^-?[a-zA-Z0-9]{1,30}$" 
										data-bv-regexp-message="商品编号格式不正确"
										class="form-control" id="goodsCode" name="model.goodsCode" required
										data-bv-notempty-message="商品编号不能为空"
										data-bv-remote="true"
										data-bv-remote-url="${path}/goods/isGoodsExist" 
										data-bv-remote-message="商品编号已经存在">
							</c:if>
						</div>
					</div>

					<div class="form-group">
						<input type="hidden" id = "model_classification_id" name="model.classification.id"  />
						<label for="product-uuid" class="col-xs-2 control-label">所属类别</label>
						<div class="col-xs-3">
							<select class="form-control" id="one_classification" nextClass_index="2" name="one_classification"
							 onchange="getTwoClassification(this)" 
								required
								data-bv-notempty-message="一级不能为空">
								<option value="" <c:if test="${empty model.classification.parentClassification.id }">selected="selected"</c:if>>请选择一级分类</option>
								<c:forEach items="${classificationList}" var="classification" varStatus="i">
									<option value="${classification.id}" isEmptyAttr="${empty classification.otherAttrJson }" <c:if test="${model.classification.parentClassification.parentClassification.id eq classification.id ||model.classification.parentClassification.id eq classification.id || model.classification.id eq classification.id}">selected="selected"</c:if>>${classification.name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="col-xs-3">
							<select class="form-control" id="two_classification" nextClass_index="3" name="two_classification" onchange="getTwoClassification(this)" 
								required
								data-bv-notempty-message="二级不能为空">
								<option value="" <c:if test="${empty model.classification.id }">selected="selected"</c:if>>请选择二级分类</option>
								<c:forEach items="${twoClassificationList}" var="twoClassification" varStatus="i">
									<option value="${twoClassification.id}" isEmptyAttr="${empty twoClassification.otherAttrJson }" <c:if test="${model.classification.parentClassification.id eq twoClassification.id || model.classification.id eq twoClassification.id}">selected="selected"</c:if>>${twoClassification.name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="col-xs-3">
							<select class="form-control" id="three_classification" name="three_classification" onchange="selectClassification(this)" 
								required
								data-bv-notempty-message="三级不能为空">
								<option value="" <c:if test="${empty model.classification.id }">selected="selected"</c:if>>请选择三级分类</option>
								<c:forEach items="${threeClassificationList}" var="threeClassification" varStatus="i">
									<option value="${threeClassification.id}" isEmptyAttr="${empty threeClassification.otherAttrJson }" <c:if test="${model.classification.id eq threeClassification.id }">selected="selected"</c:if>>${threeClassification.name}</option>
								</c:forEach>
							</select>
						</div>
						
					</div>

					<div class="form-group">
						<c:if test="${empty model.store.id}">
							<label for="product-uuid" class="col-xs-2 control-label">所属门店</label>
							<div class="col-xs-2" <c:if test="${not empty user.store.id}">style="padding-top: 7px;"</c:if>>
								<c:if test="${empty user.store.id}">
									<select class="form-control" name="model.store.id" 
										required
										data-bv-notempty-message="所属门店不能为空"
										>
										<option value="" <c:if test="${empty model.store.id }">selected="selected"</c:if>>请选择所属门店</option>
										<c:forEach items="${storeList}" var="store" varStatus="i">
											<option value="${store.id}" <c:if test="${model.store.id eq store.id }">selected="selected"</c:if>>${store.name}</option>
										</c:forEach>
									</select>
								</c:if>
								<c:if test="${not empty user.store.id}">
									<input type="hidden" name="model.store.id" value="${user.store.id }" class="form-control" />
									${user.store.name }
								</c:if>
							</div>
							<div class="col-xs-2" style="padding-top: 7px;">
								<span style="font-size: 10px;color: red">*商品所属门店保存后不可修改</span>
							</div>
						</c:if>
						
						<c:if test="${not empty model.store.id}">
							<label for="product-uuid" class="col-xs-2 control-label">所属门店</label>
								<div class="col-xs-4" style="padding-top: 7px;">${model.store.name}
							</div>
						</c:if>

						<label for="product-uuid" class="col-xs-2 control-label">上市时间</label>
						<div class="col-xs-3">
							<input type="text" value="${model.marketTime }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="marketTime" name="model.marketTime" required data-bv-notempty-message="上市时间不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$" 
									data-bv-regexp-message="上市时间格式不正确" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">吊牌价</label>
						<div class="col-xs-4">
							<input type="text" value="${model.price }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="address" name="model.price" required data-bv-notempty-message="吊牌价不能为空" 
									pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00)$" 
									data-bv-regexp-message="吊牌价格式不正确，参考格式：18.88"/>
						</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">实际售价</label>
						<div class="col-xs-3">
							<input type="text" value="${model.salesPrice }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="marketTime" name="model.salesPrice" required data-bv-notempty-message="实际售价不能为空"
									pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|([0-9]{1}\.{1}[1-9][0-9]{0,1})|0|0.0|0.00)$" 
									data-bv-regexp-message="实际售价格式不正确，参考格式：18.88" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">库存预警上限</label>
						<div class="col-xs-4">
							<input type="text" value="${model.warningUp }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="warningUp" name="model.warningUp" required data-bv-notempty-message="库存预警上限不能为空"
									pattern="^(([1-9][0-9]{0,7})|0)$" 
									data-bv-regexp-message="库存预警上限格式不正确,请输入正整数" />
						</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">库存预警下限</label>
						<div class="col-xs-3">
							<input type="text" value="${model.warningDown }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="warningDown" name="model.warningDown" required data-bv-notempty-message="库存预警下限不能为空" 
									pattern="^(([1-9][0-9]{0,7})|0)$" 
									data-bv-regexp-message="库存预警下限格式不正确,请输入正整数" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">所用单位</label>
						<div class="col-xs-4">
							<select class="form-control" name="model.specification.id" 
								required
								data-bv-notempty-message="所用单位不能为空"
								>
								<option value="" <c:if test="${empty model.specification.id }">selected="selected"</c:if>>请选择所用单位</option>
								<c:forEach items="${specificationList}" var="specification" varStatus="i">
									<option value="${specification.id}" <c:if test="${model.specification.id eq specification.id }">selected="selected"</c:if>>${specification.name}</option>
								</c:forEach>
							</select>
						</div>
						
						<label for="product-uuid" class="col-xs-2 control-label">所属品牌</label>
						<div class="col-xs-3">
							<select class="form-control" name="model.brand.id" 
								required
								data-bv-notempty-message="所属品牌不能为空"
								>
								<option value="" <c:if test="${empty model.brand.id }">selected="selected"</c:if>>请选择所属品牌</option>
								<c:forEach items="${brandList}" var="brand" varStatus="i">
									<option value="${brand.id}" <c:if test="${model.brand.id eq brand.id }">selected="selected"</c:if>>${brand.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-9">
							<input type="text" value="${model.remark }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.remark"/>
						</div>
					</div>

					<div id="input_childGoods"></div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">图片信息</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">图片上传</label>
						<div class="col-xs-8">
							<div id="fileDiv" style="overflow:hidden"></div>
						</div>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<!-- 新增子商品--待复制节点 -->
	<div class="form-group" id="goodsProperty_div_one_copy" style="display: none;">
		<input type="hidden" value="" id="goodsProperty_id"/>
		<input type="hidden" value="${model.id }" id="goodsProperty_goods_id"/>
		<label for="product-uuid" class="col-xs-2 control-label">名称</label>
		<div class="col-xs-3">
			<input type="text" value="${goodsProperty.name }" class="form-control"
				onkeydown="if(event.keyCode==32) return false;"
				id="name" required data-bv-notempty-message="名称不能为空"
				pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
				data-bv-regexp-message="请输入正确的名称">
		</div>

		<label for="product-uuid" class="col-xs-2 control-label">数量</label>
		<div class="col-xs-3">
			<input type="text" value="${goodsProperty.number }" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="number" required data-bv-notempty-message="数量不能为空"
					pattern="^[0-9]{1,7}[1-9]$"
					data-bv-regexp-message="请输入正确的数量" />
		</div>
		<div class="col-xs-1" style="padding-top: 7px;">
			<input type="button" value="删除" class="btn btn-danger btn-xs goodsProperty_delete_button"/>
		</div>
	</div>

	<input type="hidden" id="goodsProperty_delete_input_copy"/>

	<script type="text/javascript">
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
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.goods.model.Goods,id",required:true});
			</c:if>
			<c:if test="${not empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.goods.model.Goods,id",idOwner:"${model.id}",required:true});
				if($("#one_classification").val().trim() == "${model.classification.id}"){
					$("#three_classification").attr("disabled","disabled");
					$("#two_classification").attr("disabled","disabled");
					bootstrapValidator_again();
				}
				if($("#two_classification").val().trim() == "${model.classification.id}"){
					$("#three_classification").attr("disabled","disabled");
					bootstrapValidator_again();
				}
			</c:if>
			$("#input_childGoods").load(
					"${path}/classification/goodsChild?id=${model.classification.id}&goodsId=${model.id}");
		})
	</script>
</body>
</html>
