package org.myweb.first.notice.model.service;

import java.util.List;
import org.myweb.first.notice.model.dao.NoticeDao;
import org.myweb.first.notice.model.dto.Notice;
import org.myweb.first.notice.model.dto.NoticeSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NoticeService {
    @Autowired
    private NoticeDao noticeDao;

    // 공지사항 전체 목록 조회
    public List<Notice> selectAllNotices() {
        return noticeDao.selectAllNotices();
    }

    // 공지사항 상세 조회 (조회수 증가 포함)
    @Transactional
    public Notice selectNoticeById(Long postId) {
        noticeDao.updateViewCount(postId);
        return noticeDao.selectNoticeById(postId);
    }

    // 공지사항 등록
    public int insertNotice(Notice notice) {
        return noticeDao.insertNotice(notice);
    }

    // 공지사항 수정
    public int updateNotice(Notice notice) {
        return noticeDao.updateNotice(notice);
    }

    // 공지사항 삭제
    public int deleteNotice(Long postId) {
        return noticeDao.deleteNotice(postId);
    }

    // 검색 조건에 따른 공지사항 목록 조회
    public List<Notice> searchNotices(NoticeSearchCondition cond) {
        return noticeDao.searchNotices(cond);
    }
} 