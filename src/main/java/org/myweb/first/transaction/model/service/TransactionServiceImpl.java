package org.myweb.first.transaction.model.service;

import java.util.List;
import java.util.Map;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.myweb.first.transaction.model.dao.TransactionDao;
import org.myweb.first.transaction.model.dto.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;


@Service("transactionService")
@Transactional
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private TransactionDao transactionDao;
    
    private static final String API_URL = "https://invoicing.co/api/v1/invoices"; // Invoice Ninja API 엔드포인트
    private static final String API_TOKEN = "YOUR_API_TOKEN"; // 발급받은 API 토큰

    public String getInvoices() throws Exception {
        CloseableHttpClient client = HttpClients.createDefault();
        HttpGet request = new HttpGet(API_URL);
        request.setHeader("X-Ninja-Token", API_TOKEN);
        request.setHeader("Accept", "application/json");

        try (CloseableHttpResponse response = client.execute(request)) {
            String jsonResponse = EntityUtils.toString(response.getEntity());
            return jsonResponse;
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
