package com.unitever.module.banner.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.banner.dao.manual.BannerDAO;
import com.unitever.module.banner.model.Banner;
import com.unitever.platform.component.attachment.util.AttachmentUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.banner.service->BannerService.java
 * </p>
 * <P>
 * 微信首页轮播serivices
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Service
@Transactional
public class BannerService {

	@Autowired
	private BannerDAO bannerDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param banner
	 *            void
	 */
	public int save(Banner banner) {
		if (banner != null) {
			banner.setId(UUID.getUUID());
			banner.setCreateTime(new Date());
			int i = bannerDAO.save(banner);
			if (0 < i) {
				AttachmentUtil.bindAttachment(banner);
				return i;
			}
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param banner
	 * @return int
	 */
	public int update(Banner banner) {
		if (null != banner) {
			if (StringUtils.isNotBlank(banner.getId())) {
				int i = bannerDAO.update(banner);
				if (0 < i) {
					AttachmentUtil.bindAttachment(banner);
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return Banner
	 */
	public Banner getBannerById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return bannerDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param banner
	 * @return List<Banner>
	 */
	public List<Banner> getBannerByBanner(Banner banner) {
		return bannerDAO.getBannerByBanner(banner);
	}

	/**
	 * 获取符合当前条件的Banner数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param banner
	 * @return int
	 */
	public int getCountByBanner(Banner banner) {
		return bannerDAO.getCountByObject(banner);
	}

	/**
	 *
	 * <P>
	 * 获取第一条微信首页banner图实体对象
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Object
	 */
	public Banner getBannerFirst() {
		return bannerDAO.getBannerFirst();
	}

}
