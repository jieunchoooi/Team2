package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.service.GptService;

@Controller
@RequestMapping("/gpt/*")
public class GptController {
	
	@Inject
	private GptService gptService;
	
	@PostMapping("/interest")
	public String interest(@RequestParam("prompt") String prompt, Model model ) {
		
//		System.out.println("GptController interest()");
//		System.out.println("prompt : " + prompt);
//		
//		String result = gptService.getInterestByGpt(prompt);
//		System.out.println("결과 : " + result);
//		
//		model.addAttribute("prompt", prompt);
//		model.addAttribute("result", result);
		
		return "gpt/chatgpt";
	}
	
	

}
