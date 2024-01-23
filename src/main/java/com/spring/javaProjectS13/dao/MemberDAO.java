package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.MemberVO;
import com.spring.javaProjectS13.vo.PageVO;

public interface MemberDAO {

	public MemberVO memberMidCheck(@Param("mid") String mid);

	public MemberVO memberNickCheck(@Param("nickName") String nickName);

	public int memberJoin(@Param("vo") MemberVO vo);

	public int nickNameUpdate(@Param("nickName") String nickName, @Param("mid") String mid);

	public int memnberNameUpdate(@Param("name") String name, @Param("mid") String mid);

	public int emailUpdate(@Param("email") String email, @Param("mid") String mid);

	public void memberVisitPointExpUpdate(@Param("idx") int idx, @Param("flag") String flag);

	public void memberLastDateUpdate(@Param("idx") int idx);

	public MemberVO memberEmailCheck(@Param("email") String email);

	public int memberPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public int memberDelete(@Param("mid") String mid, @Param("why") String why);

	public int profileChange(@Param("mid") String mid, @Param("profile") String profile);

	public void memberLoginOk(@Param("idx") int idx);

	public void memberLogoutOk(@Param("memberIdx") int memberIdx);

	public void deleteAllLogin();

	public List<MemberVO> friendList(@Param("idx") int idx);

	public List<MemberVO> memberList(@Param("vo") PageVO vo);

	public int memberUpdate(@Param("vo") MemberVO vo);

	public MemberVO memberIdxSearch(int idx);

	public int memberTotRecCnt(@Param("vo") PageVO vo);

	public int selectedMemberDelete(String idxArray);

	public int inputKeyword(@Param("idx") int idx, @Param("keyword") String keyword);

	public List<MemberVO> memberListIdx(String idxArray);

}
