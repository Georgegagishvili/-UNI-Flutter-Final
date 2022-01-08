import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/services/exapi.dart';

class ExpensesModel extends ChangeNotifier {
  List<Expense> _expenses = [];
  int _totalAmount = 0;

  List<Expense> get getExpenses => _expenses;

  int get getTotalAmount => _totalAmount;

  getAndSetExpenses() async {
    _totalAmount = 0;
    try {
      var response = await ExApi().getExpenses();
      if (response.statusCode == 200) {
        _expenses = Expense.convertExpenses(response.body);
        _totalAmount = _expenses.fold(
            0, (_totalAmount, element) => _totalAmount + element.amount);
        notifyListeners();
      } else {
        print("getAndSetExpenses error : ${response.statusCode} ::"
            ":: ${response.body}");
      }
    } catch (e) {
      print(e);
    }
  }

  addExpense(Expense expense) async {
    try {
      var response = await ExApi().addExpense(expense);
      if (response.statusCode == 200) {
        _expenses.add(expense);
        _totalAmount = _expenses.fold(
            0, (_totalAmount, element) => _totalAmount + element.amount);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  deleteExpense(int id) async {
    try {
      var response = await ExApi().removeExpense(id);
      if (response.statusCode == 200) {
        _expenses.removeWhere((element) => element.id == id);
        _totalAmount = _expenses.fold(
            0, (_totalAmount, element) => _totalAmount + element.amount);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  editExpense(Expense expense) async {
    try {
      var response = await ExApi().updateExpense(expense);
      if (response.statusCode == 200) {
        getAndSetExpenses();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
