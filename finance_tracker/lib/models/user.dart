class User {
  final String? firstName;

  final String? lastName;

  final String? email;

  final List<String>? banks;

  final int? balance;

  User({this.firstName, this.lastName, this.email, this.banks, this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],

      lastName: json['lastName'],

      email: json['email'],

      banks: List<String>.from(json['banks']),

      balance: json['balance'],
    );
  }
}
