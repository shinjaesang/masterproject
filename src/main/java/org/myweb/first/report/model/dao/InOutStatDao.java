package org.myweb.first.report.model.dao;

import org.myweb.first.report.model.dto.InOutStatDto;
import java.util.List;
import java.util.Map;

public interface InOutStatDao {
    // 날짜별 입출고/재고 집계 리스트 조회
    List<InOutStatDto> selectDailyInOutStat(Map<String, Object> params);
} 