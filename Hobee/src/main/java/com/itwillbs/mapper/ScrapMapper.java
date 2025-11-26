package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.ScrapVO;

public interface ScrapMapper {

	int addScrap(ScrapVO vo);

    List<ScrapVO> getScrapList(int user_num);

    int deleteScrap(ScrapVO vo);

    int existsScrap(ScrapVO vo);
    
    void deleteScrapAfterPayment(@Param("userNum") int userNum,
            @Param("lectureNums") List<Integer> lectureNums);

	int isScrapped(@Param("lecture_num") int lecture_num, 
			           @Param("user_num")int user_num);
}
