package com.spring.javaProjectS13.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.service.ServiceService;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

@Controller
@RequestMapping("/service")
public class ServiceController {
	@Autowired
	ServiceService serviceService;
	
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public String serviceListGet(Model model, PageVO pageVO) {
		List<ServiceVO> vos =  serviceService.serviceList(pageVO);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		
		return "service/serviceList"; 
	}
	
	@RequestMapping(value = "/serviceInput", method = RequestMethod.GET)
	public String serviceInputGet() {
		return "service/serviceInput"; 
	}
	
	@RequestMapping(value = "/serviceInput", method = RequestMethod.POST)
	public String serviceInputPost(List<MultipartFile> fileList, ServiceVO vo) {
		int res = serviceService.serviceInput(fileList, vo);
		
		if(res==1) return "redirect:/message/service/serviceInputOk";
		else return "redirect:/message/service/serviceInputNo";
	}
	
	@RequestMapping(value = "/serviceContent", method = RequestMethod.GET)
	public String serviceContentGet(int idx, Model model) {
		ServiceVO vo = serviceService.serviceContent(idx);
		if(vo.getFileName()!=null) {
			String[] images = vo.getFileName().split("/");
			model.addAttribute("images",images);
		}
		if(vo.getReply()!=0) {
			ServiceVO replyVO = serviceService.serviceContent(vo.getReply());
			model.addAttribute("replyVO",replyVO);
			
			if(replyVO.getFileName()!=null) {
				String[] replyImages = replyVO.getFileName().split("/");
				model.addAttribute("replyImages",replyImages);
			}
		}
		
		model.addAttribute("vo",vo);
		return "service/serviceContent";
	}
	
	@RequestMapping(value = "/serviceReply", method = RequestMethod.GET)
	public String serviceReplyGet() {
		return "service/serviceReply";
	}
	
	@RequestMapping(value = "/serviceReply", method = RequestMethod.POST)
	public String serviceReplyPost(List<MultipartFile> fileList, ServiceVO vo) {
		int res = serviceService.serviceReply(fileList, vo);
		
		if(res==1) return "redirect:/message/service/serviceReplyOk?idx=" + vo.getRefIdx();
		else return "redirect:/message/service/serviceReplyNo?idx=" + vo.getRefIdx();
	}
	
	@RequestMapping(value = "/deleteService", method = RequestMethod.GET)
	public String deleteServiceGet(int idx, HttpSession session) {
		int res = serviceService.deleteService(idx, session);
		
		if(res==1) return "redirect:/message/service/deleteServiceOk";
		else return "redirect:/message/service/deleteServiceNo";
	}
}
