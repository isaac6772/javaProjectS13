package com.spring.javaProjectS13.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS13.vo.DiscussionVO;

public interface DiscussionService {

	public List<DiscussionVO> discussionList(int memberIdx);

	public int makeDiscussion(MultipartFile file, DiscussionVO vo, HttpSession session);

	public int reservation(int idx, HttpSession session);

	public int enterDiscussion(int idx);

}
