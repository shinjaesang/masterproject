package org.myweb.first.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.model.dto.InOutStatDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class InOutStatDaoImpl implements InOutStatDao {
    private final SqlSession sqlSession;

    @Autowired
    public InOutStatDaoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<InOutStatDto> selectDailyInOutStat(Map<String, Object> params) {
        return sqlSession.selectList("inOutStatMapper.selectDailyInOutStat", params);
    }
} 