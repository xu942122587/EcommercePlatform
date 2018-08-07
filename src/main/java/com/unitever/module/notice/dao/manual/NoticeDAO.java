package com.unitever.module.notice.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.notice.model.Notice;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class NoticeDAO extends BaseDAO<Notice, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Notice>
	 */
	public List<Notice> getNoticeByNotice(Notice notice) {
		return this.getList("getNoticeByNotice", notice);
	}

	/**
	 * 获取符合当前条件的Notice数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goodss
	 * @return int
	 */
	public int getCountByNotice(Notice notice) {
		return this.get("getCountByNotice", notice);
	}

}
