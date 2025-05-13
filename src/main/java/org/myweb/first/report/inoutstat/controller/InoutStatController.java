package org.myweb.first.report.inoutstat.controller;

import org.myweb.first.report.inoutstat.model.dto.InoutStatChartDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatDTO;
import org.myweb.first.report.inoutstat.model.dto.InoutStatSearchDTO;
import org.myweb.first.report.inoutstat.model.service.InoutStatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/report/inout")
public class InoutStatController {

    @Autowired
    private InoutStatService inoutStatService;

    /**
     * 입출고 통계 페이지를 표시합니다.
     */
    @GetMapping("/stat.do")
    public String inoutStatPage() {
        return "report/inout";
    }

    /**
     * 입출고 통계 데이터를 조회합니다.
     */
    @GetMapping("/data")
    @ResponseBody
    public List<InoutStatDTO> getInoutStatList(
            @RequestParam(name = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(name = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            @RequestParam(name = "category", required = false) String category,
            @RequestParam(name = "sort", required = false) String sort) {
        
        System.out.println("요청 받은 데이터 - 시작일: " + startDate + ", 종료일: " + endDate + ", 카테고리: " + category + ", 정렬: " + sort);
        
        InoutStatSearchDTO searchDTO = new InoutStatSearchDTO();
        searchDTO.setStartDate(startDate);
        searchDTO.setEndDate(endDate);
        searchDTO.setCategory(category);
        searchDTO.setSort(sort);

        try {
            List<InoutStatDTO> result = inoutStatService.getInoutStatList(searchDTO);
            System.out.println("조회된 데이터 수: " + (result != null ? result.size() : 0));
            if (result != null && !result.isEmpty()) {
                System.out.println("첫 번째 데이터 샘플: " + result.get(0).getStat_date() + ", 입고량: " + result.get(0).getInAmount());
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    /**
     * 입출고 통계 차트 데이터를 조회합니다.
     */
    @GetMapping("/chart")
    @ResponseBody
    public InoutStatChartDTO getInoutStatChart(
            @RequestParam(name = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(name = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            @RequestParam(name = "category", required = false) String category,
            @RequestParam(name = "sort", required = false) String sort) {
        
        InoutStatSearchDTO searchDTO = new InoutStatSearchDTO();
        searchDTO.setStartDate(startDate);
        searchDTO.setEndDate(endDate);
        searchDTO.setCategory(category);
        searchDTO.setSort(sort);

        try {
            return inoutStatService.getInoutStatChart(searchDTO);
        } catch (Exception e) {
            e.printStackTrace();
            InoutStatChartDTO emptyChart = new InoutStatChartDTO();
            emptyChart.setLabels(List.of());
            emptyChart.setInData(List.of());
            emptyChart.setOutData(List.of());
            emptyChart.setStockData(List.of());
            return emptyChart;
        }
    }
} 