package com.spring.javaProjectS13.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS13.dao.DiscussionDAO;

@Service
public class DiscussionServiceImpl implements DiscussionService {
	@Autowired
	DiscussionDAO discussionDAO;
}
