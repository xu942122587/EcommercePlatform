package com.unitever.module.goods.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.unitever.module.brand.model.Brand;
import com.unitever.module.classification.model.Classification;
import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.classification.vo.ClassificationVO;
import com.unitever.module.specification.model.Specification;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;
import com.unitever.platform.util.MapUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.goods.model->Goods.java
 * </p>
 * <P>
 * 产品实体类
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月3日
 */
public class Goods extends BaseModel {

	/** Id */
	private String id;
	/** 商品名 */
	private String name;
	/** 商品 */
	private Goods goods;
	/** 门店 */
	private Store store;
	/** 品牌 */
	private Brand brand;
	/** 所属分类 */
	private Classification classification;
	/** 商上市时间 */
	private String marketTime;
	/** 商品编码 */
	private String goodsCode;
	/** 标价 */
	private String price;
	/** 售价 */
	private String salesPrice;
	/** 库存预警上线 */
	private String warningUp;
	/** 库存预警下线 */
	private String warningDown;
	/** 颜色 */
	private String goodsColor;
	/** 尺码 */
	private String goodsSize;
	/** 个性化参数（格式由分类表决定，数据放在这里） */
	private String otherAttr;
	/** 备注 */
	private String remark;
	/** 上下架 */
	private String isVisible;
	/** 是否异常(1 异常 2 不异常) */
	private String isAbnormal;
	/** 是否推荐 */
	private String isRecommed;
	/** 是否删除（1：否，2：是） */
	private String isDelete = "1";
	/** 创建时间 */
	private Date createTime;
	/** 单位 */
	private Specification specification;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/**
	 * 自定义属性转换而来的map集合
	 */
	private Map<String, String> other_map;
	/**
	 * 用于接受页面传递过来的自定义属性集合，在保存的时候转码为json字符串，保存在otherAttr字段中
	 */
	private Map<String, String> other_map_to_save;

	private List<Goods> goodsChildList;
	private List<Goods> goodsChildListNew;
	private List<Goods> goodsChildListDelete;
	/**
	 * 图片 数据库获取
	 */
	private List<String> imgUrl;
	/**
	 * 赠品赠送数量
	 */
	private String putOutNumber;
	/**
	 * 减免记录ID
	 */
	private String OSM_ID;
	/**
	 * 产品库存（没有库存记录时，会返回0）
	 */
	private String goods_inventory;
	/**
	 * 产品最近一次进货价
	 */
	private String buyMoney;
	/**
	 * 产品最近一次进货价折扣比例
	 */
	private String buyAgio;
	/**
	 * 产品自定义属性value值拼接的字符串(ps：用“（）”包起来的值)
	 */
	private String other_attr_value;

	/**
	 * 获取主产品对应的所有子产品自定义属性排重结果
	 */
	private Map<String, List<String>> childGoodsAttrMap;

	/**
	 * 子产品数量
	 */
	private String goodsChildList_size;

	private String isRecommedValue;
	/** 是推荐商品 */
	public static final String RECOMMED_TRUE = "1";
	/** 不是推荐商品 */
	public static final String RCOMMED_FALSE = "2";

	private String isVisibleVlaue;
	/** 上架 */
	public static final String VISIBLE_TRUE = "1";
	/** 下架 */
	public static final String VISIBLE_FALSE = "2";

	private String isAbnormalVlaue;
	/** 异常 */
	public static final String ABNORMAL_TRUE = "1";
	/** 正常 */
	public static final String ABNORMAL_FALSE = "2";

	private String isDeleteValue;
	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public Goods() {
		super();
	}

