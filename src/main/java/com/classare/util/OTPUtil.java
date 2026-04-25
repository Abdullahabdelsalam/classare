package com.classare.util;

import java.util.Random;

public class OTPUtil {
        public static String generateOTP() {
            Random random = new Random();
            int otp = 100000 + random.nextInt(900000);
            return String.valueOf(otp);
        }
}

