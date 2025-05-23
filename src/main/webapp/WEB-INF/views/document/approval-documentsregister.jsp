<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 전자문서 작성</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    
    <!-- Summernote CSS -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">

    <!-- CKEditor 5 -->
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>

    <!-- Critical CSS -->
    <style>
        .spinner-border {
            display: inline-block;
            width: 2rem;
            height: 2rem;
            vertical-align: text-bottom;
            border: .25em solid currentColor;
            border-right-color: transparent;
            border-radius: 50%;
            animation: spinner-border .75s linear infinite;
        }

        @keyframes spinner-border {
            to {
                transform: rotate(360deg);
            }
        }

        #spinner {
            opacity: 0;
            visibility: hidden;
            transition: opacity .5s ease-out, visibility 0s linear .5s;
            z-index: 99999;
        }

        #spinner.show {
            transition: opacity .5s ease-out, visibility 0s linear 0s;
            visibility: visible;
            opacity: 1;
        }

        .content {
            opacity: 0;
            transition: opacity 0.3s ease-in;
        }

        .content.show {
            opacity: 1;
        }

        .approval-list {
            font-size: 0.9rem;
        }
        .approval-list .approval-item {
            padding: 5px;
            margin-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        .approval-list .approval-item:last-child {
            border-bottom: none;
        }
        .approval-list .approval-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .approval-list .approval-text {
            flex-grow: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Sidebar Start -->
        <jsp:include page="../common/sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="../common/navbar.jsp" />
            <!-- Navbar End -->

            <!-- 문서 작성 폼 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h5 class="mb-0">전자문서 등록</h5>
                    </div>
                    
                    <form id="documentForm" action="${pageContext.request.contextPath}/document/register.do" method="post" enctype="multipart/form-data">
                        <!-- 문서 기본 정보 -->
                        <div class="row mb-3">
                            <!-- 문서 제목 -->
                            <div class="col-12 mb-3">
                                <label for="title" class="form-label">문서 제목</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                    placeholder="문서 제목을 입력하세요" required>
                            </div>
                            
                            <!-- 기안자 정보 -->
                            <div class="col-md-6 mb-3">
                                <label for="writer" class="form-label">기안자</label>
                                <input type="text" class="form-control" id="writer" name="writer" 
                                   value="${sessionScope.loginUser.empName}" readonly>
                            </div>
                            
                            <!-- 작성일자 -->
                            <div class="col-md-6 mb-3">
                                <label for="writeDate" class="form-label">작성일자</label>
                                <input type="date" class="form-control" id="writeDate" name="writeDate" 
                                    value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                            </div>
                        </div>

                        <!-- 결재선 지정 -->
                        <div class="mb-4">
                            <label class="form-label">결재선</label>
                            <div class="d-flex gap-2 mb-2">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openApprovalLine('approver')">
                                    결재자 추가
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openApprovalLine('reviewer')">
                                    검토자 추가
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openApprovalLine('referrer')">
                                    참조자 추가
                                </button>
                            </div>
                            
                            <!-- 결재선 표시 영역 -->
                            <div class="bg-white rounded p-3 border">
                                <div class="row">
                                    <!-- 결재 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">결재</h6>
                                        <div class="border rounded p-2" style="min-height: 100px">
                                            <div id="approverList" class="approval-list" data-type="approver">
                                                <!-- 결재자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 검토 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">검토</h6>
                                        <div class="border rounded p-2" style="min-height: 100px">
                                            <div id="reviewerList" class="approval-list" data-type="reviewer">
                                                <!-- 검토자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 참조 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">참조</h6>
                                        <div class="border rounded p-2" style="min-height: 100px">
                                            <div id="referrerList" class="approval-list" data-type="referrer">
                                                <!-- 참조자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 문서 유형 -->
                        <div class="mb-3">
                            <label for="documentType" class="form-label">문서 유형</label>
                            <select class="form-select" id="documentType" name="documentType" required>
                                <option value="">문서 유형을 선택하세요</option>
                                <option value="지출결의서">지출결의서</option>
                                <option value="품의서">품의서</option>
                                <option value="입고요청서">입고요청서</option>
                                <option value="출고요청서">출고요청서</option>
                                <option value="기안서">기안서</option>
                                <option value="보고서">보고서</option>
                            </select>
                        </div>

                        <!-- 문서 내용 -->
                        <div class="mb-3">
                            <label for="content" class="form-label">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="10" required></textarea>
                        </div>

                        <!-- 첨부파일 -->
                        <div class="mb-4">
                            <label for="attachments" class="form-label">첨부 파일</label>
                            <div class="input-group">
                                <input type="file" class="form-control" id="attachments" name="attachments" multiple>
                                <button type="button" class="btn btn-outline-secondary" onclick="document.getElementById('attachments').value = ''">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="form-text">파일 용량 (최대 20MB)</div>
                        </div>

                        <!-- 버튼 그룹 -->
                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-outline-primary" onclick="previewDocument()">
                                미리보기
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="history.back()">
                                취소
                            </button>
                            <button type="button" class="btn btn-outline-primary" onclick="saveTemp()">
                                임시저장
                            </button>
                            <button type="button" class="btn btn-dark" onclick="submitDocument()">결재상신</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 문서 작성 폼 끝 -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- 결재선 지정 모달 -->
        <div class="modal fade" id="approvalLineModal" tabindex="-1" aria-labelledby="approvalLineModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="approvalLineModalLabel">결재선 지정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- 결재선 선택 페이지가 로드될 영역 -->
                        <div id="approvalLineContent"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 미리보기 모달 -->
        <div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="previewModalLabel">문서 미리보기</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="previewContent">
                    </div>
                </div>
            </div>
        </div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
            <i class="bi bi-arrow-up"></i>
        </a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Summernote JS -->
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

    <script src="${pageContext.request.contextPath}/resources/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

    <!-- Page specific Javascript -->
    <script>
        let currentApprovalType = '';
        let tempSavedData = null;
        let selectedUsers = {
            approver: [],
            reviewer: [],
            referrer: []
        };

        $(document).ready(function() {
            // CKEditor 초기화
            ClassicEditor
                .create(document.querySelector('#content'), {
                    language: 'ko',
                    toolbar: [
                        'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|',
                        'outdent', 'indent', '|', 'imageUpload', 'blockQuote', 'insertTable', 'undo', 'redo'
                    ]
                })
                .then(editor => {
                    window.editor = editor;
                })
                .catch(error => {
                    console.error(error);
                });

            // 모달이 닫힐 때 내용 초기화
            $('#approvalLineModal').on('hidden.bs.modal', function () {
                $('#approvalLineContent').empty();
            });

            // 페이지 로드 시 스피너 숨기기
            hideSpinner();

            // 임시저장된 데이터 확인
            const savedData = localStorage.getItem('tempDocument');
            if (savedData) {
                tempSavedData = JSON.parse(savedData);
                if (confirm('임시저장된 문서가 있습니다. 불러오시겠습니까?')) {
                    loadTempDocument();
                }
            }

            // 결재선 초기화
            initializeApprovalLines();
        });

        // 결재선 초기화 함수
        function initializeApprovalLines() {
            const approvalTypes = ['approver', 'reviewer', 'referrer'];
            approvalTypes.forEach(type => {
                const area = document.getElementById(`${type}List`);
                if (area) {
                    area.innerHTML = '';
                }
            });
        }

        // 결재선 지정 함수
        function openApprovalLine(type) {
            console.log('Opening approval line for type:', type);
            
            if (!type || !['approver', 'reviewer', 'referrer'].includes(type)) {
                console.error('Invalid approval type:', type);
                alert('올바르지 않은 결재선 유형입니다.');
                return;
            }

            currentApprovalType = type;
            
            // 타입별 URL 매핑
            const urlMapping = {
                approver: '${pageContext.request.contextPath}/document/approval-line.do',
                reviewer: '${pageContext.request.contextPath}/document/reviewer-line.do',
                referrer: '${pageContext.request.contextPath}/document/reference-line.do'
            };

            const url = urlMapping[type] + '?type=' + type;
            console.log('Loading URL:', url);

            try {
                // 모달 내용 초기화 및 iframe 생성
                const modalContent = document.getElementById('approvalLineContent');
                if (!modalContent) {
                    throw new Error('모달 컨텐츠 영역을 찾을 수 없습니다.');
                }
                modalContent.innerHTML = '';

                const iframe = document.createElement('iframe');
                iframe.style.width = '100%';
                iframe.style.height = '600px';
                iframe.style.border = 'none';
                iframe.src = url;

                modalContent.appendChild(iframe);
                
                // iframe 로드 완료 후 초기 데이터 전달
                iframe.onload = function() {
                    try {
                        const iframeWindow = iframe.contentWindow;
                        if (iframeWindow && typeof iframeWindow.initializeSelectedUsers === 'function') {
                            iframeWindow.initializeSelectedUsers(selectedUsers[type] || []);
                        }
                    } catch (error) {
                        console.error('Error initializing iframe:', error);
                    }
                };

                // 모달 표시
                $('#approvalLineModal').modal('show');
            } catch (error) {
                console.error('Error in openApprovalLine:', error);
                alert('결재선 선택 창을 열 수 없습니다.\n' + error.message);
            }
        }

        // 결재선 선택 결과 처리 함수
        function handleApprovalLineSelection(type, users) {
            console.log('Starting handleApprovalLineSelection with:', { type, users });
            
            // type 값 검증 및 기본값 설정
            if (!type || typeof type !== 'string') {
                console.warn('Invalid type value:', type);
                type = 'approver';
            }
            
            // type 값 정규화 (소문자로 변환)
            type = type.toLowerCase();
            
            if (!['approver', 'reviewer', 'referrer'].includes(type)) {
                console.error('Invalid approval type:', type);
                alert('올바르지 않은 결재선 유형입니다.');
                return;
            }

            try {
                // 결재선 정보 업데이트
                selectedUsers[type] = users;

                // DOM 업데이트
                const targetId = `${type}List`;
                console.log('Looking for element with ID:', targetId);
                
                // 모든 approval-list 요소 확인
                const allApprovalLists = document.querySelectorAll('.approval-list');
                console.log('All approval lists:', allApprovalLists);
                
                // ID로 요소 찾기 시도
                let targetArea = document.getElementById(targetId);
                
                // ID로 찾지 못한 경우 data-type 속성으로 시도
                if (!targetArea) {
                    targetArea = document.querySelector(`.approval-list[data-type="${type}"]`);
                }
                
                // 여전히 찾지 못한 경우 클래스와 data-type으로 시도
                if (!targetArea) {
                    const elements = document.getElementsByClassName('approval-list');
                    for (let element of elements) {
                        if (element.getAttribute('data-type') === type) {
                            targetArea = element;
                            break;
                        }
                    }
                }

                if (!targetArea) {
                    console.error('Target area not found for type:', type);
                    console.log('Available elements:', allApprovalLists);
                    throw new Error(`결재선 영역을 찾을 수 없습니다. (${type})`);
                }

                // 기존 내용 초기화
                targetArea.innerHTML = '';
                
                // 폼에서 기존 hidden input 제거
                const form = document.querySelector('form');
                const existingInputs = form.querySelectorAll(`input[name="${type}List"]`);
                existingInputs.forEach(input => input.remove());

                // 새로운 결재선 정보 표시 및 hidden input 추가
                users.forEach((user, index) => {
                    console.log('user raw:', user, typeof user);
                    if (typeof user === 'string') {
                        try {
                            user = JSON.parse(user);
                        } catch (e) {
                            console.error('user 파싱 실패:', user);
                            return;
                        }
                    }
                    console.log('user after parse:', user);
                    
                    // TB_USER 테이블의 컬럼명에 맞게 수정
                    const empName = user.empName || user.name || '';
                    const department = user.deptName || user.department || '';
                    const position = user.jobTitle || user.position || '';
                    
                    console.log('결재선 표시 값:', empName, department, position);
                    if (!empName && !department && !position) {
                        console.error('Invalid user data:', user);
                        return;
                    }

                    // 결재선 항목 생성
                    const approvalItem = document.createElement('div');
                    approvalItem.className = 'approval-item';
                    approvalItem.innerHTML = 
                        '<div class="approval-info d-flex justify-content-between align-items-center">' +
                        '<span class="approval-text">' + empName + '/' + department + '/' + position + '</span>' +
                        '<button type="button" class="btn btn-link text-danger p-0" ' +
                        'onclick="clearApprovalLine(\'' + type + '\', \'' + empName + '\')">' +
                        '<i class="fas fa-times"></i>' +
                        '</button>' +
                        '</div>';
                    targetArea.appendChild(approvalItem);

                    // hidden input 추가
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = `${type}List`;
                    input.value = JSON.stringify({
                        empId: user.empId,
                        empName: empName,
                        department: department,
                        position: position,
                        order: index + 1
                    });
                    form.appendChild(input);
                });

                console.log('Successfully updated approval line for type:', type);
                // 모달 닫기
                $('#approvalLineModal').modal('hide');
            } catch (error) {
                console.error('Error in handleApprovalLineSelection:', error);
                alert('결재선 정보 처리 중 오류가 발생했습니다.\n' + error.message);
            }
        }

        // 결재선 삭제 함수
        function clearApprovalLine(type, empName) {
            console.log('Starting clearApprovalLine with:', { type, empName });
            
            try {
                // type 값 검증 및 기본값 설정
                if (!type || typeof type !== 'string') {
                    console.warn('Invalid type value:', type);
                    type = 'approver';
                }
                
                // type 값 정규화 (소문자로 변환)
                type = type.toLowerCase();
                
                if (!['approver', 'reviewer', 'referrer'].includes(type)) {
                    throw new Error('올바르지 않은 결재선 유형입니다: ' + type);
                }

                // DOM 업데이트
                const targetId = `${type}List`;
                console.log('Looking for element with ID:', targetId);
                
                // 여러 방법으로 요소 찾기 시도
                let targetArea = document.getElementById(targetId);
                
                if (!targetArea) {
                    targetArea = document.querySelector(`.approval-list[data-type="${type}"]`);
                }
                
                if (!targetArea) {
                    const elements = document.getElementsByClassName('approval-list');
                    for (let element of elements) {
                        if (element.getAttribute('data-type') === type) {
                            targetArea = element;
                            break;
                        }
                    }
                }

                if (!targetArea) {
                    console.error('Target area not found for type:', type);
                    throw new Error(`결재선 영역을 찾을 수 없습니다. (${type})`);
                }

                // typeText 설정
                const typeText = {
                    'approver': '결재',
                    'reviewer': '검토',
                    'referrer': '참조'
                }[type] || type;

                if (confirm('취소하시겠습니까?')) {
                    // 선택된 사용자 목록에서 제거
                    selectedUsers[type] = selectedUsers[type].filter(user => user.empName !== empName);
                    
                    // DOM 업데이트
                    const items = targetArea.getElementsByClassName('approval-item');
                    Array.from(items).forEach(item => {
                        if (item.textContent.includes(empName)) {
                            item.remove();
                        }
                    });

                    // hidden input 업데이트
                    const form = document.querySelector('form');
                    const inputs = form.querySelectorAll(`input[name="${type}List"]`);
                    inputs.forEach(input => {
                        try {
                            const data = JSON.parse(input.value);
                            if (data.empName === empName) {
                                input.remove();
                            }
                        } catch (error) {
                            console.error('Error parsing input value:', error);
                        }
                    });

                    console.log('Successfully removed approval line for:', empName);
                }
            } catch (error) {
                console.error('Error in clearApprovalLine:', error);
                alert('결재선 삭제 중 오류가 발생했습니다.\n' + error.message);
            }
        }

        // 임시저장 기능
        function saveTemp() {
            const form = document.querySelector('form');
            const formData = new FormData(form);
            const tempData = {
                title: formData.get('title'),
                writeDate: formData.get('writeDate'),
                documentType: formData.get('documentType'),
                content: formData.get('content'),
                approverList: getApprovalList('approver'),
                reviewerList: getApprovalList('reviewer'),
                referrerList: getApprovalList('referrer')
            };

            localStorage.setItem('tempDocument', JSON.stringify(tempData));
            alert('문서가 임시저장되었습니다.');
        }

        // 임시저장 문서 불러오기
        function loadTempDocument() {
            if (!tempSavedData) return;

            document.getElementById('title').value = tempSavedData.title || '';
            document.getElementById('writeDate').value = tempSavedData.writeDate || '';
            document.getElementById('documentType').value = tempSavedData.documentType || '';
            
            // CKEditor 내용 설정
            if (window.editor) {
                window.editor.setData(tempSavedData.content || '');
            }

            // 결재선 정보 복원
            if (tempSavedData.approverList) handleApprovalLineSelection('approver', tempSavedData.approverList);
            if (tempSavedData.reviewerList) handleApprovalLineSelection('reviewer', tempSavedData.reviewerList);
            if (tempSavedData.referrerList) handleApprovalLineSelection('referrer', tempSavedData.referrerList);
        }

        // 결재선 정보 가져오기
        function getApprovalList(type) {
            const inputs = document.querySelectorAll(`input[name="${type}List"]`);
            return Array.from(inputs).map(input => JSON.parse(input.value));
        }

        // 미리보기 기능
        function previewDocument() {
            const title = document.getElementById('title').value;
            const writer = document.getElementById('writer').value;
            const writeDate = document.getElementById('writeDate').value;
            const documentType = document.getElementById('documentType').value;
            const content = window.editor ? window.editor.getData() : '';

            // 결재선 정보 가져오기
            const referrerHtml = generateApprovalListHtml('referrer');
            const reviewerHtml = generateApprovalListHtml('reviewer');
            const approverHtml = generateApprovalListHtml('approver');

            const previewHtml = `
                <div class="preview-document">
                    <h3 class="text-center mb-4">${documentType}</h3>
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong>제목:</strong> ${title}
                        </div>
                        <div class="col-6">
                            <strong>작성일:</strong> ${writeDate}
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-6">
                            <strong>기안자:</strong> ${writer}
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4">
                            <strong>참조</strong>
                            <div>${referrerHtml}</div>
                        </div>
                        <div class="col-4">
                            <strong>검토</strong>
                            <div>${reviewerHtml}</div>
                        </div>
                        <div class="col-4">
                            <strong>승인</strong>
                            <div>${approverHtml}</div>
                        </div>
                    </div>
                    <hr>
                    <div class="document-content">
                        ${content}
                    </div>
                </div>
            `;

            document.getElementById('previewContent').innerHTML = previewHtml;
            $('#previewModal').modal('show');
        }

        // 결재선 HTML 생성
        function generateApprovalListHtml(type) {
            const list = getApprovalList(type);
            if (!list || list.length === 0) {
                return '<div class="text-muted">지정된 인원이 없습니다.</div>';
            }
            
            return list.map(user => {
                const userData = typeof user === 'string' ? JSON.parse(user) : user;
                return `
                    <div class="approval-preview-item mb-2">
                        <div class="d-flex align-items-center">
                            <div>
                                <span class="fw-bold">${userData.empName}</span>
                                <span class="text-muted">(${userData.position})</span>
                                <br>
                                <small class="text-muted">${userData.department}</small>
                            </div>
                        </div>
                    </div>
                `;
            }).join('');
        }

        // 스피너 제어 함수
        function showSpinner() {
            $('#spinner').addClass('show');
        }

        function hideSpinner() {
            $('#spinner').removeClass('show');
            $('.content').addClass('show');
        }

        function submitDocument() {
            const title = document.getElementById('title').value.trim();
            const content = window.editor ? window.editor.getData().trim() : '';
            const documentType = document.getElementById('documentType').value;

            if (!title) {
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            if (!content) {
                alert('내용을 입력해주세요.');
                return;
            }
            if (!documentType) {
                alert('문서 유형을 선택해주세요.');
                document.getElementById('documentType').focus();
                return;
            }
            if (!selectedUsers.approver || selectedUsers.approver.length === 0) {
                alert('최소 1명 이상의 결재자를 지정해야 합니다.');
                return;
            }

            const form = document.getElementById('documentForm');
            const formData = new FormData(form);

            Object.keys(selectedUsers).forEach(type => {
                selectedUsers[type].forEach(user => {
                    formData.append(`${type}List`, JSON.stringify({
                        empId: user.empId,
                        empName: user.empName || user.name,
                        department: user.department,
                        position: user.position || user.job,
                        order: user.order
                    }));
                });
            });

            formData.append('draftDate', new Date().toISOString().split('T')[0]);
            formData.append('approvalStatus', '발송');

            $.ajax({
                url: form.action,
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (response.success) {
                        alert('문서가 성공적으로 등록되었습니다.');
                        localStorage.removeItem('tempDocument');
                        location.href = '${pageContext.request.contextPath}/document/list.do';
                    } else {
                        alert('문서 등록 중 오류가 발생했습니다: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('문서 등록 중 오류가 발생했습니다.');
                    console.error(error);
                }
            });
        }
    </script>
</body>
</html>