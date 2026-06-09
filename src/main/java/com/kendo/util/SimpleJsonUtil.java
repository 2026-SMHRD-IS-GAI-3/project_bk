package com.kendo.util;

/*
 * 간단한 JSON 문자열 생성 유틸
 * 외부 JSON 라이브러리 없이 결과를 문자열로 만들 때 사용한다.
 */
public class SimpleJsonUtil {

    public static String makeResultJson(String result) {
        return "{\"result\":\"" + result + "\"}";
    }
}
