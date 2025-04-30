<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 검토자 지정</title>
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
        <div class="approval-title">검토자 지정</div>
        
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
                            <!-- 선택된 검토자가 여기에 추가됨 -->
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
        // 현재 페이지의 타입을 서버에서 받아옴
        const currentType = '${param.type}' || 'reviewer';
        let selectedUsers = [];

        console.log('Page initialized with type:', currentType);

        function initializeSelectedUsers(users) {
            console.log('Initializing with users:', users);
            
            if (!users || !Array.isArray(users)) {
                console.log('No users to initialize or invalid data');
                return;
            }
            
            try {
                // 오른쪽 테이블 초기화
                $('#rightTable tbody').empty();
                selectedUsers = [...users];

                // 이전에 선택된 사용자들을 오른쪽 테이블에 추가
                users.forEach((user, index) => {
                    addUserToRightTable(user);
                });

                console.log('Initialization complete. Selected users:', selectedUsers);
            } catch (error) {
                console.error('Error during initialization:', error);
            }
        }

        $(document).ready(function() {
            console.log('Page loaded. Current type:', currentType);
            
            // 부모 창에서 현재 선택된 사용자 정보 가져오기
            try {
                if (window.parent && window.parent.selectedUsers && window.parent.selectedUsers[currentType]) {
                    console.log('Found existing users in parent window');
                    initializeSelectedUsers(window.parent.selectedUsers[currentType]);
                }
            } catch (error) {
                console.error('Error getting parent window data:', error);
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
                    alert('추가할 검토자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    const dept = $(this).find('td:eq(1)').text();
                    const name = $(this).find('td:eq(2)').text();
                    const position = $(this).find('td:eq(3)').text();

                    if (!selectedUsers.includes(name)) {
                        const user = {
                            department: dept,
                            name: name,
                            position: position
                        };
                        addUserToRightTable(user);
                        selectedUsers.push(name);
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
                    alert('제거할 검토자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    const dept = $(this).find('td:eq(2)').text();
                    const name = $(this).find('td:eq(3)').text();
                    const position = $(this).find('td:eq(4)').text();

                    selectedUsers = selectedUsers.filter(user => user !== name);
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

        function addUserToRightTable(user) {
            try {
                console.log('Adding user to right table:', user);
                
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
            } catch (error) {
                console.error('Error adding user to right table:', error);
            }
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
            console.log('Starting save selection process. Current type:', currentType);
            
            try {
                const selectedUsers = [];
                
                // 선택된 사용자 정보 수집
                $('#rightTable tbody tr').each(function() {
                    const user = {
                        order: $(this).find('td:eq(1)').text(),
                        department: $(this).find('td:eq(2)').text(),
                        name: $(this).find('td:eq(3)').text(),
                        position: $(this).find('td:eq(4)').text()
                    };

                    // 사용자 데이터 유효성 검사
                    if (!user.name || !user.department || !user.position) {
                        throw new Error('불완전한 사용자 정보가 있습니다.');
                    }

                    selectedUsers.push(user);
                });

                console.log('Collected users for type:', currentType, selectedUsers);

                // 부모 창 존재 여부 확인
                if (!window.parent) {
                    throw new Error('부모 창을 찾을 수 없습니다.');
                }

                // 부모 창의 함수 존재 여부 확인
                if (typeof window.parent.handleApprovalLineSelection !== 'function') {
                    throw new Error('부모 창의 처리 함수를 찾을 수 없습니다.');
                }

                // 타입이 비어있는지 확인
                if (!currentType) {
                    throw new Error('결재선 유형이 지정되지 않았습니다.');
                }

                // 부모 창의 함수 호출
                console.log('Calling parent window function with type:', currentType);
                window.parent.handleApprovalLineSelection(currentType, selectedUsers);
                
                console.log('Save operation completed successfully');
            } catch (error) {
                console.error('Error in saveSelection:', error);
                alert('검토자 정보 저장 중 오류가 발생했습니다.\n' + error.message);
            }
        }

        function cancelSelection() {
            try {
                if (window.parent && window.parent.$('#approvalLineModal').length) {
                    window.parent.$('#approvalLineModal').modal('hide');
                }
            } catch (error) {
                console.error('Error in cancelSelection:', error);
                window.close();
            }
        }
    </script>
</body>
</html>