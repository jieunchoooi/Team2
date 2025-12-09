package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.service.GptService;

@Controller
@RequestMapping("/gpt/*")
public class GptController {
	
	@Inject
	private GptService gptService;
	
//	@PostMapping("/interest")
//	@ResponseBody
//	public boolean interest(@RequestParam("prompt") String prompt,
//	                        @RequestParam("user_id") String user_id) {
//	    try {
//	        gptService.insetInterest(prompt, user_id);
//	        return true; // 성공
//	    } catch (Exception e) {
//	        return false; // 실패
//	    }
//	}

	@PostMapping("/interest")
	@ResponseBody
	public boolean interest(@RequestParam("user_id") String user_id,
	                        @RequestParam("tags") List<String> tags) {
	    try {
	        for(String prompt : tags) {
	            gptService.insetInterest(prompt, user_id); // 각 관심사 DB 저장
	        }
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}
