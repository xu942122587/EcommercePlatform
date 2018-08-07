package com.unitever.module.goods.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.classification.model.Classification;
import com.unitever.module.goods.dao.manual.GoodsDAO;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.store.model.Store;
import com.unitever.module.weChat.vo.GoodsPageVo;
import com.unitever.platform.component.attachment.util.AttachmentUtil;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.JsonUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.goods.service->GoodsService.java
 * </p>
 * <P>
 * 商品Service
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月3日
 */
@Service
@Transactional
public class GoodsService {

	@Autowired
	private GoodsDAO goodsDAO;

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 *            待保存的list
	 * @param goodsId
	 *            门店ID，新建的门店必须传入，其他情况可传入null
	 * @return int
	 */
	public int batchInsert(List<Goods> list, Goods goods) {
		if (null != list) {
			if (!list.isEmpty()) {
				Iterator<Goods> it = list.iterator();
				while (it.hasNext()) {
					Goods goods_ = it.next();
					if (null == goods_.getOther_map_to_save() || goods_.getOther_map_to_save().isEmpty()) {
						it.remove();
					}
				}
				if (null == list || list.isEmpty()) {
					return 0;
				}
				boolean isHaveGoods = false;
				if (null == list.get(0).getGoods() || StringUtils.isBlank(list.get(0).getGoods().getId())) {
					if (null != goods && StringUtils.isNotBlank(goods.getId())) {
						isHaveGoods = false;
					} else {
						return 0;
					}
				} else {
					isHaveGoods = true;
				}
				List<Goods> list_to_save = new ArrayList<Goods>();
				for (Goods goods_for : list) {
					if (!isHaveGoods) {
						goods_for.setGoods(goods);
					}
					goods_for.setStore(goods.getStore());
					goods_for.setClassification(goods.getClassification());
					goods_for.setSpecification(goods.getSpecification());
					goods_for.setBrand(goods.getBrand());
					goods_for.setPrice(goods.getPrice());
					goods_for.setSalesPrice(goods.getSalesPrice());
					goods_for.setOtherAttr(JsonUtil.map2Json(goods_for.getOther_map_to_save()));
					list_to_save.add(goods_for);
				}
				list.clear();
				return goodsDAO.batchInsert(list_to_save);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量更新
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchUpdate(List<Goods> list, Goods goods) {
		if (null != list) {
			if (!list.isEmpty()) {
				Iterator<Goods> it = list.iterator();
				while (it.hasNext()) {
					Goods goods_ = it.next();
					if (null == goods_.getOther_map_to_save() || goods_.getOther_map_to_save().isEmpty()) {
						it.remove();
					}
				}
				if (null == list || list.isEmpty()) {
					return 0;
				}

				List<Goods> list_to_save = new ArrayList<Goods>();
				for (Goods goods_for : list) {
					goods_for.setOtherAttr(JsonUtil.map2Json(goods_for.getOther_map_to_save()));
					goods_for.setStore(goods.getStore());
					goods_for.setClassification(goods.getClassification());
					goods_for.setSpecification(goods.getSpecification());
					goods_for.setBrand(goods.getBrand());
					goods_for.setPrice(goods.getPrice());
					goods_for.setSalesPrice(goods.getSalesPrice());
					list_to_save.add(goods_for);
				}
				list.clear();
				return goodsDAO.batchUpdate(list_to_save);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchDelete(List<Goods> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return goodsDAO.batchDelete(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 保存商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goods
	 * @return int
	 */
	public int save(Goods goods) {
		if (goods != null) {
			goods.setId(UUID.getUUID());
			goods.setCreateTime(new Date());
			goods.setIsDelete(Goods.ISDELETE_NO);
			goods.setIsVisible(Goods.VISIBLE_TRUE);
			goods.setIsRecommed(Goods.RCOMMED_FALSE);
			goods.setIsAbnormal(Goods.ABNORMAL_FALSE);
			int i = goodsDAO.save(goods);
			if (0 < i) {
				this.batchInsert(goods.getGoodsChildListNew(), goods);
				AttachmentUtil.bindAttachment(goods);
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goods
	 * @return int
	 */
	public int update(Goods goods) {
		if (null != goods) {
			if (StringUtils.isNotBlank(goods.getId())) {
				// goods.setOtherAttr(JsonUtil.map2Json(goods.getOther_map_to_save()));
				int i = goodsDAO.update(goods);
				if (0 < i) {
					this.batchInsert(goods.getGoodsChildListNew(), goods);
					this.batchUpdate(goods.getGoodsChildList(), goods);
					this.batchDelete(goods.getGoodsChildListDelete());
					AttachmentUtil.bindAttachment(goods);
				}
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据id获取商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return Goods
	 */
	public Goods getGoodsById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return goodsDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据商品获取商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goods
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsByGoods(Goods goods) {
		return goodsDAO.getGoodsByGoods(goods);
	}

	/**
	 *
	 * <P>
	 * 根据店铺获取商品-未删除的主商品（所有的）
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月8日
	 * @param id
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsByStoreId(String id) {
		return goodsDAO.getGoodsByStoreId(id);
	}

	/**
	 *
	 * <P>
	 * 获取所有推荐商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月7日
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsForIsRecommed() {
		return goodsDAO.getGoodsForIsRecommed();
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取微信端主商品-上架，正常商品，未删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 15, 2017
	 * @param storeId
	 *            门店ID
	 * @return List<Goods>
	 */
	public List<Goods> getWechatGoodsByStoreId(String storeId, String classId) {
		return goodsDAO.getWechatGoodsByStoreId(storeId, classId);
	}

	/**
	 *
	 * <P>
	 * 获取商品数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goods
	 * @return int
	 */
	public int getCountByGoods(Goods goods) {
		return goodsDAO.getCountByGoods(goods);
	}

	/**
	 *
	 * <P>
	 * 获取异常商品数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月11日
	 * @return int
	 */
	public String getContByAbnormalGoods(String storeId) {
		return goodsDAO.getContByAbnormalGoods(storeId);
	}

	/**
	 *
	 * <P>
	 * 当前店铺的所有商品的数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月8日
	 * @param id
	 * @return int
	 */
	public int getCountByStoreId(String id) {
		return goodsDAO.getCountByStoreId(id);
	}

	/**
	 *
	 * <P>
	 * 获取商品分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param page
	 * @param goods
	 * @return Page<Goods>
	 */
	public Page<Goods> getPage(Page<Goods> page, Goods goods) {
		if (StringUtils.isNotBlank(goods.getEndDate())) {
			goods.setEndDate(goods.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(goodsDAO.getCountByObject(goods));
		goods.setStartOfPage(page.getStartOfPage());
		goods.setPageSize(page.getPageSize());
		page.setResults(goodsDAO.getGoodsByGoods(goods));
		if (StringUtils.isNotBlank(goods.getEndDate())) {
			goods.setEndDate(goods.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除商品(假删除)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return int
	 */
	public int deleteGoods(String id) {
		if (StringUtils.isNotBlank(id)) {
			Goods goods = new Goods(id);
			goods.setIsDelete(Goods.ISDELETE_YES);
			return goodsDAO.update(goods);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 删除主商品及其子商品(假删除)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return int
	 */
	public int deleteAll(String id) {
		if (StringUtils.isNotBlank(id)) {
			return goodsDAO.deleteAll(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @return List<Goods>
	 */
	public List<Goods> getAllGoods() {
		return goodsDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 上下架操作
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goodsId
	 * @return int
	 */
	public int doSetVisible(String goodsId, String flag) {

		if (StringUtils.isBlank(goodsId) || StringUtils.isBlank(flag)) {
			return 0;
		} else {
			Goods goods = new Goods(goodsId);

			goods.setIsVisible(flag);

			int tmp = update(goods);

			if (tmp > 0) {
				return 1;
			} else {
				return 0;
			}
		}
	}

	/**
	 *
	 * <P>
	 * 修改推荐状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goodsId
	 * @return AjaxJson
	 */
	public int doSetRecommed(String goodsId, String flag) {
		if (StringUtils.isBlank(goodsId) || StringUtils.isBlank(flag)) {
			return 0;
		} else {
			Goods goods = new Goods(goodsId);

			goods.setIsRecommed(flag);

			int tmp = update(goods);

			if (tmp > 0) {
				return 1;
			} else {
				return 0;
			}
		}

	}

	/**
	 *
	 * <P>
	 * 修改异常状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月10日
	 * @param goodsId
	 * @param flag
	 *            异常状态
	 * @return int
	 */
	public int doSetAbnormal(String goodsId, String flag) {
		if (StringUtils.isBlank(goodsId) || StringUtils.isBlank(flag)) {
			return 0;
		} else {
			Goods goods = new Goods(goodsId);

			goods.setIsAbnormal(flag);

			int tmp = update(goods);

			if (tmp > 0) {
				return 1;
			} else {
				return 0;
			}
		}

	}

	/**
	 *
	 * <P>
	 * 根据id获取所有子商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月4日
	 * @param id
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsChildById(String id) {
		return goodsDAO.getGoodsChildById(id);
	}

	/**
	 *
	 * <P>
	 * 依据QRCodeID获取产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param qRCodeID
	 * @return Goods
	 */
	public Goods getGoodsByQRCodeID(String qRCodeID) {
		return goodsDAO.getGoodsByQRCodeID(qRCodeID);
	}

	/**
	 *
	 * <P>
	 * 获取所有主产品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 8, 2017
	 * @return Object
	 */
	public List<Goods> getAllParentGoods() {
		return goodsDAO.getAllParentGoods();
	}

	/**
	 *
	 * <P>
	 * 设置当前类别的所有商品异常
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 15, 2017
	 * @param id
	 * @return int
	 */
	public int abnormalAllByclassificationId(String id) {
		return goodsDAO.abnormalAllByclassificationId(id);
	}

	/**
	 *
	 * <P>
	 * 依据主产品ID获取子产品的库存
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月13日
	 * @param id
	 * @return List<Inventory>
	 */
	public List<Goods> getGoodsChildListByInventoryGoodsId(String goodsId, String storageId) {
		return goodsDAO.getGoodsChildListByInventoryGoodsId(goodsId, storageId);
	}

	/**
	 *
	 * <P>
	 * 依据产品属性和产品Id获取产品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @return Goods
	 */
	public Goods getGoodsByGoodsAttr(String goodsId, List<String> goodsAttr) {
		return goodsDAO.getGoodsByGoodsAttr(goodsId, goodsAttr);
	}

	/**
	 *
	 * <P>
	 * 获取商品分段
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param page
	 * @param isRecommed
	 * @return GoodsPageVo
	 */
	public GoodsPageVo getGoodsForIndex(Integer page, String isRecommed, String storeId, String classId,
			String goodsName) {
		GoodsPageVo vo = new GoodsPageVo();
		Goods goods = new Goods();
		goods.setName(goodsName);
		goods.setIsRecommed(isRecommed);
		goods.setStore(new Store(storeId));
		goods.setClassification(new Classification(classId));
		if (page == null) {
			page = 1;
		} else {
			if (page <= 0) {
				page = 1;
			}
		}

		int offset = (page - 1) * 7;
		int limit = 7;
		List<Goods> list = goodsDAO.getGoodsForPage(goods, offset, limit);

		int totalCount = goodsDAO.getGoodsCountForIndex(goods);
		if ((offset + limit) >= totalCount) {
			vo.setIsHave("no");
		} else {
			vo.setIsHave("yes");
		}
		vo.setTotalRecord(totalCount);
		vo.setGoodsList(list);
		vo.setPageNo(page);
		return vo;

	}

	/**
	 *
	 * <P>
	 * 获取商品分段(多)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param page
	 * @param isRecommed
	 * @return GoodsPageVo
	 */
	public GoodsPageVo getGoodsListForIndex(Integer page, String isRecommed, String storeId, List<String> classList,
			String goodsName) {
		GoodsPageVo vo = new GoodsPageVo();
		Goods goods = new Goods();
		goods.setName(goodsName);
		goods.setIsRecommed(isRecommed);
		goods.setStore(new Store(storeId));
		if (page == null) {
			page = 1;
		} else {
			if (page <= 0) {
				page = 1;
			}
		}

		int offset = (page - 1) * 10;
		int limit = 10;
		List<Goods> list = goodsDAO.getGoodsListForPage(goods, offset, limit, classList);

		int totalCount = goodsDAO.getGoodsListCountForIndex(goods, classList);
		if ((offset + limit) >= totalCount) {
			vo.setIsHave("no");
		} else {
			vo.setIsHave("yes");
		}
		vo.setTotalRecord(totalCount);
		vo.setGoodsList(list);
		vo.setPageNo(page);
		return vo;

	}

	/**
	 *
	 * <P>
	 * 同时更新主产品和子产品的价格字段-依据子产品更新
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月28日
	 * @param goods
	 * @return int
	 */
	public int updateGoodsAll(Goods goods) {
		return goodsDAO.updateGoodsAll(goods);
	}

	/**
	 *
	 * <P>
	 * 获取所有小商品店的产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @return Object
	 */
	public List<Goods> getAllGaveGoodsList() {
		return goodsDAO.getAllGaveGoodsList();
	}

	/**
	 *
	 * <P>
	 * 活动分组获取产品级活动主产品备选项列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 21, 2017
	 * @param store_id
	 *            门店ID
	 * @param goodsCode
	 *            产品编号（模糊查询）
	 * @param class_id
	 *            所属分类ID（1、2、3级分类ID都可）
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsListWhithProGroup(String store_id, String goodsCode, String class_id) {
		return goodsDAO.getGoodsListWhithProGroup(store_id, goodsCode, class_id);
	}

	/**
	 *
	 * <P>
	 * 依据订单OrderCode获取赠品list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderCode
	 * @return List<Goods>
	 */
	public List<Goods> getPutOutGoodsListByOrderCode(String orderCode) {
		return StringUtils.isBlank(orderCode) ? null : goodsDAO.getPutOutGoodsListByOrderCode(orderCode);
	}

	/**
	 *
	 * <P>
	 * 订单Code获取可换购产品List
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 4, 2017
	 * @param orderCode
	 * @return List<Goods>
	 */
	public List<Goods> getChangeEnoughGoodsListByOrderCode(String orderCode) {
		return StringUtils.isBlank(orderCode) ? null : goodsDAO.getChangeEnoughGoodsListByOrderCode(orderCode);
	}

	/**
	 *
	 * <P>
	 * 根据购物车Id获取异常商品名称
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年3月31日
	 * @param shoppingcartList
	 * @return String
	 */
	public String getErroGoodsNameByShoppingCart(String shoppingcartList) {
		return goodsDAO.getErroGoodsNameByShoppingCart(shoppingcartList);
	}
}
