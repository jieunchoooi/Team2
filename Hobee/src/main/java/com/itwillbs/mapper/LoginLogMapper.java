package com.itwillbs.mapper;

import com.itwillbs.domain.LoginLogVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LoginLogMapper {

    void insertLoginLog(LoginLogVO vo);

    List<LoginLogVO> getRecentLogs(@Param("user_id") String userId);
}
