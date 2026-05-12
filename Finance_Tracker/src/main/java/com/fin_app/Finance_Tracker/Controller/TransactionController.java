package com.fin_app.Finance_Tracker.Controller;

import com.fin_app.Finance_Tracker.DTOs.CreateTransactionRequest;
import com.fin_app.Finance_Tracker.DTOs.TransactionResponse;
import com.fin_app.Finance_Tracker.Entities.User;
import com.fin_app.Finance_Tracker.Service.TransactionService;
import com.fin_app.Finance_Tracker.Service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@CrossOrigin("*")
@RestController
@RequestMapping("/transaction")
public class TransactionController {


    private final TransactionService transactionService;

    private final UserService userService;

    public  TransactionController(TransactionService transactionService, UserService userService) {
        this.transactionService = transactionService;
        this.userService = userService;
    }

    @PostMapping("/computeResponse")
    public ResponseEntity<TransactionResponse> computeResponse(@RequestParam("email") String userEmail ,@RequestBody CreateTransactionRequest createTransactionRequest) {
        return ResponseEntity.ok(transactionService.computeTransaction(userEmail, createTransactionRequest));
    }

    @GetMapping("/all")
    public ResponseEntity<List<TransactionResponse>> getTransactions(@RequestParam("email") String userEmail) {
        return ResponseEntity.ok(transactionService.getAllTransactions(userEmail));
    }

    @GetMapping("/monthlyIncome")
    public ResponseEntity<Map<Integer,Integer>> getMonthlyIncome(User user) {
        return ResponseEntity.ok(transactionService.getMonthlyIncome(user));
    }

    @GetMapping("/monthlyExpense")
    public ResponseEntity<Map<Integer,Integer>> getMonthlyExpense(@RequestParam("email") String userEmail) {
        return  ResponseEntity.ok(transactionService.getMonthlyExpense(userEmail));
    }

    @GetMapping("/categoryAnalytics")
    public ResponseEntity<Map<Integer,Integer>> getCategoryAnalytics(User user) {
        return ResponseEntity.ok(transactionService.getCategoryAnalytics(user));
    }
}
