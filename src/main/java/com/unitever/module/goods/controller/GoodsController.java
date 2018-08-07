package com.unitever.module.goods.controller;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.role.model.Role;
import com.unitever.auth.user.model.User;
import com.unitever.module.brand.service.BrandService;
import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.specification.service.SpecificationService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.goods.controller->GoodsController.java
 * </p>
 * <P>
 * 商品 Controller
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月3日
 */
@Controller
@RequestMapping(value = "/goods")
public class GoodsController extends SpringController {

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ClassificationService classificationService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private SpecificationService specificationService;
	@Autowired
	private QrcodeService qrcodeService;

	private Logger logger_goodsController = LoggerFactory.getLogger("GoodsController");

	/**
	 *
	 * <P>
	 * 商品列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param page
	 * @param goods
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Goods> page, @FormModel("model") Goods goods) {
		setAttribute("pageObj", goodsService.getPage(page, goods));
		setAttribute("model", goods);
		setAttribute("classificationList", classificationService.getParentClassificationList());
		setAttribute("brandList", brandService.getAllBrand());
		setAttribute("storeList", storeService.getAllStore());
		return "module/goods/goods-list";
	}

	/**
	 *
	 * <P>
	 * 添加或修改商品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		setAttribute("classificationList", classificationService.getParentClassificationList());
		setAttribute("brandList", brandService.getAllBrand());
		setAttribute("storeList", storeService.getAllTianheStore());
		setAttribute("specificationList", specificationService.getAllSpecification());
		if (StringUtils.isNotBlank(id)) {
			Goods goods = goodsService.getGoodsById(id);
			if (null != goods.getClassification().getParentClassification()
					&& StringUtils.isNotBlank(goods.getClassification().getParentClassification().getId())
					&& null == goods.getClassification().getParentClassification().getParentClassification()) {
				setAttribute(
						"twoClassificationList",
						classificationService.getChildrenClassificationList(goods.getClassification()
								.getParentClassification().getId()));
			}
			if (null != goods.getClassification().getParentClassification()
					&& StringUtils.isNotBlank(goods.getClassification().getParentClassification().getId())
					&& null != goods.getClassification().getParentClassification().getParentClassification()
					&& StringUtils.isNotBlank(goods.getClassification().getParentClassification()
							.getParentClassification().getId())) {
				setAttribute(
						"twoClassificationList",
						classificationService.getChildrenClassificationList(goods.getClassification()
								.getParentClassification().getParentClassification().getId()));
				setAttribute(
						"threeClassificationList",
						classificationService.getChildrenClassificationList(goods.getClassification()
								.getParentClassification().getId()));
			}
			setAttribute("model", goods);
		}
		return "module/goods/goods-input";
	}

	/**
	 *
	 * <P>
	 * 查看商品详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id) {
		setAttribute("model", goodsService.getGoodsById(id));
		setAttribute("classStringList", classificationService.getClassificationAttrForClassification(goodsService
				.getGoodsById(id).getClassification()));
		return "module/goods/goods-view";
	}

	/**
	 *
	 * <P>
	 * 保存或更新
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goods
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Goods goods) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goods.getId())) {
				if ((null != goods.getGoodsChildList() && 0 < goods.getGoodsChildList().size())
						|| (null != goods.getGoodsChildListNew() && 0 < goods.getGoodsChildListNew().size())) {
					goods.setIsAbnormal(Goods.ABNORMAL_FALSE);
					if (0 >= goodsService.update(goods)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("修改商品失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("修改商品成功！");
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("商品必须添加属性,请检查!");
				}
			} else {
				if (null != goods.getGoodsChildListNew() && 0 < goods.getGoodsChildListNew().size()) {
					if (0 >= goodsService.save(goods)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("添加商品失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加商品成功！");
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("商品必须添加属性,请检查!");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("保存商品信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= goodsService.deleteAll(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除商品失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除商品失败，请刷新页面后重试~");
				logger_goodsController.warn("删除商品时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("删除商品出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 上下架操作
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doSetVisible", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doSetVisible(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "flag") String flag) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				if (0 >= goodsService.doSetVisible(goodsId, flag)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("上下架失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("上下架失败，请刷新页面后重试~");
				logger_goodsController.warn("上下架时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("上下架出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 推荐与取消推荐操作
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doSetRecommed", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doSetRecommed(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "flag") String flag) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				if (0 >= goodsService.doSetRecommed(goodsId, flag)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("推荐操作失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("推荐操作失败，请刷新页面后重试~");
				logger_goodsController.warn("推荐操作时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("推荐操作出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 修改异常状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月10日
	 * @param goodsId
	 * @param flag
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doSetAbnormal", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doSetAbnormal(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "flag") String flag) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				if (0 >= goodsService.doSetAbnormal(goodsId, flag)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("异常操作失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("异常操作失败，请刷新页面后重试~");
				logger_goodsController.warn("异常操作时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("异常操作出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据产品ID获取产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getGoodsByGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsByGoodsId(@RequestParam(value = "goodsId") String goodsId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				Goods goods = goodsService.getGoodsById(goodsId);
				if (null != goods) {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取产品信息成功");
					ajaxJson.setObj(getGoodsToJsp(goods));
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_goodsController.warn("获取产品信息时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据QRCodeID获取产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getGoodsByQrcodeId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsByQrcodeId(@RequestParam(value = "QRCodeID") String QRCodeID,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "checkQrcode", required = false) String checkQrcode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(QRCodeID)) {
				if ("yes".equals(checkQrcode)) {
					Qrcode qrcode = qrcodeService.getQrcodeById(QRCodeID);
					if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("二维码无效，换一件试试吧~");
						return ajaxJson;
					} else {
						if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("本件产品已卖出，换一件试试吧~");
							return ajaxJson;
						} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("本件产品已经退还给厂家了，换一件试试吧~");
							return ajaxJson;
						} else if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("本件产品已经被其他订单（采购退货单、库存调拨单）锁定了，换一件试试吧~");
							return ajaxJson;
						}
					}
				}
				Goods goods = goodsService.getGoodsByQRCodeID(QRCodeID);
				if (null != goods) {
					if (StringUtils.isNotBlank(storeId)) {
						if (!storeId.equals(goods.getStore().getId())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("扫描产品不归属该门店，请仔细确认~");
							return ajaxJson;
						}
					} else {
						User user_in_session = UserUtil.getCurrUser();
						if (Role.TYPE_EMPLOYEE.equals(user_in_session.getRole().getType())) {
							if (!user_in_session.getStore().getId().equals(goods.getStore().getId())) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("扫描产品不归属本门店，请仔细确认~");
								return ajaxJson;
							}
						}
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取产品信息成功");
					ajaxJson.setObj(getGoodsToJsp(goods));
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_goodsController.warn("获取产品信息时，QRCodeID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据QRCodeID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 由数据库获取的goods对象转码后用于ajax返回页面<br/>
	 * 避免出现转码时，死循环转码主商品和子商品现象导致转码失败
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goods_by_getFunction
	 * @return Goods
	 */
	public static Goods getGoodsToJsp(Goods goods_by_getFunction) {
		Goods goods_to_jsp = new Goods();
		boolean isChildrenGoods = false;
		goods_to_jsp.setId(goods_by_getFunction.getId());
		goods_to_jsp.setOtherAttr(goods_by_getFunction.getOtherAttr());
		goods_to_jsp.setGoods_inventory(goods_by_getFunction.getGoods_inventory());
		goods_to_jsp.setBuyMoney(goods_by_getFunction.getBuyMoney());
		goods_to_jsp.setBuyAgio(goods_by_getFunction.getBuyAgio());
		goods_to_jsp.setGoodsChildList_size(goods_by_getFunction.getGoodsChildList_size());
		if (null != goods_by_getFunction.getGoods()) {
			if (StringUtils.isNotBlank(goods_by_getFunction.getGoods().getId())) {
				isChildrenGoods = true;
			}
		}
		if (isChildrenGoods) {
			goods_to_jsp.setName(goods_by_getFunction.getGoods().getName());
			goods_to_jsp.setImgUrl(goods_by_getFunction.getGoods().getImgUrl());
			goods_to_jsp.setPrice(goods_by_getFunction.getGoods().getPrice());
			goods_to_jsp.setGoodsCode(goods_by_getFunction.getGoods().getGoodsCode());
			goods_to_jsp.setSalesPrice(goods_by_getFunction.getGoods().getSalesPrice());
			goods_to_jsp.setGoods(new Goods(goods_by_getFunction.getGoods().getId()));
		} else {
			goods_to_jsp.setGoods(new Goods(""));
			goods_to_jsp.setName(goods_by_getFunction.getName());
			goods_to_jsp.setPrice(goods_by_getFunction.getPrice());
			goods_to_jsp.setImgUrl(goods_by_getFunction.getImgUrl());
			goods_to_jsp.setGoodsCode(goods_by_getFunction.getGoodsCode());
			goods_to_jsp.setSalesPrice(goods_by_getFunction.getSalesPrice());
		}
		return goods_to_jsp;
	}

