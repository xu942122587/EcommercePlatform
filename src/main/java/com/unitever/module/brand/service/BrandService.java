package com.unitever.module.brand.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.brand.dao.manual.BrandDAO;
import com.unitever.module.brand.model.Brand;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.brand.service->BrandService.java
 * </p>
 * <P>
 * 商品品牌
 * </p>
 *
 * @author 闫枫
 * @date Jun 30, 2017
 */
@Service
@Transactional
public class BrandService {

	@Autowired
	private BrandDAO brandDAO;

	/**
	 * 保存新品牌信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param brand
	 *            void
	 */
	public int save(Brand brand) {
		if (brand != null) {
			brand.setId(UUID.getUUID());
			brand.setCreateTime(new Date());
			brand.setIsDelete(Brand.ISDELETE_NO);
			int i = brandDAO.save(brand);
			return i;
		}
		return 0;
	}

	/**
	 * 更新品牌信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param brand
	 * @return int
	 */
	public int update(Brand brand) {
		if (null != brand) {
			if (StringUtils.isNotBlank(brand.getId())) {
				int i = brandDAO.update(brand);
				return i;
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取品牌信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return Brand
	 */
	public Brand getBrandById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return brandDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据品牌信息获取品牌信息列表
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param brand
	 * @return List<Brand>
	 */
	public List<Brand> getBrandByBrand(Brand brand) {
		return brandDAO.getBrandByBrand(brand);
	}

	/**
	 * 获取符合当前条件的品牌信息数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param brand
	 * @return int
	 */
	public int getCountByBrand(Brand brand) {
		return brandDAO.getCountByObject(brand);
	}

	/**
	 *
	 * <P>
	 * 获取品牌信息分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param brand
	 * @return Page<Brand>
	 */
	public Page<Brand> getPage(Page<Brand> page, Brand brand) {
		if (StringUtils.isNotBlank(brand.getEndDate())) {
			brand.setEndDate(brand.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(brandDAO.getCountByObject(brand));
		brand.setStartOfPage(page.getStartOfPage());
		brand.setPageSize(page.getPageSize());
		page.setResults(brandDAO.getBrandByBrand(brand));
		if (StringUtils.isNotBlank(brand.getEndDate())) {
			brand.setEndDate(brand.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除品牌信息--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int deleteBrand(String id) {
		if (StringUtils.isNotBlank(id)) {
			Brand brand = new Brand(id);
			brand.setIsDelete(Brand.ISDELETE_YES);
			return brandDAO.update(brand);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有品牌信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @return Object
	 */
	public List<Brand> getAllBrand() {
		return brandDAO.getAll();
	}

}
