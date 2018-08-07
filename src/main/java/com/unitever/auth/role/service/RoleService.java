package com.unitever.auth.role.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.function.model.Function;
import com.unitever.auth.role.dao.manual.RoleDAO;
import com.unitever.auth.role.model.Role;
import com.unitever.auth.role.model.RoleFunctionRelation;
import com.unitever.auth.role.model.RoleOperationRelation;
import com.unitever.platform.core.dao.Page;

@Service
@Transactional
public class RoleService {

	@Autowired
	private RoleDAO roleDAO;

	public Page<Role> getPage(Page<Role> page, Role role) {
		List<Role> roleList = roleDAO.getRoleByRole(role,
				page.getStartOfPage(), page.getPageSize());
		page.setTotalRecord(roleDAO.getRoleSizeByRole(role));
		page.setResults(roleList);
		return page;
	}

	public void save(Role role) {
		if (role != null) {
			roleDAO.save(role);
		}
	}

	public Role getRoleWithId(String id) {
		return roleDAO.get(id);
	}

	/**
	 *
	 * <P>
	 * 获取所有角色列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return List<Role>
	 */
	public List<Role> getRoleList() {
		return roleDAO.getAll();
	}

	public void update(Role role) {
		roleDAO.update(role);
	}

	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			roleDAO.deleteRoleFunctionsByRoleId(id);
			roleDAO.deleteRoleOperations(id);
			roleDAO.delete(id);
		}
	}

	public void batchInsert(List<RoleFunctionRelation> list) {
		roleDAO.batchInsert(list);
	}

	public void batchInsertRoleOperation(List<RoleOperationRelation> list) {
		roleDAO.batchInsertRoleOperation(list);
	}

	public List<RoleFunctionRelation> getRoleFunctionRelationsByRoleId(
			String roleId) {
		return roleDAO.getRoleFunctionRelationsByRoleId(roleId);
	}

	public List<Function> getFunctionsByRoleId(String roleId) {
		return roleDAO.getFunctionsByRoleId(roleId);
	}

	public void deleteRoleFunctions(String roleId) {
		roleDAO.deleteRoleFunctions(roleId);
	}

	public void deleteRoleOperations(String roleId) {
		roleDAO.deleteRoleOperations(roleId);
	}

	public void deleteRoleFunctionsByFunctionId(String functionId) {
		roleDAO.deleteRoleFunctionsByFunctionId(functionId);
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
		return roleDAO.getRoleOperationCodeStrByRoleId(roleId);
	}

	/**
	 *
	 * <P>
	 * 获取所有非系统管理员的角色列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Role> getNoSystemRoleList() {
		return roleDAO.getNoSystemRoleList();
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
		return roleDAO.getRoleByRoleKey(roleKey);
	}
}