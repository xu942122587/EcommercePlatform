package com.unitever.auth.user.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class UserDAO extends BaseDAO<User, String> {

	/**
	 * 根据用户名得到启用的系统用户
	 */
	public User getUserWithLoginName(String loginName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", loginName);
		List<User> usrList = this.getList("getUserWithLoginName", params);
		return usrList.size() > 0 ? usrList.get(0) : null;
	}

	public List<User> getUserWithUser(User user) {
		return this.getList("getUserListWithUser", user);
	}

	/**
	 *
	 * <P>
	 * 获取所有非系统管理员类型的用户list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 26, 2016
	 * @return List<User>
	 */
	public List<User> getAllNoSYSUserList() {
		return this.getList("getAllNoSYSUserList", null);
	}

	/**
	 *
	 * <P>
	 * 获取导购列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param roleId
	 * @return List<User>
	 */
	public List<User> getGuideUserList() {
		return this.getList("getGuideUserList");
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取关联用户
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @param storeId
	 * @return List<User>
	 */
	public List<User> getUserListByStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.getList("getUserListByStoreId", map);
	}
}