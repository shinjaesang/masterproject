package org.myweb.first.notice.model.dto;

import java.io.Serializable;
import java.util.Date;

public class Notice implements Serializable {
    private Long postId;
    private String title;
    private String content;
    private String author;
    private Date createdAt;
    private Integer viewCount;
    private byte[] attachedFile;
    private String attachedFileName; // 첨부파일 원본 이름
    private String authorName; // TB_USER 테이블과 조인하여 가져올 작성자 이름

    public Notice() {}

    public Long getPostId() { return postId; }
    public void setPostId(Long postId) { this.postId = postId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    
    public byte[] getAttachedFile() { return attachedFile; }
    public void setAttachedFile(byte[] attachedFile) { this.attachedFile = attachedFile; }
    
    public String getAttachedFileName() { return attachedFileName; }
    public void setAttachedFileName(String attachedFileName) { this.attachedFileName = attachedFileName; }
    
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
} 