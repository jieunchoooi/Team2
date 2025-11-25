package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.UserVO;
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
   public String main(Model model) {
      System.out.println("MainController main()");
      
      List<LectureVO> bestList = lectureService.getTop10();
      List<LectureVO> lectureList = lectureService.getAllLectures();

      model.addAttribute("bestList", bestList);
      model.addAttribute("lectureList", lectureList);
      
      return "main/main";
   }
   
   @RequestMapping(value="/search")
   public String search(@RequestParam("search") String search, Model model) {
      System.out.println("MainController search()");     
    
      List<LectureVO> lectureList = lectureService.getAllLectures(search);
    
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
    	  scrapService.addScrap(lecture_num, user_num);
          res.put("success", true);
      } catch (Exception e) {
          res.put("success", false);
      }
      
      return res;
   }
   

}

