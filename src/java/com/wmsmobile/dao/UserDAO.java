/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.wmsmobile.dao;

import com.wmsmobile.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class UserDAO extends dbConfig {

    public UserDAO() {
        super();
    }

    public List<User> getListUserForAdmin(String role, String status, String search) {
        List<User> listUser = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.name, u.email, u.status, r.role_name "
                + "FROM users u "
                + "INNER JOIN roles r ON u.role_id = r.role_id ");

        boolean hasCondition = false;

        if (role != null && !role.equals("All") && !role.isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" r.role_name = ? ");
            params.add(role);
        }

        if (status != null && !status.equals("All") && !status.isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" u.status = ? ");
            params.add("Active".equals(status));
        }

        if (search != null && !search.trim().isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" u.email LIKE ? ");
            params.add("%" + search + "%");
        }

        sql.append(" ORDER BY u.user_id ASC");

        try {
            Connection conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("role_name"),
                        rs.getBoolean("status")));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listUser;
    }

    public boolean toggleStatus(int userId) {
        String sql = "UPDATE users set status = !status WHERE user_id = ?";

        try {
            Connection conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            int rowsAffected = ps.executeUpdate();

            ps.close();
            conn.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        String sql = "SELECT user_id, name, email, status, role_id FROM users WHERE email = ? AND password = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getInt("status"),
                        rs.getInt("role_id")
                );
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT user_id, name, email, status, role_id FROM users WHERE email = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getInt("status"),
                        rs.getInt("role_id")
                );
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
