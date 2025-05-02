package org.myweb.first.authority.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.authority.model.dto.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("authorityDao")
public class AuthorityDao {
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    // 전체 사용자 목록 조회
    public List<Member> selectAllUsers() {
        return sqlSession.selectList("org.myweb.first.authority.model.dao.AuthorityDao.selectAllUsers");
    }
    
    // 검색 조건에 따른 사용자 목록 조회
    public List<Member> searchUsers(Map<String, String> params) {
        return sqlSession.selectList("org.myweb.first.authority.model.dao.AuthorityDao.searchUsers", params);
    }
    
    // 사용자 상태 변경
    public int updateUserStatus(Map<String, String> params) {
        return sqlSession.update("org.myweb.first.authority.model.dao.AuthorityDao.updateUserStatus", params);
    }
    
    // 사용자 권한 변경
    public int updateUserRole(Map<String, String> params) {
        return sqlSession.update("org.myweb.first.authority.model.dao.AuthorityDao.updateUserRole", params);
    }
    
    // 사용자 삭제
    public int deleteUser(String empId) {
        return sqlSession.delete("org.myweb.first.authority.model.dao.AuthorityDao.deleteUser", empId);
    }
    
    // 전체 사용자 수 조회
    public int getTotalUsers(Map<String, String> params) {
        return sqlSession.selectOne("org.myweb.first.authority.model.dao.AuthorityDao.getTotalUsers", params);
    }
    
    // 페이지별 사용자 목록 조회
    public List<Member> getUsersByPage(Map<String, String> params) {
        return sqlSession.selectList("org.myweb.first.authority.model.dao.AuthorityDao.getUsersByPage", params);
    }
    
    // 역할 목록 조회
    public List<Role> selectAllRoles() {
        return sqlSession.selectList("org.myweb.first.authority.model.dao.AuthorityDao.selectAllRoles");
    }
    
    // 사용자 역할 추가
    public int insertUserRole(Map<String, String> params) {
        return sqlSession.insert("org.myweb.first.authority.model.dao.AuthorityDao.insertUserRole", params);
    }
} 