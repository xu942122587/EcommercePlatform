package com.unitever.platform.util;

import java.util.ArrayList;
import java.util.List;

import com.unitever.platform.core.config.Config;

public class ResourcesUtil {

	public static List<String> getkeyList(String key) {
		if (key.equals(Config.PUBLIC_OPERATION_BL)) {
			List<String> list = new ArrayList<String>();
			list.add("/bd/welcome/welcome");// 登陆页页面
			list.add("/bd/welcome/ajaxValidationUser");// 登陆验证
			list.add("/weChat/WeChatHandler");// 登陆页页面
			list.add("/sys/attachment/showPic");
			list.add("/sys/attachment/showTempPic");
			list.add("/qrcode/printQRCode");
			list.add("/platform/pdfJS/web/viewer.html");
			return list;
		} else if (key.equals(Config.PUBLIC_OPERATION_AL)) {
			List<String> list = new ArrayList<String>();
			list.add("/qrcode/printQRCode");
			list.add("/bd/welcome/login");// 首页
			list.add("/bd/welcome/logout");// 注销
			list.add("/user/userDetail");// 修改个人信息
			list.add("/user/updateSelfDetail");// 修改个人信息
			list.add("/user/validateUserIsExist");// 验证账户是否重复
			list.add("/user/toChangePassword");// 跳转至修改密码页面
			list.add("/user/changePassword");// 修改密码
			list.add("/user/passwordIsRight");// 验证密码是否正确
			list.add("/sys/attachment/saveUploadFile");
			list.add("/sys/attachment/ajaxDeleteUploadFile");
			list.add("/sys/attachment/saveUEditorFile");
			list.add("/sys/attachment/showPic");
			list.add("/sys/attachment/showTempPic");
			list.add("/sys/attachment/ajaxGetAttachment");
			list.add("/sys/attachmentConfig/ajaxGetConfig");
			list.add("/sys/attachmentConfig/saveUploadFile");
			list.add("/sys/attachmentConfig/save");
			list.add("/sys/attachmentConfig/ajaxDele");
			list.add("/sys/i18n/ajaxGetI18nValues");
			list.add("/bd/welcome/getSalesCount");
			list.add("/notice/view");
			list.add("/platform/pdfJS/web/viewer.html");
			return list;
		}
		return null;
	}

}
