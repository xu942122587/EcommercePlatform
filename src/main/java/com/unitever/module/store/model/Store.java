package com.unitever.module.store.model;

import java.util.Date;
import java.util.List;

import com.unitever.auth.user.model.User;
import com.unitever.module.storeProperty.model.StoreProperty;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.customer.model->Customer.java
 * </p>
 * <P>
 * * 客户
 * </p>
 *
 * @author 闫枫
 * @date Jun 27, 2017
 */
public class Store extends BaseModel {

	/** Id */
	private String id;
	/** 门店名称 */
	private String name;
	/** 门店编号 */
	private String storeCode;
	/** 负责人 */
	private String chargeName;
	/** 负责人联系方式 */
	private String chargePhone;
	/** 门店电话 */
	private String storePhone;
	/** 门店面积 */
	private String acreage;
	/** 门店地址 */
	private String address;
	/** 备注 */
	private String remark;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 门店类型（1：直营店，2：商家店） */
	private String type;
	/**
	 * 门店状态（1：正常，2：停业）
	 */
	private String state;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/**
	 * 门店关联员工
	 */
	private List<User> userList;
	/**
	 * 图片 数据库获取
	 */
	private List<String> imgUrl;
	/**
	 * 经营品牌
	 */
	private String brandString;
	/**
	 * 门店固定资产列表--已有
	 */
	private List<StoreProperty> storePropertieList;
	/**
	 * 门店固定资产列表--新建（待保存--页面回传）
	 */
	private List<StoreProperty> storePropertieNew;
	/**
	 * 门店固定资产列表--删除（待删除--页面回传）
	 */
	private List<StoreProperty> storePropertieDelete;

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	private String stateValue;
	/**
	 * 门店状态：正常
	 */
	public static final String STATE_NO_STOP = "1";
	/**
	 * 门店状态：停业
	 */
	public static final String STATE_STOP = "2";

	private String typeValue;
	/**
	 * 门店类型：直营店
	 */
	public static final String TYPE_ONE = "1";
	/**
	 * 门店类型：商家店
	 */
	public static final String TYPE_TWO = "2";
	/**
	 * 门店类型：小商品店
	 */
	public static final String TYPE_THREE = "3";

	public Store() {
		super();
	}

	public Store(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param name
	 *            门店名称
	 * @param storeCode
	 *            门店编号
	 * @param chargeName
	 *            负责人
	 * @param chargePhone
	 *            负责人联系方式
	 * @param storePhone
	 *            门店电话
	 * @param acreage
	 *            门店面积
	 * @param address
	 *            门店地址
	 * @param remark
	 *            备注
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param createTime
	 */
	public Store(String id, String name, String storeCode, String chargeName, String chargePhone, String storePhone,
			String acreage, String address, String remark, String isDelete, Date createTime) {
		super();
		this.id = id;
		this.name = name;
		this.storeCode = storeCode;
		this.chargeName = chargeName;
		this.chargePhone = chargePhone;
		this.storePhone = storePhone;
		this.acreage = acreage;
		this.address = address;
		this.remark = remark;
		this.isDelete = isDelete;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the name 门店名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name（门店名称） to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the storeCode 门店编号
	 */
	public String getStoreCode() {
		return storeCode;
	}

	/**
	 * @param storeCode
	 *            the storeCode（门店编号） to set
	 */
	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	/**
	 * @return the chargeName 负责人
	 */
	public String getChargeName() {
		return chargeName;
	}

	/**
	 * @param chargeName
	 *            the chargeName（负责人） to set
	 */
	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}

	/**
	 * @return the chargePhone 负责人联系方式
	 */
	public String getChargePhone() {
		return chargePhone;
	}

	/**
	 * @param chargePhone
	 *            the chargePhone（负责人联系方式 ） to set
	 */
	public void setChargePhone(String chargePhone) {
		this.chargePhone = chargePhone;
	}

	/**
	 * @return the storePhone 门店电话
	 */
	public String getStorePhone() {
		return storePhone;
	}

	/**
	 * @param storePhone
	 *            the storePhone（门店电话 ） to set
	 */
	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone;
	}

