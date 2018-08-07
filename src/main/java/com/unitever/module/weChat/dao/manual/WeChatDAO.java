package com.unitever.module.weChat.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.weChat.model.WeChat;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class WeChatDAO extends BaseDAO<WeChat, String> {

	/**
	 * <p>
	 * 根据WeChat条件查询WeChat
	 * </p>
	 * 
	 * @param WeChat
	 * @return List<WeChat>
	 */
	public List<WeChat> getWeChatByWeChat(WeChat weChat) {
		return this.getList("getWeChatByWeChat", weChat);
	}

	public WeChat getWeChatWithWeChatNum(String weChatNum) {
		WeChat weChat = new WeChat();
		weChat.setWechatnum(weChatNum);
		return this.get("getWeChatByWeChat", weChat);
	}

	public WeChat getWeChatWithAppId(String appid) {
		WeChat weChat = new WeChat();
		weChat.setAppid(appid);
		return this.get("getWeChatByWeChat", weChat);
	}

	/**
	 *
	 * <P>
	 * 保存消费者每日抽奖次数上限
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 14, 2016
	 * @param prizeMaxCount
	 */
	public void updatePrizeMaxCount(String prizeMaxCount) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prizeMaxCount", prizeMaxCount);
		this.update("updatePrizeMaxCount", map);
	}
}