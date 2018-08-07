package com.unitever.module.record.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.record.model.Record;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class RecordDAO extends BaseDAO<Record, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Record>
	 */
	public List<Record> getRecordByRecord(Record record) {
		return this.getList("getRecordByRecord", record);
	}

	/**
	 * 获取符合当前条件的Record数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goodss
	 * @return int
	 */
	public int getCountByRecord(Record record) {
		return this.get("getCountByRecord", record);
	}

	/**
	 *
	 * <P>
	 * 批量保存入库信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param recordList
	 * @return int
	 */
	public int batchInsert(List<Record> recordList) {
		return this.batchInsert("save", recordList);
	}
}