	/**
	 * @return the acreage 门店面积
	 */
	public String getAcreage() {
		return acreage;
	}

	/**
	 * @param acreage
	 *            the acreage(门店面积) to set
	 */
	public void setAcreage(String acreage) {
		this.acreage = acreage;
	}

	/**
	 * @return the address 门店地址
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address(门店地址) to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark(备注) to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getFt() {
		return ft;
	}

	public void setFt(String ft) {
		this.ft = ft;
	}

	public String getLt() {
		return lt;
	}

	public void setLt(String lt) {
		this.lt = lt;
	}

	public String getFu() {
		return fu;
	}

	public void setFu(String fu) {
		this.fu = fu;
	}

	public String getLu() {
		return lu;
	}

	public void setLu(String lu) {
		this.lu = lu;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete（是否删除（1：否，2：是）） to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the storePropertieList 门店固定资产列表--已有
	 */
	public List<StoreProperty> getStorePropertieList() {
		return storePropertieList;
	}

	/**
	 * @param storePropertieList
	 *            the storePropertieList( 门店固定资产列表--已有) to set
	 */
	public void setStorePropertieList(List<StoreProperty> storePropertieList) {
		this.storePropertieList = storePropertieList;
	}

	/**
	 * @return the storePropertieNew 门店固定资产列表--新建（待保存）
	 */
	public List<StoreProperty> getStorePropertieNew() {
		return storePropertieNew;
	}

	/**
	 * @param storePropertieNew
	 *            the storePropertieNew（门店固定资产列表--新建（待保存）） to set
	 */
	public void setStorePropertieNew(List<StoreProperty> storePropertieNew) {
		this.storePropertieNew = storePropertieNew;
	}

	/**
	 * @return the storePropertieDelete 门店固定资产列表--删除（待删除--页面回传）
	 */
	public List<StoreProperty> getStorePropertieDelete() {
		return storePropertieDelete;
	}

	/**
	 * @param storePropertieDelete
	 *            the storePropertieDelete（门店固定资产列表--删除（待删除--页面回传）） to set
	 */
	public void setStorePropertieDelete(List<StoreProperty> storePropertieDelete) {
		this.storePropertieDelete = storePropertieDelete;
	}

	/**
	 * @return the state 门店状态（1：正常，2：停业）
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state（门店状态（1：正常，2：停业）） to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_NO_STOP.equals(state)) {
			return "正常";
		} else if (STATE_STOP.equals(state)) {
			return "停业";
		}
		return stateValue;
	}

	/**
	 * @return the userList 门店关联员工
	 */
	public List<User> getUserList() {
		return userList;
	}

	/**
	 * @param userList
	 *            the userList(门店关联员工) to set
	 */
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	/**
	 * @return the imgUrl 图片 数据库获取
	 */
	public List<String> getImgUrl() {
		return imgUrl;
	}

	/**
	 * @param imgUrl
	 *            the imgUrl(图片 数据库获取) to set
	 */
	public void setImgUrl(List<String> imgUrl) {
		this.imgUrl = imgUrl;
	}

	/**
	 * @return the brandString 经营品牌
	 */
	public String getBrandString() {
		return brandString;
	}

	/**
	 * @param brandString
	 *            the brandString（经营品牌） to set
	 */
	public void setBrandString(String brandString) {
		this.brandString = brandString;
	}

	/**
	 * @return the type 门店类型（1：直营店，2：商家店）
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type（门店类型（1：直营店，2：商家店）） to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the typeValue
	 */
	public String getTypeValue() {
		if (TYPE_ONE.equals(type)) {
			return "直营店";
		} else if (TYPE_TWO.equals(type)) {
			return "商家店";
		} else if (TYPE_THREE.equals(type)) {
			return "小商品店";
		}
		return "其他~";
	}

	@Override
	public String toString() {
		return "Store [id=" + id + ", name=" + name + ", storeCode=" + storeCode + ", chargeName=" + chargeName
				+ ", chargePhone=" + chargePhone + ", storePhone=" + storePhone + ", acreage=" + acreage + ", address="
				+ address + ", remark=" + remark + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu="
				+ fu + ", lu=" + lu + "]";
	}

}
