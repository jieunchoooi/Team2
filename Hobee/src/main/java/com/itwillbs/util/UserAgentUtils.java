package com.itwillbs.util;

public class UserAgentUtils {

    // User-Agent 문자열을 받아 브라우저/OS 형식으로 반환
    public static String parse(String userAgent) {

        if (userAgent == null) return "Unknown Device";

        String browser = getBrowser(userAgent);
        String os = getOS(userAgent);

        return browser + " / " + os;
    }

    // 브라우저 분석
    private static String getBrowser(String ua) {
        ua = ua.toLowerCase();

        if (ua.contains("edg")) return "Microsoft Edge";
        if (ua.contains("chrome")) return "Chrome";
        if (ua.contains("safari")) return "Safari";
        if (ua.contains("firefox")) return "Firefox";
        if (ua.contains("opera")) return "Opera";

        return "Unknown Browser";
    }

    // OS 분석
    private static String getOS(String ua) {
        ua = ua.toLowerCase();

        if (ua.contains("windows")) return "Windows";
        if (ua.contains("mac os")) return "macOS";
        if (ua.contains("android")) return "Android";
        if (ua.contains("iphone")) return "iOS";

        return "Unknown OS";
    }
}
