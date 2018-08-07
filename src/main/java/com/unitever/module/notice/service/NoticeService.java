package com.unitever.module.notice.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.notice.dao.manual.NoticeDAO;
import com.unitever.module.notice.model.Notice;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;

	/**
	 *
	 * <P>
	 * 保存新公告信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param notice
	 * @return int
	 */
	public int save(Notice notice) {
		if (notice != null) {
			notice.setId(UUID.getUUID());
			notice.setCreateTime(new Date());
			int i = noticeDAO.save(notice);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新公告信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param notice
	 * @return int
	 */
	public int update(Notice notice) {
		if (null != notice) {
			if (StringUtils.isNotBlank(notice.getId())) {
				int i = noticeDAO.update(notice);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取公告信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return Notice
	 */
	public Notice getNoticeById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return noticeDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据公告信息获取公告信息列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param notice
	 * @return List<Notice>
	 */
	public List<Notice> getNoticeByNotice(Notice notice) {
		return noticeDAO.getNoticeByNotice(notice);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的公告信息数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param notice
	 * @return int
	 */
	public int getCountByNotice(Notice notice) {
		return noticeDAO.getCountByNotice(notice);
	}

	/**
	 *
	 * <P>
	 * 获取公告信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param notice
	 * @return Page<Notice>
	 */
	public Page<Notice> getPage(Page<Notice> page, Notice notice) {
		if (StringUtils.isNotBlank(notice.getEndDate())) {
			notice.setEndDate(notice.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(noticeDAO.getCountByObject(notice));
		notice.setStartOfPage(page.getStartOfPage());
		notice.setPageSize(page.getPageSize());
		page.setResults(noticeDAO.getNoticeByNotice(notice));
		if (StringUtils.isNotBlank(notice.getEndDate())) {
			notice.setEndDate(notice.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除公告信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteNotice(String id) {
		if (StringUtils.isNotBlank(id)) {
			return noticeDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有公告信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<Notice>
	 */
	public List<Notice> getAllNotice() {
		return noticeDAO.getAll();
	}

}
