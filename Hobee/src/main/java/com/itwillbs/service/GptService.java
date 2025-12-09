package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.GptMapper;

@Service
public class GptService {
	
	@Inject
	private GptMapper gptMapper;

	public String insetInterest(String prompt, String user_id) {
		System.out.println("GptService insetInterest(prompt,user_id)");
		return gptMapper.insetInterest(prompt, user_id);
	}

}
