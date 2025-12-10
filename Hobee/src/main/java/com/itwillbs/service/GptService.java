package com.itwillbs.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.GptMapper;

@Service
public class GptService {
	
	@Inject
	private GptMapper gptMapper;

	public Object insetInterest(Map<String, Object> params) {
		System.out.println("GptService insetInterest(prompt,user_id)");
		return gptMapper.insetInterest(params);
	}

}
