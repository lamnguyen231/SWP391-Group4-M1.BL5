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
 * User Data Access Object
 * Quản lý tất cả các thao tác với database liên quan đến User
 * 
 * Chức năng chính:
 * - Lấy danh sách user với filter (role, status, search) - Admin
 * - Toggle status user (Active/Inactive) - Admin
 * - Đăng nhập (email + password)
 * - Tìm user theo email (cho Forgot Password)
 * - Cập nhật password (cho Change Password và Reset Password)
 * - Cập nhật profile (name) - User
 * 
 * @author PC
 */
public class UserDAO extends dbConfig {

    public UserDAO() {
        super();
    }

    /**
     * Lấy danh sách user với các điều kiện filter - Dành cho Admin
     * Được sử dụng trong trang User List của Admin
     * 
     * @param role Filter theo role ("All", "Admin", "Staff", "Customer")
     * @param status Filter theo status ("All", "Active", "Inactive")
     * @param search Tìm kiếm theo email (LIKE %search%)
     * @return Danh sách User thỏa mãn điều kiện, sắp xếp theo user_id ASC
     */
    public List<User> getListUserAdmin(String role, String status, String search) {
        List<User> listUser = new ArrayList<>();
        // List chứa các tham số động cho PreparedStatement
        List<Object> params = new ArrayList<>();

        // Xây dựng câu SQL động với StringBuilder
        // Base query: JOIN users với roles để lấy role_name
        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.name, u.email, u.status, r.role_name "
                        + "FROM users u "
                        + "INNER JOIN roles r ON u.role_id = r.role_id ");

        // Flag để kiểm tra đã có WHERE clause chưa
        boolean hasCondition = false;

        // Filter 1: Theo Role (nếu không phải "All")
        if (role != null && !role.equals("All") && !role.isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" r.role_name = ? ");
            params.add(role); // Thêm giá trị vào list params
        }

        // Filter 2: Theo Status (nếu không phải "All")
        if (status != null && !status.equals("All") && !status.isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" u.status = ? ");
            // Convert "Active" -> true, "Inactive" -> false
            params.add("Active".equals(status));
        }

        // Filter 3: Tìm kiếm theo Email (LIKE pattern)
        if (search != null && !search.trim().isEmpty()) {
            if (hasCondition == false) {
                sql.append(" WHERE ");
                hasCondition = true;
            } else {
                sql.append(" AND ");
            }

            sql.append(" u.email LIKE ? ");
            // Thêm % vào 2 bên để search bất kỳ vị trí nào
            params.add("%" + search + "%");
        }

        // Sắp xếp theo user_id tăng dần
        sql.append(" ORDER BY u.user_id ASC");

        try {
            Connection conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            // Set các tham số động vào PreparedStatement
            // Index bắt đầu từ 1 (không phải 0)
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            // Thực thi query và lấy kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo User object từ mỗi row
                // Note: Không lấy password vì lý do bảo mật
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

    /**
     * Đảo ngược trạng thái của user (Active ↔ Inactive)
     * Được sử dụng bởi Admin trong trang User List
     * 
     * SQL: UPDATE users SET status = !status WHERE user_id = ?
     * !status = NOT status (MySQL bitwise NOT operator)
     * - true → false (Active → Inactive)
     * - false → true (Inactive → Active)
     * 
     * @param userId ID của user cần toggle status
     * @return true nếu toggle thành công, false nếu thất bại hoặc user không tồn tại
     */
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

    public User getAccountByLogin(String email, String password) {
        try {
            String sql = "SELECT u.user_id, u.name, u.email, u.status, r.role_name "
                    + "FROM users u "
                    + "INNER JOIN roles r ON u.role_id = r.role_id "
                    + "WHERE u.email = ? AND u.password = ?";

            Connection conn = new dbConfig().getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, email);
            stm.setString(2, password);

            ResultSet rs = stm.executeQuery();

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
        }
        return null;
    }

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
