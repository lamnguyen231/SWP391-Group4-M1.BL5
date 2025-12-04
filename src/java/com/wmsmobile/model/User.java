/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.wmsmobile.model;

/**
 *
 * @author PC
 */
public class User {
    private int id;
    private String name;
    private String email;
    private String role;
    private String status;

    public User(int id, String name, String email, String role, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
    public String getStatus() { return status; }
}
