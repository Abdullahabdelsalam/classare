package com.classare.dao;

import com.classare.model.Stage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StageDAO {
    private Connection conn;

    public StageDAO(Connection conn) {
        this.conn = conn;
    }
    // Bring all stages
    public List<Stage> getAllStages() throws SQLException {
        List<Stage> stages = new ArrayList<>();
        String sql = "SELECT * FROM stages ORDER BY id";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Stage stage = new Stage();
                stage.setId(rs.getInt("id"));
                stage.setName(rs.getString("name"));
                stages.add(stage);
            }
        }
        return stages;
    }

    // Add a new stage
    public boolean addStage(Stage stage) throws SQLException {
        String sql = "INSERT INTO stages(name) VALUES(?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stage.getName());
            return ps.executeUpdate() > 0;
        }
    }

    // Modify an existing stage
    public boolean updateStage(Stage stage) throws SQLException {
        String sql = "UPDATE stages SET name=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stage.getName());
            ps.setInt(2, stage.getId());
            return ps.executeUpdate() > 0;
        }
    }

    //delete stage
    public boolean deleteStage(int id) throws SQLException {
        String sql = "DELETE FROM stages WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Bring one stage
    public Stage getStageById(int id) throws SQLException {
        String sql = "SELECT * FROM stages WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Stage stage = new Stage();
                    stage.setId(rs.getInt("id"));
                    stage.setName(rs.getString("name"));
                    return stage;
                }
            }
        }
        return null;
    }

}
