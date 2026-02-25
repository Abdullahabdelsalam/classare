package com.classare.dao;

import com.classare.model.Instructor;
import com.classare.model.Person;
import com.classare.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class RegistrationDAO {
    public boolean registerInstructor(Instructor instructor, String email, String password) {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1️⃣ person
            String personSql = """
          INSERT INTO person(national_id, first_name, last_name, gender, birth_date, phone, address)
                          VALUES (?, ?, ?, ?, ?, ?, ?)
        """;
            PreparedStatement pStmt =
                    conn.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);

            Person p = instructor.getPerson();

            pStmt.setString(1, p.getNationalId());
            pStmt.setString(2, p.getFirstName());
            pStmt.setString(3, p.getLastName());
            pStmt.setString(4, p.getGender());
            pStmt.setDate(5, Date.valueOf(p.getBirthDate()));
            pStmt.setString(6, p.getPhone());
            pStmt.setString(7, p.getAddress());

            pStmt.executeUpdate();


            ResultSet prs = pStmt.getGeneratedKeys();
            if (!prs.next()) throw new SQLException("Failed to create person");
            long personId = prs.getLong(1);

            // 2️⃣ users
            String userSql = """
            INSERT INTO users (person_id, email, password_hash)
            VALUES (?, ?, ?)
        """;
            PreparedStatement uStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            uStmt.setLong(1, personId);
            uStmt.setString(2, email);
            uStmt.setString(3, BCrypt.hashpw(password, BCrypt.gensalt()));
            uStmt.executeUpdate();

            ResultSet urs = uStmt.getGeneratedKeys();
            if (!urs.next()) throw new SQLException("Failed to create user");
            long userId = urs.getLong(1);

            // 3️⃣ user_roles → INSTRUCTOR
            String roleSql = """
            INSERT INTO user_roles (user_id, role_id)
            VALUES (?, (SELECT id FROM roles WHERE name = 'INSTRUCTOR'))
        """;
            PreparedStatement rStmt = conn.prepareStatement(roleSql);
            rStmt.setLong(1, userId);
            rStmt.executeUpdate();

            // 4️⃣ instructors
            String instructorSql = """
            INSERT INTO instructors (person_id, specialization)
            VALUES (?, ?)
        """;
            PreparedStatement iStmt = conn.prepareStatement(instructorSql);
            iStmt.setLong(1, personId);
            iStmt.setString(2, instructor.getSpecialization());
            iStmt.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ignored) {}
            e.printStackTrace();
            return false;

        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
public boolean registerStudent(Person person, String email, String password, int levelId, int facultyId) {
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // بدء المعاملة لضمان حفظ كل الجداول أو لا شيء

        // 1. حفظ البيانات الشخصية (جدول person)
        String personSql = "INSERT INTO person (national_id, first_name, last_name, gender, birth_date, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pStmt = conn.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);
        pStmt.setString(1, person.getNationalId());
        pStmt.setString(2, person.getFirstName());
        pStmt.setString(3, person.getLastName());
        pStmt.setString(4, person.getGender());
        pStmt.setString(5, String.valueOf(person.getBirthDate()));
        pStmt.setString(6, person.getPhone());
        pStmt.setString(7, person.getAddress());
        pStmt.executeUpdate();

        ResultSet rsP = pStmt.getGeneratedKeys();
        long personId = 0;
        if (rsP.next()) personId = rsP.getLong(1);

        // 2. إنشاء حساب المستخدم (جدول users)
        String userSql = "INSERT INTO users (person_id, email, password_hash) VALUES (?, ?, ?)";
        PreparedStatement uStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
        uStmt.setLong(1, personId);
        uStmt.setString(2, email);
        uStmt.setString(3, BCrypt.hashpw(password, BCrypt.gensalt()));
        uStmt.executeUpdate();

        ResultSet rsU = uStmt.getGeneratedKeys();
        long userId = 0;
        if (rsU.next()) userId = rsU.getLong(1);

        // 3. ربط المستخدم بدور STUDENT (جدول user_roles)
        String roleSql = "INSERT INTO user_roles (user_id, role_id) VALUES (?, (SELECT id FROM roles WHERE name = 'STUDENT'))";
        PreparedStatement rStmt = conn.prepareStatement(roleSql);
        rStmt.setLong(1, userId);
        rStmt.executeUpdate();

        // 4. ربط الطالب بالمستوى الدراسي (جدول students)
        // تعديل جملة الـ INSERT لتشمل الكلية
        String studentSql = "INSERT INTO students (person_id, level_id, faculty_id) VALUES (?, ?, ?)";
        PreparedStatement sStmt = conn.prepareStatement(studentSql);

        sStmt.setLong(1, personId);
        sStmt.setInt(2, levelId);

// الربط الذكي: لو مفيش كلية (حالة المدارس) نبعت NULL
        if (facultyId != 0) {
            sStmt.setInt(3, facultyId);
        } else {
            sStmt.setNull(3, java.sql.Types.INTEGER);
        }
        sStmt.executeUpdate();

        conn.commit(); // تنفيذ كل العمليات بنجاح
        return true;

    } catch (SQLException e) {
        if (conn != null) {
            try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
        e.printStackTrace();
        return false;
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
}
