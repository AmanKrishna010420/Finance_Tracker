package com.fin_app.Finance_Tracker.Entities;

import jakarta.persistence.*;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name="transactions")
public class Transaction {




    private UUID transactionId =  UUID.randomUUID();

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int transactionPrimaryId;
    private int transactionCategory;
    /*
    * Hash Map for Category with String - Integer
    * Food - 1
    * Fuel - 2
    * Medical -3
    * Travel - 4
    * Entertainment - 5
    * Miscellaneous  - 6
    * */
    private int amount;
    private int transactionType ; // 0 for expense 1 for income
    private LocalDate transactionDate;
    private LocalTime transactionTime;
    @ManyToOne
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalTime getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(LocalTime transactionTime) {
        this.transactionTime = transactionTime;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(int transactionType) {
        this.transactionType = transactionType;
    }

    public LocalDate getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    public int getTransactionCategory() {
        return transactionCategory;
    }

    public void setTransactionCategory(int transactionCategory) {
        this.transactionCategory = transactionCategory;
    }

    public int getTransactionPrimaryId() {
        return transactionPrimaryId;
    }

    public void setTransactionPrimaryId(int transactionPrimaryId) {
        this.transactionPrimaryId = transactionPrimaryId;
    }

    public UUID getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(UUID transactionId) {
        this.transactionId = transactionId;
    }
}
