<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>

	<c:if test="${not empty classStringList}">
		<div class="form-group">
			<label for="product-uuid" class="col-xs-12 control-label lantiao_lable">商品属性</label>
		</div>
		
		<div class="form-group">
			<label for="product-uuid" class="col-xs-1 control-label">
				<input type="button" value="新建" class="btn btn-primary btn-xs" onclick="newGoodsChild();"/>
			</label>
		</div>
	
		<div id="goods_div_all">
			<c:forEach items="${model.goodsChildList}" var="goodsChild" varStatus="i">
				<div class="col-xs-5" style="background-color: #20a1d2;margin: 10px">
					<div class="form-group">
						<div class="col-xs-12" style="padding-top: 7px;">
							<input type="button" style="float: right;" value="删除" class="btn btn-danger btn-xs goodsProperty_delete_button"/>
						</div>
					</div>
					<input type="hidden" value="${goodsChild.id }" id="goodsChild_id" name="model.goodsChildList[${i.index }].id"/>
					<input type="hidden" value="${model.id }" id="goodsChild_goods_id" name="model.goodsChildList[${i.index }].goods.id"/>
					<c:forEach items="${classStringList}" var="classString" >
						<div class="form-group">
							<%-- <input type="hidden" value="${classString.attrCode}" id="classString_attrCode" name="model.goodsChildList[${i.index }].other_map_to_save[attrCode]"/> --%>
							<label for="product-uuid" class="col-xs-4 control-label">${classString.attr}</label>
							<c:if test="${'1' eq classString.inputType}">
								<div class="col-xs-8">
									<input type="text" value="${model.goodsChildList[i.index].other_map[classString.attrCode]}" class="form-control"
										onkeydown="if(event.keyCode==32) return false;" maxlength="12"
										name="model.goodsChildList[${i.index }].other_map_to_save[${classString.attrCode}]"
										<c:if test="${'1' eq classString.isRequired}">
											required data-bv-notempty-message="属性值不能为空"
										</c:if>
										>
								</div>
							</c:if>
							<c:if test="${'2' eq classString.inputType}">
								<div class="col-xs-8">
									<select class="form-control" name="model.goodsChildList[${i.index }].other_map_to_save[${classString.attrCode}]" 
										<c:if test="${'1' eq classString.isRequired}">
											required data-bv-notempty-message="属性值不能为空"
										</c:if>
										>
										<option value="" <c:if test="${empty goodsChild.other_map[attrCode].value }">selected="selected"</c:if>>请选择所属类别</option>
										<c:forEach items="${fn:split(classString.childAttr,',')}" var="childAttr">
											<option value="${childAttr}" <c:if test="${childAttr eq model.goodsChildList[i.index].other_map[classString.attrCode]}">selected="selected"</c:if>>${childAttr}</option>
										</c:forEach>
									</select>
								</div>
							</c:if>
							<c:if test="${'3' eq classString.inputType}">
								<div class="col-xs-8">
									<input type="text" value="${model.goodsChildList[i.index].other_map[classString.attrCode]}" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										name="model.goodsChildList[${i.index }].other_map_to_save[${classString.attrCode}]"
										<c:if test="${'1' eq classString.isRequired}">
											required data-bv-notempty-message="属性值不能为空"
										</c:if>
										pattern="^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$"
										data-bv-regexp-message="请输入正确的属性(手机号类型)">
								</div>
							</c:if>
							<c:if test="${'4' eq classString.inputType}">
								<div class="col-xs-8">
									<input type="text" value="${model.goodsChildList[i.index].other_map[classString.attrCode]}" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										<c:if test="${'1' eq classString.isRequired}">
											required data-bv-notempty-message="属性值不能为空"
										</c:if>
										name="model.goodsChildList[${i.index }].other_map_to_save[${classString.attrCode}]"
										pattern="^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
										data-bv-regexp-message="请输入正确的属性(邮箱类型)">
								</div>
							</c:if>
							<c:if test="${'5' eq classString.inputType}">
								<div class="col-xs-8">
									<input type="text" value="${model.goodsChildList[i.index].other_map[classString.attrCode]}" class="form-control"
										onkeydown="if(event.keyCode==32) return false;"
										name="model.goodsChildList[${i.index }].other_map_to_save[${classString.attrCode}]"
										<c:if test="${'1' eq classString.isRequired}">
											required data-bv-notempty-message="属性值不能为空"
										</c:if>
										pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1}){0,1}|([0-9]{1}\.{1}[1-9])|0|0.0)$"
										data-bv-regexp-message="请输入正确的属性(金额类型)">
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</c:if>
	
	<!-- 新增子商品--待复制节点 -->
	<div class="col-xs-5" id="goods_div_one_copy" style="display: none;background-color: #20a1d2;margin: 10px">
		<div class="form-group">
			<div class="col-xs-12" style="padding-top: 7px;">
				<input type="button" style="float: right;" value="删除" class="btn btn-danger btn-xs goodsProperty_delete_button"/>
			</div>
		</div>
		<input type="hidden" value="" id="goodsChild_id" />
		<input type="hidden" value="${model.id }" id="goodsChild_goods_id" />
		<c:forEach items="${classStringList}" var="classString" varStatus="i">
			<div class="form-group">
				<label for="product-uuid" class="col-xs-4 control-label">${classString.attr}</label>
				<c:if test="${'1' eq classString.inputType}">
					<div class="col-xs-8">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="attr_input_${i.index }" maxlength="12"
								name_end="other_map_to_save[${classString.attrCode}]"
								<c:if test="${'1' eq classString.isRequired}">
									required data-bv-notempty-message="属性不能为空"
								</c:if>>
					</div>
				</c:if>
				<c:if test="${'2' eq classString.inputType}">
					<div class="col-xs-8">
						<select class="form-control"  
								name_end="other_map_to_save[${classString.attrCode}]"
								id="attr_input_${i.index }"
								<c:if test="${'1' eq classString.isRequired}">
									required data-bv-notempty-message="属性不能为空"
								</c:if>>
							<option value="" <c:if test="${empty goodsChild.other_map[attrCode].value }">selected="selected"</c:if>>请选择所属类别</option>
							<c:forEach items="${fn:split(classString.childAttr,',')}" var="childAttr" varStatus="i">
								<option value="${childAttr}" <c:if test="${childAttr eq goodsChild.other_map[attrCode].value }">selected="selected"</c:if>>${childAttr}</option>
							</c:forEach>
						</select>
					</div>
				</c:if>
				<c:if test="${'3' eq classString.inputType}">
					<div class="col-xs-8">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;" id="attr_input_${i.index }"
								name_end="other_map_to_save[${classString.attrCode}]"
								<c:if test="${'1' eq classString.isRequired}">
									required data-bv-notempty-message="属性不能为空"
								</c:if>
								pattern="^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$"
								data-bv-regexp-message="请输入正确的属性(手机类型)">
					</div>
				</c:if>
				<c:if test="${'4' eq classString.inputType}">
					<div class="col-xs-8">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;" id="attr_input_${i.index }"
								name_end="other_map_to_save[${classString.attrCode}]"
								<c:if test="${'1' eq classString.isRequired}">
									required data-bv-notempty-message="属性不能为空"
								</c:if>
								pattern="^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
								data-bv-regexp-message="请输入正确的属性(邮箱类型)">
					</div>
				</c:if>
				<c:if test="${'5' eq classString.inputType}">
					<div class="col-xs-8">
						<input type="text" value="" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								name_end="other_map_to_save[${classString.attrCode}]" id="attr_input_${i.index }"
								<c:if test="${'1' eq classString.isRequired}">
									required data-bv-notempty-message="属性不能为空"
								</c:if>
								pattern="^(([1-9][0-9]{0,7})(\.{1}[0-9]{1}){0,1}|([0-9]{1}\.{1}[1-9])|0|0.0)$"
								data-bv-regexp-message="请输入正确的属性(金额类型)">
					</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<input type="hidden" id="goodsProperty_delete_input_copy"/>
	<script type="text/javascript">
		var goodsProperty_add_index = 0,
			goodsProperty_delete_index = 0,
			classStringList_size = "${classStringList.size()}" - 0;
		/**
		* 新建门店固定资产方法
		*/
		function newGoodsChild(){
			var new_goodsProperty_div = $("#goods_div_one_copy").clone();
			new_goodsProperty_div.find("#goodsChild_id").attr("name","model.goodsChildListNew[" + goodsProperty_add_index + "].id");
			new_goodsProperty_div.find("#goodsChild_goods_id").attr("name","model.goodsChildListNew[" + goodsProperty_add_index + "].goods.id");
			for(var i = 0; i < classStringList_size; i++){
				new_goodsProperty_div.find("#attr_input_" + i).attr("name","model.goodsChildListNew[" + goodsProperty_add_index + "]." + new_goodsProperty_div.find("#attr_input_" + i).attr("name_end"));
			}
			new_goodsProperty_div.removeAttr("id");
			$("#goods_div_all").append(new_goodsProperty_div.show());
			goodsProperty_add_index++;
			// 重新初始化验证
			bootstrapValidator_again();
		}

		/**
		* 删除门店固定资产监听
		*/
		$(document).on("click", ".goodsProperty_delete_button", function(){
			var goodsProperty_id_value = $(this).parent().parent().parent().find("#goodsChild_id").val().trim();
			if("" != goodsProperty_id_value){
				// 删除的已有的固定资产，将删除标记回传
				var goodsProperty_delete_input = $("#goodsProperty_delete_input_copy").clone();
				goodsProperty_delete_input.attr("name","model.goodsChildListDelete[" + goodsProperty_delete_index + "].id").val(goodsProperty_id_value);
				$("#goods_div_all").append(goodsProperty_delete_input);
				goodsProperty_delete_index++;
			}
			// 由于bootstrap验证的原因，节点不能直接删除，需要将所有input禁用后，隐藏节点
			$(this).parent().parent().parent().find("input").attr("disabled","disabled");
			$(this).parent().parent().parent().find("select").attr("disabled","disabled");
			$(this).parent().parent().parent().hide();
			// 重新初始化验证
			bootstrapValidator_again();
		});
		bootstrapValidator_again();
</script>
