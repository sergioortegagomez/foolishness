package com.foolishness.api;

public class BookForm {

    private String title;
    private String isbn;
    private Integer pages;
    private String author;

    public BookForm() {
    }

    public void setTitle(String aTitle) {
        this.title = aTitle;
    }

    public String getTitle() {
        return title;
    }

    public void setIsbn(String aIsbn) {
        this.isbn = aIsbn;
    }

    public String getIsbn() {
        return this.isbn;
    }

    public void setPages(Integer aPages) {
        this.pages = aPages;
    }

    public Integer getPages() {
        return this.pages;
    }

    public void setAuthor(String aAuthor) {
        this.author = aAuthor;
    }

    public String getAuthor() {
        return this.author;
    }
}