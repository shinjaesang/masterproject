package org.myweb.first.notice.model.dto;

public class NoticeSearchCondition {
    private String title;
    private String author;
    private String startDate;
    private String endDate;

    public NoticeSearchCondition() {}

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "NoticeSearchCondition [title=" + title + ", author=" + author + ", startDate=" + startDate + ", endDate="
                + endDate + "]";
    }
} 