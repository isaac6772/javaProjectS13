package com.spring.javaProjectS13.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaProjectS13.dao.MemberDAO;
import com.spring.javaProjectS13.vo.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		MemberVO vo = memberDAO.memberMidCheck(mid);
		int level = 0;
		if(vo!=null) level = vo.getLevel();
		if(level!=77) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/interceptor/adminNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
