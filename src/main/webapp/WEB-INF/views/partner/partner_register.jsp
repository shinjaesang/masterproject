<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 거래처 등록</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .register-title { font-size: 2rem; font-weight: bold; margin-bottom: 2rem; }
        .form-label { font-weight: 500; }
        .form-section { margin-bottom: 1.5rem; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-gray { background: #f8f9fa; color: #111; border: 1px solid #bbb; }
        .btn-gray:hover { background: #e9ecef; color: #111; }
        .file-upload-box {
            border: 2px dashed #bbb;
            border-radius: 6px;
            padding: 2rem 1rem;
            text-align: center;
            color: #888;
            background: #fafafa;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <!-- Sidebar Start -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
    <!-- Sidebar End -->
    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
        <!-- Navbar End -->
        <div class="container-fluid pt-4 px-4">
            <div class="register-title">거래처 등록</div>
            <form method="post" enctype="multipart/form-data" action="#">
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="form-section">
                            <label class="form-label">거래처명</label>
                            <input type="text" class="form-control" name="partnerName" placeholder="판매처명을 입력하세요" required>
                        </div>
                        <div class="form-section">
                            <label class="form-label">담당자</label>
                            <input type="text" class="form-control" name="manager" placeholder="담당자명을 입력하세요">
                        </div>
                        <div class="form-section">
                            <label class="form-label">이메일</label>
                            <input type="email" class="form-control" name="email" placeholder="example@email.com">
                        </div>
                        <div class="form-section">
                            <label class="form-label">주소</label>
                            <div class="d-flex mb-2 gap-2">
                                <input type="text" class="form-control" name="zipcode" placeholder="우편번호" style="max-width: 50%;">
                                <button type="button" class="btn btn-gray">주소 검색</button>
                            </div>
                            <input type="text" class="form-control mb-2" name="address1" placeholder="기본주소">
                            <input type="text" class="form-control" name="address2" placeholder="상세주소">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-section">
                            <label class="form-label">사업자 등록번호</label>
                            <input type="text" class="form-control" name="bizNo" placeholder="000-00-00000">
                        </div>
                        <div class="form-section">
                            <label class="form-label">연락처</label>
                            <input type="text" class="form-control" name="phone" placeholder="000-0000-0000">
                        </div>
                        <div class="form-section">
                            <label class="form-label">지역</label>
                            <select class="form-select" name="region">
                                <option value="">지역 선택</option>
                                <option>서울</option>
                                <option>경기</option>
                                <option>인천</option>
                                <option>부산</option>
                                <option>대구</option>
                                <option>광주</option>
                                <option>대전</option>
                                <option>울산</option>
                                <option>기타</option>
                            </select>
                        </div>
                        <div class="form-section">
                            <label class="form-label">거래처 유형</label>
                            <select class="form-select" name="partnerType" required>
                                <option value="">유형 선택</option>
                                <option>공급처</option>
                                <option>판매처</option>
                            </select>
                        </div>
                        <div class="form-section">
                            <label class="form-label">계약서 및 첨부파일</label>
                            <div class="file-upload-box mb-2">
                                파일 업로드 또는 끌어서 놓기<br>
                                <span style="font-size:0.95em; color:#aaa;">PDF, PNG, JPG 최대 10MB</span>
                                <input type="file" class="form-control mt-2" name="attachFile" accept=".pdf,.png,.jpg,.jpeg">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-gray px-4">취소</button>
                    <button type="submit" class="btn btn-black px-4">등록</button>
                </div>
            </form>
        </div>
    </div>
    <!-- Content End -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html> 