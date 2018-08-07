package com.unitever.auth.function.controller; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.function.model.Function;
import com.unitever.auth.function.service.FunctionService;
import com.unitever.auth.operation.service.OperationService;
import com.unitever.auth.role.service.RoleService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;

/** 
 * @author 作者 : 邓文杰
 * @version 创建时间：2015-12-15 下午3:52:45 
 * 类说明 ：权限
 */

@Controller
@RequestMapping(value="/function")
public class FunctionController extends SpringController{
	
	@Autowired
	private FunctionService functionService;
	
	@RequestMapping(value="/list")
	public String list(@FormModel("page") Page<Function> page, @FormModel("model") Function function){
		setAttribute("pageObj", functionService.getPage(page, function));
		setAttribute("model", function);
		return "auth/function/function-list";
	}
	
	@RequestMapping("/getFunctionTree")
	@ResponseBody
	public String getFunctionTree(String roleId) {
		return functionService.getFunctionTree(roleId);
	}
	
	@RequestMapping(value="/goAddOrUpdate")
	public String goAddOrUpdate(@RequestParam(value="inputKind", required = false) String inputKind,
			@RequestParam(value="id", required = false) String id){
		if("update".equals(inputKind)){
			setAttribute("function", functionService.getFunctionWithId(id));
		}else{
			setAttribute("function", new Function());
		}
		//获取所有父权限
		setAttribute("parentFunctions", functionService.getParentFunctions());
		setAttribute("inputKind", inputKind);
		return "auth/function/function-add";
	}
	
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public AjaxJson doAddOrUpdate(Function function) {
		String inputKind = getRequest().getParameter("inputKind");
		AjaxJson json=new AjaxJson();
		if("update".equals(inputKind)) {
			functionService.update(function);
		} else {
			functionService.save(function);
		}
		json.setSuccess(true);
		return json;
	}
	
	@RequestMapping(value="/doDelete",method=RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String functionId) {
		AjaxJson json=new AjaxJson();
		functionService.delete(functionId);
		json.setSuccess(true);
		return json;
	}

}
