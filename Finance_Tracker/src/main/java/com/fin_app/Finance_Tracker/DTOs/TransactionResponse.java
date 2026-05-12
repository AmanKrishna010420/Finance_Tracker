package com.fin_app.Finance_Tracker.DTOs;

import org.springframework.cglib.core.Local;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.UUID;

public class TransactionResponse {
    private UUID transactionId;
    private LocalDate transactionDate;
    private LocalTime transactionTime;
    private int transactionType;
    private int transactionCategory;
    private int amount;
    private int balance;

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
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

    public int getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(int transactionType) {
        this.transactionType = transactionType;
    }

    public UUID getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(UUID transactionId) {
        this.transactionId = transactionId;
    }

    public LocalTime getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(LocalTime transactionTime) {
        this.transactionTime = transactionTime;
    }
}
