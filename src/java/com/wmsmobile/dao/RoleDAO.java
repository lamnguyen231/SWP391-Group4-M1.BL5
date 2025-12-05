package com.wmsmobile.dao;

import com.wmsmobile.model.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author super
 */
public class RoleDAO extends dbConfig {

    public RoleDAO() {
        super();
    }

    public List<Role> getListRoleAdmin() {
        List<Role> listRole = new ArrayList<>();

        String sql = "SELECT * FROM roles";

        try {
            Connection conn = new dbConfig().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listRole.add(new Role(
                        rs.getInt("role_id"),
                        rs.getString("role_name")
                ));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listRole;
    }
}
