package com.unitever.module.client.service;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.user.model.User;
import com.unitever.module.client.dao.manual.ClientShoppingcartDAO;
import com.unitever.module.client.model.ClientShoppingcart;
import com.unitever.module.goods.controller.GoodsController;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.client.service->
 * ClientShoppingcartService.java
 * </p>
 * <P>
 * 收银购物车Serices
 * </p>
 *
 * @author 闫枫
 * @date Jul 22, 2017
 */
@Service
@Transactional
public class ClientShoppingcartService {

	@Autowired
	private ClientShoppingcartDAO clientShoppingcartDAO;
	@Autowired
	private QrcodeService qrcodeService;

	/**
	 *
	 * <P>
	 * 保存客户端购物车商品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 22, 2017
	 * @param clientShoppingcart
	 * @return int
	 */
	public int save(ClientShoppingcart clientShoppingcart) {
		if (null != clientShoppingcart) {
			return clientShoppingcartDAO.save(clientShoppingcart);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 客户端登录时，初始化收银员购物车
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 22, 2017
	 * @param userId
	 * @return int
	 */
	public int initWithUserLogin(String userId) {
		return StringUtils.isNotBlank(userId) ? clientShoppingcartDAO.initWithUserLogin(userId) : 0;
	}

	/**
	 *
	 * <P>
	 * 客户端添加到购物车
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 22, 2017
	 * @param qrcodeId
	 * @param type
	 *            类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现）
	 * @return AjaxJson
	 */
	public AjaxJson addClientGoods(String qrcodeId, String type, String userId) {
		AjaxJson ajaxJson = new AjaxJson();
		Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
		if (null == qrcode) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("无法识别的二维码，请重试~");
		} else {
			if (StringUtils.isBlank(qrcode.getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("无法识别的二维码，请重试~");
			} else {
				if (ClientShoppingcart.TYPE_ONE.equals(type)) {
					// 卖出产品的各种情况过滤
					if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("亲，该二维码已被库存调拨单或采购退货单锁定，请先联系工作人员解锁才能卖出哦~");
					} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("亲，本件产品已经卖出了好像，不可以再次卖出哦~");
					} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("亲，本件产品已经退还厂家了，不可以卖出的哦~");
					} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
						// 产品状态正常，可以售出
						int i = 0;
						Goods goods = GoodsController.getGoodsToJsp(qrcode.getGoods());
						ClientShoppingcart clientShoppingcar = new ClientShoppingcart(UUID.getUUID(), new User(userId),
								goods, type, "1", goods.getSalesPrice(), new Date(), new Qrcode(qrcodeId));
						i = clientShoppingcartDAO.save(clientShoppingcar);
						if (0 >= i) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("录入产品出错，请重试~");
						} else {
							ajaxJson.setSuccess(true);
							ajaxJson.setObj(clientShoppingcar);
						}
					}
				} else if (ClientShoppingcart.TYPE_TWO.equals(type)) {
					if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
						// 卖出状态的产品可以退货
						// TODO---------------------等待后续实现-------------------------------------
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("亲，本件产品不是卖出的产品，不可退（换）货的哦~");
					}
				}
			}
		}
		return ajaxJson;
	}
}