package com.unitever.auth.role.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.unitever.auth.function.model.Function;
import com.unitever.auth.role.service.RoleService;
import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseModel;
import com.unitever.platform.core.spring.SpringContextHolder;

/**
 * @author 作者 : 邓文杰
 * @version 创建时间：2015-12-15 下午3:11:55 类说明
 */
public class Role extends BaseModel {

	private String id;
	private String name;
	private String description;
	private String type;
	private String roleKey;
	private List<Function> functions = new ArrayList<Function>();// 关联Function
	private List<Function> parentFunctions = new ArrayList<Function>();// 关联一级Function
	private Set<User> users = new HashSet<User>();// 关联user

	/** 角色类别：系统管理员 **/
	public static final String TYPE_SYSADMIN = "1";
	/** 角色类别：管理员 **/
	public static final String TYPE_ADMIN = "2";
	/** 角色类别：员工 **/
	public static final String TYPE_EMPLOYEE = "3";

	private String typeValue;

	private String functionIds;
	private String operationCodes;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRoleKey() {
		return roleKey;
	}

	public void setRoleKey(String roleKey) {
		this.roleKey = roleKey;
	}

	public List<Function> getFunctions() {
		RoleService roleService = SpringContextHolder.getBean(RoleService.class);
		return roleService.getFunctionsByRoleId(id);
	}

	public void setFunctions(List<Function> functions) {
		this.functions = functions;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public List<Function> getParentFunctions() {
		return parentFunctions;
	}

	public void setParentFunctions(List<Function> parentFunctions) {
		this.parentFunctions = parentFunctions;
	}

	public String getFunctionIds() {
		return functionIds;
	}

	public void setFunctionIds(String functionIds) {
		this.functionIds = functionIds;
	}

	public String getOperationCodes() {
		return operationCodes;
	}

	public void setOperationCodes(String operationCodes) {
		this.operationCodes = operationCodes;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTypeValue() {
		if (TYPE_SYSADMIN.equals(type)) {
			return "系统管理员";
		} else if (TYPE_ADMIN.equals(type)) {
			return "管理员";
		} else if (TYPE_EMPLOYEE.equals(type)) {
			return "员工";
		}
		return typeValue;
	}

	public void setTypeValue(String typeValue) {
		this.typeValue = typeValue;
	}

}
