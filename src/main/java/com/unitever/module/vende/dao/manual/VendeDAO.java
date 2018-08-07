package com.unitever.module.vende.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.vende.model.Vende;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class VendeDAO extends BaseDAO<Vende, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Vende>
	 */
	public List<Vende> getVendeByVende(Vende vende) {
		return this.getList("getVendeByVende", vende);
	}

	/**
	 * 获取符合当前条件的Vende数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByVende(Vende vende) {
		return this.get("getCountByVende", vende);
	}

}
