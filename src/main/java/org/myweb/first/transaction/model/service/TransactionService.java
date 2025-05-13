package org.myweb.first.transaction.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.transaction.model.dto.Transaction;
import org.myweb.first.transaction.model.dto.TransactionInvoice;

public interface TransactionService {
    // 거래문서 목록 조회
    List<Transaction> selectTransactionList(Map<String, Object> paramMap);
    
    // 거래문서 상세 조회
    Transaction selectTransactionDetail(String docNo);
    
    // 거래문서 등록
    int insertTransaction(Transaction transaction);
    
    // 거래문서 수정
    int updateTransaction(Transaction transaction);
    
    // 거래문서 삭제
    int deleteTransaction(String tdocId);
    
    // 거래문서 일괄 삭제
    int deleteTransactions(List<String> tdocIdList);
    
    // invoice ninja
    List<TransactionInvoice> getInvoiceList() throws Exception;

}
