package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dao.InOutStatDao;
import org.myweb.first.report.model.dto.InOutStatDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class InOutStatServiceImpl implements InOutStatService {
    private final InOutStatDao inOutStatDao;

    @Autowired
    public InOutStatServiceImpl(InOutStatDao inOutStatDao) {
        this.inOutStatDao = inOutStatDao;
    }

    @Override
    public List<InOutStatDto> getDailyInOutStat(Map<String, Object> params) {
        return inOutStatDao.selectDailyInOutStat(params);
    }
} 