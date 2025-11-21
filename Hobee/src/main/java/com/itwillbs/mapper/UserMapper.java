package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.UserVO;

@Mapper
public interface UserMapper {

    // ✅ 회원가입
    void insertUser(UserVO userVO);

    // ✅ 로그인
    UserVO loginUser(UserVO userVO);

    // ✅ 아이디로 회원 조회 (로그인, 중복확인 공용)
    UserVO selectUserById(@Param("user_id") String user_id);

    // ✅ 이메일로 사용자 찾기
    UserVO findUserByEmail(@Param("user_email") String user_email);

    // ✅ 임시 비밀번호 업데이트
    void updateTempPassword(@Param("user_id") String user_id,
                            @Param("tempPw") String tempPw);

    // ✅ 이메일 중복 체크
    int checkEmail(@Param("user_email") String user_email);

    // ✅ 아이디 + 이메일 → 회원 찾기
    UserVO findUserByIdAndEmail(@Param("user_id") String user_id,
                                @Param("user_email") String user_email);

    // ✅ 이름 + 이메일 → 아이디 찾기
    UserVO findIdByNameAndEmail(@Param("user_name") String user_name,
                                @Param("user_email") String user_email);

    // 회원 등급 업데이트
    int updateUserGrade(UserVO userVO);
    
    // 특정 회원 정보 조회 (로그인/세션 재로딩용) */
    UserVO getUserByNum(int user_num);

    // 회원 포인트 조회 */
    int getUserPoints(int userNum);

    // 회원 포인트 업데이트 */
    int updateUserPoints(UserVO userVO);

    
}
