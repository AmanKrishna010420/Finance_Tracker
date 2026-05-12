package com.fin_app.Finance_Tracker.DTOs;

import java.util.Map;


public class TransactionAnalytics {

    private Map<Integer,Integer> monthlyExpense;
    private Map<Integer,Integer> monthlyIncome;
    private Map<Integer,Integer> sumOfCategoryExpense;

    public Map<Integer, Integer> getSumOfCategoryExpense() {
        return sumOfCategoryExpense;
    }

    public void setSumOfCategoryExpense(Map<Integer, Integer> sumOfCategoryExpense) {
        this.sumOfCategoryExpense = sumOfCategoryExpense;
    }

    public Map<Integer, Integer> getMonthlyIncome() {
        return monthlyIncome;
    }

    public void setMonthlyIncome(Map<Integer, Integer> monthlyIncome) {
        this.monthlyIncome = monthlyIncome;
    }

    public Map<Integer, Integer> getMonthlyExpense() {
        return monthlyExpense;
    }

    public void setMonthlyExpense(Map<Integer, Integer> monthlyExpense) {
        this.monthlyExpense = monthlyExpense;
    }
}
