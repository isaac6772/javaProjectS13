package com.spring.javaProjectS13.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	// 400에러가 났을때 이동할 메세지 폼 보기
	@RequestMapping(value = "/error400", method = RequestMethod.GET)
	public String error400Get() {
		return "errorPage/error400";
	}
	
	// 404에러가 났을때 이동할 메세지 폼 보기
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	
	// 405에러가 났을때 이동할 메세지 폼 보기
	@RequestMapping(value = "/error405", method = RequestMethod.GET)
	public String error405Get() {
		return "errorPage/error405";
	}
	
	// 500에러가 났을때 이동할 메세지 폼 보기
	@RequestMapping(value = "/error500", method = RequestMethod.GET)
	public String error500Get() {
		return "errorPage/error500";
	}
	
	// NumberFormat에러가 났을때 이동할 메세지 폼...
	@RequestMapping(value = "/errorNumberFormat", method = RequestMethod.GET)
	public String errorNumberFormatGet() {
		return "errorPage/errorNumberFormat";
	}
	
	// NullPointer에러가 났을때 이동할 메세지 폼...
	@RequestMapping(value = "/errorNullPointer", method = RequestMethod.GET)
	public String errorNullPointerGet() {
		return "errorPage/errorNullPointer";
	}
	
	
}
