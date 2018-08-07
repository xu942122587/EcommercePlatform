package com.unitever.auth.function.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.function.dao.manual.FunctionDAO;
import com.unitever.auth.function.model.Function;
import com.unitever.auth.function.model.FunctionTree;
import com.unitever.auth.function.model.State;
import com.unitever.auth.operation.dao.manual.OperationDAO;
import com.unitever.auth.role.dao.manual.RoleDAO;
import com.unitever.auth.role.model.RoleFunctionRelation;
import com.unitever.auth.role.model.RoleOperationRelation;
import com.unitever.platform.core.dao.Page;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import net.sf.json.util.PropertyFilter;

@Service
@Transactional
public class FunctionService {

	public Page<Function> getPage(Page<Function> page, Function Function) {
		List<Function> FunctionList = functionDAO.getParentFunctions();
		page.setTotalRecord(FunctionList.size());
		if (FunctionList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(FunctionList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(FunctionList.subList(page.getStartOfPage(), FunctionList.size()));
		}
		return page;
	}

	public String getFunctionTree(String roleId) {
		List<Function> FunctionList = functionDAO.getParentFunctions();
		List<RoleFunctionRelation> roleFunctionsList = roleDAO.getRoleFunctionRelationsByRoleId(roleId);
		List<RoleOperationRelation> operationRelations = roleDAO.getRoleOperationLsitByRoleId(roleId);
		List<FunctionTree> funcTrees = new ArrayList<FunctionTree>();
		for (Function function : FunctionList) {
			FunctionTree node = new FunctionTree();
			node.setId(function.getId());
			node.setText(function.getName());
			node.setLevel(function.getLevel());
			for (RoleFunctionRelation relation : roleFunctionsList) {
				if (relation.getFunctionId().equals(function.getId())) {
					node.setState(new State(true));
				}
			}
			if (function.getParentFunction() != null) {
				node.setParentId(function.getParentFunction().getId());
			}
			if (!function.getChildrenFunctions().isEmpty()) {
				List<FunctionTree> childFuncTree = new ArrayList<FunctionTree>();
				for (Function childFunc : function.getChildrenFunctions()) {
					FunctionTree childNode = new FunctionTree();
					childNode.setId(childFunc.getId());
					childNode.setText(childFunc.getName());
					childNode.setLevel(childFunc.getLevel());
					if (childFunc.getParentFunction() != null) {
						childNode.setParentId(childFunc.getParentFunction().getId());
					}
					for (RoleFunctionRelation relation : roleFunctionsList) {
						if (relation.getFunctionId().equals(childFunc.getId())) {
							childNode.setState(new State(true));
						}
					}
					childFuncTree.add(childNode);
				}
				node.setNodes(childFuncTree);
			}
			funcTrees.add(node);
		}

		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setJavaPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) {
				System.out.println(source + ":" + name + ":" + value);
				if (value == null || String.valueOf(value).equals("")) {
					return true;
				}
				return false;
			}

		});
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray jsonObj = JSONArray.fromObject(funcTrees, jsonConfig);
		// 过滤空nodes
		for (int i = 0; i < jsonObj.size(); i++) {
			JSONObject object = jsonObj.getJSONObject(i);
			JSONArray arry = object.getJSONArray("nodes");
			if (arry.size() <= 0) {
				object.remove("nodes");
				jsonObj.set(i, object);
			} else {
				for (int j = 0; j < arry.size(); j++) {
					JSONObject objectChild = arry.getJSONObject(j);
					JSONArray arryChild = objectChild.getJSONArray("nodes");
					if (arryChild.size() <= 0) {
						objectChild.remove("nodes");
						arry.set(j, objectChild);
					}
				}
				object.remove("nodes");
				object.put("nodes", arry);
				jsonObj.set(i, object);
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("function_", jsonObj);
		jsonObject.put("operation_", JSONArray.fromObject(operationRelations, jsonConfig));
		return jsonObject.toString();
	}

	public void save(Function Function) {
		if (Function != null) {
			functionDAO.save(Function);
		}
	}

	public Function getFunctionWithId(String id) {
		return functionDAO.get(id);
	}

	public List<Function> getFunctionList() {
		return functionDAO.getAll();
	}

	public void update(Function Function) {
		functionDAO.update(Function);
	}

	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			// 先删除所以功能里的操作
			operationDAO.deleteByFunctionId(id);
			// 删除功能和角色的关系
			roleDAO.deleteRoleFunctionsByFunctionId(id);
			functionDAO.delete(id);
		}
	}

	public Function getFunctionWithName(String name) {
		if (StringUtils.isBlank(name)) {
			return null;
		}
		return functionDAO.getFunctionWithName(name);
	}

	public List<Function> getParentFunctions() {
		return functionDAO.getParentFunctions();
	}

	public List<Function> getFunctionByFunction(Function Function) {
		return functionDAO.getFunctionByFunction(Function);
	}

	@Autowired
	private FunctionDAO functionDAO;
	@Autowired
	private RoleDAO roleDAO;
	@Autowired
	private OperationDAO operationDAO;
}