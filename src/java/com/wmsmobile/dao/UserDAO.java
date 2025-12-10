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

    public List<User> getListUserAdmin(String role, String status, String search) {
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

            sql.append(" u.email LIKE ? OR u.name LIKE ?");
            params.add("%" + search + "%");
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
                        rs.getBoolean("status"));
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

    public boolean toggleStatus(int userId) {
        // ! là bitwise NOT trong MySQL, đảo ngược giá trị boolean
        String sql = "UPDATE users set status = !status WHERE user_id = ?";

        try {
            Connection conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            // executeUpdate() trả về số row bị ảnh hưởng
            int rowsAffected = ps.executeUpdate();

            ps.close();
            conn.close();

            // Nếu có ít nhất 1 row bị update → thành công
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xác thực user khi đăng nhập bằng email và password
     * Được sử dụng trong LoginController
     * 
     * @param email Email của user
     * @param password Password (plain text - chưa hash)
     * @return User object nếu login thành công, null nếu sai credentials
     */
    public User getAccountByLogin(String email, String password) {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            String sql = "SELECT u.user_id, u.name, u.email, u.status, r.role_name "
                    + "FROM users u "
                    + "INNER JOIN roles r ON u.role_id = r.role_id "
                    + "WHERE u.email = ? AND u.password = ?";

            conn = new dbConfig().getConnection();
            stm = conn.prepareStatement(sql);

            stm.setString(1, email);
            stm.setString(2, password);

            rs = stm.executeQuery();

            if (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"), 
                    rs.getString("role_name"),
                    rs.getBoolean("status")
                );

                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stm != null) stm.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * Get user by email only (for forgot password)
     */
    public User getUserByEmail(String email) {
        Connection conn = null;
        try {
            String sql = "SELECT u.user_id, u.name, u.email, u.status, r.role_name "
                    + "FROM users u "
                    + "INNER JOIN roles r ON u.role_id = r.role_id "
                    + "WHERE u.email = ?";

            conn = new dbConfig().getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, email);

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("role_name"),
                    rs.getBoolean("status")
                );
                rs.close();
                stm.close();
                return user;
            }
        } catch (Exception e) {
            System.out.println("[ERROR] Get user by email exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * Update user password
     */
    public boolean updatePassword(int userId, String newPassword) {
        Connection conn = null;
        try {
            String sql = "UPDATE users SET password = ? WHERE user_id = ?";

            conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean updateUserProfile(int userId, String name) {
        Connection conn = null;
        try {
            String sql = "UPDATE users SET name = ? WHERE user_id = ?";

            conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
