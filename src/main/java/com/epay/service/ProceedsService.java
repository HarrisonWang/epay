package com.epay.service;

import com.epay.model.Page;
import com.epay.model.Proceeds;

public interface ProceedsService {

	public boolean add(Proceeds proceeds);
	
	public Page<Proceeds> find(int page, int pageSize);
	
	public Page<Proceeds> search(Proceeds proceeds, int page, int pageSize);
	
	public double sumMoney(Proceeds proceeds);
	
}
