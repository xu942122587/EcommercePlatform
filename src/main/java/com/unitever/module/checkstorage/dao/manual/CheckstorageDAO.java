package com.unitever.module.checkstorage.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.checkstorage.model.Checkstorage;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class CheckstorageDAO extends BaseDAO<Checkstorage, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Checkstorage>
	 */
	public List<Checkstorage> getCheckstorageByCheckstorage(Checkstorage checkstorage) {
		return this.getList("getCheckstorageByCheckstorage", checkstorage);
	}

	/**
	 * 获取符合当前条件的Checkstorage数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByCheckstorage(Checkstorage checkstorage) {
		return this.get("getCountByCheckstorage", checkstorage);
	}

}
