package org.myweb.first.notices.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class NoticesController {
    
    // 공지사항 목록 페이지
    @RequestMapping(value = "notices.do", method = RequestMethod.GET)
    public String listNotices(Model model) {
        return "notices/notices";
    }
    
    // 공지사항 작성 페이지로 이동
    @RequestMapping(value = "noticeswrite.do", method = RequestMethod.GET)
    public String noticesWriteForm() {
        return "notices/noticeswrite";
    }
    
    // 공지사항 저장 처리
    @RequestMapping(value = "noticeswrite.do", method = RequestMethod.POST)
    public String noticesWrite(HttpSession session) {
        return "redirect:notices.do";
    }
    
    // 공지사항 상세 보기
    @RequestMapping(value = "noticesView.do", method = RequestMethod.GET)
    public String viewNotice(@RequestParam("noticeId") Long noticeId, Model model) {
        return "notices/view";
    }
    
    // 공지사항 수정 페이지
    @RequestMapping(value = "noticesEdit.do", method = RequestMethod.GET)
    public String editNoticeForm(@RequestParam("noticeId") Long noticeId,
                               HttpSession session) {
        return "notices/edit";
    }
    
    // 공지사항 수정
    @RequestMapping(value = "noticesEdit.do", method = RequestMethod.POST)
    public String editNotice(@RequestParam("noticeId") Long noticeId,
                           HttpSession session) {
        return "redirect:notices.do";
    }
    
    // 공지사항 삭제
    @RequestMapping(value = "noticesDelete.do", method = RequestMethod.POST)
    public String deleteNotice(@RequestParam("noticeId") Long noticeId,
                             HttpSession session) {
        return "redirect:notices.do";
    }
} 