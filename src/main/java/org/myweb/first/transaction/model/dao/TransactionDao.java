package org.myweb.first.transaction.model.dao;

import java.io.File;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.transaction.model.dto.Transaction;
import org.myweb.first.transaction.model.dto.TransactionInvoice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;

@Repository("transactionDao")
public class TransactionDao {
    @Autowired
    private SqlSession sqlSession;
    
    private static final Logger logger = LoggerFactory.getLogger(TransactionDao.class);

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    private final String invoiceNinjaApiUrl = "https://invoicing.co/api/v1/invoices";
    private final String apiToken = "B6miqPRE13GCyMSw5UfgMOfgKKyE8glgEeIMBXgwVLPzzc9hIXy5yieoHLgS1Wig"; // 실제 토큰으로 교체
    private final File invoiceFile = new File("invoices.json");
    
    public TransactionDao() {
        this.restTemplate = new RestTemplate();
        this.objectMapper = new ObjectMapper();
    }
    
    // invoice ninja
    public List<TransactionInvoice> selectInvoiceList() throws Exception {
        logger.info("Invoice Ninja API 호출 시작: {}", invoiceNinjaApiUrl);
        try {
            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("X-API-Token", apiToken);
            headers.set("X-Requested-With", "XMLHttpRequest");
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // API 호출
            ResponseEntity<String> response = restTemplate.exchange(
                invoiceNinjaApiUrl,
                HttpMethod.GET,
                entity,
                String.class
            );

//            // JSON 파싱
//            Map<String, Object> responseBody = objectMapper.readValue(response.getBody(), Map.class);
//            List<Map<String, Object>> invoiceData = (List<Map<String, Object>>) responseBody.get("data");
//
//            // JSON 데이터를 TransactionInvoice 객체로 변환
//            List<TransactionInvoice> invoices = invoiceData.stream().map(data -> {
//                try {
//                    String uploaderName = data.containsKey("user_id") ? (String) data.get("user_id") : "Unknown";
//                    String statusId = data.get("status_id") != null ? String.valueOf(data.get("status_id")) : "unknown";
//                    String status = switch (statusId) {
//                        case "1" -> "draft";
//                        case "2" -> "sent";
//                        case "3" -> "viewed";
//                        default -> "unknown";
//                    };
            
         // 디버깅: 원본 API 응답 출력
            logger.debug("API 원본 응답: {}", response.getBody());

            Map<String, Object> responseBody = objectMapper.readValue(response.getBody(), Map.class);
            List<Map<String, Object>> invoiceData = (List<Map<String, Object>>) responseBody.get("data");

            if (invoiceData == null || invoiceData.isEmpty()) {
                logger.warn("Invoice Ninja API 응답 데이터가 비어있습니다.");
                return Collections.emptyList();
            }

            List<TransactionInvoice> invoices = invoiceData.stream().map(data -> {
                try {
                    String uploaderName = data.containsKey("user_id") ? (String) data.get("user_id") : "Unknown";
                    String statusId = data.get("status_id") != null ? String.valueOf(data.get("status_id")) : "unknown";
                    String status = switch (statusId) {
                        case "1" -> "draft";
                        case "2" -> "sent";
                        case "3" -> "viewed";
                        default -> "unknown";
                    };

                    return new TransactionInvoice(
                        data.get("id") != null ? (String) data.get("id") : "",
                        data.get("number") != null ? (String) data.get("number") : "",
                        "TAX",
                        data.get("client_id") != null ? (String) data.get("client_id") : "",
                        uploaderName,
                        status,
                        data.get("date") != null ? (String) data.get("date") : ""
                    );
                } catch (Exception e) {
                    logger.warn("Invoice 데이터 변환 중 오류: {}", data, e);
                    return null;
                }
            }).filter(invoice -> invoice != null).collect(Collectors.toList());

            logger.info("Invoice Ninja API 호출 성공, 조회된 데이터 수: {}", invoices.size());
            return invoices;
        } catch (Exception e) {
            logger.error("Invoice Ninja API 호출 실패: {}", e.getMessage());
            throw new Exception("Failed to fetch invoices from Invoice Ninja", e);
        }
    }
    
    public void syncInvoices() throws Exception {
        selectInvoiceList(); // API 호출 및 JSON 파일 저장
    }
    
    

    // 거래문서 목록 조회
    public List<Transaction> selectTransactionList(Map<String, Object> paramMap) {
        return sqlSession.selectList("org.myweb.first.transaction.model.dao.TransactionDao.selectTransactionList", paramMap);
    }
    
    // 거래문서 상세 조회
    public Transaction selectTransactionDetail(String docNo) {
        return sqlSession.selectOne("org.myweb.first.transaction.model.dao.TransactionDao.selectTransactionDetail", docNo);
    }
    
    public int insertTransaction(Transaction transaction) {
        return sqlSession.insert("org.myweb.first.transaction.model.dao.TransactionDao.insertTransaction", transaction);
    }

    public int updateTransaction(Transaction transaction) {
        return sqlSession.update("org.myweb.first.transaction.model.dao.TransactionDao.updateTransaction", transaction);
    }

    public int deleteTransaction(String tdocId) {
        return sqlSession.delete("org.myweb.first.transaction.model.dao.TransactionDao.deleteTransaction", tdocId);
    }

    // 거래문서 일괄 삭제
    public int deleteTransactions(List<String> tdocIdList) {
        return sqlSession.delete("org.myweb.first.transaction.model.dao.TransactionDao.deleteTransactions", tdocIdList);
    }
}
