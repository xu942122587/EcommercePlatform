package com.unitever.module.specification.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.specification.dao.manual.SpecificationDAO;
import com.unitever.module.specification.model.Specification;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class SpecificationService {

	@Autowired
	private SpecificationDAO specificationDAO;

	/**
	 *
	 * <P>
	 * 保存新产品单位信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return int
	 */
	public int save(Specification specification) {
		if (specification != null) {
			specification.setId(UUID.getUUID());
			specification.setCreateTime(new Date());
			specification.setIsDelete("1");
			int i = specificationDAO.save(specification);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新产品单位信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return int
	 */
	public int update(Specification specification) {
		if (null != specification) {
			if (StringUtils.isNotBlank(specification.getId())) {
				int i = specificationDAO.update(specification);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取产品单位信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return specification
	 */
	public Specification getSpecificationById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return specificationDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据产品单位信息获取产品单位信息列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return List<specification>
	 */
	public List<Specification> getSpecificationBySpecification(Specification specification) {
		return specificationDAO.getSpecificationBySpecification(specification);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的产品单位信息数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param specification
	 * @return int
	 */
	public int getCountBySpecification(Specification specification) {
		return specificationDAO.getCountBySpecification(specification);
	}

	/**
	 *
	 * <P>
	 * 获取产品单位信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param specification
	 * @return Page<specification>
	 */
	public Page<Specification> getPage(Page<Specification> page, Specification specification) {
		if (StringUtils.isNotBlank(specification.getEndDate())) {
			specification.setEndDate(specification.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(specificationDAO.getCountByObject(specification));
		specification.setStartOfPage(page.getStartOfPage());
		specification.setPageSize(page.getPageSize());
		page.setResults(specificationDAO.getSpecificationBySpecification(specification));
		if (StringUtils.isNotBlank(specification.getEndDate())) {
			specification.setEndDate(specification.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除产品单位信息 假
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteSpecification(String id) {
		if (StringUtils.isNotBlank(id)) {
			Specification specification = new Specification(id);
			specification.setIsDelete(Specification.ISDELETE_YES);
			return specificationDAO.update(specification);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有产品单位信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<specification>
	 */
	public List<Specification> getAllSpecification() {
		return specificationDAO.getAll();
	}

}
