package com.unitever.module.brand.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.brand.model.Brand;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class BrandDAO extends BaseDAO<Brand, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Brand
	 * @return List<Brand>
	 */
	public List<Brand> getBrandByBrand(Brand brand) {
		return this.getList("getBrandByBrand", brand);
	}

	/**
	 * 获取符合当前条件的Brand数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Brand
	 * @return int
	 */
	public int getCountByBrand(Brand brand) {
		return this.get("getCountByBrand", brand);
	}

}
