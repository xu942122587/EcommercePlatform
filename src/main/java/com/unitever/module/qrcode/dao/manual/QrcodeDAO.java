package com.unitever.module.qrcode.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class QrcodeDAO extends BaseDAO<Qrcode, String> {

	/**
	 * 根据Qrcode条件查询Qrcode依据产品和日期的分组统计
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Qrcode
	 * @return List<Qrcode>
	 */
	public List<Qrcode> getQrcodeByQrcode(Qrcode qrcode) {
		return this.getList("getQrcodeByQrcode", qrcode);
	}

	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年1月29日
	 * @param qrcode
	 * @return int
	 */
	public int getCountByQrcode(Qrcode qrcode) {
		return this.get("getCountByQrcode", qrcode);
	}

	/**
	 * <p>
	 * 根据Qrcode条件查询Qrcode明细
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param qrcode
	 * @return List<Qrcode>
	 */
	public List<Qrcode> getQrcodeListByQrcode(Qrcode qrcode) {
		return this.getList("getQrcodeListByQrcode", qrcode);
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchInsert(List<Qrcode> list) {
		return this.batchInsert("save", list);
	}

	/**
	 *
	 * <P>
	 * 依据二维码批次号获取二维码列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param qrcodeBatch
	 * @return List<Qrcode>
	 */
	public List<Qrcode> getQrcodeByQRCdodeBatch(String qrcodeBatch) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("qrcodeBatch", qrcodeBatch);
		return this.getList("getQrcodeByQRCdodeBatch", map);
	}

	/**
	 *
	 * <P>
	 * 依据二维码Id获取二维码list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 14, 2017
	 * @param id
	 * @return List<Qrcode>
	 */
	public List<Qrcode> getQrcodeListById(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.getList("getQrcodeListById", map);
	}

	/**
	 *
	 * <P>
	 * 根据ProcurementId修改所有qrcode状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateAllQrcodeStateByProcurementId(String state, String procurementId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("state", state);
		map.put("procurementId", procurementId);
		return this.update("updateAllQrcodeStateByProcurementId", map);
	}

	/**
	 *
	 * <P>
	 * 根据AllocationId修改所有qrcode状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateAllQrcodeStateByAllocationId(String state, String allocationId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("state", state);
		map.put("allocationId", allocationId);
		return this.update("updateAllQrcodeStateByAllocationId", map);
	}

	/**
	 *
	 * <P>
	 * state由正常变锁定
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateStateOneToFour(Qrcode qrcode) {
		return this.update("updateStateOneToFour", qrcode);
	}

	/**
	 *
	 * <P>
	 * state由锁定变正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToOne(Qrcode qrcode) {
		return this.update("updateStateFourToOne", qrcode);
	}

	/**
	 *
	 * <P>
	 * state由锁定变卖出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToTwo(Qrcode qrcode) {
		return this.update("updateStateFourToTwo", qrcode);
	}

	/**
	 *
	 * <P>
	 * state由卖出变正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateTwoToOne(Qrcode qrcode) {
		return this.update("updateStateTwoToOne", qrcode);
	}

	/**
	 *
	 * <P>
	 * state由正常变卖出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateOneToTwo(Qrcode qrcode) {
		return this.update("updateStateOneToTwo", qrcode);
	}

	/**
	 *
	 * <P>
	 * 根据orderId修改qrcode状态从锁定为正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToOneByOrderId(String orderId) {
		Map<String, String> map = new HashMap<>();
		map.put("orderId", orderId);
		return this.update("updateStateFourToOneByOrderId", map);
	}

	/**
	 *
	 * <P>
	 * 依据订单Ordercode获取订单赠品QrcodeList
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderCode
	 * @return Object
	 */
	public List<Qrcode> getPutOutQrcodeListByOrderCode(String orderCode) {
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.getList("getPutOutQrcodeListByOrderCode", map);
	}
}
