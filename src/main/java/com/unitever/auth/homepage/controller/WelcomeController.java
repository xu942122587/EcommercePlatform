package com.unitever.auth.homepage.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.homepage.util.ValidatePatchca;
import com.unitever.auth.user.model.User;
import com.unitever.auth.user.service.UserService;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.module.inventory.vo.InventoryVO;
import com.unitever.module.notice.service.NoticeService;
import com.unitever.platform.core.web.controller.SpringController;

@Controller
@RequestMapping("/bd/welcome")
public class WelcomeController extends SpringController {

	@Autowired
	private UserService userService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private InventoryDAO inventoryDAO;

	@RequestMapping("/welcome")
	public String welcome() {
		this.getRequest().setAttribute("productTitle", User.PRODUCTTITLE);
		return "/homepage/welcome";
	}

	// 登陆，然后去toIndex页面，跳转到其他业务模块
	@RequestMapping("/login")
	public String login() {
		// request.getSession().setAttribute("user", user);
		User user = (User) this.getRequest().getSession().getAttribute("user");
		// 获取所有父权限
		if (null != user.getStore() && StringUtils.isNotBlank(user.getStore().getId())) {
			setAttribute("abnormaiGoodsCount", goodsService.getContByAbnormalGoods(user.getStore().getId()));
			setAttribute("user", user);
		} else {
			setAttribute("abnormaiGoodsCount", goodsService.getContByAbnormalGoods(null));
		}
		setAttribute("parentFunctions", user.getRole().getParentFunctions());
		setAttribute("functionIds", user.getRole().getFunctionIds());
		setAttribute("noticeList", noticeService.getAllNotice());
		setAttribute("inventoryVOList", inventoryDAO.getInventoryVOList(new InventoryVO()));
		return "/index/index";
	}

	// 登陆，然后去toIndex页面，跳转到其他业务模块
	@RequestMapping("/logout")
	public String logout() {
		this.getRequest().getSession().removeAttribute("user");
		this.getRequest().getSession().removeAttribute("operations");
		return "/homepage/welcome";
	}

	@RequestMapping("/ajaxValidationUser")
	@ResponseBody
	public void ajaxValidationUser() {
		String loginName = this.getRequest().getParameter("loginName");
		String password = this.getRequest().getParameter("password");
		String result = "{\"successStatus\":\"false\",\"errorMsg\":\"用户名或密码错误！(Username or password error)\"}";
		try {
			boolean isSuccess = userService.validationUser(loginName, password, this.getRequest());
			if (isSuccess) {
				result = "{\"successStatus\":\"true\"}";
			}
		} catch (Exception e) {
			result = "{\"successStatus\":\"false\",\"errorMsg\":\"" + e.getMessage() + "\"}";
		}
		this.print(result);
	}

	/**
	 * 获取验证码图片
	 */
	@RequestMapping("/validatePatchca")
	@ResponseBody
	public void validatePatchca() {
		ValidatePatchca.patchca(this.getRequest(), this.getResponse());
	}

	/**
	 * 获取验证码数字
	 */
	@RequestMapping("/getSessionPatchca")
	@ResponseBody
	public void getSessionPatchca() {
		String token = (String) this.getRequest().getSession().getAttribute("PATCHCA");
		this.print(token);
	}

	/**
	 * 验证 验证码是否正确
	 */
	@RequestMapping("/validateSessionPatchca")
	@ResponseBody
	public void validateSessionPatchca(String imgjudge) {
		if (StringUtils.isBlank(imgjudge)) {
			this.print(String.valueOf(false));
		}
		String token = (String) this.getRequest().getSession().getAttribute("PATCHCA");
		this.print(String.valueOf(imgjudge.equals(token)));
	}
}