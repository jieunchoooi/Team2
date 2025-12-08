package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LoginHistoryMapper {

    /* ==========================================================
       1) 로그인 기록 저장 (중복 검사 없음)
    ========================================================== */
    void insertLoginHistory(
            @Param("user_id") String user_id,
            @Param("device_info") String device_info,
            @Param("location") String location
    );


    /* ==========================================================
       2) 로그인 기록 저장 (중복 기기 방지)
          - Mapper XML의 <insert id="insertLoginHistoryIfNotDuplicate"> 와 매핑
    ========================================================== */
    void insertLoginHistoryIfNotDuplicate(
            @Param("user_id") String user_id,
            @Param("device_info") String device_info,
            @Param("location") String location
    );


    /* ==========================================================
       3) 최근 로그인 기기 (1개)
    ========================================================== */
    String getLastDevice(@Param("user_id") String user_id);


    /* ==========================================================
       4) 최근 로그인 기기 목록 (중복 제거 / 최대 5개)
    ========================================================== */
    List<String> getRecentLoginDevices(@Param("user_id") String user_id);


    /* ==========================================================
       5) 최근 로그인 지역
    ========================================================== */
    String getLastLocation(@Param("user_id") String user_id);

}
