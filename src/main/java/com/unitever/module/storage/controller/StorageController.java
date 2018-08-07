package com.unitever.module.storage.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.storage.model.Storage;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storage.controller->StorageController.
 * java
 * </p>
 * <P>
 * 仓库controller
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Controller
@RequestMapping(value = "/storage")
public class StorageController extends SpringController {

	@Autowired
	private StorageService storageService;
	@Autowired
	private StoreService storeService;

	private Logger logger_storageController = LoggerFactory.getLogger("StorageController");

	/**
	 *
	 * <P>
	 * 跳转至仓库列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param storage
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Storage> page, @FormModel("model") Storage storage) {
		setAttribute("pageObj", storageService.getPage(page, storage));
		setAttribute("model", storage);
		return "module/storage/storage-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加修改仓库
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
			setAttribute("model", storageService.getStorageById(id));
		}
		setAttribute("storeList", storeService.getAllTianheStore());
		return "module/storage/storage-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看仓库
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", storageService.getStorageById(id));
		return "module/storage/storage-view";
	}

	/**
	 *
	 * <P>
	 * 保存仓库信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storage
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Storage storage) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(storage.getId())) {
				ajaxJson.setMsg("修改仓库成功！");
				if (0 >= storageService.update(storage)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改仓库失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改仓库成功！");
				}
			} else {
				if (0 >= storageService.save(storage)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加仓库失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加仓库成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storageController.error(
					"保存仓库信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除仓库
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
				if (0 >= storageService.deleteStorage(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除仓库失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除仓库失败，请刷新页面后重试~");
				logger_storageController.warn("删除仓库时，仓库ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storageController.error(
					"删除仓库出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 仓库停用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doStorageStop", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doStorageStop(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= storageService.storageStop(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("仓库停用失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("仓库停用失败，请刷新页面后重试~");
				logger_storageController.warn("仓库停用时，仓库ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storageController.error(
					"仓库停用出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 仓库启用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doStorageStart", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doStorageStart(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= storageService.storageStart(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("仓库启用失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("仓库启用失败，请刷新页面后重试~");
				logger_storageController.warn("仓库启用时，仓库ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storageController.error(
					"仓库启用出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}