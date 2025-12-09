package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.GptMapper;

@Service
public class GptService {
	
	@Inject
	private GptMapper gptMapper;

	public String getInterestByGpt(String prompt) {
		System.out.println("GptService getInterestByGpt(prompt)");
		return gptMapper.getInterestByGpt(prompt);
	}

}
