class Transaction {
  final String? transactionId;

  final String? transactionDate;

  final String? transactionTime;

  final int? transactionType;

  final int? transactionCategory;

  final int? amount;

  Transaction({
    this.transactionId,

    this.transactionDate,

    this.transactionTime,

    this.transactionType,

    this.transactionCategory,

    this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],

      transactionDate: json['transactionDate'],

      transactionTime: json['transactionTime'],

      transactionType: json['transactionType'],

      transactionCategory: json['transactionCategory'],

      amount: json['amount'],
    );
  }

  String get transactionTypeText {
    switch (transactionType) {
      case 0:
        return "Expense";

      case 1:
        return "Income";

      default:
        return "Unknown";
    }
  }

  String get categoryText {
    switch (transactionCategory) {
      case 1:
        return "Food";

      case 2:
        return "Fuel";

      case 3:
        return "Medical";

      case 4:
        return "Travel";

      case 5:
        return "Entertainment";

      case 6:
        return "Miscellaneous";

      default:
        return "Other";
    }
  }
}
