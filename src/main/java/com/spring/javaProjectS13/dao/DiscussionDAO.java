package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.DiscussionVO;

public interface DiscussionDAO {

	public List<DiscussionVO> discussionList();

	public int makeDiscussion(@Param("vo") DiscussionVO vo);

	public void updateDiscussionState();

	public DiscussionVO discussion(@Param("idx") int idx);

	public int reservationTimeCheck(@Param("idx") int idx);

	public void addParticipant(@Param("idx") int idx, @Param("memberIdx") int memberIdx);

	public int enterTimeCheck(@Param("idx") int idx);

}
