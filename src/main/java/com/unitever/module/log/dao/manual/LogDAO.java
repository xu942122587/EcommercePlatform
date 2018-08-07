package com.unitever.module.log.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.log.model.Log;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class LogDAO extends BaseDAO<Log, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Log>
	 */
	public List<Log> getLogByLog(Log log) {
		return this.getList("getLogByLog", log);
	}

	/**
	 * 获取符合当前条件的Log数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByLog(Log log) {
		return this.get("getCountByLog", log);
	}

}
