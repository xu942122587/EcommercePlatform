package com.unitever.auth.function.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.unitever.auth.function.model.Function;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class FunctionDAO extends BaseDAO<Function, String>{

	public List<Function> getChildrenFunctions(String id){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("id", id);
		return this.getList("getChildrenFunctions", params);
	}

	public Function getFunctionWithName(String name) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("name", name);
		List<Function> functionList = this.getList("getFunctionWithName", name);
		return functionList.size() > 0 ? functionList.get(0) : null;
	}

	public List<Function> getFunctionByFunction(Function function) {
		return this.getList("getFunctionByFunction", function);
	}

	
	public List<Function> getParentFunctions() {
		return this.getList("getParentFunctions");
	}
}