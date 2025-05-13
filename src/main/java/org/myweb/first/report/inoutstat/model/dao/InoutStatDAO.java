package org.myweb.first.report.inoutstat.model.dao;

import java.util.List;

import org.myweb.first.report.inoutstat.model.dto.InoutStatDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatSearchDTO;

public interface InoutStatDAO {
    
    /**
     * 입출고 통계 데이터를 조회합니다.
     * @param searchDTO 검색 조건
     * @return 입출고 통계 데이터 목록
     */
    List<InoutStatDTO> selectInoutStatList(InoutStatSearchDTO searchDTO);
    
    /**
     * 입출고 통계 차트 데이터를 조회합니다.
     * @param searchDTO 검색 조건
     * @return 입출고 통계 데이터 목록
     */
    List<InoutStatDTO> selectInoutStatChart(InoutStatSearchDTO searchDTO);
} 