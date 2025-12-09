package com.wmsmobile.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 * Dịch vụ gửi Email sử dụng Gmail SMTP
 * Cấu hình để gửi email reset mật khẩu cho người dùng
 * 
 * @author PC
 */
public class EmailService {
    
    // Cấu hình Gmail SMTP server
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587"; // Port TLS
    private static final String USERNAME = "vunthe176677@fpt.edu.vn"; // Email gửi
    private static final String PASSWORD = "bbbufuaftokdebta"; // App Password (không phải mật khẩu Gmail thường)
    
    /**
     * Gửi email chứa link reset mật khẩu
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param resetLink Link để reset mật khẩu (có chứa token)
     * @return true nếu gửi thành công, false nếu thất bại
     */
    public static boolean sendPasswordResetEmail(String toEmail, String resetLink) {
        try {
            // Thiết lập các thuộc tính cho mail server
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true"); // Bật xác thực
            props.put("mail.smtp.starttls.enable", "true"); // Bật TLS
            props.put("mail.smtp.host", SMTP_HOST); // SMTP host
            props.put("mail.smtp.port", SMTP_PORT); // SMTP port
            props.put("mail.smtp.ssl.trust", SMTP_HOST); // Trust Gmail server
            props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Sử dụng TLS 1.2
            
            // Tạo session với authenticator (đăng nhập Gmail)
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });
            
            // Tạo nội dung email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "WMS Mobile System")); // Người gửi
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); // Người nhận
            message.setSubject("Password Reset Request - WMS Mobile"); // Tiêu đề email
            
            // Nội dung email dạng HTML (đẹp hơn plain text)
            String htmlContent = createEmailTemplate(resetLink);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("Email reset mật khẩu đã gửi thành công đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Gửi email thất bại: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Tạo template HTML cho email reset mật khẩu
     * Sử dụng inline CSS để đảm bảo hiển thị đúng trên mọi email client
     * 
     * @param resetLink Link reset mật khẩu cần chèn vào email
     * @return Chuỗi HTML hoàn chỉnh
     */
    private static String createEmailTemplate(String resetLink) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }" +
                ".button { display: inline-block; padding: 15px 30px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }" +
                ".warning { background: #fff3cd; padding: 15px; border-left: 4px solid #ffc107; margin: 20px 0; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h1>🔐 Password Reset Request</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello,</p>" +
                "<p>We received a request to reset your password for your WMS Mobile account.</p>" +
                "<p>Click the button below to reset your password:</p>" +
                "<p style='text-align: center;'>" +
                "<a href='" + resetLink + "' class='button'>Reset Password</a>" +
                "</p>" +
                "<p>Or copy and paste this link into your browser:</p>" +
                "<p style='word-break: break-all; background: white; padding: 10px; border: 1px solid #ddd;'>" +
                resetLink +
                "</p>" +
                "<div class='warning'>" +
                "<strong>⚠️ Important:</strong>" +
                "<ul>" +
                "<li>This link will expire in 30 minutes</li>" + // Cập nhật từ 15 thành 30 phút
                "<li>If you didn't request this, please ignore this email</li>" +
                "<li>For security, never share this link with anyone</li>" +
                "</ul>" +
                "</div>" +
                "<p>Best regards,<br>WMS Mobile Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated email. Please do not reply.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
    
    /**
     * Hàm test để kiểm tra cấu hình email
     * Chỉ dùng cho development, không sử dụng trong production
     */
    public static void main(String[] args) {
        String testEmail = "test@example.com";
        String testLink = "http://localhost:8080/resetPassword?token=test123";
        
        boolean success = sendPasswordResetEmail(testEmail, testLink);
        System.out.println("Email test " + (success ? "PASSED" : "FAILED"));
    }
}
