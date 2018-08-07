package com.unitever.module.eticketuseRecord.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.eticketuseRecord.model.EticketUseRecord;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class EticketUseRecordDAO extends BaseDAO<EticketUseRecord, String> {

	public List<EticketUseRecord> getUseRecordByUseRecord(EticketUseRecord eticketUseRecord) {
		return this.getList("getUseRecordByUseRecord", eticketUseRecord);
	}

	public void deleteRecordByOrderId(String orderId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("orderId", orderId);
		this.delete("deleteRecordByOrderId", map);
	}

	/**
	 *
	 * <P>
	 * 已经打单ID获取当前打单使用的电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @param id
	 * @return
	 */
	public List<EticketUseRecord> getOrderUseEticketListByOrderId(String orderId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderId", orderId);
		return this.getList("getOrderUseEticketListByOrderId", map);
	}

}
