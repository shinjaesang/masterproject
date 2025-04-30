<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 참조자 지정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="재고관리 ERP 시스템" name="keywords">
    <meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
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
            flex: 1;
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
            <!-- 왼쪽 테이블 -->
            <div class="col-md-5">
                <div class="search-box">
                    <input type="text" class="form-control" id="leftSearch" placeholder="이름 검색">
                    <input type="text" class="form-control" id="leftDeptSearch" placeholder="부서 검색">
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered" id="leftTable">
                        <thead>
                            <tr>
                                <th style="width: 50px">선택</th>
                                <th>부서</th>
                                <th>이름</th>
                                <th>직급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 기존 사용자 목록이 여기에 표시됩니다 -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 가운데 버튼 그룹 -->
            <div class="col-md-2 d-flex align-items-center justify-content-center">
                <div class="btn-group-vertical">
                    <button type="button" class="btn btn-primary" id="addButton">추가 →</button>
                    <button type="button" class="btn btn-secondary" id="removeButton">← 제거</button>
                </div>
            </div>

            <!-- 오른쪽 테이블 -->
            <div class="col-md-5">
                <div class="table-responsive">
                    <table class="table table-bordered" id="rightTable">
                        <thead>
                            <tr>
                                <th style="width: 50px">선택</th>
                                <th>순서</th>
                                <th>부서</th>
                                <th>이름</th>
                                <th>직급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 선택된 참조자가 여기에 추가됨 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <div class="d-flex justify-content-end mt-3">
            <button type="button" class="btn btn-secondary me-2" onclick="cancelSelection()">취소</button>
            <button type="button" class="btn btn-primary" onclick="saveSelection()">저장</button>
        </div>
    </div>

    <!-- Page specific Javascript -->
    <script>
        let previouslySelectedUsers = [];
        let removedUsers = new Set();
        let rightTableUsers = new Set();

        // 이전에 선택된 사용자 초기화
        function initializeSelectedUsers(users) {
            if (!users || !Array.isArray(users)) return;
            
            // 오른쪽 테이블 초기화
            $('#rightTable tbody').empty();
            rightTableUsers.clear();

            // 이전에 선택된 사용자들을 오른쪽 테이블에 추가
            users.forEach(user => {
                addUserToRightTable(user);
                rightTableUsers.add(user.name);
            });

            // 왼쪽 테이블에서 선택된 사용자 제거
            $('#leftTable tbody tr').each(function() {
                const name = $(this).find('td:eq(2)').text();
                if (rightTableUsers.has(name)) {
                    $(this).remove();
                }
            });
        }

        $(document).ready(function() {
            // 이전에 선택된 사용자 정보 가져오기
            if (window.parent && window.parent.getCurrentLineUsers) {
                previouslySelectedUsers = window.parent.getCurrentLineUsers('referrer');
                // 이전 선택된 사용자들을 오른쪽 테이블에 추가
                previouslySelectedUsers.forEach(user => {
                    addUserToRightTable(user);
                });
            }

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
                    const dept = $(this).find('td:eq(1)').text();
                    const name = $(this).find('td:eq(2)').text();
                    const position = $(this).find('td:eq(3)').text();

                    if (!rightTableUsers.has(name)) {
                        const user = {
                            department: dept,
                            name: name,
                            position: position
                        };
                        addUserToRightTable(user);
                        rightTableUsers.add(name);
                        $(this).remove();
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
                    const dept = $(this).find('td:eq(2)').text();
                    const name = $(this).find('td:eq(3)').text();
                    const position = $(this).find('td:eq(4)').text();

                    rightTableUsers.delete(name);
                    addUserToLeftTable({
                        department: dept,
                        name: name,
                        position: position
                    });
                    $(this).remove();
                });

                updateOrder();
            });
        });

        // 삭제된 사용자 복원 함수
        function restoreUser(userName) {
            removedUsers.add(userName);
        }

        // 사용자 추가 시 삭제된 사용자 확인
        function addUserToRightTable(user) {
            if (removedUsers.has(user.name)) {
                removedUsers.delete(user.name);
            }
            
            const order = $('#rightTable tbody tr').length + 1;
            const newRow = $('<tr>');
            newRow.append($('<td>').append($('<input>').attr({
                type: 'checkbox',
                class: 'form-check-input'
            })));
            newRow.append($('<td>').text(order));
            newRow.append($('<td>').text(user.department));
            newRow.append($('<td>').text(user.name));
            newRow.append($('<td>').text(user.position));

            $('#rightTable tbody').append(newRow);
            updateOrder();
        }

        function addUserToLeftTable(user) {
            const newRow = $('<tr>');
            newRow.append($('<td>').append($('<input>').attr({
                type: 'checkbox',
                class: 'form-check-input'
            })));
            newRow.append($('<td>').text(user.department));
            newRow.append($('<td>').text(user.name));
            newRow.append($('<td>').text(user.position));

            $('#leftTable tbody').append(newRow);
        }

        function updateOrder() {
            $('#rightTable tbody tr').each(function(index) {
                $(this).find('td:eq(1)').text(index + 1);
            });
        }

        function saveSelection() {
            const selectedUsers = [];
            $('#rightTable tbody tr').each(function() {
                selectedUsers.push({
                    order: $(this).find('td:eq(1)').text(),
                    department: $(this).find('td:eq(2)').text(),
                    name: $(this).find('td:eq(3)').text(),
                    position: $(this).find('td:eq(4)').text()
                });
            });

            if (window.parent && typeof window.parent.handleApprovalLineSelection === 'function') {
                window.parent.handleApprovalLineSelection('referrer', selectedUsers);
            } else {
                alert('참조자 정보를 전달할 수 없습니다.');
            }
        }

        function cancelSelection() {
            if (window.parent && typeof window.parent.cancelApprovalLine === 'function') {
                window.parent.cancelApprovalLine();
            } else {
                window.parent.$('#approvalLineModal').modal('hide');
            }
        }
    </script>
</body>
</html>