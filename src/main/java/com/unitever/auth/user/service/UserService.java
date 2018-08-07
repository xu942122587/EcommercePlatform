package com.unitever.auth.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.role.service.RoleService;
import com.unitever.auth.user.dao.manual.UserDAO;
import com.unitever.auth.user.model.User;
import com.unitever.module.cashierUserLoginAndLogout.model.CashierUserLoginAndLogout;
import com.unitever.module.cashierUserLoginAndLogout.service.CashierUserLoginAndLogoutServices;
import com.unitever.module.client.service.ClientShoppingcartService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;

@Service
@Transactional
public class UserService {
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private RoleService roleService;
	@Autowired
	private ClientShoppingcartService clientShoppingcartService;
	@Autowired
	private CashierUserLoginAndLogoutServices cashierUserLoginAndLogoutServices;

	public Page<User> getPage(Page<User> page, User user) {
		page.setTotalRecord(userDAO.getCountByObject(user));
		user.setStartOfPage(page.getStartOfPage());
		user.setPageSize(page.getPageSize());
		page.setResults(userDAO.getUserWithUser(user));
		return page;
	}

	public List<User> getUserWithUser(User user) {
		return userDAO.getUserWithUser(user);
	}

	public boolean validationUser(String loginName, String password, HttpServletRequest request) throws Exception {
		if (StringUtils.isBlank(loginName) || StringUtils.isBlank(password)) {
			throw new Exception("用户名或密码不能为空！(The username or password cannot be empty)");
		}
		User user = this.getUserWithLoginName(loginName);
		if (user == null) {
			return false;
		}
		// 将User放入session
		request.getSession().setAttribute("user", user);
		// 将用户权限放入session中
		request.getSession().setAttribute("operations", user.getOperationsList());
		String passwordMD5 = new Md5PasswordEncoder().encodePassword(password, null);
		if (!passwordMD5.equals(user.getPassword())) {
			return false;
		}
		return true;
	}

	public User getUserWithLoginName(String loginName) {
		if (StringUtils.isBlank(loginName)) {
			return null;
		}
		return userDAO.getUserWithLoginName(loginName);
	}

	public User getUserWithId(String id) {
		return userDAO.get(id);
	}

	public void changePassworkWithUserId(String userId, String password) {
		User user = userDAO.get(userId);
		user.setPassword(new Md5PasswordEncoder().encodePassword(password, null));
		userDAO.update(user);
	}

	public List<User> getUserList() {
		return userDAO.getAll();
	}

	public void update(User user) {
		if (StringUtils.isNotBlank(user.getPassword())) {
			// 只有在密码不为空时，才进行MD5加密，防止将空密码加密后存储
			user.setPassword(new Md5PasswordEncoder().encodePassword(user.getPassword(), null));
		}
		userDAO.update(user);

	}

	public void delete(String id) {
		userDAO.delete(id);
	}

	public void save(User user) {
		user.setPassword(new Md5PasswordEncoder().encodePassword(user.getPassword(), null));
		userDAO.save(user);
	}

	/**
	 *
	 * <P>
	 * 获取所有非系统管理员类型的用户list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 26, 2016
	 * @return Object
	 */
	public List<User> getAllNoSYSUserList() {
		return userDAO.getAllNoSYSUserList();
	}

	/**
	 *
	 * <P>
	 * 客户端使用，验证登录用户是否正确
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 19, 2017
	 * @param username
	 * @param password
	 * @return boolean
	 */
	public AjaxJson validationUserByClient(String username, String password, String cashierCode) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(cashierCode)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("登录失败，请联系技术人员~");
			return ajaxJson;
		}
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("用户名或密码不能为空！");
			return ajaxJson;
		}
		User user = this.getUserWithLoginName(username);
		if (user == null) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("用户名不存在！");
			return ajaxJson;
		}
		if (!user.getRole().getRoleKey().equals("client_login")) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("该账号不具备收银权限！");
			return ajaxJson;
		}
		String passwordMD5 = new Md5PasswordEncoder().encodePassword(password, null);
		if (!passwordMD5.equals(user.getPassword())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("密码错误！");
			return ajaxJson;
		}

		User user_to_return = new User(user.getId());
		user_to_return.setName(user.getName());
		user_to_return.setUserCode(user.getUsername());

		CashierUserLoginAndLogout cashierUserLoginAndLogout = cashierUserLoginAndLogoutServices
				.getNoLogoutMsgByCashierUserId(user.getId());
		if (null != cashierUserLoginAndLogout && StringUtils.isNotBlank(cashierUserLoginAndLogout.getId())) {
			if (!cashierUserLoginAndLogout.getCashierCode().equals(cashierCode)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("当前账号在" + cashierUserLoginAndLogout.getCashierCode() + "款台有未交班记录，请先交班~");
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(true);
				ajaxJson.setObj(user_to_return);
				return ajaxJson;
			}
		} else {
			clientShoppingcartService.initWithUserLogin(user.getId());
			CashierUserLoginAndLogout cashierUserLoginAndLogout_toSave = new CashierUserLoginAndLogout();
			cashierUserLoginAndLogout_toSave.setCashierUser(user);
			cashierUserLoginAndLogout_toSave.setCashierCode(cashierCode);
			if (0 >= cashierUserLoginAndLogoutServices.save(cashierUserLoginAndLogout_toSave)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("登录失败，请稍后重试~");
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(true);
				ajaxJson.setObj(user_to_return);
				return ajaxJson;
			}
		}
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
		return userDAO.getGuideUserList();
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取关联用户
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @param id
	 * @return Object
	 */
	public List<User> getUserListByStoreId(String storeId) {
		return StringUtils.isNotBlank(storeId) ? userDAO.getUserListByStoreId(storeId) : null;
	}
}