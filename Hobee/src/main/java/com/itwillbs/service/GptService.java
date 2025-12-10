package com.itwillbs.service;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.mapper.GptMapper;

@Service
public class GptService {
    
    @Inject
    private GptMapper gptMapper;

    @Value("${gpt.API_KEY}")
    private String apiKey;

    private String url = "https://api.openai.com/v1/chat/completions";
    private String model = "gpt-4o-mini";
    private double temperature = 0.0;

    // 관심사 저장
    public Object insetInterest(Map<String, Object> params) {
        return gptMapper.insetInterest(params);
    }

    // ⭐ GPT 추천 강의 번호 가져오기 (관심사 + 구매 이력 + 전체 강의 목록)
    public List<Integer> getRecommendLectureIds(String user_id) {

        // 1) 관심사 조회 (리스트로)
        List<String> interestsList = gptMapper.getUserInterestList(user_id);
        String interests = "";
        if (interestsList != null && !interestsList.isEmpty()) {
            interests = String.join(",", interestsList);
        }

        // 2) 구매 강의 조회
        List<Integer> purchasedLectureIds = gptMapper.getPurchasedLectureIds(user_id);
        String purchasedStr = purchasedLectureIds.isEmpty()
                ? "없음"
                : purchasedLectureIds.toString();   // 예: [1,5,7]

        // ⭐ 관심사도 없고 구매 이력도 없으면 빈 리스트 반환
        if ((interests.isEmpty() || interests.equals("")) && purchasedLectureIds.isEmpty()) {
            return new ArrayList<>();
        }

        // ⭐ 3) 전체 강의 목록 조회 (ID, 제목, 카테고리, 태그 포함)
        List<Map<String, Object>> allLectures = gptMapper.getAllLecturesInfo();
        
        // 강의 목록이 없으면 빈 리스트 반환
        if (allLectures == null || allLectures.isEmpty()) {
            return new ArrayList<>();
        }
        
        // 강의 정보를 GPT가 이해할 수 있는 형태로 변환
        StringBuilder lecturesInfo = new StringBuilder();
        for (Map<String, Object> lec : allLectures) {
            lecturesInfo.append(String.format(
                "ID:%s|제목:%s|카테고리:%s|태그:%s\n",
                lec.get("lecture_num"),
                lec.get("lecture_title"),
                lec.get("category_detail"),
                lec.get("lecture_tag")
            ));
        }

        // 4) GPT 프롬프트 생성
        List<Map<String, String>> messages = new ArrayList<>();

        messages.add(Map.of(
            "role", "system",
            "content",
                "너는 취미 강의 추천 전문가야.\n"
              + "아래 제공된 강의 목록에서만 선택해서 추천해야 해.\n"
              + "유저의 관심사가 있으면 관심사와 맞는 강의를 우선 추천하고,\n"
              + "관심사가 없으면 구매한 강의와 비슷한 카테고리나 태그의 강의를 추천해.\n"
              + "이미 구매한 강의는 제외하고, 최대 10~15개 정도 추천해.\n"
              + "추천할 강의 ID만 콤마로 구분해서 '2,3,101,102' 형태로만 출력해.\n"
              + "설명 문장 없이 숫자만 출력해야 해."
        ));

        String userInfo = "=== 유저 정보 ===\n";
        if (!interests.isEmpty() && !interests.equals("")) {
            userInfo += "유저 관심사: " + interests + "\n";
        } else {
            userInfo += "유저 관심사: 없음\n";
        }
        userInfo += "유저가 이미 구매한 강의 ID: " + purchasedStr;

        messages.add(Map.of(
            "role", "user",
            "content",
                "=== 선택 가능한 전체 강의 목록 ===\n" 
              + lecturesInfo.toString() + "\n"
              + userInfo
        ));

        // 요청 Body
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", model);
        requestBody.put("temperature", temperature);
        requestBody.put("messages", messages);

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);

        HttpEntity<String> entity =
            new HttpEntity<>(new JSONObject(requestBody).toString(), headers);

        // UTF-8 RestTemplate
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0,
                new StringHttpMessageConverter(StandardCharsets.UTF_8));

        // GPT 호출
        ResponseEntity<String> response =
                restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        // JSON 파싱 → 추천 강의 번호 리스트
        String content = extractContent(response.getBody());

        return parseIds(content);
    }

    // assistant → content 추출
    private String extractContent(String json) {
        JSONObject obj = new JSONObject(json);
        return obj.getJSONArray("choices")
                .getJSONObject(0)
                .getJSONObject("message")
                .getString("content");
    }

    // "1,5,7" → [1, 5, 7]
    private List<Integer> parseIds(String content) {
        List<Integer> list = new ArrayList<>();

        if (content == null || content.trim().equals("")) return list;

        String[] arr = content.replaceAll("[^0-9,]", "").split(",");

        for (String s : arr) {
            if (!s.trim().equals("")) {
                list.add(Integer.parseInt(s.trim()));
            }
        }
        return list;
    }
}