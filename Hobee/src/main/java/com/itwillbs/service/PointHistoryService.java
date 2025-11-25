package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.PointHistoryVO;
import com.itwillbs.mapper.PointHistoryMapper;

@Service
public class PointHistoryService {

	 @Autowired
	    private PointHistoryMapper pointHistoryMapper;

	 /** 특정 회원의 전체 포인트 내역 조회 */
	    public List<PointHistoryVO> getHistoryByUser(int userNum) {
	        return pointHistoryMapper.getPointHistoryByUser(userNum);
	    }

}
	