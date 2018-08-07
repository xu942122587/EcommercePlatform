package com.unitever.auth.user.controller;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.role.model.Role;
import com.unitever.auth.role.service.RoleService;
import com.unitever.auth.user.model.User;
import com.unitever.auth.user.service.UserService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;

@Controller
@RequestMapping(value = "/user")
public class UserController extends SpringController {

	/**
	 * 跳转至用户列表页面
	 * 
	 * @param page
	 * @param propaganda
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<User> page, @FormModel("model") User user) {
		user.setState(User.USER_STATE_NORMAL);
		setAttribute("pageObj", userService.getPage(page, user));
		setAttribute("model", user);
		return "auth/user/user-list";
	}

	/**
	 * 跳转至修改用户密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toChangePassword", method = RequestMethod.GET)
	public String toChangePassword() {
		// setAttribute("model", UserHelper.getCurrUser());
		return "auth/user/user-changePassword";
	}

	/**
	 * 修改用户密码
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson changePassword() {
		AjaxJson json = new AjaxJson();
		String userId = getRequest().getParameter("id");
		String password = getRequest().getParameter("newPassword");
		userService.changePassworkWithUserId(userId, password);
		return json;
	}

	@RequestMapping(value = "/passwordIsRight", method = RequestMethod.POST)
	@ResponseBody
	public String passwordIsRight() {
		JSONObject object = new JSONObject();
		User userSession = (User) this.getRequest().getSession().getAttribute("user");
		String userId = userSession.getId();
		String password = this.getRequest().getParameter("password");
		if (StringUtils.isNotBlank(userId) && StringUtils.isNotBlank(password)) {
			User user = userService.getUserWithId(userId);
			if (user != null) {
				String passwordMD5 = new Md5PasswordEncoder().encodePassword(password, null);
				if (passwordMD5.equals(user.getPassword())) {
					object.put("valid", true);
				} else {
					object.put("valid", false);
				}
			} else {
				object.put("valid", false);
			}
		}
		return object.toString();
	}

	/**
	 * 跳转至--新增编辑用户页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		String inputKind = getRequest().getParameter("inputKind");
		if (Role.TYPE_SYSADMIN.equals(UserUtil.getCurrUser().getRole().getType())) {
			setAttribute("roles", roleService.getRoleList());
		} else {
			setAttribute("roles", roleService.getNoSystemRoleList());
		}
		setAttribute("storeList", storeService.getAllTianheStore());
		setAttribute("inputKind", inputKind);
		if ("update".equals(inputKind)) {
			setAttribute("model", userService.getUserWithId(id));
		}
		return "auth/user/user-add";
	}

	/**
	 * 跳转至查看用户
	 * 
	 * @return
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", userService.getUserWithId(id));
		return "auth/user/user-view";
	}

	/**
	 * 跳转至个人账户
	 * 
	 * @return
	 */
	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String userDetail() {
		return "auth/user/user-detail";
	}

	/**
	 * 修改自己的信息
	 */
	@RequestMapping(value = "/updateSelfDetail", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson updateSelfDetail(User user) {
		AjaxJson json = new AjaxJson();
		if (StringUtils.isNotBlank(user.getId())) {
			json.setMsg("修改个人信息成功！");
			userService.update(user);
			User user_ = userService.getUserWithId(user.getId());
			this.getRequest().getSession().setAttribute("user", user_);
		}
		json.setSuccess(true);
		return json;
	}

	/**
	 * 用户名是否可用验证--修改用户信息用
	 * 
	 * @return
	 */
	@RequestMapping(value = "/validateUserIsExist", method = RequestMethod.POST)
	@ResponseBody
	public String validateUserIsExist() {
		JSONObject object = new JSONObject();
		String remote = this.getRequest().getParameter("username");
		String userId = this.getRequest().getParameter("userId");
		if (StringUtils.isNotBlank(remote)) {
			User user = userService.getUserWithId(userId);
			if (user == null) {
				object.put("valid", true);
			} else {
				// 验证一下是否修改用户名，如果用户名还是之前的，可以验证通过
				if (remote.equals(user.getUsername())) {
					object.put("valid", true);
				} else {
					User user_ = userService.getUserWithLoginName(remote);
					if (user_ == null) {
						object.put("valid", true);
					} else {
						object.put("valid", false);
					}
				}

			}
		}
		return object.toString();
	}

	/**
	 * 用户名是否可用验证--添加用户用
	 * 
	 * @return
	 */
	@RequestMapping(value = "/isUserExist", method = RequestMethod.POST)
	@ResponseBody
	public String isUserExist() {
		JSONObject object = new JSONObject();
		String remote = this.getRequest().getParameter("username");
		if (StringUtils.isNotBlank(remote)) {
			User user = userService.getUserWithLoginName(remote);
			if (user == null) {
				object.put("valid", true);
			} else {
				object.put("valid", false);
			}
		}
		return object.toString();
	}

	/**
	 * 保存用户信息
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(User user) {
		AjaxJson json = new AjaxJson();
		if (StringUtils.isNotBlank(user.getId())) {
			json.setMsg("修改用户成功！");
			userService.update(user);
			// 因为防止，在跳到修改界面后，拿不到最新的用户数据，所以要从新从数据库去取
			User userSession = (User) this.getRequest().getSession().getAttribute("user");
			// 修改的是当前用户，要更新session
			if (userSession.getId().equals(user.getId())) {
				User user_ = userService.getUserWithId(user.getId());
				this.getRequest().getSession().setAttribute("user", user_);
			}
		} else {
			json.setMsg("添加用户成功！");
			userService.save(user);
		}
		json.setSuccess(true);
		return json;
	}

	/**
	 * 删除用户
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String id) {
		AjaxJson json = new AjaxJson();
		User user = new User(id);
		user.setState(User.USER_STATE_REMOVE);
		try {
			userService.update(user);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("删除用户失败，稍后再试试吧~");
		}
		json.setSuccess(true);
		return json;
	}

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private StoreService storeService;
}