	public Goods(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param name
	 *            商品名
	 * @param goods
	 *            商品
	 * @param brand
	 *            品牌
	 * @param classification
	 *            所属分类
	 * @param goodsCode
	 *            商品编码
	 * @param price
	 *            标价
	 * @param salesPrice
	 *            售价
	 * @param warningUp
	 *            库存预警上线
	 * @param warningDown
	 *            库存预警下线
	 * @param goodsColor
	 *            颜色
	 * @param goodsSize
	 * @param otherAttr
	 *            个性化参数
	 * @param remark
	 *            备注
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param createTime
	 */
	public Goods(String id, String name, Goods goods, Brand brand, Classification classification, String goodsCode,
			String price, String salesPrice, String warningUp, String warningDown, String goodsColor, String goodsSize,
			String otherAttr, String remark, String isDelete, Date createTime) {
		super();
		this.id = id;
		this.name = name;
		this.goods = goods;
		this.brand = brand;
		this.classification = classification;
		this.goodsCode = goodsCode;
		this.price = price;
		this.salesPrice = salesPrice;
		this.warningUp = warningUp;
		this.warningDown = warningDown;
		this.goodsColor = goodsColor;
		this.goodsSize = goodsSize;
		this.otherAttr = otherAttr;
		this.remark = remark;
		this.isDelete = isDelete;
		this.createTime = createTime;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the name 商品
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name 商品名 to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the specification 单位
	 */
	public Specification getSpecification() {
		return specification;
	}

	/**
	 * @param specification
	 *            the specification 单位 to set
	 */
	public void setSpecification(Specification specification) {
		this.specification = specification;
	}

	/**
	 * @return the goods 商品
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods 商品 to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the store
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the brand 品牌
	 */
	public Brand getBrand() {
		return brand;
	}

	/**
	 * @param brand
	 *            the brand 品牌 to set
	 */
	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	/**
	 * @return the classification 所属分类
	 */
	public Classification getClassification() {
		return classification;
	}

	/**
	 * @param classification
	 *            the classification 所属分类 to set
	 */
	public void setClassification(Classification classification) {
		this.classification = classification;
	}

	/**
	 * @return the marketTime 上市时间
	 */
	public String getMarketTime() {
		return marketTime;
	}

	/**
	 * @param marketTime
	 *            the marketTime 上市时间 to set
	 */
	public void setMarketTime(String marketTime) {
		this.marketTime = marketTime;
	}

	/**
	 * @return the goodsCode 商品编码
	 */
	public String getGoodsCode() {
		return goodsCode;
	}

	/**
	 * @param goodsCode
	 *            the goodsCode 商品编码 to set
	 */
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}

	/**
	 * @return the price 标价
	 */
	public String getPrice() {
		return price;
	}

	/**
	 * @param price
	 *            the price 标价 to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the salesPrice 售价
	 */
	public String getSalesPrice() {
		return salesPrice;
	}

	/**
	 * @param salesPrice
	 *            the salesPrice 售价 to set
	 */
	public void setSalesPrice(String salesPrice) {
		this.salesPrice = salesPrice;
	}

	/**
	 * @return the warningUp 库存预警上线
	 */
	public String getWarningUp() {
		return warningUp;
	}

	/**
	 * @param warningUp
	 *            the warningUp 库存预警上线 to set
	 */
	public void setWarningUp(String warningUp) {
		this.warningUp = warningUp;
	}

	/**
	 * @return the warningDown 库存预警下线
	 */
	public String getWarningDown() {
		return warningDown;
	}

	/**
	 * @param warningDown
	 *            the warningDown 库存预警下线 to set
	 */
	public void setWarningDown(String warningDown) {
		this.warningDown = warningDown;
	}

	/**
	 * @return the goodsColor
	 */
	public String getGoodsColor() {
		return goodsColor;
	}

	/**
	 * @param goodsColor
	 *            the goodsColor to set
	 */
	public void setGoodsColor(String goodsColor) {
		this.goodsColor = goodsColor;
	}

	/**
	 * @return the goodsSize
	 */
	public String getGoodsSize() {
		return goodsSize;
	}

	/**
	 * @param goodsSize
	 *            the goodsSize to set
	 */
	public void setGoodsSize(String goodsSize) {
		this.goodsSize = goodsSize;
	}

	/**
	 * @return the otherAttr 个性化参数
	 */
	public String getOtherAttr() {
		return otherAttr;
	}

	/**
	 * @param otherAttr
	 *            the otherAttr 个性化参数 to set
	 */
	public void setOtherAttr(String otherAttr) {
		this.otherAttr = otherAttr;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark 备注 to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete 是否删除（1：否，2：是） to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the createTime
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime
	 *            the createTime to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * @return the ft
	 */
	public String getFt() {
		return ft;
	}

	/**
	 * @param ft
	 *            the ft to set
	 */
	public void setFt(String ft) {
		this.ft = ft;
	}

	/**
	 * @return the lt
	 */
	public String getLt() {
		return lt;
	}

	/**
	 * @param lt
	 *            the lt to set
	 */
	public void setLt(String lt) {
		this.lt = lt;
	}

	/**
	 * @return the fu
	 */
	public String getFu() {
		return fu;
	}

	/**
	 * @param fu
	 *            the fu to set
	 */
	public void setFu(String fu) {
		this.fu = fu;
	}

	/**
	 * @return the lu
	 */
	public String getLu() {
		return lu;
	}

	/**
	 * @param lu
	 *            the lu to set
	 */
	public void setLu(String lu) {
		this.lu = lu;
	}

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate
	 *            the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate
	 *            the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the isDeleteValue
	 */
	public String getIsDeleteValue() {
		if (ISDELETE_NO.equals(isDelete)) {
			return "否";
		} else if (ISDELETE_YES.equals(isDelete)) {
			return "是";
		}
		return null;
	}

	/**
	 * @return the isVisible
	 */
	public String getIsVisible() {
		return isVisible;
	}

	/**
	 * @param isVisible
	 *            the isVisible to set
	 */
	public void setIsVisible(String isVisible) {
		this.isVisible = isVisible;
	}

	/**
	 * @return the isAbnormal
	 */
	public String getIsAbnormal() {
		return isAbnormal;
	}

	/**
	 * @param isAbnormal
	 *            the isAbnormal to set
	 */
	public void setIsAbnormal(String isAbnormal) {
		this.isAbnormal = isAbnormal;
	}

	/**
	 * @return the isRecommed
	 */
	public String getIsRecommed() {
		return isRecommed;
	}

	/**
	 * @param isRecommed
	 *            the isRecommed to set
	 */
	public void setIsRecommed(String isRecommed) {
		this.isRecommed = isRecommed;
	}

	/**
	 * @return the isVisibleVlaue
	 */
	public String getIsVisibleVlaue() {
		if (VISIBLE_TRUE.equals(isVisible)) {
			return "上架";
		} else if (VISIBLE_FALSE.equals(isVisible)) {
			return "下架";
		}
		return null;
	}

	/**
	 * @return the isAbnormalVlaue
	 */
	public String getIsAbnormalVlaue() {
		if (ABNORMAL_TRUE.equals(isAbnormal)) {
			return "异常";
		} else if (ABNORMAL_FALSE.equals(isAbnormal)) {
			return "正常";
		}
		return null;
	}

	/**
	 * @return the isRecommedValue
	 */
	public String getIsRecommedValue() {
		if (RECOMMED_TRUE.equals(isRecommed)) {
			return "是";
		} else if (RCOMMED_FALSE.equals(isRecommed)) {
			return "否";
		}
		return null;
	}

	/**
	 * @return the other_map
	 */
	public Map<String, String> getOther_map() {
		return StringUtils.isNotBlank(otherAttr) ? MapUtil.jsonToHashMap(otherAttr) : null;
	}

	/**
	 * @return the goodsChildList
	 */
	public List<Goods> getGoodsChildList() {
		return goodsChildList;
	}

	/**
	 * @param goodsChildList
	 *            the goodsChildList to set
	 */
	public void setGoodsChildList(List<Goods> goodsChildList) {
		this.goodsChildList = goodsChildList;
	}

	/**
	 * @return the goodsChildListNew
	 */
	public List<Goods> getGoodsChildListNew() {
		return goodsChildListNew;
	}

	/**
	 * @param goodsChildListNew
	 *            the goodsChildListNew to set
	 */
	public void setGoodsChildListNew(List<Goods> goodsChildListNew) {
		this.goodsChildListNew = goodsChildListNew;
	}

	/**
	 * @return the goodsChildListDelete
	 */
	public List<Goods> getGoodsChildListDelete() {
		return goodsChildListDelete;
	}

	/**
	 * @param goodsChildListDelete
	 *            the goodsChildListDelete to set
	 */
	public void setGoodsChildListDelete(List<Goods> goodsChildListDelete) {
		this.goodsChildListDelete = goodsChildListDelete;
	}

	/**
	 * @return the other_map_to_save
	 */
	public Map<String, String> getOther_map_to_save() {
		return other_map_to_save;
	}

	/**
	 * @param other_map_to_save
	 *            the other_map_to_save to set
	 */
	public void setOther_map_to_save(Map<String, String> other_map_to_save) {
		this.other_map_to_save = other_map_to_save;
	}

	/**
	 * @return the imgUrl
	 */
	public List<String> getImgUrl() {
		return imgUrl;
	}

	/**
	 * @param imgUrl
	 *            the imgUrl to set
	 */
	public void setImgUrl(List<String> imgUrl) {
		this.imgUrl = imgUrl;
	}

	/**
	 * @return the goods_inventory 产品剩余库存（无库存时默认返回0）
	 */
	public String getGoods_inventory() {
		return StringUtils.isNotBlank(goods_inventory) ? goods_inventory : "0";
	}

	/**
	 * @param goods_inventory
	 *            the goods_inventory（产品剩余库存） to set
	 */
	public void setGoods_inventory(String goods_inventory) {
		this.goods_inventory = goods_inventory;
	}

	/**
	 * @return the other_attr_value 产品自定义属性value值拼接的字符串(用“（）”包起来的值)
	 */
	public String getOther_attr_value() {
		String other_attr_value = "(";
		Map<String, String> map = this.getOther_map();
		if (null != map) {
			if (!map.isEmpty()) {
				for (String string : map.values()) {
					other_attr_value += string + "-";
				}
				return other_attr_value.substring(0, other_attr_value.length() - 1) + ")";
			}
		}
		return "";
	}

	/**
	 * @return the buyMoney 产品最近一次进货价
	 */
	public String getBuyMoney() {
		return StringUtils.isNotBlank(buyMoney) ? buyMoney : "0";
	}

	/**
	 * @param buyMoney
	 *            the buyMoney(产品最近一次进货价) to set
	 */
	public void setBuyMoney(String buyMoney) {
		this.buyMoney = buyMoney;
	}

	/**
	 * @return the buyAgio 产品最近一次进货价折扣比例
	 */
	public String getBuyAgio() {
		return StringUtils.isNotBlank(buyAgio) ? buyAgio : "0";
	}

	/**
	 * @param buyAgio
	 *            the buyAgio(产品最近一次进货价折扣比例) to set
	 */
	public void setBuyAgio(String buyAgio) {
		this.buyAgio = buyAgio;
	}

	/**
	 * @return the goodsChildList_size 子产品数量
	 */
	public String getGoodsChildList_size() {
		if (StringUtils.isBlank(goodsChildList_size)) {
			if (null != goodsChildList)
				if (!goodsChildList.isEmpty())
					return String.valueOf(goodsChildList.size());
			return "0";
		} else {
			return goodsChildList_size;
		}
	}

	/**
	 * @param goodsChildList_size
	 *            the goodsChildList_size(子产品数量) to set
	 */
	public void setGoodsChildList_size(String goodsChildList_size) {
		this.goodsChildList_size = goodsChildList_size;
	}

	/**
	 * @return the childGoodsAttrMap 获取主产品对应的所有子产品自定义属性排重结果
	 */
	public Map<String, List<String>> getChildGoodsAttrMap() {
		Map<String, List<String>> childGoodsAttrMap = new HashMap<String, List<String>>();
		if (0 < Integer.parseInt(getGoodsChildList_size())) {
			List<ClassificationVO> classificationVOList = ClassificationService
					.getClassificationAttrForClassification(classification);
			if (null != classificationVOList)
				if (!classificationVOList.isEmpty())
					for (ClassificationVO classificationVO : classificationVOList) {
						String attrCode = classificationVO.getAttrCode();
						String attrCode_value = "";
						for (Goods goods : goodsChildList) {
							Map<String, String> goods_other_map = goods.getOther_map();
							if (null != goods_other_map && !goods_other_map.isEmpty()) {
								attrCode_value = goods_other_map.get(attrCode);
							}
							if (childGoodsAttrMap.containsKey(attrCode)) {
								List<String> attrCodeArray_ = childGoodsAttrMap.get(attrCode);
								if (!attrCodeArray_.contains(attrCode_value)) {
									attrCodeArray_.add(attrCode_value);
									childGoodsAttrMap.put(attrCode, attrCodeArray_);
								}
							} else {
								List<String> attrCodeArray_ = new ArrayList<String>();
								attrCodeArray_.add(attrCode_value);
								childGoodsAttrMap.put(attrCode, attrCodeArray_);
							}
						}
					}
			return childGoodsAttrMap;
		}
		return null;
	}

	/**
	 * @return the putOutNumber 赠品赠送数量
	 */
	public String getPutOutNumber() {
		return putOutNumber;
	}

	/**
	 * @param putOutNumber
	 *            the putOutNumber（赠品赠送数量） to set
	 */
	public void setPutOutNumber(String putOutNumber) {
		this.putOutNumber = putOutNumber;
	}

	/**
	 * @return the oSM_ID 减免记录ID
	 */
	public String getOSM_ID() {
		return OSM_ID;
	}

	/**
	 * @param oSM_ID
	 *            the oSM_ID(减免记录ID) to set
	 */
	public void setOSM_ID(String oSM_ID) {
		this.OSM_ID = oSM_ID;
	}

}
