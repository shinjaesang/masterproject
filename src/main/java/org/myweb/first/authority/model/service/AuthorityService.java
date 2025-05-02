package org.myweb.first.authority.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.authority.model.dto.Role;
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
    
    // 전체 사용자 수 조회
    int getTotalUsers(Map<String, String> params);
    
    // 페이지별 사용자 목록 조회
    List<Member> getUsersByPage(int page, int pageSize, Map<String, String> params);
    
    // 모든 권한 목록 조회
    List<Role> selectAllRoles();
    
    // 사용자 역할 추가
    int insertUserRole(Map<String, String> params);
} 