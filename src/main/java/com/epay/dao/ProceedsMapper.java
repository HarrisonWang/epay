package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Proceeds;

public interface ProceedsMapper {

	public int save(Proceeds instance);
	
	public int count(Map<String, Object> params);
	
	public List<Proceeds> find(Map<String, Object> params);

	public double sumMoney(Map<String, Object> params);
	
	public List<Proceeds> search(Map<String, Object> params);

}
