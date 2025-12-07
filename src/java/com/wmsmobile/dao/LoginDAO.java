/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.wmsmobile.dao;

/**
 *
 * @author hp
 */
public class AccountDAO extends dbConfig {
    public Account getAccountByLogin(String username, String password) {
        try {
            String sql = "SELECT * FROM Account where username like ? and password like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getString(1), rs.getString(2),rs.getInt(3));
            }
        } catch (Exception ex) {

        }
        return null;
    }


   
}
