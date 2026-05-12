package com.fin_app.Finance_Tracker.Repository;

import com.fin_app.Finance_Tracker.Entities.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Integer> {

}
