package org.myweb.first.report.inoutstat.model.service;

import java.util.List;

import org.myweb.first.report.inoutstat.model.dto.InoutStatChartDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatSearchDTO;

public interface InoutStatService {
    
    /**
     * 입출고 통계 데이터를 조회합니다.
     * @param searchDTO 검색 조건
     * @return 입출고 통계 데이터 목록
     */
    List<InoutStatDTO> getInoutStatList(InoutStatSearchDTO searchDTO);
    
    /**
     * 입출고 통계 차트 데이터를 조회합니다.
     * @param searchDTO 검색 조건
     * @return 차트 데이터
     */
    InoutStatChartDTO getInoutStatChart(InoutStatSearchDTO searchDTO);
} 