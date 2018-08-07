package com.unitever.module.vende.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.vende.dao.manual.VendeDAO;
import com.unitever.module.vende.model.Vende;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class VendeService {

	@Autowired
	private VendeDAO vendeDAO;

	/**
	 * 保存新供应商
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param vende
	 *            void
	 */
	public int save(Vende vende) {
		if (vende != null) {
			vende.setId(UUID.getUUID());
			vende.setCreateTime(new Date());
			vende.setIsDelete(Vende.ISDELETE_NO);
			int i = vendeDAO.save(vende);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 * 更新供应商
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param vende
	 * @return int
	 */
	public int update(Vende vende) {
		if (null != vende) {
			if (StringUtils.isNotBlank(vende.getId())) {
				int i = vendeDAO.update(vende);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取供应商
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return Vende
	 */
	public Vende getVendeById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return vendeDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据供应商获取供应商
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param vende
	 * @return List<Vende>
	 */
	public List<Vende> getVendeByVende(Vende vende) {
		return vendeDAO.getVendeByVende(vende);
	}

	/**
	 * 获取符合当前条件的供应商数量
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param vende
	 * @return int
	 */
	public int getCountByVende(Vende vende) {
		return vendeDAO.getCountByVende(vende);
	}

	/**
	 *
	 * <P>
	 * 获取所有供应商
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Object
	 */
	public List<Vende> getAll() {
		return vendeDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取供应商分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param page
	 * @param vende
	 * @return Page<Vende>
	 */
	public Page<Vende> getPage(Page<Vende> page, Vende vende) {
		if (StringUtils.isNotBlank(vende.getEndDate())) {
			vende.setEndDate(vende.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(vendeDAO.getCountByObject(vende));
		vende.setStartOfPage(page.getStartOfPage());
		vende.setPageSize(page.getPageSize());
		page.setResults(vendeDAO.getVendeByVende(vende));
		if (StringUtils.isNotBlank(vende.getEndDate())) {
			vende.setEndDate(vende.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除供应商--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return int
	 */
	public int deleteVende(String id) {
		if (StringUtils.isNotBlank(id)) {
			Vende vende = new Vende(id);
			vende.setIsDelete(Vende.ISDELETE_YES);
			return vendeDAO.update(vende);
		}
		return 0;
	}

}
