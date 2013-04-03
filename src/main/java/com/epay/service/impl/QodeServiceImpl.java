package com.epay.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.*;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.epay.dao.QodeMapper;
import com.epay.model.Page;
import com.epay.model.Qode;
import com.epay.service.QodeService;

@Service
public class QodeServiceImpl implements QodeService {
	
	@Autowired
	private QodeMapper qodeMapper;

	public boolean save(String filePath, Qode instance) {
		List<Qode> list = null;
		Qode qode = null;
		try {
			File file = new File(filePath);
			List<String> strs = FileUtils.readLines(file);
			list = new ArrayList<Qode>(strs.size());
            String currentDate = DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd HH:mm:ss");
			for (String str : strs) {
				qode = new Qode();
				qode.setCode(str);
				qode.setType(instance.getType());
				qode.setValid(instance.getValid());
				qode.setAreaCode(instance.getAreaCode());
                qode.setInsertDate(currentDate);
				list.add(qode);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int result = qodeMapper.batchSave(list);
		if (result > 0) {
			return true;
		}
		return false;
	}

	public Page<Qode> find(Qode qode, int currentPage, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (qode != null) {
			params.put("type", qode.getType());
			params.put("valid", qode.getValid());
			params.put("areaCode", qode.getAreaCode());
		}
		int totalCount = qodeMapper.count(params);
		Page<Qode> page = new Page<Qode>(currentPage, pageSize, totalCount);
		params.put("beginIndex", page.getBeginIndex());
		params.put("pageSize", page.getPageSize());
		List<Qode> qodes = qodeMapper.find(params);
		page.setContent(qodes);
		return page;
	}
	
	public double sumMoney(Qode qode) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (qode != null && StringUtils.isNotEmpty(qode.getType())) {
			map.put("type", qode.getType());
		}
		if (qode != null && StringUtils.isNotEmpty(qode.getAreaCode())) {
			map.put("areaCode", qode.getAreaCode());
		}
		if (qode != null && StringUtils.isNotEmpty(qode.getValid())) {
			map.put("valid", qode.getValid());
		}
		double totalMoney = qodeMapper.sumMoney(map);
		return totalMoney;
	}

}
