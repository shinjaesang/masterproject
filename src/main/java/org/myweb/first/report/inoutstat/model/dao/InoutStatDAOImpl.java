package org.myweb.first.report.inoutstat.model.dao;

import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.inoutstat.model.dto.InoutStatDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatSearchDTO;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Repository
public class InoutStatDAOImpl implements InoutStatDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<InoutStatDTO> selectInoutStatList(InoutStatSearchDTO searchDTO) {
        return sqlSession.selectList("org.myweb.first.report.inoutstat.model.dao.InoutStatDAO.selectInoutStatList", searchDTO);
    }

    @Override
    public List<InoutStatDTO> selectInoutStatChart(InoutStatSearchDTO searchDTO) {
        return sqlSession.selectList("org.myweb.first.report.inoutstat.model.dao.InoutStatDAO.selectInoutStatChart", searchDTO);
    }
} 