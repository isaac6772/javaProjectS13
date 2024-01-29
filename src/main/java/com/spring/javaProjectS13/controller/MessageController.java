package com.spring.javaProjectS13.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@RequestMapping(value = "/member/{msgFlag}", method = RequestMethod.GET)
	public String memberMessage(Model model, @PathVariable String msgFlag) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg","회원가입을 축하드립니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg","회원가입에 실패하였습니다.");
			model.addAttribute("url","member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg","");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg","아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("msg","로그아웃 되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("nickNameUpdateOk")) {
			model.addAttribute("msg","닉네임이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("nickNameUpdateNo")) {
			model.addAttribute("msg","닉네임 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("memnberNameUpdateOk")) {
			model.addAttribute("msg","이름이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("memnberNameUpdateNo")) {
			model.addAttribute("msg","이름 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberUpdate");
		}
		else if(msgFlag.equals("emailUpdateOk")) {
			model.addAttribute("msg","메일이 변경되었습니다.");
			model.addAttribute("url","member/memberUpdate");
		}
		else if(msgFlag.equals("emailUpdateNo")) {
			model.addAttribute("msg","메일 변경에 실패하였습니다.");
			model.addAttribute("url","member/memberUpdate");
		}
		else if(msgFlag.equals("memberPwdChangeOk")) {
			model.addAttribute("msg","비밀번호가 변경되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberPwdChangeNo")) {
			model.addAttribute("msg","비밀번호가 틀렸습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberPwdChange");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg","회원탈퇴가 성공적으로 처리되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg","회원탈퇴에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=memberDelete");
		}
		else if(msgFlag.equals("profileChangeOk")) {
			model.addAttribute("msg","프로필 사진이 변경되었습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=myPage1");
		}
		else if(msgFlag.equals("profileChangeNo")) {
			model.addAttribute("msg","프로필 사진 변경에 실패하였습니다.");
			model.addAttribute("url","member/myPageIframe?myPage=myPage1");
		}
		else if(msgFlag.equals("memberPwdResetOk")) {
			model.addAttribute("msg","비밀번호가 변경되었습니다.");
			model.addAttribute("url","home");
		}
		else if(msgFlag.equals("memberPwdResetNo")) {
			model.addAttribute("msg","비밀번호 변경에 실패하였습니다.");
			model.addAttribute("url","member/memberIdPwdFind");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/interceptor/{interceptorFlag}")
	public String loginNo(Model model, @PathVariable String interceptorFlag) {
		if(interceptorFlag.equals("loginNo")) {
			model.addAttribute("msg","로그인 후 이용바랍니다.");
			model.addAttribute("url","home");
		}
		else if(interceptorFlag.equals("adminNo")) {
			model.addAttribute("msg","관리자 계정만 접근가능합니다.");
			model.addAttribute("url","home");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/admin/{adminFlag}")
	public String adminMessage(Model model, @PathVariable String adminFlag, String msgFlag) {
		if(adminFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg","회원정보가 수정되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("memberUpdateNo")) {
			String msg = "";
			if(msgFlag.equals("2")) msg = "아이디가 형식에 맞지않습니다.";
			else if(msgFlag.equals("3")) msg = "중복된 아이디가 존재합니다.";
			else if(msgFlag.equals("4")) msg = "닉네임이 형식에 맞지 않습니다";
			else if(msgFlag.equals("5")) msg = "중복된 닉네임이 존재합니다.";
			else if(msgFlag.equals("6")) msg = "이름이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("7")) msg = "이메일이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("8")) msg = "중복된 이메일이 존재합니다.";
			else if(msgFlag.equals("9")) msg = "레벨이 형식에 맞지 않습니다.";
			else if(msgFlag.equals("10")) msg = "포인트가 형식에 맞지 않습니다.";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("selectedMemberDeleteOk")) {
			model.addAttribute("msg","선택한 회원이 삭제되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("selectedMemberDeleteNo")) {
			model.addAttribute("msg","회원을 삭제하는 동안 오류가 발생했습니다.");
			model.addAttribute("url","/admin/adminMain?src=memberManager");
		}
		else if(adminFlag.equals("adServiceDeleteOk")) {
			model.addAttribute("msg","선택한 광고를 삭제하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=adManager");
		}
		else if(adminFlag.equals("adServiceDeleteNo")) {
			model.addAttribute("msg","광고 삭제에 실패하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=adManager");
		}
		else if(adminFlag.equals("adInputOk")) {
			model.addAttribute("msg","저장되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=adManager");
		}
		else if(adminFlag.equals("adInputNo")) {
			model.addAttribute("msg","저장에 실패하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=adManager");
		}
		else if(adminFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg","선택하신 게시물이 삭제되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=boardManager");
		}
		else if(adminFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg","게시물 삭제에 실패하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=boardManager");
		}
		else if(adminFlag.equals("reportDeleteOk")) {
			model.addAttribute("msg","해당 신고글이 삭제되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=reportManager");
		}
		else if(adminFlag.equals("reportDeleteNo")) {
			model.addAttribute("msg","삭제에 실패하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=reportManager");
		}
		else if(adminFlag.equals("reportContentDeleteOk")) {
			model.addAttribute("msg","해당 글이 삭제되었습니다.");
			model.addAttribute("url","/admin/adminMain?src=reportManager");
		}
		else if(adminFlag.equals("reportContentDeleteNo")) {
			model.addAttribute("msg","삭제에 실패하였습니다.");
			model.addAttribute("url","/admin/adminMain?src=reportManager");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/service/{serviceFlag}")
	public String serviceMessage(Model model, @PathVariable String serviceFlag, 
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx) {
		if(serviceFlag.equals("serviceInputOk")) {
			model.addAttribute("msg","글이 등록되었습니다.");
			model.addAttribute("url","/service/serviceList");
		}
		else if(serviceFlag.equals("serviceInputNo")) {
			model.addAttribute("msg","글 등록에 실패하였습니다");
			model.addAttribute("url","/service/serviceInput");
		}
		else if(serviceFlag.equals("serviceReplyOk")) {
			model.addAttribute("msg","답변이 등록되었습니다.");
			model.addAttribute("url","/service/serviceContent?idx=" + idx);
		}
		else if(serviceFlag.equals("serviceReplyNo")) {
			model.addAttribute("msg","답변 등록에 실패하였습니다");
			model.addAttribute("url","/service/serviceContent?idx=" + idx);
		}
		else if(serviceFlag.equals("deleteServiceOk")) {
			model.addAttribute("msg","게시물이 삭제되었습니다.");
			model.addAttribute("url","/service/serviceList");
		}
		else if(serviceFlag.equals("deleteServiceNo")) {
			model.addAttribute("msg","게시물 삭제에 실패하였습니다");
			model.addAttribute("url","/service/serviceList");
		}
		else if(serviceFlag.equals("accessDeny")) {
			model.addAttribute("msg","비공개 게시물은 보실 수 없습니다.");
			model.addAttribute("url","/service/serviceList");
		}
		
		return "include/message";
	}
	
	@RequestMapping("/board/{boardFlag}")
	public String boardMessage(Model model, @PathVariable String boardFlag,
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx) {
		if(boardFlag.equals("boardInputOk")) {
			model.addAttribute("msg","글이 등록되었습니다.");
			model.addAttribute("url","board/boardList");
		}
		else if(boardFlag.equals("boardInputNo")) {
			model.addAttribute("msg","글 등록에 실패하였습니다.");
			model.addAttribute("url","board/boardInput");
		}
		else if(boardFlag.equals("boardContentNo")) {
			model.addAttribute("msg","존재하지 않는 게시물입니다.");
			model.addAttribute("url","board/boardList");
		}
		else if(boardFlag.equals("inputReplyOk")) {
			model.addAttribute("msg","댓글이 등록되었습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("inputReplyNo")) {
			model.addAttribute("msg","댓글 등록에 실패하였습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg","게시물이 수정되었습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg","게시물이 수정에 실패하였습니다.");
			model.addAttribute("url","board/boardUpdate?idx=" + idx);
		}
		else if(boardFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg","게시물이 삭제되었습니다.");
			model.addAttribute("url","board/boardList");
		}
		else if(boardFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg","게시물이 삭제에 실패하였습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("deleteReplyOk")) {
			model.addAttribute("msg","댓글이 삭제되었습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("deleteReplyNo")) {
			model.addAttribute("msg","댓글 삭제에 실패하였습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("updateReplyOk")) {
			model.addAttribute("msg","댓글이 수정되었습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("updateReplyNo")) {
			model.addAttribute("msg","댓글 수정에 실패하였습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("reportOk")) {
			model.addAttribute("msg","신고가 접수되었습니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		else if(boardFlag.equals("reportNo")) {
			model.addAttribute("msg","이미 신고접수된 글입니다.");
			model.addAttribute("url","board/boardContent?idx=" + idx);
		}
		
		return "include/message";
	}
	
	@RequestMapping("/discussion/{flag}")
	public String discussionMessage(Model model, @PathVariable String flag) {
		if(flag.equals("makeDiscussionOk")) {
			model.addAttribute("msg","등록되었습니다.");
			model.addAttribute("url","discussion/discussionList");
		}
		else if(flag.equals("makeDiscussionNo")) {
			model.addAttribute("msg","토론 등록에 실패하였습니다.");
			model.addAttribute("url","discussion/discussionList");
		}
		else if(flag.equals("enterDiscussionNo")) {
			model.addAttribute("msg","이미 종료된 토론입니다.");
			model.addAttribute("url","discussion/discussionList");
		}
		
		return "include/message";
	}
}
