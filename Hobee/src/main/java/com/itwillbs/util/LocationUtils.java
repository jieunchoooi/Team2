package com.itwillbs.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

public class LocationUtils {

    public static String getLocation(String ip) {
        try {
            if (ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1")) {
                return "Localhost (Korea)";
            }

            String url = "https://ipinfo.io/" + ip + "/geo";

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(new URL(url).openStream(), "UTF-8")
            );

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            String json = sb.toString();

            // 약간의 문자열 파싱으로 city/region/country 추출
            String city = extract(json, "\"city\": \"", "\"");
            String region = extract(json, "\"region\": \"", "\"");
            String country = extract(json, "\"country\": \"", "\"");

            if (city == null) city = "Unknown City";
            if (region == null) region = "Unknown Region";
            if (country == null) country = "Unknown Country";

            return city + ", " + region + ", " + country;

        } catch (Exception e) {
            return "Unknown Location";
        }
    }

    private static String extract(String text, String start, String end) {
        int s = text.indexOf(start);
        if (s == -1) return null;
        s += start.length();

        int e = text.indexOf(end, s);
        if (e == -1) return null;

        return text.substring(s, e);
    }
}
