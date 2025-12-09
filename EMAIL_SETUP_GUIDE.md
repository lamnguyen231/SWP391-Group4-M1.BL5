# Email Configuration Guide for WMS Mobile

## 📧 Setup Gmail SMTP for Password Reset

### Step 1: Create/Use Gmail Account
1. Use your Gmail account or create a new one
2. Example: `wmsmobile.system@gmail.com`

### Step 2: Enable 2-Step Verification
1. Go to: https://myaccount.google.com/security
2. Click "2-Step Verification"
3. Follow the setup process

### Step 3: Generate App Password
1. Go to: https://myaccount.google.com/apppasswords
2. Select app: "Mail"
3. Select device: "Windows Computer"
4. Click "Generate"
5. **COPY the 16-character password** (example: `abcd efgh ijkl mnop`)

### Step 4: Update EmailService.java
Open: `src/java/com/wmsmobile/util/EmailService.java`

Replace these lines:
```java
private static final String USERNAME = "your-email@gmail.com"; 
private static final String PASSWORD = "your-app-password"; 
```

With your credentials:
```java
private static final String USERNAME = "wmsmobile.system@gmail.com"; 
private static final String PASSWORD = "abcdefghijklmnop"; // Remove spaces
```

### Step 5: Test Email Service
Run this command in terminal:
```bash
cd src/java
javac -cp "../../lib/*" com/wmsmobile/util/EmailService.java
java -cp "../../lib/*:." com.wmsmobile.util.EmailService
```

Or test through the forgot password feature directly.

---

## 🔧 Configuration Options

### Option 1: Gmail (Recommended for Testing)
- Host: `smtp.gmail.com`
- Port: `587` (TLS)
- Requires: App Password

### Option 2: Outlook/Hotmail
```java
private static final String SMTP_HOST = "smtp-mail.outlook.com";
private static final String SMTP_PORT = "587";
```

### Option 3: Custom SMTP Server
Update the SMTP settings in `EmailService.java` according to your provider.

---

## ✅ Verification Checklist

- [ ] 2-Step Verification enabled on Gmail
- [ ] App Password generated
- [ ] Username and Password updated in EmailService.java
- [ ] Project rebuilt (Clean and Build)
- [ ] Test email sent successfully

---

## 🐛 Troubleshooting

### "Authentication failed"
- Check if App Password is correct (no spaces)
- Verify 2-Step Verification is enabled
- Make sure you're using App Password, not regular Gmail password

### "Connection timeout"
- Check internet connection
- Verify SMTP host and port
- Check firewall/antivirus settings

### Email goes to spam
- This is normal for development
- In production, configure SPF/DKIM records
- Use a verified domain email

---

## 🚀 Current Flow

1. User enters email → `/forgotPassword`
2. System generates token and reset link
3. **Email sent to user's inbox**
4. User clicks link in email
5. User sets new password
6. Success! Can login with new password

---

## 📝 Notes

- Token expires in 15 minutes
- If email fails, backup link shown on screen
- For production: use environment variables for credentials
- Never commit credentials to Git!

