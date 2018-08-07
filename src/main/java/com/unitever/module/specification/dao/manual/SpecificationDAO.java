package com.unitever.module.specification.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.specification.model.Specification;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class SpecificationDAO extends BaseDAO<Specification, String> {

	/**
	 *
	 * <P>根据Object获取</p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return List<Specification>
	 */
	public List<Specification> getSpecificationBySpecification(Specification specification) {
		return this.getList("getSpecificationBySpecification", specification);
	}

	/**
	 *
	 * <P>获取符合当前条件的specification数量</p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return int
	 */
	public int getCountBySpecification(Specification specification) {
		return this.get("getCountBySpecification", specification);
	}

}
