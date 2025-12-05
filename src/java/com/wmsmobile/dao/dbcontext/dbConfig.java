package com.wmsmobile.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class dbConfig {

    protected static Connection con = null; 
    
    private String username = "root";
    private String password = "sa123";
    private String uri = "jdbc:mysql://localhost:3306/wms-mobile";
    private String driver = "com.mysql.cj.jdbc.Driver";

    public dbConfig() {
        try {
            Class.forName(driver);
            getConnection(); 
            System.out.println("Connection Successful");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(dbConfig.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Driver not found");
        }
    }

    public Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                con = DriverManager.getConnection(uri, username, password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) {
        new dbConfig();
    }
}
