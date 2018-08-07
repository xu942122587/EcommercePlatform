package com.unitever.module.smsverifALi.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.smsverifALi.model.SMSVerifALi;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class SMSVerifALiDAO extends BaseDAO<SMSVerifALi, String> {

	public List<SMSVerifALi> getSMSVerifListWithSMSVerif(SMSVerifALi smsverif) {
		return this.getList("getSMSVerifListWithSMSVerif", smsverif);
	}

	public void deleteByPhone(String phone) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("phone", phone);
		this.getBatchSqlSession().delete("deleteByPhone", map);
	}

	/**
	 * 根据手机号码获取验证码
	 */
	public SMSVerifALi getSMSByPhone(String phone) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("phone", phone);
		List<SMSVerifALi> smsverifList = this.getList("getSMSByPhone", params);
		return smsverifList.size() > 0 ? smsverifList.get(0) : null;
	}
}