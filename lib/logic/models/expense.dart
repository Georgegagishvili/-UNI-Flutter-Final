import 'dart:convert';

class Expense {
  final int id;
  final String expenseTitle;
  final int amount;
  final String date;

  Expense({
    required this.id,
    required this.expenseTitle,
    required this.amount,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      expenseTitle: json['expenseTitle'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "expenseTitle": expenseTitle,
        "amount": amount,
        "date": date.toString(),
      };

  static List<Expense> convertExpenses(String respBody) {
    final converted = jsonDecode(respBody).cast<Map<String, dynamic>>();

    return converted.map<Expense>((json) => Expense.fromJson(json)).toList();
  }
}
