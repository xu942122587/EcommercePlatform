package com.unitever.module.vende.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.area.model.Area;
import com.unitever.module.area.service.AreaService;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.vende.model.Vende;
import com.unitever.module.vende.service.VendeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

import net.sf.json.JSONArray;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.vende.controller->VendeController. java
 * </p>
 * <P>
 * 供应商controller
 * </p>
 *
 * @author 闫枫
 * @date Jul 3, 2017
 */
@Controller
@RequestMapping(value = "/vende")
public class VendeController extends SpringController {

	@Autowired
	private VendeService vendeService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private AreaService areaService;

	private Logger logger_vendeController = LoggerFactory.getLogger("VendeController");

	/**
	 *
	 * <P>
	 * 跳转至供应商列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param page
	 * @param vende
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Vende> page, @FormModel("model") Vende vende) {
		setAttribute("pageObj", vendeService.getPage(page, vende));
		setAttribute("model", vende);
		return "module/vende/vende-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加修改供应商
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			Vende vende = vendeService.getVendeById(id);
			setAttribute("model", vende);
			setAttribute("areaCityList", areaService.getAreaByArea(
					new Area(null, null, null, Area.STATE_DELETE_NO, new Area(vende.getAddressArray()[0]), null)));
			setAttribute("areaDistrictList", areaService.getAreaByArea(
					new Area(null, null, null, Area.STATE_DELETE_NO, new Area(vende.getAddressArray()[1]), null)));
		}
		setAttribute("storeList", storeService.getAllStore());
		setAttribute("areaProvinceList",
				areaService.getAreaByArea(new Area(null, null, null, Area.STATE_DELETE_NO, null, null)));
		return "module/vende/vende-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看供应商
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", vendeService.getVendeById(id));
		return "module/vende/vende-view";
	}

	/**
	 *
	 * <P>
	 * 保存供应商信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param vende
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Vende vende) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(vende.getId())) {
				ajaxJson.setMsg("修改供应商成功！");
				if (0 >= vendeService.update(vende)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改供应商失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改供应商成功！");
				}
			} else {
				if (0 >= vendeService.save(vende)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加供应商失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加供应商成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_vendeController.error(
					"保存供应商信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除供应商
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= vendeService.deleteVende(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除供应商失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除供应商失败，请刷新页面后重试~");
				logger_vendeController.warn("删除供应商时，供应商ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_vendeController.error(
					"删除供应商出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * ajax依据父AreaId获取AreaListJson
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 4, 2017
	 * @param areaId
	 * @return
	 */
	@RequestMapping(value = "/getAjaxAreaByAreaId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getAjaxAreaByArea(@RequestParam(value = "areaId") String areaId) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setSuccess(true);
		List<Area> areas = areaService
				.getAreaByArea(new Area(null, null, null, Area.STATE_DELETE_NO, new Area(areaId), null));
		ajaxJson.setMsg(JSONArray.fromObject(areas).toString());
		return ajaxJson;
	}
}