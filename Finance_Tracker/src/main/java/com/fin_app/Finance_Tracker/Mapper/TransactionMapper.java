package com.fin_app.Finance_Tracker.Mapper;


import com.fin_app.Finance_Tracker.DTOs.CreateTransactionRequest;
import com.fin_app.Finance_Tracker.DTOs.TransactionResponse;
import com.fin_app.Finance_Tracker.Entities.Transaction;

public class TransactionMapper {

    public static Transaction toEntity(CreateTransactionRequest request){
        Transaction transaction = new Transaction();
        transaction.setAmount(request.getAmount());
        transaction.setTransactionCategory(request.getTransactionCategory());
        transaction.setTransactionDate(request.getTransactionDate());
        transaction.setTransactionType(request.getTransactionType());
        transaction.setTransactionTime(request.getTransactionTime());
        return transaction;
    };

    public static TransactionResponse toDTO(Transaction transaction){
        TransactionResponse response = new TransactionResponse();
        response.setTransactionId(transaction.getTransactionId());
        response.setTransactionCategory(transaction.getTransactionCategory());
        response.setTransactionDate(transaction.getTransactionDate());
        response.setTransactionType(transaction.getTransactionType());
        response.setTransactionTime(transaction.getTransactionTime());
        response.setAmount(transaction.getAmount());
        return response;
    }
}
