package org.myweb.first.report.controller;

import org.myweb.first.report.model.dto.InOutStatDto;
import org.myweb.first.report.model.service.InOutStatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/report/inout")
public class InOutStatController {
    private final InOutStatService inOutStatService;

    @Autowired
    public InOutStatController(InOutStatService inOutStatService) {
        this.inOutStatService = inOutStatService;
    }

    @GetMapping("/data")
    public List<InOutStatDto> getDailyInOutStat(
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate,
            @RequestParam(name = "warehouse", required = false) String warehouse,
            @RequestParam(name = "category", required = false) String category,
            @RequestParam(name = "productName", required = false) String productName
    ) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("warehouse", warehouse);
        params.put("category", category);
        params.put("productName", productName);
        return inOutStatService.getDailyInOutStat(params);
    }
} 