package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.EnrollmentVO;

@Mapper
public interface EnrollmentMapper {
    int insertEnrollment(EnrollmentVO enrollmentVO);
}
