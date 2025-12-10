package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public boolean interest(@RequestParam("user_id") String user_id,
	                        @RequestParam("tags") List<String> tags) {
		   try {
		        Map<String, Object> params = new HashMap<>();
		        params.put("user_id", user_id);
		        params.put("tags", tags);
		        gptService.insetInterest(params);
		        return true;
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false;
		    }
	}

}
