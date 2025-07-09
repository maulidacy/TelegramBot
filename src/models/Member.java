/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author cahya
 */
public class Member {
    private int id;
    private String nomorHP;
    private String username;
    private String chatID;
    private String status;

    public Member(int id, String nomorHP, String username, String chatID, String status) {
        this.id = id;
        this.nomorHP = nomorHP;
        this.username = username;
        this.chatID = chatID;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomorHP() {
        return nomorHP;
    }

    public void setNomorHP(String nomorHP) {
        this.nomorHP = nomorHP;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getChatID() {
        return chatID;
    }

    public void setChatID(String chatID) {
        this.chatID = chatID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Member{" +
               "id=" + id +
               ", nomorHP='" + nomorHP + '\'' +
               ", username='" + username + '\'' +
               ", chatID='" + chatID + '\'' +
               ", status='" + status + '\'' +
               '}';
    }
}
