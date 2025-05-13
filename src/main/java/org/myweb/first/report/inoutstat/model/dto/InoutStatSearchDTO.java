package org.myweb.first.report.inoutstat.model.dto;

import java.time.LocalDate;

public class InoutStatSearchDTO {
    private LocalDate startDate;     // 시작일
    private LocalDate endDate;       // 종료일
    private String category;         // 카테고리
    private String sort;             // 정렬 기준 (날짜순, 입고량순, 출고량순)

    // Getters and Setters
    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }
} 