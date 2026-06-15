package com.kendo.util;
import java.nio.file.Files;
import java.util.Base64;
import java.io.File;

public class imageUtill {
	public static String encode(String path) throws Exception {
        byte[] bytes = Files.readAllBytes(new File(path).toPath());
        return Base64.getEncoder().encodeToString(bytes);
    }
}
