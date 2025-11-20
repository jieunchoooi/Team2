package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.GradeVO;
import com.itwillbs.mapper.GradeMapper;

@Service
public class GradeService {

    @Autowired
    private GradeMapper gradeMapper;

    /** 회원 번호로 등급 조회 */
    public GradeVO getGradeByUser(int user_num) {
        return gradeMapper.getGradeByUser(user_num);
    }

    /** 등급 ID로 조회 */
    public GradeVO getGradeById(int grade_id) {
        return gradeMapper.getGradeById(grade_id);
    }
}
