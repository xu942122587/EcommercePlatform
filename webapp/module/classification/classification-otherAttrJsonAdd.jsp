<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
	<head>
		<script src="${path}/platform/ui/bootstrap/js/bootstrap-treeview.min.js"></script>
		<script src="${path}/platform/common/js/jquery.cookie.js"></script>
		<script type="text/javascript">
			var isSuccess = true;
			Namespace.register("com.yunt.classification.otherAttrJsonAdd");
			com.yunt.classification.otherAttrJsonAdd = {
				submitClassification : function() {
					if(isSuccess){
						isSuccess = false;//防止重复提交
						if($('#theForm').data('bootstrapValidator').isValid()){
							var childAttr_string = "";
							$(".childAttr_class:not(:disabled)").each(function(){
								childAttr_string += ","+$(this).val().trim();
							})
							childAttr_string = childAttr_string.substring(1);
							$("#childAttr").val(childAttr_string);
							var formData = $("#theForm").serialize();
							$.ajax({
								url : "${path}/classification/otherAttrJsonDoAddOrUpdate?flag=${flag}",
								data : formData,
								type : "post",
								dataType : "json",
								success : function(data) {
									if (data.success) {
										toastr.success(data.msg);
										com.yunt.index.toPreIndex();
									} else {
										toastr.error(data.msg);
										isSuccess = true;
									}
								},
								error : function(xhr, type, exception) {
									toastr.error("请检查网络设置");
									isSuccess = true;
								}
							});
						}else{
							isSuccess = true;
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
					<form onsubmit="return com.yunt.classification.otherAttrJsonAdd.submitClassification();"  class="form-horizontal"  id="theForm" role="form" method="get"  data-bv-message="This value is not valid" data-bv-feedbackicons-valid="glyphicon glyphicon-ok" data-bv-feedbackicons-invalid="glyphicon glyphicon-remove" data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">

						<div class="form-group">
							<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">自定义属性</label>
						</div>

						<input type="hidden" id="childAttr" name="childAttr" value=""/>
						<input type="hidden" id="childAttr" name="attrCode" value="${attrCode}"/>
						<c:if test="${not empty model.id }">
							<input type="hidden" name="model.id" value="${model.id}"  />
						</c:if>

						<div class="form-group" id="parentClassification">
							<label for="category-name" class="col-xs-4 control-label">所属分类</label>
							<div class="col-xs-4">
								<input type="text" onkeydown="if(event.keyCode==32) return false;" value="${model.name }" class="form-control" disabled="disabled" >
							</div>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-4 control-label">属性</label>
							<div class="col-xs-4">
								<input type="text" onkeydown="if(event.keyCode==32) return false;" value="${attr}" class="form-control" id="attr" name="attr" required data-bv-notempty-message="分类名称不能为空" maxlength="20">
							</div>
						</div>

						<div class="form-group">
							<label for="product-uuid" class="col-xs-4 control-label">输入类型</label>
							<div class="col-xs-4">
								<select class="form-control" id="inputType" name="inputType" onchange="onChangeSelect()" style="border-radius: 6px 0 0 6px;">
									<c:if test="${1 eq inputType }">
										<option value="1" selected="selected">自由输入</option>
										<option value="2" >备选项输入</option>
										<option value="3" >手机号类型输入</option>
										<option value="4" >邮箱类型输入</option>
										<option value="5" >金额类型输入</option>
									</c:if>
									<c:if test="${2 eq inputType }">
										<option value="1" >自由输入</option>
										<option value="2" selected="selected">备选项输入</option>
										<option value="3" >手机号类型输入</option>
										<option value="4" >邮箱类型输入</option>
										<option value="5" >金额类型输入</option>
									</c:if>
									<c:if test="${3 eq inputType }">
										<option value="1" >自由输入</option>
										<option value="2" >备选项输入</option>
										<option value="3" selected="selected">手机号类型输入</option>
										<option value="4" >邮箱类型输入</option>
										<option value="5" >金额类型输入</option>
									</c:if>
									<c:if test="${4 eq inputType }">
										<option value="1" >自由输入</option>
										<option value="2" >备选项输入</option>
										<option value="3" >手机号类型输入</option>
										<option value="4" selected="selected">邮箱类型输入</option>
										<option value="5" >金额类型输入</option>
									</c:if>
									<c:if test="${5 eq inputType }">
										<option value="1" >自由输入</option>
										<option value="2" >备选项输入</option>
										<option value="3" >手机号类型输入</option>
										<option value="4" >邮箱类型输入</option>
										<option value="5" selected="selected">金额类型输入</option>
									</c:if>
									<c:if test="${empty inputType }">
										<option value="1" >自由输入</option>
										<option value="2" >备选项输入</option>
										<option value="3" >手机号类型输入</option>
										<option value="4" >邮箱类型输入</option>
										<option value="5" >金额类型输入</option>
									</c:if>
								</select>
							</div>
						</div>

						<div class="form-group" style="display: none;">
							<label for="product-uuid" class="col-xs-4 control-label">是否必填</label>
							<div class="col-xs-4">
							<input type="hidden" id="isRequired" name="isRequired" value="1"/>
<%-- 								<select class="form-control"  id="isRequired" name="isRequired"  style="border-radius: 6px 0 0 6px;">
									<c:if test="${1 eq isRequired }">
										<option value="1" selected="selected">是</option>
										<option value="2" >否</option>
									</c:if>
									<c:if test="${2 eq isRequired }">
										<option value="1" >是</option>
										<option value="2" selected="selected">否</option>
									</c:if>
									<c:if test="${empty isRequired }">
										<option value="1" >是</option>
										<option value="2" >否</option>
									</c:if>
								</select> --%>
							</div>
						</div>

						<div class="form-group" id="new_childAttr_div_button">
							<label for="product-uuid" class="col-xs-4 control-label"></label>
							<div class="col-xs-4" >
								<button type="button" class="btn btn-primary" onclick="addChildAttr()">添加新备选项输入框</button>
							</div>
						</div>

						<div id="childAttr_div_all">
							<c:forEach items="${childAttrList}" var="childAttr" varStatus="i">
								<div class="form-group">
									<label for="product-uuid" class="col-xs-4 control-label">备选项</label>
									<div class="col-xs-4">
										<input type="text" onkeydown="if(event.keyCode==32) return false;" value="${childAttr}" class="form-control childAttr_class"  name="childAttr${i.index}" required data-bv-notempty-message="备选项不能为空" maxlength="20">
									</div>
									<div class="col-xs-1" style="margin-top: 7px">
										<button type="button" class="btn btn-danger btn-xs" onclick="deleteChildAttr(this)">删除</button>
									</div>
								</div>
							</c:forEach>
						</div>

						<div class="form-actions col-xs-8 pull-right">
							<button id="ert" type="submit" class="btn btn-primary">提交</button>
							<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<div class="form-group" id="childAttr_div_one_copy" style="display: none;">
			<label for="product-uuid" class="col-xs-4 control-label">备选项</label>
			<div class="col-xs-4">
				<input type="text" onkeydown="if(event.keyCode==32) return false;" value="${childAttr}" class="form-control childAttr_class" disabled="disabled" required data-bv-notempty-message="备选项不能为空" maxlength="20">
			</div>
			<div class="col-xs-1" style="margin-top: 7px">
				<button type="button" class="btn btn-danger btn-xs" onclick="deleteChildAttr(this)">删除</button>
			</div>
		</div>
		
		<script type="text/javascript">
		    $(function() {
		    	$('#theForm').bootstrapValidator();//初始化验证
		    	if(2 == $("#inputType").val()){
		    		$("#childAttr_div_all").show();
		    		$("#new_childAttr_div_button").show();
		    	}else{
		    		$("#childAttr_div_all").hide();
		    		$("#new_childAttr_div_button").hide();
		    	}
		    })
		    function onChangeSelect(){
		    	if(2 == $("#inputType").val()){
		    		addChildAttr();
		    		$("#childAttr_div_all").show();
		    		$("#new_childAttr_div_button").show();
		    	}else{
		    		$("#childAttr_div_all").hide();
		    		$("#new_childAttr_div_button").hide();
		    	}
		    }
		    
	    	var childAttr_index = "${fn:length(childAttrList)}" - 0;
		    function addChildAttr(){
		    	var childAttr_div  = $("#childAttr_div_one_copy").clone();
		    	childAttr_div.find("input").attr("name","childAttr" + childAttr_index).removeAttr("disabled");
		    	childAttr_div.find("label").html("备选项");
		    	childAttr_div.removeAttr("id");
		    	$("#childAttr_div_all").append(childAttr_div.show());
	    		childAttr_index++
		    	bootstrapValidator_again();
		    }
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
		    function deleteChildAttr(this_){
		    	$(this_).parent().parent().find("input").attr("disabled","disabled");
				$(this_).parent().parent().hide();
				// 重新初始化验证
				bootstrapValidator_again();
		    }
		</script>
	</body>
</html>
