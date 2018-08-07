package com.unitever.module.evaluation.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.customer.model.Customer;
import com.unitever.module.evaluation.dao.manual.EvaluationDAO;
import com.unitever.module.evaluation.model.Evaluation;
import com.unitever.platform.component.attachment.service.AttachmentConfigService;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.FileUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class EvaluationService {

	private Logger logger_evaluationService = LoggerFactory.getLogger("EvaluationService");
	@Autowired
	private EvaluationDAO evaluationDAO;
	@Autowired
	private AttachmentConfigService attachmentConfigService;

	public List<Evaluation> getEvaluationListWithCustomerId(String customerId) {
		Evaluation evaluation = new Evaluation();
		evaluation.setCustomer(new Customer(customerId));
		return evaluationDAO.getEvaluationListWithEvaluation(evaluation);
	}

	/**
	 * 根据goodsId获取List
	 * 
	 * @author XiaoYu
	 * @date 2017年1月13日
	 * @param goodsId
	 * @return List<Evaluation>
	 */
	public List<Evaluation> getEvaluationListByGoodsId(String goodsId) {
		if (StringUtils.isNotBlank(goodsId)) {
			return evaluationDAO.getEvaluationListByGoodsId(goodsId);
		}
		return null;
	}

	/**
	 * 保存评价
	 * 
	 * @author XiaoYu
	 * @date 2017年1月13日
	 * @param evaluation
	 * @return AjaxJson
	 */
	public int doSaveEvalute(Evaluation evaluation) {
		evaluation.setId(UUID.getUUID());
		evaluation.setCreateTime(new Date());
		int i = evaluationDAO.save(evaluation);
		if (0 < i && StringUtils.isNotBlank(evaluation.getImgName())) {
			String[] imgNameArray = evaluation.getImgName().split(",");
			boolean isFileBindSuccess = true;
			for (String str : imgNameArray) {
				if (isFileBindSuccess) {
					try {
						FileUtil.bindFile(str, attachmentConfigService.getAttachmentConfigDefault().getSaveDir());
					} catch (IOException e) {
						isFileBindSuccess = false;
						logger_evaluationService.error("绑定文件出错，出错文件名：" + str + "\r\n具体错误原因如下："
								+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
					}
				}
			}
		}
		return i;
	}
}
