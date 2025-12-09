package com.itwillbs.service;

import com.itwillbs.domain.LoginLogVO;
import com.itwillbs.mapper.LoginLogMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class LoginLogService {

    @Inject
    private LoginLogMapper mapper;

    public void insertLog(String userId, String ip, String device, String location) {
        LoginLogVO vo = new LoginLogVO();
        vo.setUser_id(userId);
        vo.setIp(ip);
        vo.setDevice(device);
        vo.setLocation(location);
        mapper.insertLoginLog(vo);
    }

    public List<LoginLogVO> getRecentLogs(String userId) {
        return mapper.getRecentLogs(userId);
    }
}
