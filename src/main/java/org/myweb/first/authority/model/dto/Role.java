package org.myweb.first.authority.model.dto;

import java.util.Date;

public class Role {
    private String roleGroupId;
    private String roleGroupName;
    private Date createdAt;
    
    public Role() {}
    
    public Role(String roleGroupId, String roleGroupName, Date createdAt) {
        this.roleGroupId = roleGroupId;
        this.roleGroupName = roleGroupName;
        this.createdAt = createdAt;
    }
    
    public String getRoleGroupId() {
        return roleGroupId;
    }
    
    public void setRoleGroupId(String roleGroupId) {
        this.roleGroupId = roleGroupId;
    }
    
    public String getRoleGroupName() {
        return roleGroupName;
    }
    
    public void setRoleGroupName(String roleGroupName) {
        this.roleGroupName = roleGroupName;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Role [roleGroupId=" + roleGroupId + ", roleGroupName=" + roleGroupName + ", createdAt=" + createdAt + "]";
    }
} 