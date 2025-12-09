package com.itwillbs.controller;

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
	
	@PostMapping("/interest")
	@ResponseBody
	public boolean interest(@RequestParam("prompt") String prompt,
	                        @RequestParam("user_id") String user_id) {
	    try {
//	        gptService.insetInterest(prompt, user_id);
	        return true; // 성공
	    } catch (Exception e) {
	        return false; // 실패
	    }
	}

	
}
