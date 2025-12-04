/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.wmsmobile.dao;

import java.util.ArrayList;
import java.util.List;

import com.wmsmobile.model.User;

/**
 *
 * @author PC
 */

public class UserDAO extends dbConfig{
    
    public UserDAO() {
        super();
    }

    public List<User> getListUserForAdmin() {
        List<User> listUser = new ArrayList<>();

        // Mock data
        listUser.add(new User(1, "Nguyen Lam", "mystyme2312@gmail.com", "Employee", "Inactive"));
        listUser.add(new User(2, "Pham Hiep", "def@testmail.com", "Keeper", "Active"));

        /*Add sql command then try catch for data */

        return listUser;
    }
}
