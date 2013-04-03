package com.epay.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.epay.dao.ProceedsMapper;
import com.epay.model.Page;
import com.epay.model.Proceeds;
import com.epay.service.ProceedsService;

@Service
public class ProceedsServiceImpl implements ProceedsService {

	private static final Log logger = LogFactory.getLog(ProceedsServiceImpl.class);
	
	@Autowired
	private ProceedsMapper proceedsMapper;
	
	public boolean add(Proceeds proceeds) {
		try {
			int i = proceedsMapper.save(proceeds);
			if (i == 1) {
				return true;
			}
		} catch (Exception e) {
			logger.error("保存打款信息失败！" + e);
		}
		return false;
	}

	public Page<Proceeds> find(int page, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		int totalCount = proceedsMapper.count(params);
		Page<Proceeds> result = new Page<Proceeds>(page, pageSize, totalCount);
		params.put("beginIndex", result.getBeginIndex());
		params.put("pageSize", result.getPageSize());
		List<Proceeds> list = proceedsMapper.find(params);
		result.setContent(list);
		return result;
	}

	public double sumMoney(Proceeds proceeds) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (proceeds != null) {
			map.put("beginDate", proceeds.getBeginDate());
			map.put("endDate", proceeds.getEndDate());
			map.put("bizType", proceeds.getBizType());
			map.put("accountName", proceeds.getAccountName());
		}
		double money = proceedsMapper.sumMoney(map);
		return money;
	}

	public Page<Proceeds> search(Proceeds proceeds, int page, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (proceeds != null) {
			map.put("beginDate", proceeds.getBeginDate());
			map.put("endDate", proceeds.getEndDate());
			map.put("bizType", proceeds.getBizType());
			map.put("accountName", proceeds.getAccountName());
		}
		int totalCount = proceedsMapper.count(map);
		Page<Proceeds> result = new Page<Proceeds>(page, pageSize, totalCount);
		map.put("beginIndex", result.getBeginIndex());
		map.put("pageSize", result.getPageSize());
		List<Proceeds> content = proceedsMapper.search(map);
		result.setContent(content);
		return result;
	}

}
