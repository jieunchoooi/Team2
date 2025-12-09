package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LoginHistoryMapper {

    // 🔹 로그인 기록 저장
    void insertLoginHistory(
            @Param("user_id") String userId,
            @Param("device_info") String deviceInfo,
            @Param("location") String location
    );

    // 🔹 가장 최근 로그인 기기 (중복 저장 방지용)
    String getLastDevice(@Param("user_id") String userId);

    // 🔹 최근 로그인 기기 5개 목록
    List<String> getRecentDevices(@Param("user_id") String userId);

    // 🔹 바로 이전 접속 지역
    String getLastLocation(@Param("user_id") String userId);
}
