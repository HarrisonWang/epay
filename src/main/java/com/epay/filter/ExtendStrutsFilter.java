package com.epay.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

public class ExtendStrutsFilter extends StrutsPrepareAndExecuteFilter {
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		Object obj = session.getAttribute("LOGIN_USER");
		// 用户未登录，自动跳转到登录页处理
		if (obj == null && request.getRequestURI().lastIndexOf(".jsp") != -1 && request.getRequestURI().lastIndexOf("/signin.jsp") == -1) {
			response.sendRedirect(basePath + "user/signin.jsp");
			return;
		}
		super.doFilter(req, res, chain);
	}

}
