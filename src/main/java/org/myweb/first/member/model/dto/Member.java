package org.myweb.first.member.model.dto;

import java.sql.Date;

//vo(dto, do, entity, bean) 작성규칙
//1. 반드시 직렬화할 것
//2. 모든 필드는 private : 반드시 캡슐화할 것
//3. 기본생성자, 매개변수 있는 생성자 작성할 것
//4. 모든 필드에 대한 getters and setters 
//5. toString() overriding
//선택 : equals(), clone() 등 오버라이딩, 그 외의 메소드
public class Member implements java.io.Serializable {
	private static final long serialVersionUID = -4952932019676617041L;

	//Field == Property (멤버변수 == 속성)
	private String empId;          // 사원번호
	private String empName;        // 사용자 이름
	private String department;     // 부서
	private String job;           // 직무
	private String email;         // 이메일
	private String phone;         // 전화번호
	private String empNo;         // 주민등록번호
	private Date hireDate;        // 입사일
	private String address;       // 주소
	private String empPwd;        // 비밀번호
	private String adminYN;       // 관리자 여부
	private Date lastLoginDate;   // 마지막 로그인 날짜
	private String isActive;      // 계정 활성화 여부
	
	public Member() {
		super();
	}	

	public Member(String empId, String empName, String department, String job, String email, String phone,
			String empNo, Date hireDate, String address, String empPwd, String adminYN,
			Date lastLoginDate, String isActive) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.department = department;
		this.job = job;
		this.email = email;
		this.phone = phone;
		this.empNo = empNo;
		this.hireDate = hireDate;
		this.address = address;
		this.empPwd = empPwd;
		this.adminYN = adminYN;
		this.lastLoginDate = lastLoginDate;
		this.isActive = isActive;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmpPwd() {
		return empPwd;
	}

	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}

	public String getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(String adminYN) {
		this.adminYN = adminYN;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	@Override
	public String toString() {
		return "Member [empId=" + empId + ", empName=" + empName + ", department=" + department + 
			   ", job=" + job + ", email=" + email + ", phone=" + phone + ", empNo=" + empNo + 
			   ", hireDate=" + hireDate + ", address=" + address + ", empPwd=" + empPwd + 
			   ", adminYN=" + adminYN + ", lastLoginDate=" + lastLoginDate + ", isActive=" + isActive + "]";
	}
}

