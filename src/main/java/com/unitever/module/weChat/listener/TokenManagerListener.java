package com.unitever.module.weChat.listener;

import java.util.List;

import org.springframework.beans.factory.InitializingBean;

import com.unitever.module.weChat.model.WeChat;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.platform.util.AlipayApiUtil;
import com.unitever.platform.util.WeChatScanPayUtil;

import weixin.popular.support.TicketManager;
import weixin.popular.support.TokenManager;

public class TokenManagerListener implements InitializingBean {

	/*
	 * 给web容器添加一个Listener类，在容器启动的时候执行Listener的“初始化”方法，在这个初始化方法中执行查询数据库的所有操作，
	 * 然后将数据库中的信息缓存起来
	 * 问题：上面的方法很好，但问题是如何去查询数据库，由于使用了spring的IOC特性，查询数据库的service控制dao层，dao层访问数据库，
	 * 而Listener类只是在系统启动的时候会执行初始化方法，但是“service”对象没有被spring管理，
	 * 也就是说没有service对象访问数据库，
	 * 只能使用jdbc的方式连接，这个很显然不符合MVC开发的特性。那么如何才能在启动web容器的时候利用spring的IOC特性呢？
	 * 解决方法：spring给出的解决方案——写一个类，实现InitializingBean接口，然后交由spring容器管理
	 */

	private WeChatService weChatService;

	public WeChatService getWeChatService() {
		return weChatService;
	}

	public void setWeChatService(WeChatService weChatService) {
		this.weChatService = weChatService;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// 在这个方法里面写 初始化的数据也可以。
		System.out.println("<<<<<<<<<<初始化");
		List<WeChat> weChatList = weChatService.getWeChatList();
		if (null == weChatList || weChatList.isEmpty()) {
			System.err.println("微信公众号信息为空，系统启动失败，请联系技术人员解决~");
			// System.exit(0);
			System.out.println("<<<<<<<<<<初始化失败");
		} else {
			// 默认只加载第一个公众号信息，单公众号版
			WeChat weChat = weChatList.get(0);
			// 初始化微信退款所需内容
			WeChatScanPayUtil.initScanPay(weChat);
			// 初始化支付宝退款所需内容
			AlipayApiUtil.initScanPay(weChat);
			TokenManager.init(weChat.getAppid(), weChat.getAppsecret());
			Thread.sleep(2000);
			TicketManager.init(weChat.getAppid());
			System.out.println("<<<<<<<<<<初始化完成");
		}
	}

}
