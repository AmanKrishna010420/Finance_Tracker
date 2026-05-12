package com.fin_app.Finance_Tracker.DTOs;

import jakarta.validation.constraints.NotBlank;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

public class CreateTransactionRequest {

        @NotBlank
        private int amount;
        private LocalTime transactionTime;
        private LocalDate transactionDate;
        @PositiveOrZero
        private int transactionType;
        @NotBlank
        private int transactionCategory;

    public LocalTime getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(LocalTime transactionTime) {
        this.transactionTime = transactionTime;
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

    public LocalDate getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
