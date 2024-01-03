package com.spring.javaProjectS13.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.MemberVO;

public interface MemberDAO {

	MemberVO memberMidCheck(@Param("mid") String mid);

	MemberVO memberNickCheck(@Param("nickName") String nickName);

	int memberJoin(@Param("vo") MemberVO vo);

	int nickNameUpdate(@Param("nickName") String nickName, @Param("mid") String mid);

	int memnberNameUpdate(@Param("name") String name, @Param("mid") String mid);

	int emailUpdate(@Param("email") String email, @Param("mid") String mid);
}
