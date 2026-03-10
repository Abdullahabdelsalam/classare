package com.classare.dao;

import com.classare.model.*;
import com.classare.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InstructorDAO {

    public List<Instructor> getAllInstructors() {
        List<Instructor> instructors = new ArrayList<>();

        String sql = """
            SELECT 
                i.id AS instructor_id,
                i.specialization,
                p.id AS person_id,
                p.first_name,
                p.last_name,
                p.gender,
                p.phone,
                p.address
            FROM instructors i
            JOIN person p ON i.person_id = p.id
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Person p = new Person();
                p.setId(rs.getLong("person_id"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));

                Instructor instructor = new Instructor();
                instructor.setId(rs.getLong("instructor_id"));
                instructor.setSpecialization(rs.getString("specialization"));
                instructor.setPerson(p);

                instructors.add(instructor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return instructors;
    }


    public Instructor getInstructorById(long instructorId) {

        String sql = """
            SELECT 
                i.id AS instructor_id,
                i.specialization,
                p.id AS person_id,
                p.first_name,
                p.last_name,
                p.gender,
                p.phone,
                p.address
            FROM instructors i
            JOIN person p ON i.person_id = p.id
            WHERE i.id = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, instructorId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Person p = new Person();
                p.setId(rs.getLong("person_id"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));

                Instructor instructor = new Instructor();
                instructor.setId(rs.getLong("instructor_id"));
                instructor.setSpecialization(rs.getString("specialization"));
                instructor.setPerson(p);

                return instructor;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public long getInstructorIdByPersonId(long personId) {

        String sql = "SELECT id FROM instructors WHERE person_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, personId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getLong("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }


    public List<Course> getCoursesByInstructor(long instructorId) {
        List<Course> courses = new ArrayList<>();

        String sql = """
            SELECT 
                c.id,
                c.price,
                s.name AS subject_name,
                l.name AS level_name,
                ctr.name AS center_name
            FROM courses c
            JOIN subjects s ON c.subject_id = s.id
            JOIN levels l ON c.level_id = l.id
            JOIN centers ctr ON c.center_id = ctr.id
            WHERE c.instructor_id = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, instructorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getLong("id"));
                course.setPrice(rs.getDouble("price"));

                Subject subject = new Subject();
                subject.setName(rs.getString("subject_name"));

                Level level = new Level();
                level.setName(rs.getString("level_name"));

                Center center = new Center();
                center.setName(rs.getString("center_name"));

                course.setSubject(subject);
                course.setLevel(level);
                course.setCenter(center);

                courses.add(course);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    /* =====================================================
       5️⃣ Delete Instructor (Soft logic)
       ===================================================== */
    public boolean deleteInstructor(long instructorId) {

        String sql = "DELETE FROM instructors WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, instructorId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public static Instructor findByPersonId(long pid) {
        String sql = "SELECT i.id AS instructor_id, i.specialization, "
                + "p.id AS person_id, p.first_name, p.last_name, p.gender, p.birth_date, p.phone, p.address "
                + "FROM instructors i "
                + "JOIN person p ON i.person_id = p.id "
                + "WHERE p.id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, pid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Instructor instructor = new Instructor();
                instructor.setId(rs.getLong("instructor_id"));
                instructor.setSpecialization(rs.getString("specialization"));

                // Create Person object
                Person person = new Person();
                person.setId(rs.getLong("person_id"));
                person.setFirstName(rs.getString("first_name"));
                person.setLastName(rs.getString("last_name"));
                person.setGender(rs.getString("gender"));
                person.setBirthDate(rs.getDate("birth_date"));
                person.setPhone(rs.getString("phone"));
                person.setAddress(rs.getString("address"));

                instructor.setPerson(person);
                return instructor;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}

