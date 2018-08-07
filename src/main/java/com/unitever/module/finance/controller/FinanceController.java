package com.unitever.module.finance.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.unitever.module.consume.service.ConsumeService;
import com.unitever.module.finance.service.FinanceService;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurement.service.ProcurementService;
import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.module.procurementGoods.service.ProcurementGoodsService;
import com.unitever.module.procurementQrcode.model.ProcurementQrcode;
import com.unitever.module.procurementQrcode.service.ProcurementQrcodeService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/finance")
public class FinanceController extends SpringController {

	@Autowired
	private FinanceService financeService;
	@Autowired
	private ProcurementQrcodeService procurementQrcodeService;
	@Autowired
	private ProcurementGoodsService procurementGoodsService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private ProcurementService procurementService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ConsumeService rechargeRecordService;

	private Logger logger_financeController = LoggerFactory.getLogger("FinanceController");

	/**
	 *
	 * <P>
	 * 跳转至财务管理流水列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月14日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/orderList")
	public String orderList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		try {
			setAttribute("pageObj", financeService.getOrderPage(page, order));
			setAttribute("model", order);
			return "module/finance/finance-orderList";
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往流水列表界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至财务管理流水列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月14日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/rechargeRecordList")
	public String rechargeRecordList(@FormModel("page") Page<RechargeRecord> page,
			@FormModel("model") RechargeRecord rechargeRecord) {
		try {
			setAttribute("pageObj", financeService.getRechargeRecordPage(page, rechargeRecord));
			setAttribute("model", rechargeRecord);
			return "module/finance/finance-rechargeRecordList";
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往充值列表出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至财务管理采购列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月14日
	 * @param page
	 * @param procurement
	 * @return String
	 */
	@RequestMapping(value = "/procurementList")
	public String procurementList(@FormModel("page") Page<Procurement> page,
			@FormModel(value = "model") Procurement procurement) {
		try {
			setAttribute("pageObj", financeService.getProcurementPage(page, procurement));
			setAttribute("model", procurement);
			return "module/finance/finance-procurementList";
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往采购列表出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至查看财务管理流水
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
	public String orderView(@RequestParam(value = "id") String id) {
		try {
			setAttribute("model", orderService.getOrderById(id));
			return "module/finance/finance-orderView";
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往财务管理流水出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至查看充值
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/rechargeRecordView", method = RequestMethod.GET)
	public String rechargeRecordView(@RequestParam(value = "id") String id) {
		try {
			setAttribute("model", rechargeRecordService.getConsumeById(id));
			return "module/finance/finance-rechargeRecordView";
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往充值界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至查看财务管理采购
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/procurementView", method = RequestMethod.GET)
	public String procurementView(@RequestParam(value = "id") String id, @RequestParam(value = "type") String type) {
		try {
			if (Procurement.TYPE_TWO.equals(type)) {
				List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
						.getProcurementQrcodeListByProcurementId(id);
				List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
				for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
					Qrcode qrcode = qrcodeService.getQrcodeById(procurementQrcode.getQrcode().getId());
					QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
					qrcodeVO.setProcurementQrcodeId(procurementQrcode.getId());
					qrcodeVOList.add(qrcodeVO);
				}
				Procurement procurement = procurementService.getProcurementById(id);

				setAttribute("type", type);
				setAttribute("procurementId", id);
				setAttribute("model", procurement);
				setAttribute("qrcodeVOList", qrcodeVOList);
				return "module/finance/finance-procurementView";
			} else if (Procurement.TYPE_ONE.equals(type)) {
				Procurement procurement = procurementService.getProcurementById(id);
				List<ProcurementGoods> procurementGoodsList = procurementGoodsService.getAllByProcurementId(id);

				setAttribute("model", procurement);
				setAttribute("procurementGoodsList", procurementGoodsList);
				setAttribute("type", type);
				return "module/finance/finance-procurementView";
			} else {
				System.err.println("未正确获得采购单分类");
				return "module/weChat/jsp/weChat_404";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger_financeController.error("前往财务管理采购界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}
}