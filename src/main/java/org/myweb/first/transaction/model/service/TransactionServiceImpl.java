package org.myweb.first.transaction.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.transaction.model.dao.TransactionDao;
import org.myweb.first.transaction.model.dto.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("transactionService")
@Transactional
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private TransactionDao transactionDao;

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
}
