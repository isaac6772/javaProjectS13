package com.spring.javaProjectS13.logoutListener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.spring.javaProjectS13.dao.MemberDAO;

public class SessionListener implements HttpSessionListener{

	@Override
	public void sessionCreated(HttpSessionEvent se) {}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(se.getSession().getServletContext());
		HttpSession session = se.getSession();
		int memberIdx = session.getAttribute("sIdx") == null ? 0 : (int) session.getAttribute("sIdx");
		
		if(memberIdx!=0) {
			MemberDAO memberDAO = (MemberDAO) ctx.getBean("memberDAO");
			memberDAO.memberLogoutOk(memberIdx);
		}
	}
	
}
