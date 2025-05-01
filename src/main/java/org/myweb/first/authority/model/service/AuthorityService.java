package org.myweb.first.authority.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.member.model.dto.Member;

public interface AuthorityService {
    // 전체 사용자 목록 조회
    List<Member> selectAllUsers();
    
    // 검색 조건에 따른 사용자 목록 조회
    List<Member> searchUsers(Map<String, String> params);
    
    // 사용자 상태 변경
    int updateUserStatus(String empId, String status);
    
    // 사용자 권한 변경
    int updateUserRole(String empId, String role);
    
    // 사용자 삭제
    int deleteUser(String empId);
} 