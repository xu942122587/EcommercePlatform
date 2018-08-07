package com.unitever.auth.operation.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.unitever.auth.operation.model.Operation;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OperationDAO extends BaseDAO<Operation, String>{

	public List<Operation> getOperationsByFuncId(String functionId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("functionId", functionId);
		return this.getList("getOperationsByFuncId", params);
	}
	
	public void deleteByFunctionId(String functionId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("functionId", functionId);
		this.getBatchSqlSession().delete("deleteByFunctionId", map);
	}
}