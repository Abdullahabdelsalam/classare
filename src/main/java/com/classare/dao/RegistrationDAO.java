package com.classare.dao;

import com.classare.model.Instructor;
import com.classare.model.InstructorDocument;
import com.classare.model.Person;
import com.classare.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.List;

public class RegistrationDAO {
    public boolean registerInstructor(Instructor instructor,
                                      String email,
                                      String password,
                                      List<InstructorDocument> documents) {

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // ================= PERSON =================
            String personSql = """
            INSERT INTO person(
                national_id,
                first_name,
                last_name,
                gender,
                birth_date,
                phone,
                address,
                profile_image_url
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

            PreparedStatement pStmt =
                    conn.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);

            Person p = instructor.getPerson();

            pStmt.setString(1, p.getNationalId());
            pStmt.setString(2, p.getFirstName());
            pStmt.setString(3, p.getLastName());
            pStmt.setString(4, p.getGender());
            pStmt.setDate(5, java.sql.Date.valueOf(p.getBirthDate()));
            pStmt.setString(6, p.getPhone());
            pStmt.setString(7, p.getAddress());
            pStmt.setString(8, p.getProfileImageUrl());

            pStmt.executeUpdate();

            ResultSet rs = pStmt.getGeneratedKeys();
            if (!rs.next()) throw new SQLException("Person failed");
            long personId = rs.getLong(1);

            // ================= USER =================
            String userSql = """
            INSERT INTO users(person_id, email, password_hash)
            VALUES (?, ?, ?)
        """;

            PreparedStatement uStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            uStmt.setLong(1, personId);
            uStmt.setString(2, email);
            uStmt.setString(3, BCrypt.hashpw(password, BCrypt.gensalt()));
            uStmt.executeUpdate();

            ResultSet urs = uStmt.getGeneratedKeys();
            urs.next();
            long userId = urs.getLong(1);

            // ================= ROLE =================
            String roleSql = """
            INSERT INTO user_roles(user_id, role_id)
            VALUES (?, (SELECT id FROM roles WHERE name='INSTRUCTOR'))
        """;

            PreparedStatement rStmt = conn.prepareStatement(roleSql);
            rStmt.setLong(1, userId);
            rStmt.executeUpdate();

            // ================= INSTRUCTOR =================
            String insSql = """
            INSERT INTO instructors(person_id, specialization)
            VALUES (?, ?)
        """;

            PreparedStatement iStmt = conn.prepareStatement(insSql, Statement.RETURN_GENERATED_KEYS);
            iStmt.setLong(1, personId);
            iStmt.setString(2, instructor.getSpecialization());
            iStmt.executeUpdate();

            ResultSet irs = iStmt.getGeneratedKeys();
            irs.next();
            long instructorId = irs.getLong(1);

            // ================= DOCUMENTS =================
            if (documents != null) {
                String docSql = """
                INSERT INTO instructor_documents(instructor_id, file_url, file_type)
                VALUES (?, ?, ?)
            """;

                PreparedStatement dStmt = conn.prepareStatement(docSql);

                for (InstructorDocument doc : documents) {
                    dStmt.setLong(1, instructorId);
                    dStmt.setString(2, doc.getFileUrl());
                    dStmt.setString(3, doc.getFileType());
                    dStmt.addBatch();
                }

                dStmt.executeBatch();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            return false;

        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    public boolean registerInstructorONE(Instructor instructor, String email, String password) {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

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

    public boolean registerStudent(Person p, String email, String password, int levelId, int facultyId) {

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1. Insert Person
            String personSql = "INSERT INTO person(first_name,last_name,national_id,gender,birth_date,phone,address,profile_image_url) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement psPerson = conn.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);

            psPerson.setString(1, p.getFirstName());
            psPerson.setString(2, p.getLastName());
            psPerson.setString(3, p.getNationalId());
            psPerson.setString(4, p.getGender());
            psPerson.setDate(5, Date.valueOf(p.getBirthDate()));
            psPerson.setString(6, p.getPhone());
            psPerson.setString(7, p.getAddress());
            psPerson.setString(8, p.getProfileImageUrl());

            psPerson.executeUpdate();

            ResultSet rsPerson = psPerson.getGeneratedKeys();
            rsPerson.next();
            long personId = rsPerson.getLong(1);

            // 2. Hash Password
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // 3. Insert User
            String userSql = "INSERT INTO users(person_id,email,password_hash) VALUES (?,?,?)";
            PreparedStatement psUser = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

            psUser.setLong(1, personId);
            psUser.setString(2, email);
            psUser.setString(3, hashedPassword);

            psUser.executeUpdate();

            ResultSet rsUser = psUser.getGeneratedKeys();
            rsUser.next();
            long userId = rsUser.getLong(1);

            // 4. Assign Role (STUDENT = 3)
            String roleSql = "INSERT INTO user_roles(user_id, role_id) VALUES (?,3)";
            PreparedStatement psRole = conn.prepareStatement(roleSql);
            psRole.setLong(1, userId);
            psRole.executeUpdate();

            // 5. Insert Student
            String studentSql = "INSERT INTO students(person_id,level_id,faculty_id) VALUES (?,?,?)";
            PreparedStatement psStudent = conn.prepareStatement(studentSql);

            psStudent.setLong(1, personId);
            psStudent.setInt(2, levelId);

            if (facultyId == 0) {
                psStudent.setNull(3, Types.INTEGER);
            } else {
                psStudent.setInt(3, facultyId);
            }

            psStudent.executeUpdate();

            conn.commit();

            return true;

        } catch (Exception e) {
            e.printStackTrace();

            try {
                if (conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    public void saveOTP(String email, String otp) throws Exception {

        Connection conn = DBConnection.getConnection();

        String sql = "UPDATE users SET otp_code=?, otp_expiry=? WHERE email=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, otp);
        ps.setTimestamp(2, new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000));
        ps.setString(3, email);

        ps.executeUpdate();
        conn.close();
    }
}
