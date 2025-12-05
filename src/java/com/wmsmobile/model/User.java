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

    private int userId;
    private String name;
    private String email;
    private int status;
    private int roleId;

    public User() {
    }

    public User(int userId, String name, String email, int status, int roleId) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.status = status;
        this.roleId = roleId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", name=" + name + ", email=" + email + ", status=" + status + ", roleId=" + roleId + '}';
    }
}