	/**
	 *
	 * <P>
	 * 由数据库获取的goods对象转码后用于ajax返回页面<br/>
	 * 避免出现转码时，死循环转码主商品和子商品现象导致转码失败
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goods_by_getFunction
	 * @return List<Goods>
	 */
	public static List<Goods> getSubGoodsListToJsp(Goods goods_by_getFunction) {
		List<Goods> goods_list_to_jsp = new ArrayList<Goods>();
		List<Goods> goods_list_by_getFunction = goods_by_getFunction.getGoodsChildList();
		if (null != goods_list_by_getFunction) {
			if (!goods_list_by_getFunction.isEmpty()) {
				for (Goods goods_subGoods : goods_list_by_getFunction) {
					goods_list_to_jsp.add(getGoodsToJsp(goods_subGoods));
				}
			}
		}
		return goods_list_to_jsp;
	}

	/**
	 *
	 * <P>
	 * 由数据库获取的goodsList转码后用于ajax返回页面<br/>
	 * 避免出现转码时，死循环转码主商品和子商品现象导致转码失败
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goods_by_getFunction
	 * @return List<Goods>
	 */
	public static List<Goods> getGoodsListToJsp(List<Goods> goodsList_by_getFunction) {
		List<Goods> goods_list_to_jsp = new ArrayList<Goods>();
		if (null != goodsList_by_getFunction) {
			if (!goodsList_by_getFunction.isEmpty()) {
				for (Goods goods_subGoods : goodsList_by_getFunction) {
					goods_list_to_jsp.add(getGoodsToJsp(goods_subGoods));
				}
			}
		}
		return goods_list_to_jsp;
	}

