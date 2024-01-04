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

	void memberVisitUpdate(@Param("idx") int idx);

	void memberLastDateUpdate(@Param("idx") int idx);

	MemberVO memberEmailCheck(@Param("email") String email);

	int memberPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	int memberDelete(@Param("mid") String mid, @Param("why") String why);

	int profileChange(@Param("mid") String mid, @Param("profile") String profile);
}
