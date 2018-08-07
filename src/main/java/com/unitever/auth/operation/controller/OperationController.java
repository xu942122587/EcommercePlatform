package com.unitever.auth.operation.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.function.service.FunctionService;
import com.unitever.auth.operation.model.Operation;
import com.unitever.auth.operation.service.OperationService;
import com.unitever.auth.role.service.RoleService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;

/**
 * @author 作者 : 邓文杰
 * @version 创建时间：2015-12-15 下午3:52:45 类说明 ：权限
 */

@Controller
@RequestMapping(value = "/operation")
public class OperationController extends SpringController {

	@Autowired
	private OperationService operationService;
	@Autowired
	private FunctionService functionService;
	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/list")
	public String list(@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "isFromRole", required = false) boolean isFromRole,
			@RequestParam(value = "roleId", required = false) String roleId, @FormModel("page") Page<Operation> page,
			@FormModel("model") Operation operation) {
		setAttribute("pageObj", operationService.getPage(page, operation));
		setAttribute("model", operation);
		setAttribute("isFromRole", isFromRole);
		if (isFromRole) {
			String role_operation_String = roleService.getRoleOperationCodeStrByRoleId(roleId);
			setAttribute("role_operation_String", role_operation_String);
			if (StringUtils.isNotBlank(role_operation_String))
				setAttribute("role_operation_Array", role_operation_String.split(","));
		}
		setAttribute("title", title);
		return "auth/operation/operation-list";
	}

	@RequestMapping(value = "/goAddOrUpdate")
	public String goAddOrUpdate(@RequestParam(value = "inputKind", required = false) String inputKind,
			@RequestParam(value = "functionId", required = false) String functionId,
			@RequestParam(value = "operationId", required = false) String operationId) {
		if ("update".equals(inputKind)) {
			setAttribute("operation", operationService.getOperationWithId(operationId));
		} else {
			setAttribute("operation", new Operation());
		}
		setAttribute("parentFunction", functionService.getFunctionWithId(functionId));
		setAttribute("inputKind", inputKind);
		return "auth/operation/operation-add";
	}

	@RequestMapping(value = "/doAddOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doAddOrUpdate(Operation operation) {
		AjaxJson json = new AjaxJson();
		if (StringUtils.isNotBlank(operation.getId())) {
			operationService.update(operation);
			json.setMsg("修改操作成功！");
		} else {
			operationService.save(operation);
			json.setMsg("添加操作成功！");
		}
		json.setSuccess(true);
		return json;
	}

	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String operationId) {
		AjaxJson json = new AjaxJson();
		operationService.delete(operationId);
		json.setSuccess(true);
		return json;
	}

}
