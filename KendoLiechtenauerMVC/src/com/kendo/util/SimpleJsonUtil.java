package com.kendo.util;

/*
 * SimpleJsonUtil 클래스
 * ---------------------------------------
 * 외부 JSON 라이브러리를 추가하지 않고도
 * Python Flask 서버가 보내준 간단한 JSON 문자열에서
 * 필요한 값을 꺼내기 위한 유틸 클래스이다.
 *
 * 실무에서는 Gson, Jackson 같은 라이브러리를 쓰는 것이 더 좋다.
 * 수업/과제용으로 라이브러리 충돌을 줄이기 위해 간단하게 만들었다.
 */
public class SimpleJsonUtil {

    // JSON 문자열에서 문자열 값을 꺼내는 메서드
    public static String getString(String json, String key) {
        String findKey = "\"" + key + "\"";
        int keyIndex = json.indexOf(findKey);

        if (keyIndex == -1) {
            return "";
        }

        int colonIndex = json.indexOf(":", keyIndex);
        int firstQuote = json.indexOf("\"", colonIndex + 1);
        int secondQuote = json.indexOf("\"", firstQuote + 1);

        if (colonIndex == -1 || firstQuote == -1 || secondQuote == -1) {
            return "";
        }

        return json.substring(firstQuote + 1, secondQuote);
    }

    // JSON 문자열에서 double 값을 꺼내는 메서드
    public static double getDouble(String json, String key) {
        String findKey = "\"" + key + "\"";
        int keyIndex = json.indexOf(findKey);

        if (keyIndex == -1) {
            return 0;
        }

        int colonIndex = json.indexOf(":", keyIndex);
        int commaIndex = json.indexOf(",", colonIndex + 1);
        int endBraceIndex = json.indexOf("}", colonIndex + 1);

        int endIndex;
        if (commaIndex == -1) {
            endIndex = endBraceIndex;
        } else if (endBraceIndex == -1) {
            endIndex = commaIndex;
        } else {
            endIndex = Math.min(commaIndex, endBraceIndex);
        }

        try {
            String value = json.substring(colonIndex + 1, endIndex).trim();
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0;
        }
    }

    // JSON 문자열에서 boolean 값을 꺼내는 메서드
    public static boolean getBoolean(String json, String key) {
        String findKey = "\"" + key + "\"";
        int keyIndex = json.indexOf(findKey);

        if (keyIndex == -1) {
            return false;
        }

        int colonIndex = json.indexOf(":", keyIndex);
        int commaIndex = json.indexOf(",", colonIndex + 1);
        int endBraceIndex = json.indexOf("}", colonIndex + 1);

        int endIndex;
        if (commaIndex == -1) {
            endIndex = endBraceIndex;
        } else if (endBraceIndex == -1) {
            endIndex = commaIndex;
        } else {
            endIndex = Math.min(commaIndex, endBraceIndex);
        }

        String value = json.substring(colonIndex + 1, endIndex).trim();
        return value.equals("true");
    }
}
