package com.wmsmobile.model;

/**
 *
 * @author super
 */
public class Role {

    private int id;
    private String name;
    private boolean status;

    public Role(int id, String name, boolean status) {
        this.id = id;
        this.name = name;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean getStatus() {
        return status;
    }
}
