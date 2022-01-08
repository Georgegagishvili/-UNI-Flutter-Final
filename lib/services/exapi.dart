import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:personal_expenses/logic/models/expense.dart';

class ExApi {
  final String _host = "http://10.0.2.2:4000";

  getExpenses() async {
    var url = Uri.parse("$_host/expenses");
    var response = await http.get(url);

    // print("getExpenses: ${response.statusCode} :::: ${response.body}");

    return response;
  }

  getExpenseById(int id) async {
    var url = Uri.parse("$_host/expense/$id");
    var response = await http.get(url);

    return response;
  }

  addExpense(Expense expense) async {
    var url = Uri.parse("$_host/add-expense");
    var body = jsonEncode(expense.toJson());
    var response = await http.post(url, body: body);

    // print("addExpense: ${response.statusCode} :::: ${response.body}");

    return response;
  }

  removeExpense(int id) async {
    var url = Uri.parse("$_host/delete-expense/$id");
    var response = await http.delete(url);

    // print("removeExpense: ${response.statusCode} :::: ${response.body}");

    return response;
  }

  updateExpense(Expense expense) async {
    var url = Uri.parse("$_host/update-expense");
    var body = jsonEncode(expense.toJson());
    var response = await http.put(url, body: body);

    // print("updateExpense: ${response.statusCode} :::: ${response.body}");

    return response;
  }
}
