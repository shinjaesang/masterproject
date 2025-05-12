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
