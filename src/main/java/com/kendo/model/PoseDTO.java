package com.kendo.model;
import java.util.Map;
/*
 * 자세 분석 결과를 임시로 담는 DTO
 * 현재 DB에는 자세 분석 테이블이 없으므로 DB 저장용이 아니라 화면/분석 결과 전달용으로 사용한다.
 */
public class PoseDTO {

	public class AiRequest {
	    private String mode;
	    private String image; // base64

	    public String getMode() { return mode; }
	    public void setMode(String mode) { this.mode = mode; }

	    public String getImage() { return image; }
	    public void setImage(String image) { this.image = image; }
	    
	}
}
