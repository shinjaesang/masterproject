<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>참조자 지정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .approval-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #dee2e6;
        }
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .search-box input {
            flex: 1 1 0;
            min-width: 0;
            max-width: 200px;
        }
        .search-box select {
            width: 120px;
            flex: none;
        }
        .table {
            font-size: 0.9rem;
        }
        .table th {
            background-color: #f8f9fa;
        }
        .btn-group-vertical {
            padding: 10px;
        }
        .btn-group-vertical .btn {
            margin: 5px 0;
        }
        .selected-row {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="approval-title">참조자 지정</div>
        
        <div class="row">
            <!-- 왼쪽: 전체 직원 목록 -->
            <div class="col-md-5">
<!--                     <div class="card-body"> -->
                        <div class="search-box">
                            <input type="text" class="form-control" id="leftSearch" placeholder="이름 검색">
                            <input type="text" class="form-control" id="leftDeptSearch" placeholder="부서 검색">
                            <select class="form-control" id="jobFilter">
                                <option value="">직급 선택</option>
                                <option value="부장">부장</option>
                                <option value="과장">과장</option>
                                <option value="대리">대리</option>
                                <option value="사원">사원</option>
                            </select>
                        </div>
                        <div class="table-responsive" style="max-height:400px; overflow-y:auto;">
                            <table class="table table-hover" id="leftTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>선택</th>
                                        <th>부서</th>
                                        <th>이름</th>
                                        <th>직급</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${employees}" var="emp">
                                        <tr>
                                            <td>
                                                <input type="checkbox" class="form-check-input" 
                                                       data-emp-id="${emp.empId}"
                                                       data-emp-name="${emp.empName}"
                                                       data-emp-dept="${emp.department}"
                                                       data-emp-job="${emp.job}">
                                            </td>
                                            <td>${emp.department}</td>
                                            <td>${emp.empName}</td>
                                            <td>${emp.job}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 가운데 버튼 그룹 -->
            <div class="col-md-2 d-flex align-items-center justify-content-center">
                <div class="btn-group-vertical">
                    <button type="button" class="btn btn-primary" id="addButton">추가 →</button>
                    <button type="button" class="btn btn-secondary" id="removeButton">← 제거</button>
                </div>
            </div>

            <!-- 오른쪽: 선택된 참조자 목록 -->
            <div class="col-md-5">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">선택된 참조자</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table" id="rightTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>선택</th>
                                        <th>부서</th>
                                        <th>이름</th>
                                        <th>직급</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <div class="d-flex justify-content-end mt-3">
            <button type="button" class="btn btn-secondary me-2" onclick="cancelSelection()">취소</button>
            <button type="button" class="btn btn-primary" onclick="saveSelection()">확인</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 현재 페이지의 타입을 서버에서 받아옴
        const currentType = '${param.type}' || 'referrer';
        let selectedUsers = [];

        $(document).ready(function() {
            // 테이블 행 선택 기능
            $('.table tbody').on('click', 'tr', function(e) {
                if (!$(e.target).is('input[type="checkbox"]')) {
                    $(this).find('input[type="checkbox"]').prop('checked', 
                        !$(this).find('input[type="checkbox"]').prop('checked'));
                }
                $(this).toggleClass('selected-row');
            });

            // 체크박스 클릭 이벤트
            $('.table tbody').on('click', 'input[type="checkbox"]', function(e) {
                e.stopPropagation();
                $(this).closest('tr').toggleClass('selected-row');
            });

            // 검색 기능
            $('#leftSearch, #leftDeptSearch').on('keyup', function() {
                const nameSearch = $('#leftSearch').val().toLowerCase();
                const deptSearch = $('#leftDeptSearch').val().toLowerCase();

                $('#leftTable tbody tr').each(function() {
                    const name = $(this).find('td:eq(2)').text().toLowerCase();
                    const dept = $(this).find('td:eq(1)').text().toLowerCase();
                    const matchName = name.includes(nameSearch);
                    const matchDept = dept.includes(deptSearch);
                    $(this).toggle(matchName && matchDept);
                });
            });

            // 추가 버튼 클릭
            $('#addButton').click(function() {
                const checkedRows = $('#leftTable tbody tr').filter(function() {
                    return $(this).find('input[type="checkbox"]').prop('checked');
                });

                if (checkedRows.length === 0) {
                    alert('추가할 참조자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    const empId = $(this).find('input[type="checkbox"]').data('emp-id');
                    const empName = $(this).find('input[type="checkbox"]').data('emp-name');
                    const empDept = $(this).find('input[type="checkbox"]').data('emp-dept');
                    const empJob = $(this).find('input[type="checkbox"]').data('emp-job');

                    if (!selectedUsers.some(user => user.empId === empId)) {
                        const user = {
                            empId: empId,
                            name: empName,
                            department: empDept,
                            position: empJob
                        };
                        addUserToRightTable(user);
                        selectedUsers.push(user);
                        $(this).find('input[type="checkbox"]').prop('checked', false)
                            .closest('tr').removeClass('selected-row');
                    }
                });
            });

            // 제거 버튼 클릭
            $('#removeButton').click(function() {
                const checkedRows = $('#rightTable tbody tr').filter(function() {
                    return $(this).find('input[type="checkbox"]').prop('checked');
                });

                if (checkedRows.length === 0) {
                    alert('제거할 참조자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    const empId = $(this).data('emp-id');
                    selectedUsers = selectedUsers.filter(user => user.empId !== empId);
                    $(this).remove();
                });
            });
        });

        function addUserToRightTable(user) {
            const newRow = $('<tr>').data('emp-id', user.empId);
            newRow.append($('<td>').append($('<input>').attr({
                type: 'checkbox',
                class: 'form-check-input'
            })));
            newRow.append($('<td>').text(user.department));
            newRow.append($('<td>').text(user.name));
            newRow.append($('<td>').text(user.position));

            $('#rightTable tbody').append(newRow);
        }

        function saveSelection() {
            if (window.parent && typeof window.parent.handleApprovalLineSelection === 'function') {
                window.parent.handleApprovalLineSelection(currentType, selectedUsers);
                window.close();
            }
        }

        function cancelSelection() {
            if (window.parent && window.parent.$) {
                window.parent.$('#approvalLineModal').modal('hide');
            } else {
                window.close();
            }
        }

        // 초기 선택된 사용자 설정
        function initializeSelectedUsers(users) {
            if (!users || !users.length) return;
            users.forEach(user => {
                const checkbox = $(`#leftTable input[data-emp-id="${user.empId}"]`);
                if (checkbox.length) {
                    checkbox.prop('checked', true).trigger('change');
                    $('#addButton').click();
                }
            });
        }

        // 필요시 부모에서 직접 호출할 수 있도록 함수 선언
        function closeApprovalLineModal() {
            $('#approvalLineModal').modal('hide');
        }
    </script>
</body>
</html> 