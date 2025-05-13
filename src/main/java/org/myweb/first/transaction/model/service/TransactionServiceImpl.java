package org.myweb.first.transaction.model.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.myweb.first.transaction.model.dao.TransactionDao;
import org.myweb.first.transaction.model.dto.Transaction;
import org.myweb.first.transaction.model.dto.TransactionInvoice;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;


@Service("transactionService")
@Transactional
public class TransactionServiceImpl implements TransactionService {
	private static final Logger logger = LoggerFactory.getLogger(TransactionServiceImpl.class);
	
	@Autowired
    private TransactionDao transactionDao;


    @Override
    public List<TransactionInvoice> getInvoiceList() throws Exception {
        logger.info("getInvoiceList 호출");
        try {
            return transactionDao.selectInvoiceList();
        } catch (Exception e) {
            logger.error("세금계산서 목록 조회 중 오류: {}", e.getMessage());
            throw new Exception("Failed to fetch invoices", e);
        }
    }

//    설명:
//    	* API_URL: Invoice Ninja의 송장 목록 API 엔드포인트.
//    	* API_TOKEN: Invoice Ninja에서 발급받은 토큰.
//    	* HttpGet: GET 요청으로 송장 목록을 가져옴.
//    	* Jackson은 JSON을 Java 객체로 변환할 때 사용 (필요 시 추가 구현).

    

    @Override
    public List<Transaction> selectTransactionList(Map<String, Object> paramMap) {
        return transactionDao.selectTransactionList(paramMap);
    }

    @Override
    public Transaction selectTransactionDetail(String docNo) {
        return transactionDao.selectTransactionDetail(docNo);
    }

    @Override
    public int insertTransaction(Transaction transaction) {
        return transactionDao.insertTransaction(transaction);
    }

    @Override
    public int deleteTransactions(List<String> tdocIdList) {
        return transactionDao.deleteTransactions(tdocIdList);
    }

    @Override
    public int updateTransaction(Transaction transaction) {
        return transactionDao.updateTransaction(transaction);
    }

    @Override
    public int deleteTransaction(String tdocId) {
        return transactionDao.deleteTransaction(tdocId);
    }
}
