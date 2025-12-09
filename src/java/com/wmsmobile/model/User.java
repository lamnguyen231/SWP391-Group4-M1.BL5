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
    private boolean status;

    public User(int id, String name, String email, String role, boolean status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean getStatus() {
        return status;
    }
    
    public String getRole() {
        return role;
    }
}
