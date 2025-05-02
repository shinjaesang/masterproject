<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>해외 세금계산서 상세보기 - Stockmaster</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="재고관리 ERP 시스템" name="keywords">
    <meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

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
</head>
<body>
    <div class="container-fluid p-4">
        <div class="bg-light rounded p-4">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h5 class="mb-0">해외 세금계산서 상세보기</h5>
                <button type="button" class="btn-close" onclick="window.close()"></button>
            </div>

            <!-- 기본 정보 -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label">Invoice 번호</label>
                        <input type="text" class="form-control" value="${invoice.invoiceNo}" readonly>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label">발행일자</label>
                        <input type="text" class="form-control" value="<fmt:formatDate value="${invoice.issueDate}" pattern="yyyy-MM-dd"/>" readonly>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label">상태</label>
                        <input type="text" class="form-control" value="${invoice.status == 'ISSUED' ? '발행 완료' : '결제 완료'}" readonly>
                    </div>
                </div>
            </div>

            <!-- 공급자 정보 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">공급자 정보</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">회사명</label>
                                <input type="text" class="form-control" value="${invoice.supplier.companyName}" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">주소</label>
                                <input type="text" class="form-control" value="${invoice.supplier.address}" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">연락처</label>
                                <input type="text" class="form-control" value="${invoice.supplier.contact}" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 고객 정보 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">고객 정보</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">회사명</label>
                                <input type="text" class="form-control" value="${invoice.customer.companyName}" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">주소</label>
                                <input type="text" class="form-control" value="${invoice.customer.address}" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">연락처</label>
                                <input type="text" class="form-control" value="${invoice.customer.contact}" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 거래내역 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">거래내역</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>품목명</th>
                                    <th>규격</th>
                                    <th>수량</th>
                                    <th>단가</th>
                                    <th>금액</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${invoice.items}" var="item">
                                    <tr>
                                        <td>${item.itemName}</td>
                                        <td>${item.specification}</td>
                                        <td class="text-end">${item.quantity}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,###.00"/>
                                            ${invoice.currency}
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${item.amount}" pattern="#,###.00"/>
                                            ${invoice.currency}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>총합계</strong></td>
                                    <td class="text-end">
                                        <strong>
                                            <fmt:formatNumber value="${invoice.totalAmount}" pattern="#,###.00"/>
                                            ${invoice.currency}
                                        </strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 세금정보 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">세금정보</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">VAT 부과 여부</label>
                                <input type="text" class="form-control" value="${invoice.vatIncluded ? '부과' : '미부과'}" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">세율</label>
                                <input type="text" class="form-control" value="${invoice.vatRate}%" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 통관정보 (수입일 경우) -->
            <c:if test="${invoice.type == 'IMPORT'}">
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">통관정보</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">통관일자</label>
                                <input type="text" class="form-control" value="<fmt:formatDate value="${invoice.customsDate}" pattern="yyyy-MM-dd"/>" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">수입신고번호</label>
                                <input type="text" class="form-control" value="${invoice.customsNo}" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>

            <!-- 결제조건 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">결제조건</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label">Payment Terms</label>
                                <input type="text" class="form-control" value="${invoice.payment.terms}" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label">결제방식</label>
                                <input type="text" class="form-control" value="${invoice.payment.method}" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label">결제기한</label>
                                <input type="text" class="form-control" value="<fmt:formatDate value="${invoice.payment.dueDate}" pattern="yyyy-MM-dd"/>" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 첨부파일 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">첨부파일</h6>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <c:forEach items="${invoice.attachments}" var="file">
                            <a href="${pageContext.request.contextPath}/download.do?fileId=${file.fileId}" 
                               class="list-group-item list-group-item-action">
                                <i class="fas fa-file me-2"></i>${file.fileName}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- 비고 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">비고</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="form-label">비고/메모</label>
                                <textarea class="form-control" rows="3" readonly>${invoice.memo}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="form-label">추가 비고</label>
                                <textarea class="form-control" rows="3" readonly>${invoice.additionalMemo}</textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 