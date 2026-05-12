package com.fin_app.Finance_Tracker.DTOs;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

public class CreateUserRequest {

    @NotBlank
    private String firstName;
    @NotBlank
    private String lastName;

    @Email
    private String userEmail;
    @NotBlank
    private String userPassword;
    //phase 1

    @NotBlank
    private String username ;
    private List<String> banks;
    @NotBlank
    private int balance;

    public @NotBlank String getFirstName() {
        return firstName;
    }

    public void setFirstName(@NotBlank String firstName) {
        this.firstName = firstName;
    }

    public @NotBlank int getBalance() {
        return balance;
    }

    public void setBalance(@NotBlank int balance) {
        this.balance = balance;
    }

    public List<String> getBanks() {
        return banks;
    }

    public void setBanks(List<String> banks) {
        this.banks = banks;
    }

    public @NotBlank String getUsername() {
        return username;
    }

    public void setUsername(@NotBlank String username) {
        this.username = username;
    }

    public @NotBlank String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(@NotBlank String userPassword) {
        this.userPassword = userPassword;
    }

    public @Email String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(@Email String userEmail) {
        this.userEmail = userEmail;
    }

    public @NotBlank String getLastName() {
        return lastName;
    }

    public void setLastName(@NotBlank String lastName) {
        this.lastName = lastName;
    }
}
