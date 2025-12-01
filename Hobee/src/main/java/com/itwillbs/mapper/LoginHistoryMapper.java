package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LoginHistoryMapper {

    void insertLoginHistory(@Param("user_id") String user_id,
                            @Param("device_info") String device_info,
                            @Param("location") String location);

    List<String> getRecentLoginDevices(@Param("user_id") String user_id);

    String getLastLocation(@Param("user_id") String user_id);
}
