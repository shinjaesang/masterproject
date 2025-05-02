package org.myweb.first.notice.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.myweb.first.notice.model.dto.Notice;
import org.myweb.first.notice.model.dto.NoticeSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDao {
    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "noticeMapper.";

    // 공지사항 전체 목록 조회
    public List<Notice> selectAllNotices() {
        return sqlSession.selectList(NAMESPACE + "selectAllNotices");
    }

    // 공지사항 상세 조회
    public Notice selectNoticeById(Long postId) {
        return sqlSession.selectOne(NAMESPACE + "selectNoticeById", postId);
    }

    // 공지사항 등록
    public int insertNotice(Notice notice) {
        return sqlSession.insert(NAMESPACE + "insertNotice", notice);
    }

    // 공지사항 수정
    public int updateNotice(Notice notice) {
        return sqlSession.update(NAMESPACE + "updateNotice", notice);
    }

    // 공지사항 삭제
    public int deleteNotice(Long postId) {
        return sqlSession.delete(NAMESPACE + "deleteNotice", postId);
    }

    // 조회수 증가
    public int updateViewCount(Long postId) {
        return sqlSession.update(NAMESPACE + "updateViewCount", postId);
    }

    // 검색 조건에 따른 공지사항 목록 조회
    public List<Notice> searchNotices(NoticeSearchCondition cond) {
        return sqlSession.selectList(NAMESPACE + "searchNotices", cond);
    }
} 