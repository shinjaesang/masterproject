package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dto.InOutStatDto;
import java.util.List;
import java.util.Map;

public interface InOutStatService {
    // 날짜별 입출고/재고 집계 리스트 조회
    List<InOutStatDto> getDailyInOutStat(Map<String, Object> params);
} 