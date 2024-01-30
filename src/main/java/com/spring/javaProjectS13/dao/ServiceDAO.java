package com.spring.javaProjectS13.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS13.vo.AdVO;
import com.spring.javaProjectS13.vo.PageVO;
import com.spring.javaProjectS13.vo.ServiceVO;

public interface ServiceDAO {

	public int serviceInput(@Param("vo") ServiceVO vo);

	public List<ServiceVO> serviceList(@Param("vo") PageVO vo);

	public int totRecCnt(@Param("vo") PageVO vo);

	public ServiceVO serviceContent(@Param("idx") int idx);

	public int serviceReply(@Param("vo") ServiceVO vo);

	public int deleteService(@Param("idx") int idx);

	public List<ServiceVO> availableAdList();

	public int adServiceDelete(String idx);

	public List<AdVO> adList();

	public void deleteAdAll();

	public int inputAd(@Param("file") String file, @Param("serviceIdx") int serviceIdx);

	public void serviceReplyAlarm(@Param("memberIdx") int memberIdx, @Param("memberIdxWho") int memberIdxWho, @Param("serviceIdx") int serviceIdx);

}
