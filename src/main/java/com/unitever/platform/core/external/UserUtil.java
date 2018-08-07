package com.unitever.platform.core.external;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.spring.SpringMVCUtil;

/**
 *
 * <P>
 * platform-xmk_2.0->com.unitever.platform.core.external->UserUtil.java
 * </p>
 * <P>
 * 获取当前userId
 * </p>
 *
 * @author 闫枫
 * @date May 5, 2017
 */
public class UserUtil {
	final static Logger logger = LoggerFactory.getLogger(UserUtil.class);

	/**
	 * 得到当前用户的ID
	 * 
	 * @author : 闫枫
	 */
	public static String getCurrUserID() {
		User user = null;
		try {
			user = (User) SpringMVCUtil.getRequest().getSession().getAttribute("user");
		} catch (Exception e) {
			user = null;
		}
		return null == user ? null : user.getId();
	}

	/**
	 * 得到当前用户的对象
	 * 
	 * @author : 闫枫
	 */
	public static User getCurrUser() {
		User user = null;
		try {
			user = (User) SpringMVCUtil.getRequest().getSession().getAttribute("user");
		} catch (Exception e) {
			user = null;
		}
		return null == user ? null : user;
	}
}
