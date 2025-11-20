package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.ScrapVO;

public interface ScrapMapper {

    int addScrap(ScrapVO vo);

    List<ScrapVO> getScrapList(int user_num);

    int deleteScrap(ScrapVO vo);

    int existsScrap(ScrapVO vo);
}
