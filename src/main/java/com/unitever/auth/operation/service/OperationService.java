package com.unitever.auth.operation.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.operation.dao.manual.OperationDAO;
import com.unitever.auth.operation.model.Operation;
import com.unitever.auth.role.dao.manual.RoleDAO;
import com.unitever.platform.core.dao.Page;

@Service
@Transactional
public class OperationService {

	public Page<Operation> getPage(Page<Operation> page, Operation operation) {
		List<Operation> OperationList = operationDAO.getOperationsByFuncId(operation.getParentFunction().getId());
		page.setTotalRecord(OperationList.size());
		// if (OperationList.size() >= (page.getStartOfPage() +
		// page.getPageSize())) {
		// page.setResults(OperationList.subList(page.getStartOfPage(),
		// page.getStartOfPage() + page.getPageSize()));
		// } else {
		// page.setResults(OperationList.subList(page.getStartOfPage(),
		// OperationList.size()));
		// }
		page.setResults(OperationList);
		return page;
	}

	public void save(Operation Operation) {
		if (Operation != null) {
			operationDAO.save(Operation);
		}
	}

	public Operation getOperationWithId(String id) {
		return operationDAO.get(id);
	}

	public List<Operation> getOperationList() {
		return operationDAO.getAll();
	}

	public void update(Operation Operation) {
		operationDAO.update(Operation);
	}

	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			roleDAO.deleteRoleOperationsByOperationId(id);
			operationDAO.delete(id);
		}
	}

	public List<Operation> getOperationsByFuncId(String functionId) {
		if (StringUtils.isBlank(functionId)) {
			return null;
		}
		return operationDAO.getOperationsByFuncId(functionId);
	}

	public void deleteByFunctionId(String functionId) {
		operationDAO.deleteByFunctionId(functionId);
	}

	@Autowired
	private OperationDAO operationDAO;
	@Autowired
	private RoleDAO roleDAO;
}