	/**
	 *
	 * <P>
	 * 依据父产品ID获取子产品信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getSubGoodsByGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getSubGoodsByGoodsId(@RequestParam(value = "goodsId") String goodsId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				Goods goods = goodsService.getGoodsById(goodsId);
				if (null != goods) {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取产品信息成功");
					ajaxJson.setObj(getSubGoodsListToJsp(goods));
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_goodsController.warn("获取产品信息时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据门店Id获取产品列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 7, 2017
	 * @param storeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getGoodsByStoreId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsByStoreId(@RequestParam(value = "storeId") String storeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(storeId)) {
				List<Goods> goodsList = goodsService.getGoodsByStoreId(storeId);
				if (null != goodsList) {
					if (!goodsList.isEmpty()) {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("获取产品信息成功");
						ajaxJson.setObj(getGoodsListToJsp(goodsList));
						return ajaxJson;
					}
				}
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_goodsController.warn("获取产品信息时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据父产品ID获取子产品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月21日
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getGoodsChildListByInventoryGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getSubGoodsByGoodsId(@RequestParam(value = "id") String id,
			@RequestParam(value = "storageId") String storageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				List<Goods> goodsList = goodsService.getGoodsChildListByInventoryGoodsId(id, storageId);
				List<Goods> goodsChildList = new ArrayList<Goods>();
				if (null != goodsList) {
					for (Goods goods : goodsList) {
						goods.getBrand().setFu_user(null);
						goodsChildList.add(goods);
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取产品信息成功");
					ajaxJson.setObj(getGoodsListToJsp(goodsChildList));
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_goodsController.warn("获取产品信息时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 活动分组获取产品级活动主产品备选项列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 21, 2017
	 * @param store_id
	 *            门店ID
	 * @param goodsCode
	 *            产品编号（模糊查询）
	 * @param class_id
	 *            所属分类ID（1、2、3级分类ID都可）
	 * @return List<Goods>
	 */
	@RequestMapping(value = "/getGoodsListWhithProGroup", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsListWhithProGroup(@RequestParam(value = "store_id", required = false) String store_id,
			@RequestParam(value = "goodsCode", required = false) String goodsCode,
			@RequestParam(value = "class_id", required = false) String class_id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			List<Goods> goodsList = goodsService.getGoodsListWhithProGroup(store_id, goodsCode, class_id);
			List<Goods> goodsChildList = new ArrayList<Goods>();
			if (null != goodsList) {
				for (Goods goods : goodsList) {
					goods.getBrand().setFu_user(null);
					goodsChildList.add(goods);
				}
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("获取产品信息成功");
				ajaxJson.setObj(getGoodsListToJsp(goodsChildList));
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_goodsController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 * 修改门店时，验证门店编号是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/validateGoodsIsExist", method = RequestMethod.POST)
	@ResponseBody
	public String validateGoodsIsExist() {
		JSONObject object = new JSONObject();
		String goodsCode = this.getRequest().getParameter("model.goodsCode");
		String goodsId = this.getRequest().getParameter("goodsId");
		if (StringUtils.isNotBlank(goodsCode)) {
			Goods goods = goodsService.getGoodsById(goodsId);
			if (goods == null) {
				object.put("valid", true);
			} else {
				// 验证一下是否修改用户名，如果用户名还是之前的，可以验证通过
				if (goodsCode.equals(goods.getGoodsCode())) {
					object.put("valid", true);
				} else {
					Goods goods2 = new Goods();
					goods2.setGoodsCode(goodsCode);
					int i = goodsService.getCountByGoods(goods2);
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
	@RequestMapping(value = "/isGoodsExist", method = RequestMethod.POST)
	@ResponseBody
	public String isGoodsExist() {
		JSONObject object = new JSONObject();
		String goodsCode = this.getRequest().getParameter("model.goodsCode");
		if (StringUtils.isNotBlank(goodsCode)) {
			Goods goods = new Goods();
			goods.setGoodsCode(goodsCode);
			int i = goodsService.getCountByGoods(goods);
			if (0 >= i) {
				object.put("valid", true);
			} else {
				object.put("valid", false);
			}
		}
		return object.toString();
	}
}