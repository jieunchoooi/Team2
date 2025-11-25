package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ScrapVO;
import com.itwillbs.mapper.ScrapMapper;

@Service
public class ScrapService {

    @Autowired
    private ScrapMapper scrapMapper;

    // 1) 스크랩 추가
    public boolean addScrap(int setLecture_num, String user_id) {
        ScrapVO vo = new ScrapVO();
        vo.setUser_id(user_id);
        vo.setLecture_num(setLecture_num);
        return scrapMapper.addScrap(vo) > 0;
    }

    // 2) 스크랩 목록 조회
    public List<ScrapVO> getScrapList(int user_num) {
        return scrapMapper.getScrapList(user_num);
    }

    // 3) 스크랩 삭제
    public boolean deleteScrap(String user_id, int lecture_num) {
        ScrapVO vo = new ScrapVO();
        vo.setUser_id(user_id);
        vo.setLecture_num(lecture_num);
        return scrapMapper.deleteScrap(vo) > 0;
    }

    // 4) 유저가 해당 강의를 스크랩했는지 여부 체크
    public boolean isScraped(String user_id, int lecture_num) {
        ScrapVO vo = new ScrapVO();
        vo.setUser_id(user_id);
        vo.setLecture_num(lecture_num);
        return scrapMapper.existsScrap(vo) > 0;
    }

    // 5) 스크랩 토글 기능 (강의 상세 페이지에서 사용)
    public boolean toggleScrap(String user_id, int lecture_num) {
        boolean exists = isScraped(user_id, lecture_num);
        ScrapVO vo = new ScrapVO();
        vo.setUser_id(user_id);
        vo.setLecture_num(lecture_num);

        if (exists) {
            return scrapMapper.deleteScrap(vo) > 0;
        } else {
            return scrapMapper.addScrap(vo) > 0;
        }
    }
}
