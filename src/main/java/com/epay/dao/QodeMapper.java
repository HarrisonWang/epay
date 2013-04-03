package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Qode;

public interface QodeMapper {

	public int batchSave(List<Qode> list); 
	
	public int count(Map<String, Object> params);
	
	public List<Qode> find(Map<String, Object> params);
	
	public double sumMoney(Map<String, Object> params);
	
}
