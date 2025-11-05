package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main/*")
public class MainController {
	
	@RequestMapping(value="/main")
	public String main() {
		System.out.println("MainController main()");
		return "main/main";
	}

}
