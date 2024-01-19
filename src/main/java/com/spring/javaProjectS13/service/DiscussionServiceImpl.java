package com.spring.javaProjectS13.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS13.dao.DiscussionDAO;
import com.spring.javaProjectS13.vo.DiscussionVO;

@Service
public class DiscussionServiceImpl implements DiscussionService {
	@Autowired
	DiscussionDAO discussionDAO;

	@Override
	public List<DiscussionVO> discussionList() {
		return discussionDAO.discussionList();
	}
}
