package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.AdminMapper;

@Service
public class AdminService {

	@Inject
	private AdminMapper adminMapper;
	
	public List<UserVO> listMember(PageVO pageVO) {
		System.out.println("AdminService listMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		
		pageVO.setStartRow(startRow);
		
		return adminMapper.listMember(pageVO);
	}

	public int countMemberList() {
		System.out.println("AdminService countMemberList()");
		return adminMapper.countMemberList();
	}

	public void LectureUpdate(LectureVO lectureVO) {
		System.out.println("AdminService LectureUpdate()");
		adminMapper.LectureUpdate(lectureVO);
	}

	public List<LectureVO> listLecture(PageVO pageVO) {
		System.out.println("AdminService listLecture()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		
		pageVO.setStartRow(startRow);
		
		return adminMapper.listLecture(pageVO);
	}

	public int countlectureList() {
		System.out.println("AdminService countlectureList()");

		return adminMapper.countlectureList();
	}

	public void deleteClass(String lecture_num) {
		System.out.println("AdminService deleteClass()");
		
		adminMapper.deleteClass(lecture_num);
	}

}
