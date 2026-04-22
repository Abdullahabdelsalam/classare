package com.classare.dao;

import com.classare.model.Exam;
import com.classare.model.ExamSubmission;
import com.classare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExamDAO {

    public boolean uploadExam(Exam exam) {
        String sql = "INSERT INTO exams (course_id, title, file_url, uploaded_by, center_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, exam.getCourseId());
            stmt.setString(2, exam.getTitle());
            stmt.setString(3, exam.getFileUrl());
            stmt.setLong(4, exam.getTeacherId());
            stmt.setLong(5, 1);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Exam> getExamsForStudent(long studentId) {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT e.* FROM exams e " +
                "JOIN courses c ON e.course_id = c.id " +
                "JOIN students s ON c.level_id = s.level_id " +
                "WHERE s.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Exam e = new Exam();
                e.setId(rs.getLong("id"));
                e.setTitle(rs.getString("title"));
                e.setFileUrl(rs.getString("file_url"));
                exams.add(e);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return exams;
    }

    public boolean gradeSubmission(long submissionId, double grade) {
        String sql = "UPDATE exam_submissions SET grade = ?, corrected = TRUE WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, grade);
            stmt.setLong(2, submissionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    public List<ExamSubmission> getSubmissionsByExam(long examId) {
        List<ExamSubmission> list = new ArrayList<>();
        String sql = "SELECT es.*, p.first_name, p.last_name FROM exam_submissions es " +
                "JOIN students s ON es.student_id = s.id " +
                "JOIN person p ON s.person_id = p.id " +
                "WHERE es.exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, examId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ExamSubmission sub = new ExamSubmission();
                sub.setId(rs.getLong("id"));
                sub.setAnswerFile(rs.getString("answer_file"));
                sub.setGrade(rs.getDouble("grade"));
                sub.setCorrected(rs.getBoolean("corrected"));

                sub.setStudentName(rs.getString("first_name") + " " + rs.getString("last_name"));

                list.add(sub);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

        // 1) Get exams for student
        public List<Map<String, Object>> getStudentExams(long studentId) {

            List<Map<String, Object>> exams = new ArrayList<>();

            String sql = "SELECT e.id, e.title, c.name AS course_name " +
                    "FROM exams e " +
                    "JOIN courses c ON e.course_id = c.id " +
                    "JOIN student_courses sc ON sc.course_id = c.id " +
                    "WHERE sc.student_id=?";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setLong(1, studentId);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rs.getLong("id"));
                    row.put("title", rs.getString("title"));
                    row.put("course_name", rs.getString("course_name"));
                    exams.add(row);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return exams;
        }

        // 2) Check if submitted
        public boolean isSubmitted(long examId, long studentId) {

            String sql = "SELECT 1 FROM exam_submissions WHERE exam_id=? AND student_id=?";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setLong(1, examId);
                ps.setLong(2, studentId);

                ResultSet rs = ps.executeQuery();
                return rs.next();

            } catch (Exception e) {
                e.printStackTrace();
            }

            return false;
        }

        // 3) Submit exam
        public boolean submitExam(long examId, long studentId, String filePath) {

            String sql = "INSERT INTO exam_submissions (exam_id, student_id, answer_file) VALUES (?, ?, ?)";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setLong(1, examId);
                ps.setLong(2, studentId);
                ps.setString(3, filePath);

                return ps.executeUpdate() > 0;

            } catch (Exception e) {
                e.printStackTrace();
            }

            return false;
        }
}
