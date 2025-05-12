<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 결재선 지정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="재고관리 ERP 시스템" name="keywords">
    <meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Favicon -->
    <link href="<c:url value='/resources/img/favicon.ico'/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">

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
        <div class="approval-title">결재자 지정</div>
        
        <div class="row">
            <!-- 왼쪽 테이블 -->
            <div class="col-md-5">
                <div class="search-box">
                    <input type="text" class="form-control" id="leftSearch" placeholder="이름 검색">
                    <input type="text" class="form-control" id="leftDeptSearch" placeholder="부서 검색">
                    <select class="form-control" id="jobFilter">
                        <option value="">직급 선택</option>
                        <option value="부장">부장</option>
                        <!-- <option value="차장">차장</option>
                        <option value="과장">과장</option>
                        <option value="대리">대리</option>
                        <option value="사원">사원</option> -->
                    </select>
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
                            <c:forEach items="${employees}" var="emp">
                                <tr 
                                    data-emp-id="${emp.empId}" 
                                    data-emp-name="${emp.empName}" 
                                    data-emp-dept="${emp.department}" 
                                    data-emp-job="${emp.job}">
                                    <td><input type="checkbox" class="form-check-input"></td>
                                    <td>${emp.department}</td>
                                    <td>${emp.empName}</td>
                                    <td>${emp.job}</td>
                                </tr>
                            </c:forEach>
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
                            <!-- 선택된 결재자가 여기에 추가됨 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <div class="d-flex justify-content-end mt-3">
            <button type="button" class="btn btn-secondary me-2" onclick="cancelApproval()">취소</button>
            <button type="button" class="btn btn-primary" onclick="saveApprovalLine()">저장</button>
        </div>
    </div>

    <!-- Page specific Javascript -->
    <script>
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
            $('#leftSearch, #leftDeptSearch, #jobFilter').on('change keyup', function() {
                const nameSearch = $('#leftSearch').val().toLowerCase();
                const deptSearch = $('#leftDeptSearch').val().toLowerCase();
                const jobFilter = $('#jobFilter').val();

                $('#leftTable tbody tr').each(function() {
                    const name = $(this).find('td:eq(2)').text().toLowerCase();
                    const dept = $(this).find('td:eq(1)').text().toLowerCase();
                    const job = $(this).find('td:eq(3)').text();
                    const matchName = name.includes(nameSearch);
                    const matchDept = dept.includes(deptSearch);
                    const matchJob = jobFilter === '' || job === jobFilter;
                    $(this).toggle(matchName && matchDept && matchJob);
                });
            });

            // 추가 버튼 클릭 - 결재자로 지정
            $('#addButton').click(function() {
                const checkedRows = $('#leftTable tbody tr').filter(function() {
                    return $(this).find('input[type="checkbox"]').prop('checked');
                });

                if (checkedRows.length === 0) {
                    alert('추가할 결재자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    // <tr>의 data 속성에서 값 추출
                    const empId = $(this).data('emp-id');
                    const name = $(this).data('emp-name');
                    const dept = $(this).data('emp-dept');
                    const position = $(this).data('emp-job');
                    const order = $('#rightTable tbody tr').length + 1;

                    console.log('추가되는 값:', {empId, name, dept, position, order});

                    const newRow = $('<tr>')
                        .attr('data-emp-id', empId)
                        .attr('data-emp-name', name)
                        .attr('data-emp-dept', dept)
                        .attr('data-emp-job', position)
                        .append($('<td>').append($('<input>').attr({
                            type: 'checkbox',
                            class: 'form-check-input'
                        })))
                        .append($('<td>').text(order))
                        .append($('<td>').text(dept))
                        .append($('<td>').text(name))
                        .append($('<td>').text(position));

                    $('#rightTable tbody').append(newRow);
                    $(this).remove();
                });

                updateOrder();
                bindRightTableEvents();
            });

            // 제거 버튼 클릭 - 결재자 해제
            $('#removeButton').click(function() {
                const checkedRows = $('#rightTable tbody tr').filter(function() {
                    return $(this).find('input[type="checkbox"]').prop('checked');
                });

                if (checkedRows.length === 0) {
                    alert('제거할 결재자를 선택해주세요.');
                    return;
                }

                checkedRows.each(function() {
                    const dept = $(this).find('td:eq(2)').text();
                    const name = $(this).find('td:eq(3)').text();
                    const position = $(this).find('td:eq(4)').text();

                    const newRow = $('<tr>');
                    newRow.append($('<td>').append($('<input>').attr({
                        type: 'checkbox',
                        class: 'form-check-input'
                    })));
                    newRow.append($('<td>').text(dept));
                    newRow.append($('<td>').text(name));
                    newRow.append($('<td>').text(position));

                    $('#leftTable tbody').append(newRow);
                    $(this).remove();
                });

                updateOrder();
                bindLeftTableEvents();
            });

            // 초기 이벤트 바인딩
            bindLeftTableEvents();
            bindRightTableEvents();
        });

        // 왼쪽 테이블 이벤트 바인딩
        function bindLeftTableEvents() {
            $('#leftTable tbody tr').each(function() {
                $(this).find('input[type="checkbox"]').prop('checked', false);
                $(this).removeClass('selected-row');
            });
        }

        // 오른쪽 테이블 이벤트 바인딩
        function bindRightTableEvents() {
            $('#rightTable tbody tr').each(function() {
                $(this).find('input[type="checkbox"]').prop('checked', false);
                $(this).removeClass('selected-row');
            });
        }

        // 순서 업데이트
        function updateOrder() {
            $('#rightTable tbody tr').each(function(index) {
                $(this).find('td:eq(1)').text(index + 1);
            });
        }

        // 저장 버튼
        function saveApprovalLine() {
            try {
                // URL 파라미터에서 type 가져오기
                const urlParams = new URLSearchParams(window.location.search);
                let type = urlParams.get('type');
                console.log('Initial type from URL:', type);

                // type 값 검증 및 기본값 설정
                if (!type || typeof type !== 'string') {
                    console.warn('Invalid type value:', type);
                    type = 'approver';
                }
                
                // type 값 정규화 (소문자로 변환)
                type = type.toLowerCase();
                console.log('Normalized type:', type);

                // 선택된 사용자 정보 수집
                const selectedUsers = [];
                $('#rightTable tbody tr').each(function() {
                    const empId = $(this).attr('data-emp-id');
                    const name = $(this).attr('data-emp-name');
                    const department = $(this).attr('data-emp-dept');
                    const position = $(this).attr('data-emp-job');
                    const order = $(this).find('td:eq(1)').text();
                    console.log('저장되는 값:', {empId, name, department, position, order});
                    selectedUsers.push({
                        empId,
                        name,
                        department,
                        position,
                        order
                    });
                });

                console.log('Selected users:', selectedUsers);
                console.log('Final type value:', type);

                // 부모 창의 함수 호출
                if (window.parent && typeof window.parent.handleApprovalLineSelection === 'function') {
                    // type 값이 유효한지 한 번 더 확인
                    if (!['approver', 'reviewer', 'referrer'].includes(type)) {
                        throw new Error('올바르지 않은 결재선 유형입니다: ' + type);
                    }

                    // 부모 창의 함수 호출
                    window.parent.handleApprovalLineSelection(type, selectedUsers);
                    window.parent.$('#approvalLineModal').modal('hide');
                } else {
                    throw new Error('결재선 정보를 전달할 수 없습니다.');
                }
            } catch (error) {
                console.error('Error in saveApprovalLine:', error);
                alert(error.message || '결재선 정보 저장 중 오류가 발생했습니다.');
            }
        }

        // 취소 버튼
        function cancelApproval() {
            if (window.parent && typeof window.parent.cancelApprovalLine === 'function') {
                window.parent.cancelApprovalLine();
            } else {
                window.parent.$('#approvalLineModal').modal('hide');
            }
        }
    </script>
</body>
</html>