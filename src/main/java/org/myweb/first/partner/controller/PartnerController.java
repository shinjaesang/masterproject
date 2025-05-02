package org.myweb.first.partner.controller;

import java.util.List;

import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;
import org.myweb.first.partner.model.service.PartnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/partner")
public class PartnerController {
    private static final Logger logger = LoggerFactory.getLogger(PartnerController.class);

    @Autowired
    private PartnerService partnerService;

    // 거래처 목록 페이지
    @GetMapping("/partner.do")
    public String partnerList() {
        return "partner/partner";
    }

    // 거래처 등록 페이지
    @GetMapping("/register.do")
    public String partnerRegister() {
        return "partner/register";
    }

    // 거래처 수정 페이지
    @GetMapping("/edit.do")
    public String partnerEdit() {
        return "partner/edit";
    }

    // 거래처 목록 조회 (AJAX)
    @GetMapping("/list")
    @ResponseBody
    public List<Partner> getPartnerList(PartnerSearchCondition cond) {
        logger.info("=== 거래처 목록 조회 시작 ===");
        logger.info("검색 조건: {}", cond);
        
        List<Partner> result;
        if ((cond.getPartnerName() == null || cond.getPartnerName().isEmpty()) &&
            (cond.getPartnerType() == null || cond.getPartnerType().isEmpty()) &&
            (cond.getBusinessRegNo() == null || cond.getBusinessRegNo().isEmpty()) &&
            (cond.getManagerName() == null || cond.getManagerName().isEmpty()) &&
            (cond.getContactInfo() == null || cond.getContactInfo().isEmpty()) &&
            (cond.getTransactionStatus() == null || cond.getTransactionStatus().isEmpty())) {
            logger.info("전체 목록 조회");
            result = partnerService.selectAllPartners();
        } else {
            logger.info("검색 조건으로 조회");
            result = partnerService.searchPartners(cond);
        }
        
        logger.info("조회 결과: {}", result);
        logger.info("=== 거래처 목록 조회 종료 ===");
        return result;
    }

    // 거래처 상세 조회 (AJAX)
    @GetMapping("/{partnerId}")
    @ResponseBody
    public Partner getPartner(@PathVariable("partnerId") String partnerId) {
        logger.info("거래처 상세 조회: {}", partnerId);
        return partnerService.selectPartnerById(partnerId);
    }

    // 거래처 등록 (AJAX)
    @PostMapping("/add")
    @ResponseBody
    public int addPartner(@RequestBody Partner partner) {
        logger.info("거래처 등록: {}", partner);
        return partnerService.insertPartner(partner);
    }

    // 거래처 수정 (AJAX)
    @PutMapping("/update")
    @ResponseBody
    public int updatePartner(@RequestBody Partner partner) {
        logger.info("거래처 수정: {}", partner);
        return partnerService.updatePartner(partner);
    }

    // 거래처 삭제 (AJAX)
    @DeleteMapping("/delete/{partnerId}")
    @ResponseBody
    public int deletePartner(@PathVariable("partnerId") String partnerId) {
        logger.info("거래처 삭제: {}", partnerId);
        return partnerService.deletePartner(partnerId);
    }
} 