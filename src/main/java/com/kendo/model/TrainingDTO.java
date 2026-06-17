package com.kendo.model;

public class TrainingDTO {

    private int postureNum;
    private int division;
    private int grade;
    private String gName;
    private int fileDiv;
    private String url;

    public TrainingDTO() {
    }

    public int getPostureNum() {
        return postureNum;
    }

    public void setPostureNum(int postureNum) {
        this.postureNum = postureNum;
    }

    public int getDivision() {
        return division;
    }

    public void setDivision(int division) {
        this.division = division;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getgName() {
        return gName;
    }

    public void setgName(String gName) {
        this.gName = gName;
    }

    public int getFileDiv() {
        return fileDiv;
    }

    public void setFileDiv(int fileDiv) {
        this.fileDiv = fileDiv;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}