package com.unitever.module.eticketuseRecord.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.module.eticketuseRecord.dao.manual.EticketUseRecordDAO;
import com.unitever.module.eticketuseRecord.model.EticketUseRecord;
import com.unitever.module.order.service.OrderService;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class EticketUseRecordService {

	@Autowired
	private OrderService orderService;
	@Autowired
	private EticketUseRecordDAO eticketUseRecordDAO;
	@Autowired
	private EticketOutRecordService eticketOutRecordService;

	public int saveEticketUseRecord(EticketUseRecord eticketUseRecord) {
		if (eticketUseRecord != null) {
			eticketUseRecord.setId(UUID.getUUID());
			eticketUseRecord.setCreateDate(DateUtil.getDate(DateUtil.getCurrDateString()));
			return eticketUseRecordDAO.save(eticketUseRecord);
		}
		return 0;
	}

	public EticketUseRecord getEticketUseRecordById(String id) {
		return eticketUseRecordDAO.get(id);
	}

	public List<EticketUseRecord> getAllEticketUseRecord() {
		return eticketUseRecordDAO.getAll();
	}

	public int updateEticketUseRecord(EticketUseRecord eticketUseRecord) {
		return eticketUseRecordDAO.update(eticketUseRecord);
	}

	public List<EticketUseRecord> getUseRecordByUseRecord(EticketUseRecord eticketUseRecord) {
		return eticketUseRecordDAO.getUseRecordByUseRecord(eticketUseRecord);
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
		return eticketUseRecordDAO.getOrderUseEticketListByOrderId(orderId);
	}

}
