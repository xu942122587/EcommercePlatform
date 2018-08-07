<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.store.input");
	com.yunt.store.input = {
		submitStore : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				if(!$.hz.swfupload.validateAttachment("fileDiv", false)){
					$("#ert").removeAttr("disabled");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/store/saveOrUpdate",
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
							toastr.success("请检查网络设置");
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
				<form onsubmit="return com.yunt.store.input.submitStore()"
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
						<label for="product-uuid" class="col-xs-2 control-label">门店名称</label>
						<div class="col-xs-3">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.name" required data-bv-notempty-message="门店名称不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的门店名称">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店编号</label>
						<div class="col-xs-3">
							<c:if test="${not empty model.id }">
								<input type="text" value="${model.storeCode }"
										onkeydown="if(event.keyCode==32) return false;"
										class="form-control" id="storeCode" name="model.storeCode" required
										data-bv-notempty-message="门店编号不能为空"
										data-bv-remote="true"
										data-bv-remote-url="${path}/store/validateStoreIsExist?storeId=${model.id}"
										data-bv-remote-message="门店编号已经存在">
							</c:if>
							<c:if test="${empty model.id }">
								<input type="text" value="${model.storeCode }"
										class="form-control" id="storeCode" name="model.storeCode" 
										onkeydown="if(event.keyCode==32) return false;"
										required data-bv-notempty-message="门店编号不能为空"
										data-bv-remote="true"
										data-bv-remote-url="${path}/store/isStoreExist" 
										data-bv-remote-message="门店编号已经存在">
							</c:if>
							
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">负责人</label>
						<div class="col-xs-3">
							<input type="text" value="${model.chargeName }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="chargeName" name="model.chargeName" required data-bv-notempty-message="负责人不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的负责人">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">联系电话</label>
						<div class="col-xs-3">
							<input type="text" value="${model.chargePhone }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="chargePhone" name="model.chargePhone" required data-bv-notempty-message="联系电话不能为空"
								pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$"
								data-bv-regexp-message="请输入正确的联系电话">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店地址</label>
						<div class="col-xs-3">
							<input type="text" value="${model.address }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="address" name="model.address" required data-bv-notempty-message="门店地址不能为空" />
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">门店类型</label>
						<div class="col-xs-3">
							<select id="type" name="model.type" class="form-control" required data-bv-notempty-message="请选择门店类型">
								<option value="" selected="selected">请选择门店类型</option>
								<option value="1">直营店</option>
								<option value="2">商家店</option>
								<option value="3">小商品店</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">门店面积</label>
						<div class="col-xs-3">
							<input type="text" value="${model.acreage }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="acreage" name="model.acreage" required data-bv-notempty-message="门店面积不能为空" />
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									id="name" name="model.remark"/>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">道具清单</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-1 control-label">
							<input type="button" value="新建" class="btn btn-primary btn-xs" onclick="newStoreProperty();"/>
						</label>
					</div>

					<div id="StoreProperty_div_all">
						<c:forEach items="${model.storePropertieList }" var="storeProperty" varStatus="i">
							<div class="form-group">
								<input type="hidden" value="${storeProperty.id }" id="storeProperty_id" name="model.storePropertieList[${i.index }].id"/>
								<input type="hidden" value="${model.id }" id="storeProperty_store_id" name="model.storePropertieList[${i.index }].store.id"/>
								<label for="product-uuid" class="col-xs-2 control-label">名称</label>
								<div class="col-xs-3">
									<input type="text" value="${storeProperty.name }" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										id="name" name="model.storePropertieList[${i.index }].name" required data-bv-notempty-message="名称不能为空"
										pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
										data-bv-regexp-message="请输入正确的名称">
								</div>
		
								<label for="product-uuid" class="col-xs-2 control-label">数量</label>
								<div class="col-xs-3">
									<input type="text" value="${storeProperty.number }" class="form-control"
											onkeydown="if(event.keyCode==32) return false;"
											id="number" name="model.storePropertieList[${i.index }].number" required data-bv-notempty-message="数量不能为空"
											pattern="^[1-9][0-9]{0,7}$"
											data-bv-regexp-message="请输入正确的数量" />
								</div>
								<div class="col-xs-1" style="padding-top: 7px;">
									<input type="button" value="删除" class="btn btn-danger btn-xs storeProperty_delete_button"/>
								</div>
							</div>
						</c:forEach>
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

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<!-- 新增门店固定资产--待复制节点 -->
	<div class="form-group" id="storeProperty_div_one_copy" style="display: none;">
		<input type="hidden" value="" id="storeProperty_id"/>
		<input type="hidden" value="${model.id }" id="storeProperty_store_id"/>
		<label for="product-uuid" class="col-xs-2 control-label">名称</label>
		<div class="col-xs-3">
			<input type="text" value="${storeProperty.name }" class="form-control"
				onkeydown="if(event.keyCode==32) return false;"
				id="name" required data-bv-notempty-message="名称不能为空"
				pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
				data-bv-regexp-message="请输入正确的名称">
		</div>

		<label for="product-uuid" class="col-xs-2 control-label">数量</label>
		<div class="col-xs-3">
			<input type="text" value="${storeProperty.number }" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="number" required data-bv-notempty-message="数量不能为空"
					pattern="^[1-9][0-9]{0,7}$"
					data-bv-regexp-message="请输入正确的数量" />
		</div>
		<div class="col-xs-1" style="padding-top: 7px;">
			<input type="button" value="删除" class="btn btn-danger btn-xs storeProperty_delete_button"/>
		</div>
	</div>

	<input type="hidden" id="storeProperty_delete_input_copy"/>

	<script type="text/javascript">
		var storeProperty_add_index = 0,
			storeProperty_delete_index = 0;

		/**
		* 新建门店固定资产方法
		*/
		function newStoreProperty(){
			var new_storeProperty_div = $("#storeProperty_div_one_copy").clone();
			new_storeProperty_div.find("#storeProperty_id").attr("name","model.storePropertieNew[" + storeProperty_add_index + "].id");
			new_storeProperty_div.find("#storeProperty_store_id").attr("name","model.storePropertieNew[" + storeProperty_add_index + "].store.id");
			new_storeProperty_div.find("#name").attr("name","model.storePropertieNew[" + storeProperty_add_index + "].name");
			new_storeProperty_div.find("#number").attr("name","model.storePropertieNew[" + storeProperty_add_index + "].number");
			new_storeProperty_div.removeAttr("id");
			$("#StoreProperty_div_all").append(new_storeProperty_div.show());
			storeProperty_add_index++;
			// 重新初始化验证
			bootstrapValidator_again();
		}

		/**
		* 删除门店固定资产监听
		*/
		$(document).on("click", ".storeProperty_delete_button", function(){
			var storeProperty_id_value = $(this).parent().parent().find("#storeProperty_id").val().trim();
			if("" != storeProperty_id_value){
				// 删除的已有的固定资产，将删除标记回传
				var storeProperty_delete_input = $("#storeProperty_delete_input_copy").clone();
				storeProperty_delete_input.attr("name","model.storePropertieDelete[" + storeProperty_delete_index + "].id").val(storeProperty_id_value);
				$("#StoreProperty_div_all").append(storeProperty_delete_input);
				storeProperty_delete_index++;
			}
			// 由于bootstrap验证的原因，节点不能直接删除，需要将所有input禁用后，隐藏节点
			$(this).parent().parent().find("input").attr("disabled","disabled");
			$(this).parent().parent().hide();
			// 重新初始化验证
			bootstrapValidator_again();
		});

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

		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
			<c:if test="${empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.store.model.Store,id",required:true});
			</c:if>
			<c:if test="${not empty model.id}">
				$.hz.swfupload.init("fileDiv",{classFieldName:"com.unitever.module.store.model.Store,id",idOwner:"${model.id}",required:true});
			</c:if>
		});
		$("#type").val("${model.type}")
	</script>
</body>
</html>
