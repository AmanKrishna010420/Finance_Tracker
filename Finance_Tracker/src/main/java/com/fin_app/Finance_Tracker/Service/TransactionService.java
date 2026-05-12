package com.fin_app.Finance_Tracker.Service;

import com.fin_app.Finance_Tracker.DTOs.CreateTransactionRequest;
import com.fin_app.Finance_Tracker.DTOs.TransactionResponse;
import com.fin_app.Finance_Tracker.Entities.User;
import com.fin_app.Finance_Tracker.Mapper.TransactionMapper;
import com.fin_app.Finance_Tracker.Mapper.UserMapper;
import com.fin_app.Finance_Tracker.Repository.TransactionRepository;
import com.fin_app.Finance_Tracker.Repository.UserRepository;
import com.fin_app.Finance_Tracker.Entities.Transaction;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class TransactionService {
    /*
    * Income
    * Expense
    * Fetch Transactions
    * Month Transaction Fetch*/

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TransactionRepository transactionRepository;

    public TransactionResponse computeTransaction(String userEmail, CreateTransactionRequest createTransactionRequest) {

        Transaction txn = TransactionMapper.toEntity(createTransactionRequest);

        if(txn.getTransactionType() == 1){
            user.setUserBalance(user.getUserBalance() + txn.getAmount());
        }
        else if(txn.getTransactionType() == 0){
            user.setUserBalance(user.getUserBalance() - txn.getAmount());
        }
        else{
            throw new IllegalArgumentException("Invalid Transaction");
        }
        txn.setUser(user);
        transactionRepository.save(txn);
        userRepository.save(user);

        return TransactionMapper.toDTO(txn);

    }

    // Analytics Method

    public List<TransactionResponse> getAllTransactions(User user){
        return transactionRepository.findAll().stream().filter(
                x -> x.getUser().equals(user)).map(TransactionMapper::toDTO).collect(
                        Collectors.toList()
        );
    }

    public Map<Integer, Integer> getMonthlyIncome(User user){
        List<TransactionResponse> data = getAllTransactions(user);
        return data.stream().filter
                (transaction -> transaction.getTransactionType() == 1).collect
                (Collectors.groupingBy(
                        txn-> txn.getTransactionDate().getMonthValue(),
                Collectors.summingInt(
                        TransactionResponse::getAmount)
        ));
    }

    public Map<Integer, Integer> getMonthlyExpense(User user){
        List<TransactionResponse> data = getAllTransactions(user);
        return data.stream().filter
                (transaction -> transaction.getTransactionType() == 0).collect
                (Collectors.groupingBy(
                        txn-> txn.getTransactionDate().getMonthValue(),
                        Collectors.summingInt(
                                TransactionResponse::getAmount)
                ));
    }

    public Map<Integer, Integer>  getCategoryAnalytics(User user){
        List<TransactionResponse> data = getAllTransactions(user);
        return data.stream().filter
                (transaction -> transaction.getTransactionType() == 0).collect
                (Collectors.groupingBy(
                        TransactionResponse::getTransactionCategory,
                        Collectors.summingInt(
                                TransactionResponse::getAmount)
                ));
    }







}
