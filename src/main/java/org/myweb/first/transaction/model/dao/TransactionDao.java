package org.myweb.first.transaction.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.transaction.model.dto.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("transactionDao")
public class TransactionDao {
    @Autowired
    private SqlSession sqlSession;

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
}
