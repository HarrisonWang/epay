package com.epay.service.impl;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.epay.service.AccountService;

public class AccountServiceImplTest {

	@Test
	public void testGetAll() {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		AccountService service = ctx.getBean("accountServiceImpl", AccountService.class);
		service.getAll();

	}

}
