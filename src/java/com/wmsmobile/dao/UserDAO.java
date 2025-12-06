package com.wmsmobile.dao;

import com.wmsmobile.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User
 * @author PC
 */
public class UserDAO extends dbConfig {

    public UserDAO() {
        super();
    }

    /**
     * Get list of users for admin with filters
     */
    public List<User> getListUserForAdmin(String role, String status, String search) {
        List<User> listUser = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.name, u.email, u.status, r.role_name " +
                "FROM users u " +
                "INNER JOIN roles r ON u.role_id = r.role_id ");

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
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("role_name"),
                        rs.getBoolean("status")
                );
                listUser.add(user);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listUser;
    }

    /**
     * Toggle user status (active/inactive)
     */
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

    /**
     * Get user by email and password for login
     */
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        String sql = "SELECT u.user_id, u.name, u.email, u.status, r.role_name " +
                     "FROM users u INNER JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE u.email = ? AND u.password = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            System.out.println("[LOGIN] Attempting login for email: " + email);
            
            if (conn == null) {
                System.out.println("[ERROR] Database connection is null!");
                return null;
            }
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("role_name"),
                        rs.getBoolean("status")
                );
                System.out.println("[LOGIN] User found: " + user.getName() + " (" + user.getRole() + ")");
            } else {
                System.out.println("[LOGIN] No user found with email: " + email);
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Login exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    /**
     * Get user by email only (for forgot password)
     */
    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT u.user_id, u.name, u.email, u.status, r.role_name " +
                     "FROM users u INNER JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE u.email = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            System.out.println("[FORGOT_PASSWORD] Searching for email: " + email);
            
            if (conn == null) {
                System.out.println("[ERROR] Database connection is null!");
                return null;
            }
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("role_name"),
                        rs.getBoolean("status")
                );
                System.out.println("[FORGOT_PASSWORD] User found: " + user.getName());
            } else {
                System.out.println("[FORGOT_PASSWORD] No user found with email: " + email);
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Get user by email exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    /**
     * Update user password
     */
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
