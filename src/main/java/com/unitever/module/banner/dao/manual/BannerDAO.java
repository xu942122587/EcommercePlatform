package com.unitever.module.banner.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.banner.model.Banner;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.banner.dao.manual->BannerDAO.java
 * </p>
 * <P>
 * 微信首页banner图
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Repository
public class BannerDAO extends BaseDAO<Banner, String> {

	/**
	 *
	 * <P>
	 * 依据微信首页banner图对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param banner
	 * @return List<Banner>
	 */
	public List<Banner> getBannerByBanner(Banner banner) {
		return this.getList("getBannerByBanner", banner);
	}

	/**
	 *
	 * <P>
	 * 依据微信首页banner图对象获取统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param banner
	 * @return int
	 */
	public int getCountByBanner(Banner banner) {
		return this.get("getCountByBanner", banner);
	}

	/**
	 *
	 * <P>
	 * 获取第一条微信首页banner图实体对象
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Banner
	 */
	public Banner getBannerFirst() {
		return this.get("first", null);
	}

}
