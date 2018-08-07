<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	var isAlert = true;
	var goodsIsEmpty = true;
	Namespace.register("com.yunt.eticket.add");
	com.yunt.eticket.add = {
		submitEticket : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$ .ajax({
						url : "${path}/eticket/saveOrUpdate",
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
			return false;//防止页面刷新
		}
	};
</script>
<style type="text/css">
	/*  在chrome下：*/
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button{
	    -webkit-appearance: none !important;
	    margin: 0;
	}
	/*Firefox下：*/
	input[type="number"]{-moz-appearance:textfield;}
</style>
</head>
<body>
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.eticket.add.submitEticket()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="model.id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">电子券</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">电子券名称</label>
						<div class="col-xs-3">
							<input type="text" name="model.name" class="form-control" value="${model.name }"
									required data-bv-notempty-message="请输入电子券名称" onkeydown="if(event.keyCode==32) return false;"
									pattern="^(([a-zA-Z0-9\u4e00-\u9fa5]{1,20}))$" 
									data-bv-regexp-message="电子券名称不正确，参考格式：新年电子券Abc123"/>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">发放方式</label>
						<div class="col-xs-3">
							<select class="form-control" name="model.outType" id="outType" onchange="outTypeOnChage(this);" required data-bv-notempty-message="请选择发放方式">
								<option class="level-0" value="" <c:if test="${empty model.type }">selected="selected"</c:if>>请选择发放方式</option>
								<option class="level-0" value="1" <c:if test="${'1' eq model.outType }">selected="selected"</c:if>>手动</option>
								<option class="level-0" value="2" <c:if test="${'2' eq model.outType }">selected="selected"</c:if>>自动发放（交易）</option>
								<option class="level-0" value="3" <c:if test="${'3' eq model.outType }">selected="selected"</c:if>>自动发放（注册）</option>
								<%-- <option class="level-0" value="4" <c:if test="${'4' eq model.outType }">selected="selected"</c:if>>自动发放（充值）</option> --%>
								<option class="level-0" value="5" <c:if test="${'5' eq model.outType }">selected="selected"</c:if>>自动发放（生日）</option>
							</select>
						</div>
					</div>

					<div class="form-group" id="out_inputs_div">
						<label for="product-uuid" class="col-xs-2 control-label">发放门店</label>
						<div class="col-xs-3">
							<select class="form-control" name="model.outStore.id" id="outStore_select">
								<option class="level-0" value="" <c:if test="${empty model.id || empty model.outStore.id }">selected="selected"</c:if>>全部</option>
								<c:forEach var="store" items="${storeList }">
									<option class="level-0" value="${store.id }" <c:if test="${model.outStore.id eq store.id}">selected="selected"</c:if>>${store.name }</option>
								</c:forEach>
							</select>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券发放阀值</label>
						<div class="col-xs-3">
							<input type="text" name="model.outLimit" class="form-control" id="outLimit_input" value="${model.outLimit }"
									required data-bv-notempty-message="请输入电子券发放阀值" onkeydown="if(event.keyCode==32) return false;"
									pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00)$" 
									data-bv-regexp-message="发放阀值不正确，参考格式：168.88"/>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">电子券有效期</label>
						<div class="col-xs-3">
							<input type="text" name="model.dateLimit" class="form-control" value="${model.dateLimit }"
									required data-bv-notempty-message="请输入电子券有效期" 
									pattern="^([1-9]{1}[0-9]{0,19})$" onkeydown="if(event.keyCode==32) return false;"
									data-bv-regexp-message="有效期不正确，参考格式：3"/>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券价值</label>
						<div class="col-xs-3">
							<input name="model.price" type="text" class="form-control" value="${model.price }"
									required data-bv-notempty-message="请输入电子券价值" id="price" onkeydown="if(event.keyCode==32) return false;"
									pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1}){0,1}|([0-9]{1}\.{1}[1-9]))$" 
									data-bv-regexp-message="电子券价值格式不正确，参考格式：66.88"/>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-2 control-label">类型</label>
						<div class="col-xs-3">
							<select class="form-control" name="model.type" id="type_select" onchange="typeChange(this);">
								<option class="level-0" value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择类型</option>
								<option class="level-0" value="1" <c:if test="${'1' eq model.type}">selected="selected"</c:if>>专用</option>
								<option class="level-0" value="2" <c:if test="${'2' eq model.type}">selected="selected"</c:if>>通用</option>
							</select>
						</div>

						<label for="product-uuid" class="col-xs-2 control-label">电子券使用阀值</label>
						<div class="col-xs-3">
							<input name="model.useLimit" id="useLimit" type="text" class="form-control" value="${model.useLimit }"
									required data-bv-notempty-message="请输入电子券使用阀值" onkeydown="if(event.keyCode==32) return false;"
									pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$" 
									data-bv-regexp-message="使用阀值不正确，参考格式：168.88"/>
						</div>
					</div>

					<div class="form-group" >
						<label for="product-uuid" class="col-xs-2 control-label">发放截止时间</label>
						<div class="col-xs-3">
							<input class="form-control dateTimeChange" type="text" name="model.stopSendTimeString" onkeydown="if(event.keyCode==32) return false;" onchange="$(this).blur()"
									id="stopSendTime" value="<fmt:formatDate value="${model.stopSendTime}" pattern="yyyy-MM-dd HH:mm"/>" 
									placeholder="发放截止时间" required="required" data-bv-notempty-message="请选择发放截止时间">
						</div>

						<label for="product-uuid" class="col-xs-2 control-label" id="useStore_label">使用门店</label>
						<div class="col-xs-3" id="useStore_div">
							<select class="form-control" name="model.useStore.id" id="useStore_select" required="required" data-bv-notempty-message="请选择使用门店" >
								<option class="level-0" value="" <c:if test="${empty model.id || empty model.useStore.id }">selected="selected"</c:if>>请选择使用门店</option>
								<c:forEach var="store" items="${storeList }">
									<option class="level-0" value="${store.id }" <c:if test="${model.useStore.id eq store.id}">selected="selected"</c:if>>${store.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			<c:if test="${not empty model.id }">
				<c:if test="${'1' eq model.type}">
					$("#useStore_div").show();
					$("#useStore_label").show();
				</c:if>
				<c:if test="${'2' eq model.type}">
					$("#useStore_div").hide();
					$("#useStore_label").hide();
				</c:if>
				<c:if test="${'2' eq model.outType }">
					$("#out_inputs_div").show();
				</c:if>
				<c:if test="${'2' ne model.outType }">
					$("#out_inputs_div").hide();
				</c:if>
			</c:if>
			<c:if test="${empty model.id }">
				$("#useStore_div").hide();
				$("#useStore_label").hide();
				$("#out_inputs_div").hide();
			</c:if>
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
		/**
		* 发放方式改变的回调
		*/
		function outTypeOnChage(this_){
			var out_type_value = $(this_).val().trim();
			if("2" == out_type_value){
				$("#out_inputs_div").show();
				$("#outStore_select").val("").removeAttr("disabled");
				$("#outLimit_input").val("").removeAttr("disabled");
			} else {
				$("#out_inputs_div").hide();
				$("#outStore_select").val("").attr("disabled","disabled");
				$("#outLimit_input").val("").attr("disabled","disabled");
			}
			bootstrapValidator_again();
		}
		/**
		* 类型改变的回调
		*/
		function typeChange(this_){
			var out_type_value = $(this_).val().trim();
			if("2" == out_type_value){
				$("#useStore_div").hide();
				$("#useStore_label").hide();
				$("#useStore_select").val("").attr("disabled","disabled");
			} else {
				$("#useStore_div").show();
				$("#useStore_label").show();
				$("#useStore_select").val("").removeAttr("disabled");
			}
			bootstrapValidator_again();
		}
		$(function(){
			$('.form-control.dateTimeChange').datetimepicker({
				format: "yyyy-mm-dd hh:ii",
				todayBtn: "linked",
				clearBtn: true,
				language: "zh-CN",
				todayHighlight: true,
				minuteStep:1
			});
		});
	</script>
</body>
</html>
