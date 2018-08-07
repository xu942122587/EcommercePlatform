package com.unitever.module.procurementQrcode.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.procurementQrcode.model.ProcurementQrcode;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ProcurementQrcodeDAO extends BaseDAO<ProcurementQrcode, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<ProcurementQrcode>
	 */
	public List<ProcurementQrcode> getProcurementQrcodeByProcurementQrcode(ProcurementQrcode procurementQrcode) {
		return this.getList("getProcurementQrcodeByProcurementQrcode", procurementQrcode);
	}

	/**
	 *
	 * <P>
	 * 根据调拨单Id获得所有调拨记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月19日
	 * @param id
	 * @return List<ProcurementQrcode>
	 */
	public List<ProcurementQrcode> getProcurementQrcodeListByProcurementId(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.getList("getProcurementQrcodeListByProcurementId", map);
	}

	/**
	 *
	 * <P>
	 * 根据调拨单Id,按照商品排序,获得信息和商品数量(QrcodeCount)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param id
	 * @return List<ProcurementQrcode>
	 */
	public List<ProcurementQrcode> getQrcodeCountByProcurementId(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.getList("getQrcodeCountByProcurementId", map);
	}

	/**
	 * 获取符合当前条件的ProcurementQrcode数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByProcurementQrcode(ProcurementQrcode procurementQrcode) {
		return this.get("getCountByProcurementQrcode", procurementQrcode);
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
	public int batchInsert(List<ProcurementQrcode> list) {
		return this.batchInsert("save", list);
	}

}
