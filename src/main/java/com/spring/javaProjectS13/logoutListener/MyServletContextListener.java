package com.spring.javaProjectS13.logoutListener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.spring.javaProjectS13.dao.MemberDAO;

public class MyServletContextListener implements ServletContextListener{
	
	// 서버 구동시 모든 로그인정보 삭제
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
		MemberDAO memberDAO = (MemberDAO) ctx.getBean("memberDAO");
		memberDAO.deleteAllLogin();
	}
	
	// 서버가 끊길때 모든 로그인정보 삭제
	@Override
	public void contextDestroyed(ServletContextEvent sce) {}
}
