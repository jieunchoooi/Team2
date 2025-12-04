package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.ScrapVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.LectureService;
import com.itwillbs.service.ScrapService;

@Controller
@RequestMapping("/main/*")
public class MainController {
   
   @Inject
   private LectureService lectureService;
   @Inject
   private ScrapService scrapService;
   
   @RequestMapping(value="/main")
   public String main(Model model, HttpSession session) {
      System.out.println("MainController main()");
      
      List<LectureVO> bestList = lectureService.getTop10();
      List<LectureVO> lectureList = lectureService.getAllLectures();
      
      UserVO userVO = (UserVO) session.getAttribute("userVO");
      if(userVO != null) {
          List<Integer> scrapLectureNums = scrapService.getScrapList(userVO.getUser_num())
                                                     .stream()
                                                     .map(ScrapVO::getLecture_num)
                                                     .collect(Collectors.toList());
          
          // 강의 목록에 bookmark 정보 세팅
          for(LectureVO lecture : bestList) {
              lecture.setBookmark(scrapLectureNums.contains(lecture.getLecture_num()));
          }
          for(LectureVO lecture : lectureList) {
              lecture.setBookmark(scrapLectureNums.contains(lecture.getLecture_num()));
          }
      }

      model.addAttribute("bestList", bestList);
      model.addAttribute("lectureList", lectureList);
      
      return "main/main";
   }
   
   @RequestMapping(value="/search")
   public String search(@RequestParam("search") String search, Model model, HttpSession session) {
      System.out.println("MainController search()");     
    
      List<LectureVO> lectureList = lectureService.getAllLectures(search);
      
      UserVO userVO = (UserVO) session.getAttribute("userVO");
      if(userVO != null) {
          List<Integer> scrapLectureNums = scrapService.getScrapList(userVO.getUser_num())
                                                     .stream()
                                                     .map(ScrapVO::getLecture_num)
                                                     .collect(Collectors.toList());
          
          // 강의 목록에 bookmark 정보 세팅
          for(LectureVO lecture : lectureList) {
              lecture.setBookmark(scrapLectureNums.contains(lecture.getLecture_num()));
          }
      }
    
      model.addAttribute("lectureList", lectureList);
      
      return "main/search";
   }
   
   @RequestMapping(value="/bookmark", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> bookmark(@RequestParam("lecture_num") int lecture_num, Model model, HttpSession session ) {
      System.out.println("MainController bookmark()");
      
      UserVO userVO = (UserVO) session.getAttribute("userVO");
      int user_num = userVO.getUser_num();  
    
      Map<String, Object> res = new HashMap<>();
      
      try {
    	  //현재 북마크가 있는지 확인
    	  int count = scrapService.isScrapped(lecture_num, user_num);
    	  boolean hasBookmark = count > 0;
    	  
    	  if(hasBookmark) {
    		  //이미 있으면 삭제
    		  scrapService.deleteScrap(user_num, lecture_num);
    		  res.put("bookmarked", false); //현재 상태 반환
    	  } else {
    		  //없으면 추가
        	  scrapService.addScrap(lecture_num, user_num);
        	  res.put("bookmarked", true);
    	  }
          res.put("success", true);
      } catch (Exception e) {
          res.put("success", false);
      }
      
      return res;
   }
   
   
}

