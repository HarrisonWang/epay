package com.epay.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.epay.dao.FeeMapper;
import com.epay.model.Fee;
import com.epay.model.Page;
import com.epay.service.FeeService;

@Service
public class FeeServiceImpl implements FeeService {
	
	private static final Logger logger = Logger.getLogger(FeeServiceImpl.class);
	
	@Autowired
	private FeeMapper feeMapper;

	public Page<Fee> find(int page, int pageSize) {
		int totalCount = feeMapper.count();
		Page<Fee> instance = new Page<Fee>(page, pageSize, totalCount);
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("beginIndex", instance.getBeginIndex());
		params.put("pageSize", instance.getPageSize());
		List<Fee> feeList = feeMapper.find(params);
		instance.setContent(feeList);
		return instance;
	}

	public Fee get(String areaCode, String type) {
		Fee fee = new Fee();
		fee.setAreaCode(areaCode);
		fee.setType(type);
		return feeMapper.get(fee);
	}

	public boolean save(Fee fee) {
		Fee instance = feeMapper.get(fee);
		if (instance == null) {
			int i = feeMapper.save(fee);
			if (i == 1) {
				logger.info("保存" + fee.toString() + "成功");
				return true;
			} else if (i == 0) {
				logger.info("保存" + fee.toString() + "失败");
			}
		}
		return false;
	}

	public boolean delete(Fee fee) {
		int i = feeMapper.delete(fee);
		if (i == 1) {
			logger.info("删除" + fee.toString() + "成功");
			return true;
		}
		logger.info("删除" + fee.toString() + "失败！");
		return false;
	}

	public boolean update(Fee fee) {
		int i = feeMapper.update(fee);
		if (i == 1) {
			logger.info("更新" + fee.toString() + "成功");
			return true;
		}
		logger.info("更新" + fee.toString() + "失败！");
		return false;
	}

}
