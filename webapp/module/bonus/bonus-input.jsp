<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.bonus.input");
	com.yunt.bonus.input = {
		submitBrand : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				console.log(bonus_old_index);
				console.log(bonus_delete_index);
				console.log(bonus_new_index);
				console.log(bonus_old_index - bonus_delete_index + bonus_new_index + 1);
				if(0>=(bonus_old_index - bonus_delete_index + bonus_new_index + 1)){
					$("#ert").removeAttr("disabled");
					toastr.error("请至少录入一档提成比例！");
					return false;
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/bonus/saveOrUpdate",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								toastr.success('录入提成比例成功！');
							} else {
								toastr.error(data.msg);
							}
							com.yunt.index.toPreIndex();
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
				<form onsubmit="return com.yunt.bonus.input.submitBrand();"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div class="form-group">
						<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">提成比例</label>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-1 control-label">
							<input type="button" value="新建" class="btn btn-primary btn-xs" onclick="newBonus();"/>
						</label>
					</div>

					<div id="bonus_all_div">
						<c:forEach items="${bonusList }" var="bonus" varStatus="i">
							<div class="form-group">
								<input type="hidden" name="model.bonuOldList[${i.index }].id" value="${bonus.id }" id="bonus_id" />
								<label for="product-uuid" class="col-xs-2 control-label">业绩</label>
								<div class="col-xs-3">
									<input type="text" value="${bonus.startMoney }" class="form-control"
											onkeydown="if(event.keyCode==32) return false;"
											id="startMoney" name="model.bonuOldList[${i.index }].startMoney" required data-bv-notempty-message="业绩不能为空"
											pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00)$"
											data-bv-regexp-message="请输入正确的业绩，eg:688888.88">
								</div>

								<label for="product-uuid" class="col-xs-2 control-label">提成比例</label>
								<div class="col-xs-3">
									<input type="text" value="${bonus.proportion }" class="form-control"
											onkeydown="if(event.keyCode==32) return false;"
											id="proportion" name="model.bonuOldList[${i.index }].proportion" required data-bv-notempty-message="提成比例不能为空" 
											pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$"
											data-bv-regexp-message="请输入正确的提成比例，eg:18.88"/>
								</div>

								<div class="col-xs-1" style="padding: 7px 0;width:30px">
									%
								</div>
								<div class="col-xs-1 pull-left" style="padding-top: 7px;">
									<input type="button" value="删除" class="btn btn-danger btn-xs bonus_delete_button"/>
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="form-group col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default" onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="form-group" style="display: none;" id="bonus_one_div_copy">
		<input type="hidden" value="" id="bonus_id"/>
		<label for="product-uuid" class="col-xs-2 control-label">业绩</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="startMoney" required data-bv-notempty-message="业绩不能为空"
					pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00)$"
					data-bv-regexp-message="请输入正确的业绩，eg:688888.88">
		</div>

		<label for="product-uuid" class="col-xs-2 control-label">提成比例</label>
		<div class="col-xs-3">
			<input type="text" value="" class="form-control"
					onkeydown="if(event.keyCode==32) return false;"
					id="proportion" required data-bv-notempty-message="提成比例不能为空" 
					pattern="^(([1-9][0-9]{0,1})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9])|0|0.0|0.00|100)$"
					data-bv-regexp-message="请输入正确的提成比例，eg:18.88"/>
		</div>

		<div class="col-xs-1" style="padding: 7px 0;width:30px">
			%
		</div>

		<div class="col-xs-1" style="padding-top: 7px;">
			<input type="button" value="删除" class="btn btn-danger btn-xs bonus_delete_button"/>
		</div>
	</div>

	<input type="hidden" id="bonus_delete_input_copy"/>

	<script type="text/javascript">
		var bonus_new_index = 0,
			bonus_delete_index = 0,
			bonus_old_index = ("true" == "${empty bonusList}") ? -1 : "${bonusList.size()}" - 1;

		/**
		 * 新建提成比例
		 */
		function newBonus(){
			var bonus_one_div = $("#bonus_one_div_copy").clone();
			bonus_one_div.find("#bonus_id").attr("name", "model.bonuNewList[" + bonus_new_index + "].id");
			bonus_one_div.find("#startMoney").attr("name", "model.bonuNewList[" + bonus_new_index + "].startMoney");
			bonus_one_div.find("#proportion").attr("name", "model.bonuNewList[" + bonus_new_index + "].proportion");
			bonus_one_div.removeAttr("id");
			$("#bonus_all_div").append(bonus_one_div.show());
			bonus_new_index++;
			bootstrapValidator_again();
		}

		/**
		* 删除提成比例监听
		*/
		$(document).off("click", ".bonus_delete_button").on("click", ".bonus_delete_button", function(){
			var bonus_id_value = $(this).parent().parent().find("#bonus_id").val().trim();
			if("" != bonus_id_value){
				// 删除的已有的固定资产，将删除标记回传
				var bonus_delete_input = $("#bonus_delete_input_copy").clone();
				bonus_delete_input.attr("name","model.bonuDeleteList[" + bonus_delete_index + "].id").val(bonus_id_value);
				$("#bonus_all_div").append(bonus_delete_input);
				bonus_delete_index++;
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
		});
	</script>
</body>
</html>
