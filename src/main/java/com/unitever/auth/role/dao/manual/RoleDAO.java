package com.unitever.auth.role.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.auth.function.model.Function;
import com.unitever.auth.role.model.Role;
import com.unitever.auth.role.model.RoleFunctionRelation;
import com.unitever.auth.role.model.RoleOperationRelation;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class RoleDAO extends BaseDAO<Role, String> {

	public List<Role> getRoleByRole(Role role, int indexLine, int maxLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("indexLine", indexLine);
		map.put("maxLine", maxLine);
		map.put("role", role);
		return this.getList("getRoleByRole", map);
	}

	public int getRoleSizeByRole(Role role) {
		return this.get("getRoleSizeByRole", role);
	}

	public void batchInsert(List<RoleFunctionRelation> list) {
		this.batchInsert("saveRoleFunctionRelation", list);
	}

	public void batchInsertRoleOperation(List<RoleOperationRelation> list) {
		this.batchInsert("saveRoleOperationRelation", list);
	}

	public List<RoleFunctionRelation> getRoleFunctionRelationsByRoleId(
			String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		return this.getList("getRoleFunctionRelationsByRoleId", map);
	}

	public List<Function> getFunctionsByRoleId(String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		return this.getList("getFunctionsByRoleId", map);
	}

	public void deleteRoleFunctions(String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		this.getBatchSqlSession().delete("deleteRoleFunctions", map);
	}

	/**
	 *
	 * <P>
	 * 依据角色ID删除所有角色-操作关联
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 15, 2016
	 * @param id
	 */
	public void deleteRoleOperations(String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		this.getBatchSqlSession().delete("deleteRoleOperations", map);
	}

	public void deleteRoleFunctionsByFunctionId(String functionId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("functionId", functionId);
		this.getBatchSqlSession()
				.delete("deleteRoleFunctionsByFunctionId", map);
	}

	public void deleteRoleFunctionsByRoleId(String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		this.getBatchSqlSession().delete("deleteRoleFunctionsByRoleId", map);
	}

	/**
	 *
	 * <P>
	 * 依据操作ID删除role-operation关联
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 15, 2016
	 * @param id
	 */
	public void deleteRoleOperationsByOperationId(String operationId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("operationId", operationId);
		this.getBatchSqlSession().delete("deleteRoleOperationsByOperationId",
				map);
	}

	/**
	 *
	 * <P>
	 * 拿到该角色所有Operation
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 17, 2016
	 * @param roleId
	 * @return
	 */
	public String getRoleOperationCodeStrByRoleId(String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		return this.get("getRoleOperationCodeStrByRoleId", map);
	}

	/**
	 *
	 * <P>
	 * 通过角色Id拿到该角色所有有权限的操作
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 17, 2016
	 * @param roleId
	 * @return
	 */
	public List<RoleOperationRelation> getRoleOperationLsitByRoleId(
			String roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleId", roleId);
		return this.getList("getRoleOperationLsitByRoleId", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有非系统管理员的角色列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return List<Role>
	 */
	public List<Role> getNoSystemRoleList() {
		return this.getList("getNoSystemRoleList");
	}

	/**
	 *
	 * <P>
	 * 获取某roleKey的角色
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param roleKey
	 * @return Role
	 */
	public Role getRoleByRoleKey(String roleKey) {
		return this.get("getRoleByRoleKey", roleKey);
	}

}