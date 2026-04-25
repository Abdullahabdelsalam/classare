package com.classare.util;


import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "abdullah7ams705@gmail.com";
    private static final String APP_PASSWORD = "obyc mqkv ytin otoo";

    public static void sendOTP(String toEmail, String otp) throws Exception {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Classare - Email Verification");

        message.setText("Your OTP Code is: " + otp + "\nValid for 5 minutes.");

        Transport.send(message);
    }
}
