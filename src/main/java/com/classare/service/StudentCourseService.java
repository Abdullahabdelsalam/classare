package com.classare.service;

import com.classare.dao.StudentCourseDAO;

public class StudentCourseService {

    StudentCourseDAO dao = new StudentCourseDAO();

    public String enrollStudent(long studentId, long courseId) {

        if (dao.isEnrolled(studentId, courseId)) {
            return "ALREADY_ENROLLED";
        }

        boolean success = dao.enroll(studentId, courseId);

        if (success) {
            return "ENROLLED_SUCCESS";
        } else {
            return "FAILED";
        }
    }
}