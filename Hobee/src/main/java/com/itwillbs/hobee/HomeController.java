package com.itwillbs.hobee;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.service.LectureService;
import com.itwillbs.service.ScrapService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
   
   @Inject
   private LectureService lectureService;
   
   private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
   
   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home(Locale locale, Model model) {
      logger.info("Welcome home! The client locale is {}.", locale);
      System.out.println("MainController main()");
      
      List<LectureVO> bestList = lectureService.getTop10();
      List<LectureVO> lectureList = lectureService.getAllLectures();
      
      model.addAttribute("bestList", bestList);
      model.addAttribute("lectureList", lectureList);
      
      return "main/main";
   }
   
}
