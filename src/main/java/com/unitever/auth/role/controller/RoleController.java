package com.unitever.auth.role.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.role.model.Role;
import com.unitever.auth.role.model.RoleFunctionRelation;
import com.unitever.auth.role.model.RoleOperationRelation;
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
@RequestMapping(value = "/role")
public class RoleController extends SpringController {

	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Role> page, @FormModel("model") Role role) {
		setAttribute("pageObj", roleService.getPage(page, role));
		setAttribute("model", role);
		return "auth/role/role-list";
	}

	@RequestMapping(value = "/goAddOrUpdate")
	public String goAddOrUpdate(@RequestParam(value = "inputKind", required = false) String inputKind,
			@RequestParam(value = "id", required = false) String id) {
		if ("update".equals(inputKind)) {
			setAttribute("role", roleService.getRoleWithId(id));
		} else {
			setAttribute("role", new Role());
		}
		setAttribute("inputKind", inputKind);
		return "auth/role/role-add";
	}

	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public AjaxJson doAddOrUpdate(Role role) {
		String inputKind = getRequest().getParameter("inputKind");
		AjaxJson json = new AjaxJson();
		if ("update".equals(inputKind)) {
			roleService.update(role);
			json.setMsg("修改角色成功！");
		} else {
			roleService.save(role);
			json.setMsg("添加角色成功！");
		}
		json.setSuccess(true);
		return json;
	}

	@RequestMapping("/addFunctionWithRole")
	@ResponseBody
	public AjaxJson addFunctionWithRole(String functions, String roleId, String operations) {
		AjaxJson json = new AjaxJson();
		if (StringUtils.isNotBlank(functions) && StringUtils.isNotBlank(roleId)) {
			String[] functionsArray = functions.split(",");
			String[] operationsArray = operations.split(",");
			if (functionsArray.length > 0) {
				List<RoleFunctionRelation> list = new ArrayList<RoleFunctionRelation>();
				List<RoleOperationRelation> operationList = new ArrayList<RoleOperationRelation>();
				for (String functionId : functionsArray) {
					RoleFunctionRelation roleFunctionRelation = new RoleFunctionRelation();
					roleFunctionRelation.setFunctionId(functionId);
					roleFunctionRelation.setRoleId(roleId);
					list.add(roleFunctionRelation);
				}
				for (String operationId : operationsArray) {
					RoleOperationRelation roleOperationRelation = new RoleOperationRelation();
					roleOperationRelation.setRoleId(roleId);
					roleOperationRelation.setOperationId(operationId);
					operationList.add(roleOperationRelation);
				}
				roleService.deleteRoleFunctions(roleId);
				roleService.deleteRoleOperations(roleId);
				roleService.batchInsert(list);
				roleService.batchInsertRoleOperation(operationList);
				json.setSuccess(true);
			} else {
				json.setSuccess(false);
				json.setMsg("functions长度为0");
			}
		} else {
			json.setSuccess(false);
			json.setMsg("functions或者roleId为空");
		}
		return json;
	}

	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String roleId) {
		AjaxJson json = new AjaxJson();
		roleService.delete(roleId);
		json.setSuccess(true);
		return json;
	}

}
