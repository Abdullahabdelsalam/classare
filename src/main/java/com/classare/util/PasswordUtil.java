package com.classare.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    public static boolean check(String raw, String hashed) {
        return BCrypt.checkpw(raw, hashed);
    }
}
