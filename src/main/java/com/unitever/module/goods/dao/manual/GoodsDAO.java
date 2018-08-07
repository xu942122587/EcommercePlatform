package com.unitever.module.goods.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.goods.model.Goods;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class GoodsDAO extends BaseDAO<Goods, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Qrcode
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsByGoods(Goods goods) {
		return this.getList("getGoodsByGoods", goods);
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
		return this.getList("getGoodsForIsRecommed", null);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.getList("getGoodsChildById", map);
	}

	/**
	 *
	 * <P>
	 * 依据门店获取所有未删除主商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月8日
	 * @param id
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsByStoreId(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.getList("getGoodsByStoreId", map);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取微信端主商品-上架，正常商品，未删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 15, 2017
	 * @param id
	 * @return List<Goods>
	 */
	public List<Goods> getWechatGoodsByStoreId(String storeId, String classId) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		map.put("classId", classId);
		return this.getList("getWechatGoodsByStoreId", map);
	}

	/**
	 * 获取符合当前条件的Goods数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Qrcode
	 * @return int
	 */
	public int getCountByGoods(Goods goods) {
		return this.get("getCountByGoods", goods);
	}

	/**
	 *
	 * <P>
	 * 当前分类的所有商品的数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月5日
	 * @param id
	 * @return int
	 */
	public int getCountByClassificationId(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.get("getCountByClassificationId", map);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.get("getContByAbnormalGoods", map);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.get("getCountByStoreId", map);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("deleteAll", map);
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchInsert(List<Goods> list) {
		return this.batchInsert("save", list);
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
	public int batchUpdate(List<Goods> list) {
		return this.batchUpdate("update", list);
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
		return this.batchUpdate("deleteAll", list);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("qRCodeID", qRCodeID);
		return this.get("getGoodsByQRCodeID", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有主产品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 8, 2017
	 * @return List<Goods>
	 */
	public List<Goods> getAllParentGoods() {
		return this.getList("getAllParentGoods");
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("abnormalAllByclassificationId", map);
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
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("goodsId", goodsId);
		map.put("storageId", storageId);
		return this.getList("getGoodsChildListByInventoryGoodsId", map);
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
	public Goods getGoodsByGoodsAttr(String goodsId, List<String> goodsAttrList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("goodsId", goodsId);
		map.put("goodsAttrList", goodsAttrList);
		return this.get("getGoodsByGoodsAttr", map);
	}

	/**
	 *
	 * <P>
	 * 获取商品分页列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param goods
	 * @param offset
	 * @param limit
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsForPage(Goods goods, int offset, int limit) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("goods", goods);
		return this.getList("getGoodsForPage", params);
	}

	/**
	 *
	 * <P>
	 * 获取商品分页列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param goods
	 * @param offset
	 * @param limit
	 * @return List<Goods>
	 */
	public List<Goods> getGoodsListForPage(Goods goods, int offset, int limit, List<String> classList) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("classList", classList);
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("goods", goods);
		return this.getList("getGoodsListForPage", params);
	}

	/**
	 *
	 * <P>
	 * 获取符合要求的商品的数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param goods
	 * @return int
	 */
	public int getGoodsCountForIndex(Goods goods) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("goods", goods);
		return this.get("getGoodsCountForIndex", params);
	}

	/**
	 *
	 * <P>
	 * 获取符合要求的商品List的数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param goods
	 * @return int
	 */
	public int getGoodsListCountForIndex(Goods goods, List<String> classList) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("classList", classList);
		params.put("goods", goods);
		return this.get("getGoodsListCountForIndex", params);
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
		return this.update("updateGoodsAll", goods);
	}

	/**
	 *
	 * <P>
	 * 获取所有小商品店的产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @return List<Goods>
	 */
	public List<Goods> getAllGaveGoodsList() {
		return this.getList("getAllGaveGoodsList");
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
		Map<String, String> map = new HashMap<>();
		map.put("store_id", store_id);
		map.put("goodsCode", goodsCode);
		map.put("class_id", class_id);
		return this.getList("getGoodsListWhithProGroup", map);
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
	 * @return Object
	 */
	public List<Goods> getPutOutGoodsListByOrderCode(String orderCode) {
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.getList("getPutOutGoodsListByOrderCode", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.getList("getChangeEnoughGoodsListByOrderCode", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("shoppingcartList", shoppingcartList);
		return this.get("getErroGoodsNameByShoppingCart", map);
	}
}
