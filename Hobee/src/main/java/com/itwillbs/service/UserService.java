package com.itwillbs.service;

import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.LoginHistoryMapper;
import com.itwillbs.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class UserService {

    @Inject
    private UserMapper userMapper;

    @Inject
    private LoginHistoryMapper loginHistoryMapper;


    // ==========================================================
    // 🚀 로그인 기록 저장 (중복 기기 제외)
    // ==========================================================
    public void insertLoginHistory(String user_id, String device_info, String location) {

        if (user_id == null || device_info == null) {
            System.out.println("⚠ insertLoginHistory() 파라미터 null → 저장 생략");
            return;
        }

        // DB에서 마지막 로그인 기기 가져오기
        String lastDevice = loginHistoryMapper.getLastDevice(user_id);

        if (lastDevice != null && lastDevice.equals(device_info)) {
            System.out.println("⚠ 동일 기기 감지 → 로그인 기록 저장 생략");
            return;
        }

        // 새 기기 → 저장
        loginHistoryMapper.insertLoginHistory(user_id, device_info, location);
        System.out.println("✅ 새 로그인 기록 저장됨 → " + device_info + " @ " + location);
    }


    // ==========================================================
    // 🔹 기본 User CRUD + 로그인 로직
    // ==========================================================

    public void insertUser(UserVO userVO) {
        userMapper.insertUser(userVO);
    }

    public UserVO loginUser(UserVO userVO) {
        return userMapper.loginUser(userVO);
    }

    public UserVO selectUserById(String user_id) {
        return userMapper.selectUserById(user_id);
    }

    public UserVO findUserByEmail(String user_email) {
        return userMapper.findUserByEmail(user_email);
    }

    public void updateTempPassword(String user_id, String tempPw) {
        userMapper.updateTempPassword(user_id, tempPw);
    }

    public int checkEmail(String user_email) {
        return userMapper.checkEmail(user_email);
    }

    public UserVO findUserByIdAndEmail(String user_id, String user_email) {
        return userMapper.findUserByIdAndEmail(user_id, user_email);
    }

    public UserVO findIdByNameAndEmail(String user_name, String user_email) {
        return userMapper.findIdByNameAndEmail(user_name, user_email);
    }

    public void increaseFailCount(String user_id) {
        userMapper.increaseFailCount(user_id);
    }

    public void resetFailCount(String user_id) {
        userMapper.resetFailCount(user_id);
    }

    public void lockUser(String user_id) {
        userMapper.lockUser(user_id);
    }

    public void updateLastLoginTime(String user_id) {
        userMapper.updateLastLoginTime(user_id);
    }

    public void updatePasswordUpdatedAt(String user_id) {
        userMapper.updatePasswordUpdatedAt(user_id);
    }


    // ==========================================================
    // 🟦 로그인 로그 조회
    // ==========================================================

    // 최근 5개 기기 목록
    public List<String> getRecentLoginDevices(String user_id) {
        return loginHistoryMapper.getRecentLoginDevices(user_id);
    }
    
    public void insertLoginHistoryIfNotDuplicate(String user_id, String device_info, String location) {
        loginHistoryMapper.insertLoginHistoryIfNotDuplicate(user_id, device_info, location);
    }

    // 가장 최근 접속 지역
    public String getLastLocation(String user_id) {
        return loginHistoryMapper.getLastLocation(user_id);
    }
}
