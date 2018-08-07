<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.vende.input");
	com.yunt.vende.input = {
		submitStore : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				wirteAddressAll("vendeAddress");
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/vende/saveOrUpdate",
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
				<form onsubmit="return com.yunt.vende.input.submitStore()"
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
						<label for="product-uuid" class="col-xs-2 control-label">名称</label>
						<div class="col-xs-3">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="model.name" required data-bv-notempty-message="名称不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的名称">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">官网网址</label>
						<div class="col-xs-3">
							<input type="text" value="${model.brandHttpURI }"
									onkeydown="if(event.keyCode==32) return false;"
									class="form-control" id="brandHttpURI" name="model.brandHttpURI">
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
						<label for="product-uuid" class="col-xs-2 control-label">开户行</label>
						<div class="col-xs-3">
							<input type="text" value="${model.bankName }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;" maxlength="150"
									id="bankName" name="model.bankName" required data-bv-notempty-message="开户行不能为空" >
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">银行账户</label>
						<div class="col-xs-3">
							<input type="text" value="${model.bankCardNum }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;" maxlength="20"
								pattern="^[0-9]{16,20}$"
								data-bv-regexp-message="请输入正确的银行卡号(16-20数字)"
								id="bankCardNum" name="model.bankCardNum" required data-bv-notempty-message="银行账户不能为空" >
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">邮箱地址</label>
						<div class="col-xs-3">
							<input type="email" value="${model.email }" class="form-control" data-bv-emailAddress-message="请输入正确的邮箱地址"
									onkeydown="if(event.keyCode==32) return false;" maxlength="150"
									id="email" name="model.email" >
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">供应商地址</label>
						<div class="col-xs-2">
							<select id="area_province_vendeAddress" name="area_province_vendeAddress" class="form-control" onchange="getCity(this,'vendeAddress');"  required data-bv-notempty-message="请选择省">
								<option value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择省</option>
								<c:forEach var="areaProvince" items="${areaProvinceList }">
									<option value="${areaProvince.id }-${areaProvince.content }" <c:if test="${areaProvince.id eq model.addressArray[0] }">selected="selected"</c:if>>${areaProvince.content }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-xs-2">
							<select id="area_city_vendeAddress" name="area_city_vendeAddress" class="form-control" onchange="getDistrict(this,'vendeAddress');" required data-bv-notempty-message="请选择市">
								<option value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择市</option>
								<c:forEach var="areaCity" items="${areaCityList }">
									<option value="${areaCity.id }-${areaCity.content }" <c:if test="${areaCity.id eq model.addressArray[1] }">selected="selected"</c:if>>${areaCity.content }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-xs-2">
							<select id="area_district_vendeAddress" name="area_district_vendeAddress" <c:if test="${empty areaDistrictList || 4 ge fn:length(model.addressArray) }">disabled="disabled"</c:if> class="form-control" required data-bv-notempty-message="请选择区">
								<option value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择区</option>
								<c:forEach var="areaDistrict" items="${areaDistrictList }">
									<option value="${areaDistrict.id }-${areaDistrict.content }" <c:if test="${areaDistrict.id eq model.addressArray[2] }">selected="selected"</c:if>>${areaDistrict.content }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-xs-2">
							<input type="text" class="form-control" id="vendeAddress_input" name="vendeAddress_input" onkeydown="if(event.keyCode==32) return false;" placeholder="详细地址~"
									required data-bv-notempty-message="供应商地址不能为空"  maxlength="180" value="${model.addressArray[fn:length(model.addressArray) - 2]}">
							<input type="hidden" id="vendeAddress" name="model.address"/>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">备注</label>
						<div class="col-xs-8">
							<input type="text" value="${model.remark }" class="form-control"
									id="name" name="model.remark" />
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

	<script type="text/javascript">
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
		});

		/**
		 * 省的值改变时，拉取城市的值
		 * 闫枫
		 * 2016-09-28
		 */
		function getCity(this_, id_end){
			var province_id = $(this_).val().trim().split("-")[0];
			if("" == province_id){
				$("#area_city_" + id_end).html("<option value='' selected='selected'>请选择市</option>").val("");
				$("#area_district_" + id_end).html("<option value='' selected='selected'>请选择区</option>").val("");
				$('#theForm').bootstrapValidator('resetForm', false);
				$('#theForm').bootstrapValidator(); 
				return;
			}
			$.ajax({
				url : "${path}/vende/getAjaxAreaByAreaId?areaId=" + province_id,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var cityArray = eval(data.msg);
						var city_option_tring = "";
						for(var i = 0; i < cityArray.length; i++){
							var value_String = cityArray[i].content,
								id_String = cityArray[i].id;
							city_option_tring += "<option value=" + id_String + "-" + value_String + ">" + value_String + "</option>";
						}
						$("#area_city_" + id_end).html(
								"<option value='' selected='selected'>请选择市</option>"
								+ city_option_tring
						).val("");
						$("#area_district_" + id_end).html(
								"<option value='' selected='selected'>请选择区</option>"
						).val("")
						$('#theForm').bootstrapValidator('resetForm', false);
						$('#theForm').bootstrapValidator(); 
					} else {
						toastr.error('拉取城市信息出错，请重试或联系管理员！');
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});

		}

		/**
		 * 城市的值改变时，拉取区域的值
		 * 闫枫
		 * 2016-09-28
		 */
		function getDistrict(this_,id_end){
			var city_id = $(this_).val().trim().split("-")[0];
			if("" == city_id){
				$("#area_district_" + id_end).html("<option value='' selected='selected'>请选择区</option>").val("");
				$('#theForm').bootstrapValidator('resetForm', false);
				$('#theForm').bootstrapValidator(); 
				return false;
			}
			$.ajax({
				url : "${path}/vende/getAjaxAreaByAreaId?areaId=" + city_id,
				data : null,
				type : "POST",
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var districtArray = eval(data.msg);
						if(0 >= districtArray.length){
							$("#area_district_" + id_end).val("").attr("disabled","disabled");
						}else{
							var district_option_tring = "";
							for(var i = 0; i < districtArray.length; i++){
								var value_String = districtArray[i].content,
									id_String = districtArray[i].id;
								district_option_tring += "<option value=" + id_String + "-" + value_String + ">" + value_String + "</option>";
							}
							$("#area_district_" + id_end).html(
									"<option value='' selected='selected'>请选择区</option>"
									+ district_option_tring
							).val("").removeAttr("disabled");
						}
						$('#theForm').bootstrapValidator('resetForm', false);
						$('#theForm').bootstrapValidator(); 
					} else {
						toastr.error('拉取区域信息出错，请重试或联系管理员！');
					}
				},
				error : function(xhr, type, exception) {
					toastr.error("请检查网络设置");
				}
			});
		}

		/*
		* 地址拼接--依据给定的Id结尾，依次将省、市、区、详细地址拼接为完整地址，并放置在对应的用于提交的隐藏input中
		*/
		function wirteAddressAll(id_end){
			$("#" + id_end).val(("" != $("#area_province_"+ id_end ).val() ? $("#area_province_" + id_end ).val().trim().split("-")[0] + "-" : "")
					+ ("" != $("#area_city_"+ id_end ).val() ? $("#area_city_" + id_end ).val().trim().split("-")[0] + "-" : "")
					+ ("" != $("#area_district_"+ id_end ).val() ? $("#area_district_"+ id_end ).val().trim().split("-")[0] + "-" : "")
					+ $("#" + id_end + "_input").val().trim() + "-"
					+ ("" != $("#area_province_"+ id_end ).val() ? $("#area_province_" + id_end ).val().trim().split("-")[1] : "")
					+ ("" != $("#area_city_"+ id_end ).val() ? $("#area_city_"+ id_end ).val().trim().split("-")[1] : "")
					+ ("" != $("#area_district_"+ id_end ).val() ? $("#area_district_"+ id_end ).val().trim().split("-")[1] : "")
					+ $("#" + id_end + "_input").val().trim() 
			);
		}
	</script>
</body>
</html>
