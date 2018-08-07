package com.unitever.module.store.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.unitever.module.promotionGroup.service.PromotionGroupService;
import com.unitever.module.shoppingcart.dao.manual.ShoppingcartDAO;
import com.unitever.module.store.dao.manual.StoreDAO;
import com.unitever.module.store.model.Store;
import com.unitever.module.storeProperty.service.StorePropertyService;
import com.unitever.platform.component.attachment.util.AttachmentUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.store.service->StoreService.java
 * </p>
 * <P>
 * 门店serivices
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Service
@Transactional
public class StoreService {

	private Logger logger_storeService = LoggerFactory.getLogger("StoreService");

	@Autowired
	private StoreDAO storeDAO;
	@Autowired
	private StorePropertyService storePropertyService;
	@Autowired
	private PromotionGroupService promotionGroupService;
	@Autowired
	private ShoppingcartDAO shoppingcartDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param store
	 *            void
	 */
	public int save(Store store) {
		if (store != null) {
			store.setId(UUID.getUUID());
			store.setCreateTime(new Date());
			store.setIsDelete(Store.ISDELETE_NO);
			store.setState(Store.STATE_NO_STOP);
			int i = storeDAO.save(store);
			if (0 < i) {
				AttachmentUtil.bindAttachment(store);
				storePropertyService.batchInsert(store.getStorePropertieNew(), store.getId());
				return i;
			}
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param store
	 * @return int
	 */
	public int update(Store store) {
		if (null != store) {
			if (StringUtils.isNotBlank(store.getId())) {
				int i = storeDAO.update(store);
				if (0 < i) {
					AttachmentUtil.bindAttachment(store);
					storePropertyService.batchInsert(store.getStorePropertieNew(), null);
					storePropertyService.batchUpdate(store.getStorePropertieList());
					storePropertyService.batchDelete(store.getStorePropertieDelete());
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return Store
	 */
	public Store getStoreById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storeDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param store
	 * @return List<Store>
	 */
	public List<Store> getStoreByStore(Store store) {
		return storeDAO.getStoreByStore(store);
	}

	/**
	 * 获取符合当前条件的Store数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param store
	 * @return int
	 */
	public int getCountByStore(Store store) {
		return storeDAO.getCountByStore(store);
	}

	/**
	 *
	 * <P>
	 * 获取store分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param store
	 * @return Page<Store>
	 */
	public Page<Store> getPage(Page<Store> page, Store store) {
		if (StringUtils.isNotBlank(store.getEndDate())) {
			store.setEndDate(store.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(storeDAO.getCountByObject(store));
		store.setStartOfPage(page.getStartOfPage());
		store.setPageSize(page.getPageSize());
		page.setResults(storeDAO.getStoreByStore(store));
		if (StringUtils.isNotBlank(store.getEndDate())) {
			store.setEndDate(store.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除门店--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	public int deleteStore(String id) {
		if (StringUtils.isNotBlank(id)) {
			Store store = new Store(id);
			store.setIsDelete(Store.ISDELETE_YES);
			int i = storeDAO.update(store);
			if (0 < i) {
				shoppingcartDAO.deleteByStoreId(id);
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有门店--直营店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Store> getAllStore() {
		return storeDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取所有营业门店--直营店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Store> getAllStartStore() {
		return storeDAO.getAllStartStore();
	}

	/**
	 *
	 * <P>
	 * 获取所有商家店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Store> getAllNoTianheStore() {
		return storeDAO.getAllNoTianheStore();
	}

	/**
	 *
	 * <P>
	 * 获取所有直营店和小商品店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Store> getAllTianheStore() {
		return storeDAO.getAllTianheStore();
	}

	/**
	 *
	 * <P>
	 * 门店停业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storeStop(String id) {
		if (StringUtils.isBlank(id))
			return 0;
		int i = storeDAO.storeStop(id);
		if (0 < i) {
			shoppingcartDAO.deleteByStoreId(id);
		}
		return i;
	}

	/**
	 *
	 * <P>
	 * 门店营业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storeStart(String id) {
		return StringUtils.isBlank(id) ? 0 : storeDAO.storeStart(id);
	}

	/**
	 *
	 * <P>
	 * 根据用户购物车获取其商品所属门店
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月28日
	 * @param customerId
	 * @return List<Store>
	 */
	public List<Store> getStoreByCustomerId(String customerId) {
		return StringUtils.isBlank(customerId) ? null : storeDAO.getStoreByCustomerId(customerId);
	}

	/**
	 *
	 * <P>
	 * 客户端获取门店信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 12, 2017
	 * @param storeCode
	 * @return AjaxJson
	 */
	public AjaxJson getClisentStoreMsgByStoreCode(String storeCode) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(storeCode)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取门店信息失败，请联系技术人员~");
			logger_storeService.error("客户端获取门店信息传入门店code为空，请检查代码实现！");
			return ajaxJson;
		}
		Store store = this.getStoreByStoreCode(storeCode);
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			if (Store.TYPE_TWO.equals(store.getType())) {
				ajaxJson.setSuccess(true);
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("storeName", store.getName());
				jsonObject.put("storeId", store.getId());
				jsonObject.put("promotionPayType",
						promotionGroupService.getProGroupPayTypesByNoTianheStoreId(store.getId()));
				ajaxJson.setObj(jsonObject);
			} else if (Store.TYPE_ONE.equals(store.getType())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本单请引导客户去往--" + store.getName() + "--店内开票哦~");
			} else if (Store.TYPE_THREE.equals(store.getType())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本单请引导客户去往服务台开票~");
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("门店信息未知类型，请联系管理人员确认门店信息是否录入正确");
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("门店不存在，请重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据门店code获取门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 12, 2017
	 * @param storeCode
	 * @return Store
	 */
	public Store getStoreByStoreCode(String storeCode) {
		return StringUtils.isBlank(storeCode) ? null : storeDAO.getStoreByStoreCode(storeCode);
	}
}
