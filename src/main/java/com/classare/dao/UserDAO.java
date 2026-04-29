package com.classare.dao;

import com.classare.model.Person;
import com.classare.model.Role;
import com.classare.model.User;
import com.classare.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public static List<User> findAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id AS user_id, u.email, u.password_hash, u.is_active, " +
                "p.id AS person_id, p.first_name, p.last_name, p.national_id, p.gender, p.birth_date, p.phone, p.address " +
                "FROM users u " +
                "JOIN person p ON u.person_id = p.id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Person person = new Person();
                person.setId(rs.getLong("person_id"));
                person.setFirstName(rs.getString("first_name"));
                person.setLastName(rs.getString("last_name"));
                person.setNationalId(rs.getString("national_id"));
                person.setGender(rs.getString("gender"));
                person.setBirthDate(rs.getDate("birth_date"));
                person.setPhone(rs.getString("phone"));
                person.setAddress(rs.getString("address"));

                User user = new User();
                user.setId(rs.getLong("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setActive(rs.getBoolean("is_active"));
                user.setPerson(person);
                user.setRoles(UserDAO.getRoles(user.getId()));

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND is_active = TRUE";

        try (Connection conn = com.classare.util.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashed = rs.getString("password_hash");
                if (BCrypt.checkpw(password, hashed)) {
                    User user = new User();
                    user.setId(rs.getLong("id"));
                    user.setEmail(rs.getString("email"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static User findByEmail(String email) {
        String sql = """
            SELECT u.id uid, u.email, u.password_hash, u.is_active,
                   p.id pid, p.first_name, p.last_name
            FROM users u
            JOIN person p ON u.person_id = p.id
            WHERE u.email = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) return null;

            User user = new User();
            user.setId(rs.getLong("uid"));
            user.setEmail(rs.getString("email"));
            user.setPasswordHash(rs.getString("password_hash"));
            user.setActive(rs.getBoolean("is_active"));

            Person p = new Person();
            p.setId(rs.getLong("pid"));
            p.setFirstName(rs.getString("first_name"));
            p.setLastName(rs.getString("last_name"));

            user.setPerson(p);
            user.setRoles(getRoles(user.getId()));

            return user;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List<Role> getRoles(long userId) {
        List<Role> roles = new ArrayList<>();
        String sql = """
        SELECT r.id, r.name
        FROM roles r
        JOIN user_roles ur ON r.id = ur.role_id
        WHERE ur.user_id = ?
    """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                roles.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return roles;
    }

    public static List<Role> getUserRoles(long userId) {

        List<Role> roles = new ArrayList<>();

        String sql = "SELECT r.id, r.name FROM roles r " +
                "JOIN user_roles ur ON r.id = ur.role_id " +
                "WHERE ur.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Role role = new Role();
                role.setId(rs.getLong("id"));
                role.setName(rs.getString("name"));

                roles.add(role);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return roles;
    }


    public static User findByPersonId(long personId) {

        String sql = "SELECT * FROM users WHERE person_id = ?";
        User user = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, personId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setActive(rs.getBoolean("is_active"));

                Person person = PersonDAO.findById(personId);
                user.setPerson(person);

                user.setRoles(getUserRoles(user.getId()));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    public static boolean createAdmin(String firstName,
                                      String lastName,
                                      String email,
                                      String password) {

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            PreparedStatement check = conn.prepareStatement(
                    "SELECT id FROM users WHERE email = ?"
            );
            check.setString(1, email);

            ResultSet cr = check.executeQuery();
            if (cr.next()) {
                return false;
            }


            PreparedStatement pStmt = conn.prepareStatement(
                    "INSERT INTO person(first_name, last_name) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );

            pStmt.setString(1, firstName);
            pStmt.setString(2, lastName);
            pStmt.executeUpdate();

            ResultSet prs = pStmt.getGeneratedKeys();
            prs.next();
            long personId = prs.getLong(1);

            PreparedStatement uStmt = conn.prepareStatement(
                    "INSERT INTO users(person_id, email, password_hash) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );

            uStmt.setLong(1, personId);
            uStmt.setString(2, email);
            uStmt.setString(3, BCrypt.hashpw(password, BCrypt.gensalt()));
            uStmt.executeUpdate();

            ResultSet urs = uStmt.getGeneratedKeys();
            urs.next();
            long userId = urs.getLong(1);

            PreparedStatement roleStmt = conn.prepareStatement(
                    "SELECT id FROM roles WHERE name = 'ADMIN'"
            );

            ResultSet roleRs = roleStmt.executeQuery();
            roleRs.next();
            long roleId = roleRs.getLong(1);

            PreparedStatement urStmt = conn.prepareStatement(
                    "INSERT INTO user_roles(user_id, role_id) VALUES (?, ?)"
            );

            urStmt.setLong(1, userId);
            urStmt.setLong(2, roleId);
            urStmt.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            return false;
        }
    }
}