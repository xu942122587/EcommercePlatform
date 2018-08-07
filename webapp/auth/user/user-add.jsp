<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html lang="zh-CN">
<head>
<script>
	var isSuccess = true;
	Namespace.register("com.yunt.user.add");
	com.yunt.user.add = {
		submitUser : function() {
			if ($('#theForm').data('bootstrapValidator').isValid()) {
				var idCard_value = $("#idCard").val().trim();
				if("" != idCard_value){
					if(!IdCardValidate(idCard_value)){
						toastr.error("身份证号码格式不正确，请仔细核对~");
						$("#ert").removeAttr("disabled");
						return false;
					}
				}
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					$.ajax({
						url : "${path}/user/saveOrUpdate?inputKind=${inputKind}",
						data : formData,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = false;//防止重复提交
								if('${inputKind}'=="update"){
									toastr.success('更新用户成功！');
								}else{
									toastr.success('添加用户成功！');
								}
								com.yunt.index.toPreIndex();
							} else {
								toastr.error('添加功能失败！');
							}
						},
						error : function(xhr, type, exception) {
							alert("请检查网络设置");
						}
					});
				}
			}
			return false;//防止页面刷新
		}
	};
	/**************************************************************************************/
	/************************************身份证号码的验证*************************************/
	/**************************************************************************************/

	/**  
	 * 身份证15位编码规则：dddddd yymmdd xx p
	 * dddddd：地区码
	 * yymmdd: 出生年月日
	 * xx: 顺序类编码，无法确定
	 * p: 性别，奇数为男，偶数为女
	 * <p />
	 * 身份证18位编码规则：dddddd yyyymmdd xxx y
	 * dddddd：地区码
	 * yyyymmdd: 出生年月日
	 * xxx:顺序类编码，无法确定，奇数为男，偶数为女
	 * y: 校验码，该位数值可通过前17位计算获得
	 * <p />
	 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]
	 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
	 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
	 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置
	 *
	 */
	var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];// 加权因子   
	var ValideCode = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2];// 身份证验证位值.10代表X   
	function IdCardValidate(idCard){
		idCard = idCard.replace(/ /g, "").trim();
		if (idCard.length == 15) {
			return isValidityBrithBy15IdCard(idCard);
		} else if (idCard.length == 18) {
			var a_idCard = idCard.split("");// 得到身份证数组   
			if (isValidityBrithBy18IdCard(idCard) && isTrueValidateCodeBy18IdCard(a_idCard)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	/**  
	 * 判断身份证号码为18位时最后的验证位是否正确
	 * @param a_idCard 身份证号码数组
	 * @return
	 */
	function isTrueValidateCodeBy18IdCard(a_idCard){
		var sum = 0; // 声明加权求和变量   
		if (a_idCard[17].toLowerCase() == 'x') {
			a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
		}
		for (var i = 0; i < 17; i++) {
			sum += Wi[i] * a_idCard[i];// 加权求和   
		}
		valCodePosition = sum % 11;// 得到验证码所位置   
		if (a_idCard[17] == ValideCode[valCodePosition]) {
			return true;
		}
		else {
			return false;
		}
	}

	/**  
	 * 通过身份证判断是男是女
	 * @param idCard 15/18位身份证号码
	 * @return 'female'-女、'male'-男
	 */
	function maleOrFemalByIdCard(idCard){
		idCard = trim(idCard.replace(/ /g, ""));// 对身份证号码做处理。包括字符间有空格。   
		if (idCard.length == 15) {
			if (idCard.substring(14, 15) % 2 == 0) {
				return 'female';
			}
			else {
				return 'male';
			}
		}
		else if (idCard.length == 18) {
			if (idCard.substring(14, 17) % 2 == 0) {
				return 'female';
			}
			else {
				return 'male';
			}
		}
		else {
			return null;
		}
	}

	/**  
	 * 验证18位数身份证号码中的生日是否是有效生日
	 * @param idCard 18位书身份证字符串
	 * @return
	 */
	function isValidityBrithBy18IdCard(idCard18){
		var year = idCard18.substring(6, 10);
		var month = idCard18.substring(10, 12);
		var day = idCard18.substring(12, 14);
		var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
		// 这里用getFullYear()获取年份，避免千年虫问题   
		if (temp_date.getFullYear() != parseFloat(year) ||
		temp_date.getMonth() != parseFloat(month) - 1 ||
		temp_date.getDate() != parseFloat(day)) {
			return false;
		}
		else {
			return true;
		}
	}

	/**  
	 * 验证15位数身份证号码中的生日是否是有效生日
	 * @param idCard15 15位书身份证字符串
	 * @return
	 */
	function isValidityBrithBy15IdCard(idCard15){
		var year = idCard15.substring(6, 8);
		var month = idCard15.substring(8, 10);
		var day = idCard15.substring(10, 12);
		var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
		// 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
		if (temp_date.getYear() != parseFloat(year) ||
		temp_date.getMonth() != parseFloat(month) - 1 ||
		temp_date.getDate() != parseFloat(day)) {
			return false;
		}
		else {
			return true;
		}
	}
</script>
</head>
<body> 
	<!--new device from begin-->
	<div class="row">
		<div class="col-xs-12">
			<div class="display">
				<form onsubmit="return com.yunt.user.add.submitUser()"
						class="form-horizontal" id="theForm" role="form" method="POST"
						data-bv-message="This value is not valid"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<c:if test="${not empty model.id }">
						<input type="hidden" name="id" value="${model.id}" />
					</c:if>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">姓名</label>
						<div class="col-xs-4">
							<input type="text" value="${model.name }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;"
									id="name" name="name" required data-bv-notempty-message="姓名不能为空"
									pattern="^-?[a-zA-Z0-9\u4e00-\u9fa5a-zA-z]{2,30}$"
									data-bv-regexp-message="请输入正确的姓名">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">用户名</label>
						<div class="col-xs-4">
							<c:if test="${not empty model.id }">
								<input type="text" value="${model.username }"
										onkeydown="if(event.keyCode==32) return false;"
										class="form-control" id="username" name="username" required
										data-bv-notempty-message="用户名不能为空"
										pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
										data-bv-regexp-message="只能输6~12位入字母和数字以及_." 
										data-bv-remote="true"
										data-bv-remote-url="${path}/user/validateUserIsExist?userId=${model.id}"
										data-bv-remote-message="此账号已经存在">
							</c:if>
							<c:if test="${empty model.id }">
								<input type="text" value="${model.username }"
										class="form-control" id="username" name="username" 
										onkeydown="if(event.keyCode==32) return false;"
										required data-bv-notempty-message="用户名不能为空"
										pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
										data-bv-regexp-message="只能输6~12位入字母和数字以及_." 
										data-bv-remote="true"
										data-bv-remote-url="${path}/user/isUserExist"
										data-bv-remote-message="此账号已经存在">
							</c:if>
							
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">密码</label>
						<div class="col-xs-4">
							<input type="password" value=""
									class="form-control placehold" id="password" name="password"
									onkeydown="if(event.keyCode==32) return false;"
									onfocus="this.type='password'" autocomplete="off"
									<c:if  test="${not empty model.id }">
										placeholder="●●●●●●"
									</c:if>
									data-bv-identical="true" data-bv-identical-field="confirmPassword"
									data-bv-identical-message="确认新密码和密码不一致"
									pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
									data-bv-regexp-message="只能输入6~12位字母和数字以及_."
									<c:if test="${ empty model.id }">
										 required
										data-bv-notempty-message="密码不能为空"
									</c:if>
								>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">确认密码</label>
						<div class="col-xs-4">
							<input type="password" value=""
									class="form-control placehold" id="confirmPassword"
									onkeydown="if(event.keyCode==32) return false;"
									onfocus="this.type='password'" autocomplete="off"
									name="confirmPassword"
									<c:if  test="${not empty model.id }">
										placeholder="●●●●●●"
									</c:if>
									data-bv-identical="true" data-bv-identical-field="password"
									data-bv-identical-message="确认新密码和密码不一致"
									pattern="^-?[a-zA-Z0-9_\.]{6,12}$"
									data-bv-regexp-message="只能输入6~12位字母和数字以及_."
									<c:if test="${ empty model.id }">
										 required
										data-bv-notempty-message="确认密码不能为空"
									</c:if>
								>
						</div>
					</div>

					<div class="form-group">
						<label for="category-name" class="col-xs-4 control-label">角色</label>
						<div class="col-xs-4">
							<select class="form-control" name="role.id" id="roleId" required data-bv-notempty-message="请选择角色">
								<option class="level-0" value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择角色</option>
								<c:forEach items="${roles }" var="role">
									<option class="level-0" value="${role.id }" <c:if test="${model.role.id eq role.id}">selected="selected"</c:if>>${role.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="category-name" class="col-xs-4 control-label">所属门店</label>
						<div class="col-xs-4">
							<select class="form-control" name="store.id" id="storeId">
								<option class="level-0" value="" <c:if test="${empty model.id }">selected="selected"</c:if>>请选择所属门店</option>
								<c:forEach items="${storeList }" var="store">
									<option class="level-0" value="${store.id }" <c:if test="${model.store.id eq store.id}">selected="selected"</c:if>>${store.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">联系电话</label>
						<div class="col-xs-4">
							<input type="text" value="${model.phone }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="phone" name="phone" required data-bv-notempty-message="联系电话不能为空"
								pattern="^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(19[0-9]{1}))+\d{8})$"
								data-bv-regexp-message="请输入正确的联系电话">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">身份证号</label>
						<div class="col-xs-4">
							<input type="text" value="${model.idCard }" class="form-control"
								onkeydown="if(event.keyCode==32) return false;"
								id="idCard" name="idCard">
						</div>
					</div>

<%-- 					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">员工编号</label>
						<div class="col-xs-4">
							<input type="text" value="${model.userCode }" class="form-control"
									onkeydown="if(event.keyCode==32) return false;" id="userCode" name="userCode"
									required data-bv-notempty-message="员工编号不能为空">
						</div>
					</div> --%>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">职位</label>
						<div class="col-xs-4">
							<input type="text" value="${model.job }" class="form-control" id="job" name="job" maxlength="10"
									onkeydown="if(event.keyCode==32) return false;" required data-bv-notempty-message="职位不能为空">
						</div>
					</div>

					<div class="form-group">
						<label for="product-uuid" class="col-xs-4 control-label">入职时间</label>
						<div class="col-xs-4">
							<input type="text" value='<fmt:formatDate value="${model.joinTime }" pattern="yyyy-MM-dd"/>' class="form-control date" id="joinTime" name="joinTime"
									onkeydown="return false;" onchange="$(this).blur()" required data-bv-notempty-message="入职时间不能为空">
						</div>
					</div>

					<div class="form-actions col-xs-8 pull-right">
						<button id="ert" type="submit" class="btn btn-primary">提交</button>
						<button type="reset" class="btn btn-default"
							onclick="com.yunt.index.toPreIndex();">返回</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#theForm').bootstrapValidator();//初始化验证
			$('.form-control.date').datepicker({
				format: "yyyy-mm-dd",
				todayBtn: "linked",
				clearBtn: true,
				language: "zh-CN",
				todayHighlight: true
			});
		});
	</script>
</body>
</html>
