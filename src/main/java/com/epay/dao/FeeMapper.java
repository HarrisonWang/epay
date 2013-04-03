package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Fee;

public interface FeeMapper {

	public int save(Fee fee);
	
	public int count();
	
	public List<Fee> find(Map<String, Integer> params);
	
	public Fee get(Fee fee);
	
	public int update(Fee fee);
	
	public int delete(Fee fee);
	
}
