package com.unitever.platform.core.dao;

import java.io.Serializable;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * MyBatis的Dao基类
 */
@Repository
public class BaseDAO<T, PK extends Serializable> extends SqlSessionDaoSupport {
	private final int BATCH_DEAL_NUM = 100;
	protected static final String SQL_ID_SAVE = "save";
	protected static final String SQL_ID_UPDATE = "update";
	protected static final String SQL_ID_DELETE = "delete";
	protected static final String SQL_ID_GET = "get";
	protected static final String SQL_ID_GETALL = "getAll";
	protected static final String SQL_ID_GETPAGE = "getPage";
	protected static final String SQL_ID_GETCOUNTBYOBJECT = "getCountByObject";

	private String NAMESPACE;
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@PostConstruct
	public void SqlSessionTemplate() {
		super.setSqlSessionTemplate(sqlSessionTemplate);
		// super.setSqlSessionFactory(sqlSessionTemplate.getSqlSessionFactory());
		init();
	}

	public SqlSession getSqlSession() {
		// return
		// SqlSessionUtils.getSqlSession(sqlSessionTemplate.getSqlSessionFactory());
		return super.getSqlSession();
	}

	private void init() {
		this.NAMESPACE = this.getClass().getName();
	}

	public void saveOrUpdate(T model) {
		if (StringUtils.isEmpty((String) ModelHelper.getIdValue(model))) {
			save(model);
		} else {
			update(model);
		}
	}

	public int save(T model) {
		if (StringUtils.isEmpty((String) ModelHelper.getIdValue(model))) {
			ModelHelper.setPK(model);
		}
		ModelHelper.setDefaultWithSave(model);
		return save(SQL_ID_SAVE, model);
	}

	public int update(T model) {
		ModelHelper.setDefaultWithUpdate(model);
		return update(SQL_ID_UPDATE, model);
	}

	public int delete(PK id) {
		return delete(SQL_ID_DELETE, id);
	}

	protected int delete(String sqlID, Object object) {
		return getSqlSession().delete(buildSqlID(sqlID), object);
	}

	@SuppressWarnings("unchecked")
	public T get(PK id) {
		return (T) get(SQL_ID_GET, id);
	}

	public List<T> getAll() {
		return getList(SQL_ID_GETALL);
	}

	public Page<T> getPage(Page<T> page) {
		return getPage(SQL_ID_GETPAGE, page);
	}

	private String buildSqlID(String sqlID) {
		return NAMESPACE + "." + sqlID;
	}

	protected SqlSession getBatchSqlSession() {
		return sqlSessionTemplate;
	}

	protected int save(String sqlID, Object object) {
		return getSqlSession().insert(buildSqlID(sqlID), object);
	}

	protected int update(String sqlID, Object object) {
		return getSqlSession().update(buildSqlID(sqlID), object);
	}

	protected int delete(String sqlID, Serializable id) {
		return getSqlSession().delete(buildSqlID(sqlID), id);
	}

	public int getCountByObject(T t) {
		return getSqlSession().selectOne(buildSqlID(SQL_ID_GETCOUNTBYOBJECT), t);
	}

	@SuppressWarnings("unchecked")
	protected <X> X get(String sqlID, Serializable id) {
		return (X) getSqlSession().selectOne(buildSqlID(sqlID), id);
	}

	@SuppressWarnings("unchecked")
	protected <X> X get(String sqlID, Object obj) {
		return (X) getSqlSession().selectOne(buildSqlID(sqlID), obj);
	}

	protected <X> List<X> getList(String sqlID) {
		return getSqlSession().selectList(buildSqlID(sqlID));
	}

	protected <X> List<X> getList(String sqlID, Object object) {
		return getSqlSession().selectList(buildSqlID(sqlID), object);
	}

	protected <X> Page<X> getPage(String sqlID, Page<X> page) {
		List<X> list = getList(sqlID, page);
		page.setResults(list);
		return page;
	}

	protected <X> Page<X> getPage(List<X> list, Page<X> page) {
		page.setTotalRecord(list.size());
		if (list.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(list.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(list.subList(page.getStartOfPage(), list.size()));
		}
		return page;
	}

	protected int batchInsert(String sqlID, List<?> list) {
		SqlSession batchSession = getBatchSqlSession();
		int i = 0;
		String sqlIdFullName = buildSqlID(sqlID);
		for (int cnt = list.size(); i < cnt; i++) {
			if (StringUtils.isEmpty((String) ModelHelper.getIdValue(list.get(i)))) {
				ModelHelper.setPK(list.get(i));
			}
			ModelHelper.setDefaultWithSave(list.get(i));
			batchSession.insert(sqlIdFullName, list.get(i));
			if ((i + 1) % BATCH_DEAL_NUM == 0) {
				batchSession.flushStatements();
			}
		}
		batchSession.flushStatements();
		return i;
	}

	protected int batchUpdate(String sqlID, List<?> list) {
		SqlSession batchSession = getBatchSqlSession();
		int i = 0;
		String sqlIdFullName = buildSqlID(sqlID);
		for (int cnt = list.size(); i < cnt; i++) {
			batchSession.update(sqlIdFullName, list.get(i));
			if ((i + 1) % BATCH_DEAL_NUM == 0) {
				batchSession.flushStatements();
			}
		}
		batchSession.flushStatements();
		return i;
	}

	protected int batchDelete(String sqlID, List<?> list) {
		SqlSession batchSession = getBatchSqlSession();
		int i = 0;
		String sqlIdFullName = buildSqlID(sqlID);
		for (int cnt = list.size(); i < cnt; i++) {
			batchSession.delete(sqlIdFullName, list.get(i));
			if ((i + 1) % BATCH_DEAL_NUM == 0) {
				batchSession.flushStatements();
			}
		}
		batchSession.flushStatements();
		return i;
	}
}
