package org.myweb.first.notice.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import org.myweb.first.notice.model.dto.Notice;
import org.myweb.first.notice.model.dto.NoticeSearchCondition;
import org.myweb.first.notice.model.service.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
    
    @Autowired
    private NoticeService noticeService;
    
    // 공지사항 목록 페이지
    @GetMapping("/list.do")
    public String listNotices() {
        return "notice/notice";
    }
    
    // 공지사항 목록 데이터 (AJAX)
    @GetMapping("/list")
    @ResponseBody
    public List<Notice> getNoticeList(NoticeSearchCondition cond) {
        logger.info("=== 공지사항 목록 조회 시작 ===");
        logger.info("검색 조건: {}", cond);
        List<Notice> result;
        if ((cond.getTitle() == null || cond.getTitle().isEmpty()) &&
            (cond.getAuthor() == null || cond.getAuthor().isEmpty()) &&
            (cond.getStartDate() == null || cond.getStartDate().isEmpty()) &&
            (cond.getEndDate() == null || cond.getEndDate().isEmpty())) {
            logger.info("전체 목록 조회");
            result = noticeService.selectAllNotices();
        } else {
            logger.info("검색 조건으로 조회");
            result = noticeService.searchNotices(cond);
        }
        logger.info("조회 결과: {}", result);
        logger.info("=== 공지사항 목록 조회 종료 ===");
        return result;
    }
    
    // 공지사항 상세 조회
    @GetMapping("/view.do")
    public String viewNotice(@RequestParam(value = "postId", required = true) Long postId, Model model) {
        logger.info("=== 공지사항 상세 조회 시작 ===");
        logger.info("postId: {}", postId);
        Notice notice = noticeService.selectNoticeById(postId);
        logger.info("조회된 공지사항: {}", notice);
        model.addAttribute("notice", notice);
        logger.info("=== 공지사항 상세 조회 종료 ===");
        return "notice/noticeView";
    }
    
    // 공지사항 작성 페이지
    @GetMapping("/write.do")
    public String writeNoticeForm() {
        return "notice/noticeWrite";
    }
    
    // 공지사항 등록
    @PostMapping("/write.do")
    public String writeNotice(@ModelAttribute Notice notice, HttpSession session) {
        logger.info("=== 공지사항 등록 시작 ===");
        logger.info("입력된 공지사항: {}", notice);
        
        // 세션에서 로그인한 사용자 정보 가져오기
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser != null) {
            try {
                // loginUser 객체에서 empId를 가져오기
                java.lang.reflect.Method getEmpId = loginUser.getClass().getMethod("getEmpId");
                String empId = (String) getEmpId.invoke(loginUser);
                notice.setAuthor(empId);
                logger.info("작성자 ID: {}", empId);
            } catch (Exception e) {
                logger.error("작성자 정보를 가져오는 중 오류 발생", e);
                return "redirect:/member/login.do";
            }
        } else {
            logger.warn("로그인 정보가 없습니다.");
            return "redirect:/member/login.do";
        }
        
        int result = noticeService.insertNotice(notice);
        logger.info("등록 결과: {}", result);
        logger.info("=== 공지사항 등록 종료 ===");
        return "redirect:/notice/list.do";
    }
    
    // 공지사항 수정 페이지
    @GetMapping("/edit.do")
    public String editNoticeForm(@RequestParam(value = "postId", required = true) Long postId, Model model) {
        Notice notice = noticeService.selectNoticeById(postId);
        model.addAttribute("notice", notice);
        return "notice/noticeEdit";
    }
    
    // 공지사항 수정
    @PostMapping("/edit.do")
    @ResponseBody
    public String editNotice(@ModelAttribute Notice notice, 
                           @RequestParam(value = "file", required = false) MultipartFile file,
                           @RequestParam(value = "deleteFile", required = false) Boolean deleteFile) {
        logger.info("=== 공지사항 수정 시작 ===");
        logger.info("수정할 공지사항: {}", notice);
        logger.info("첨부파일: {}", file != null ? file.getOriginalFilename() : "없음");
        logger.info("첨부파일 삭제 여부: {}", deleteFile);
        
        try {
            // 첨부파일 삭제 체크박스가 선택된 경우
            if (deleteFile != null && deleteFile) {
                notice.setAttachedFile(null);
                notice.setAttachedFileName(null);
                logger.info("첨부파일 삭제 처리");
            }
            // 새로운 파일이 업로드된 경우
            else if (file != null && !file.isEmpty()) {
                notice.setAttachedFile(file.getBytes());
                notice.setAttachedFileName(file.getOriginalFilename());
                logger.info("새 첨부파일 저장: {}", file.getOriginalFilename());
            }
            
            int result = noticeService.updateNotice(notice);
            logger.info("수정 결과: {}", result);
            
            if (result > 0) {
                logger.info("=== 공지사항 수정 성공 ===");
                return "success";
            } else {
                logger.error("=== 공지사항 수정 실패 ===");
                return "fail";
            }
        } catch (Exception e) {
            logger.error("공지사항 수정 중 오류 발생", e);
            return "error";
        }
    }
    
    // 공지사항 삭제
    @DeleteMapping("/delete/{postId}")
    @ResponseBody
    public int deleteNotice(@PathVariable(value = "postId") Long postId) {
        return noticeService.deleteNotice(postId);
    }
    
    // 첨부파일 다운로드
    @GetMapping("/download/{postId}")
    public ResponseEntity<byte[]> downloadFile(@PathVariable(value = "postId") Long postId) {
        logger.info("=== 첨부파일 다운로드 시작 ===");
        logger.info("postId: {}", postId);
        
        try {
            Notice notice = noticeService.selectNoticeById(postId);
            if (notice == null || notice.getAttachedFile() == null) {
                logger.warn("첨부파일이 존재하지 않습니다.");
                return ResponseEntity.notFound().build();
            }
            
            // 파일 이름과 확장자 추출
            String fileName = notice.getAttachedFileName();
            if (fileName == null || fileName.isEmpty()) {
                fileName = "notice_attachment";
            }
            
            // 파일 이름 인코딩 처리
            try {
                fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
            } catch (UnsupportedEncodingException e) {
                logger.error("파일 이름 인코딩 처리 중 오류 발생", e);
                fileName = "notice_attachment";
            }
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", fileName);
            
            logger.info("다운로드 파일명: {}", fileName);
            logger.info("=== 첨부파일 다운로드 종료 ===");
            
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(notice.getAttachedFile());
                    
        } catch (Exception e) {
            logger.error("파일 다운로드 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
} 