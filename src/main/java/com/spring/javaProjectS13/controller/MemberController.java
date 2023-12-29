package com.spring.javaProjectS13.controller;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCodeSend", method = RequestMethod.POST)
	public String mailCodeSendPost(String email, HttpSession session) throws MessagingException {
		String mailCode = UUID.randomUUID().toString().substring(0,8);
		String title = "회원가입을 위한 인증코드입니다";
		
		if(mailSend(email, title, mailCode)) {
			session.setAttribute("mailCode", mailCode);
			return "1";
		}
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCodeCheck", method = RequestMethod.POST)
	public String mailCodeCheckPost(String mailCode, HttpSession session) {
		String code = session.getAttribute("mailCode")==null ? "" : (String)session.getAttribute("mailCode");
		String res = "0";
		
		if(code.equals("")) res = "0";
		else if(code.equals(mailCode)) res = "1";
		else res = "2";
		
		return res;
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
	public boolean mailSend(String email, String title, String content) throws MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		mailSender.send(message);
		return true;
	}
}
