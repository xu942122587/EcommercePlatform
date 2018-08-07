package com.unitever.module.store.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

import net.sf.json.JSONObject;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.store.controller->StoreController.java
 * </p>
 * <P>
 * 门店controller
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Controller
@RequestMapping(value = "/store")
public class StoreController extends SpringController {

	@Autowired
	private StoreService storeService;

	private Logger logger_storeController = LoggerFactory.getLogger("StoreController");

	/**
	 *
	 * <P>
	 * 跳转至门店列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param store
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Store> page, @FormModel("model") Store store) {
		setAttribute("pageObj", storeService.getPage(page, store));
		setAttribute("model", store);
		return "module/store/store-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", storeService.getStoreById(id));
		}
		return "module/store/store-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", storeService.getStoreById(id));
		return "module/store/store-view";
	}

	/**
	 *
	 * <P>
	 * 保存门店信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param store
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Store store) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(store.getId())) {
				ajaxJson.setMsg("修改门店成功！");
				if (0 >= storeService.update(store)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改门店失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改门店成功！");
				}
			} else {
				if (0 >= storeService.save(store)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加门店失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加门店成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeController.error(
					"保存门店信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= storeService.deleteStore(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除门店失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除门店失败，请刷新页面后重试~");
				logger_storeController.warn("删除门店时，门店ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeController.error(
					"删除门店出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 门店停业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doStoreStop", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doStoreStop(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= storeService.storeStop(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("门店停业失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("门店停业失败，请刷新页面后重试~");
				logger_storeController.warn("门店停业时，门店ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeController.error(
					"门店停业出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 门店营业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doStoreStart", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doStoreStart(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= storeService.storeStart(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("门店营业失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("门店营业失败，请刷新页面后重试~");
				logger_storeController.warn("门店营业时，门店ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeController.error(
					"门店营业出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 * 修改门店时，验证门店编号是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/validateStoreIsExist", method = RequestMethod.POST)
	@ResponseBody
	public String validateStoreIsExist() {
		JSONObject object = new JSONObject();
		String storeCode = this.getRequest().getParameter("model.storeCode");
		String storeId = this.getRequest().getParameter("storeId");
		if (StringUtils.isNotBlank(storeCode)) {
			Store store = storeService.getStoreById(storeId);
			if (store == null) {
				object.put("valid", true);
			} else {
				// 验证一下是否修改用户名，如果用户名还是之前的，可以验证通过
				if (storeCode.equals(store.getStoreCode())) {
					object.put("valid", true);
				} else {
					Store store2 = new Store();
					store2.setStoreCode(storeCode);
					int i = storeService.getCountByStore(store2);
					if (0 >= i) {
						object.put("valid", true);
					} else {
						object.put("valid", false);
					}
				}

			}
		}
		return object.toString();
	}

	/**
	 * 添加门店时，验证门店编号是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/isStoreExist", method = RequestMethod.POST)
	@ResponseBody
	public String isStoreExist() {
		JSONObject object = new JSONObject();
		String storeCode = this.getRequest().getParameter("model.storeCode");
		if (StringUtils.isNotBlank(storeCode)) {
			Store store = new Store();
			store.setStoreCode(storeCode);
			int i = storeService.getCountByStore(store);
			if (0 >= i) {
				object.put("valid", true);
			} else {
				object.put("valid", false);
			}
		}
		return object.toString();
	}
}