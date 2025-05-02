package org.myweb.first.authority.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.myweb.first.authority.model.dao.AuthorityDao;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.authority.model.dto.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("authorityService")
public class AuthorityServiceImpl implements AuthorityService {

    @Autowired
    private AuthorityDao authorityDao;

    @Override
    public List<Member> selectAllUsers() {
        return authorityDao.selectAllUsers();
    }

    @Override
    public List<Member> searchUsers(Map<String, String> params) {
        return authorityDao.searchUsers(params);
    }

    @Override
    @Transactional
    public int updateUserStatus(String empId, String status) {
        Map<String, String> params = new HashMap<>();
        params.put("empId", empId);
        params.put("status", status);
        return authorityDao.updateUserStatus(params);
    }

    @Override
    @Transactional
    public int updateUserRole(String empId, String role) {
        Map<String, String> params = new HashMap<>();
        params.put("empId", empId);
        params.put("adminYN", "관리자".equals(role) ? "Y" : "N");
        return authorityDao.updateUserRole(params);
    }

    @Override
    @Transactional
    public int deleteUser(String empId) {
        return authorityDao.deleteUser(empId);
    }

    @Override
    public int getTotalUsers(Map<String, String> params) {
        return authorityDao.getTotalUsers(params);
    }

    @Override
    public List<Member> getUsersByPage(int page, int pageSize, Map<String, String> params) {
        return authorityDao.getUsersByPage(params);
    }

    @Override
    public List<Role> selectAllRoles() {
        return authorityDao.selectAllRoles();
    }

    @Override
    @Transactional
    public int insertUserRole(Map<String, String> params) {
        return authorityDao.insertUserRole(params);
    }

    @Override
    public int getUserCountByRole(String roleGroupId) {
        return authorityDao.getUserCountByRole(roleGroupId);
    }

    @Override
    public int getPermissionCountByRole(String roleGroupId) {
        return authorityDao.getPermissionCountByRole(roleGroupId);
    }

    @Override
    public List<Member> getUsersByRole(String roleGroupId) {
        return authorityDao.getUsersByRole(roleGroupId);
    }
} 