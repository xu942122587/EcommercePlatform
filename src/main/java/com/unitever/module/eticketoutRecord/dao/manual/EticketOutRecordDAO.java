package com.unitever.module.eticketoutRecord.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class EticketOutRecordDAO extends BaseDAO<EticketOutRecord, String> {

	/**
	 *
	 * <P>
	 * 依据电子券发放ID设置电子券为已用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param orderId
	 * @return int
	 */
	public int setEticketUsedByEticketOutRecordId(String eticketOutRecordId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("eticketOutRecordId", eticketOutRecordId);
		return this.update("setEticketUsedByEticketOutRecordId", params);
	}

	/**
	 *
	 * <P>
	 * 取用户某种电子卷
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年1月29日
	 * @param customerId
	 * @param state
	 * @return int
	 */
	public List<EticketOutRecord> getAllByStateAndCustomerId(String customerId, String state) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("customerId", customerId);
		params.put("state", state);
		return this.getList("getAllByStateAndCustomerId", params);
	}

	/**
	 *
	 * <P>
	 * 依据EticketOutRecord获取EticketOutRecord--List
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 21, 2016
	 * @param eticketOutRecord
	 * @return
	 */
	public List<EticketOutRecord> getOutRecordByOutRecord(EticketOutRecord eticketOutRecord) {
		return this.getList("getOutRecordByOutRecord", eticketOutRecord);
	}

	/**
	 *
	 * <P>
	 * 设置电子券过期失效
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecordId
	 * @return int
	 */
	public int eticketOutRecordFail(String eticketOutRecordId) {
		Map<String, String> map = new HashMap<>();
		map.put("eticketOutRecordId", eticketOutRecordId);
		return this.update("eticketOutRecordFail", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有未使用电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getAllNoUseEticketOutRecord() {
		return this.getList("getAllNoUseEticketOutRecord");
	}

	/**
	 *
	 * <P>
	 * 依据电子券发放记录code获取电子券发放记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param eticketOutCode
	 * @return Object
	 */
	public EticketOutRecord getEticketOutRecordByCode(String eticketOutCode) {
		Map<String, String> map = new HashMap<>();
		map.put("eticketOutCode", eticketOutCode);
		return this.get("getEticketOutRecordByCode", map);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID和otherOrder的PayMoney获取可用电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param id
	 * @param payMoney
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getCustomerToUseEticketList(String storeId, String otherOrderPayMoney,
			String customerId) {
		Map<String, String> map = new HashMap<>();
		map.put("storeId", storeId);
		map.put("otherOrderPayMoney", otherOrderPayMoney);
		map.put("customerId", customerId);
		return this.getList("getCustomerToUseEticketList", map);
	}

}
