package com.wmsmobile.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Lưu trữ token reset mật khẩu trong bộ nhớ (thay vì dùng session)
 * Sử dụng ConcurrentHashMap để đảm bảo thread-safe trong môi trường đa luồng
 * 
 * @author PC
 */
public class ResetTokenStore {
    
    // Lưu trữ: token -> userId (ID người dùng yêu cầu reset)
    private static final Map<String, Integer> tokens = new ConcurrentHashMap<>();
    
    // Lưu trữ: token -> email (Email của người dùng)
    private static final Map<String, String> emails = new ConcurrentHashMap<>();
    
    // Lưu trữ: token -> thời gian hết hạn (timestamp)
    private static final Map<String, Long> expiryTimes = new ConcurrentHashMap<>();
    
    /**
     * Lưu token reset mật khẩu
     * Token sẽ hết hạn sau 30 phút
     * 
     * @param token Token ngẫu nhiên được tạo bởi UUID
     * @param userId ID của người dùng trong database
     * @param email Email của người dùng
     */
    public static void saveToken(String token, int userId, String email) {
        tokens.put(token, userId);
        emails.put(token, email);
        // Token hết hạn sau 30 phút (30 * 60 * 1000 milliseconds)
        expiryTimes.put(token, System.currentTimeMillis() + (30 * 60 * 1000));
        
        System.out.println("[TokenStore] Token đã lưu: " + token + " cho user: " + userId);
    }
    
    /**
     * Lấy ID người dùng từ token
     * 
     * @param token Token cần tra cứu
     * @return User ID hoặc null nếu token không hợp lệ
     */
    public static Integer getUserId(String token) {
        if (!isValidToken(token)) {
            return null;
        }
        return tokens.get(token);
    }
    
    /**
     * Lấy email từ token
     * 
     * @param token Token cần tra cứu
     * @return Email hoặc null nếu token không hợp lệ
     */
    public static String getEmail(String token) {
        if (!isValidToken(token)) {
            return null;
        }
        return emails.get(token);
    }
    
    /**
     * Kiểm tra token có hợp lệ không (tồn tại và chưa hết hạn)
     * 
     * @param token Token cần kiểm tra
     * @return true nếu token hợp lệ, false nếu không tồn tại hoặc đã hết hạn
     */
    public static boolean isValidToken(String token) {
        // Kiểm tra token có tồn tại không
        if (token == null || !tokens.containsKey(token)) {
            System.out.println("[TokenStore] Token không tồn tại: " + token);
            return false;
        }
        
        // Kiểm tra token có hết hạn chưa
        Long expiryTime = expiryTimes.get(token);
        if (expiryTime == null || System.currentTimeMillis() > expiryTime) {
            System.out.println("[TokenStore] Token đã hết hạn: " + token);
            removeToken(token); // Tự động xóa token hết hạn
            return false;
        }
        
        return true;
    }
    
    /**
     * Xóa token sau khi đã sử dụng
     * Được gọi sau khi reset mật khẩu thành công
     * 
     * @param token Token cần xóa
     */
    public static void removeToken(String token) {
        tokens.remove(token);
        emails.remove(token);
        expiryTimes.remove(token);
        System.out.println("[TokenStore] Token đã xóa: " + token);
    }
    
    /**
     * Dọn dẹp các token đã hết hạn (tùy chọn)
     * Có thể gọi định kỳ để giải phóng bộ nhớ
     * Trong production nên dùng ScheduledExecutorService để chạy tự động
     */
    public static void cleanupExpiredTokens() {
        long now = System.currentTimeMillis();
        expiryTimes.entrySet().removeIf(entry -> {
            if (now > entry.getValue()) {
                String token = entry.getKey();
                tokens.remove(token);
                emails.remove(token);
                System.out.println("[TokenStore] Đã dọn dẹp token hết hạn: " + token);
                return true;
            }
            return false;
        });
    }
}
