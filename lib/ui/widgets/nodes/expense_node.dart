import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/services/exapi.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/bottom_sheets/expense_detailed_sheet.dart';

class ExpenseNode extends StatelessWidget {
  const ExpenseNode({
    Key? key,
    required this.title,
    required this.amount,
    required this.date,
    required this.id,
  }) : super(key: key);
  final String title;
  final String date;
  final int amount;
  final int id;

  @override
  Widget build(BuildContext context) {
    String _datePrettified =
        DateFormat("dd MMM, yyyy").format(DateTime.parse(date));
    String _amountFormatted = NumberFormat("####.00").format(amount);
    return GestureDetector(
      onTap: () => _getExpenseById(context),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.white,
            border: Border.all(width: 1, color: AppTheme.lightGray),
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(0.1),
                blurRadius: 8,
              )
            ]),
        child: ListTile(
          title: Text(
            title,
            style: AppTheme.sixTeen,
          ),
          subtitle: Text(_datePrettified),
          trailing: Text(
            "$_amountFormatted \$",
            style: AppTheme.sixTeen,
          ),
        ),
      ),
    );
  }

  _getExpenseById(context) async {
    try {
      var response = await ExApi().getExpenseById(id);
      if (response.statusCode == 200) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ExpenseDetailedSheet(
                expense: Expense.fromJson(
                  jsonDecode(response.body),
                ),
              );
            });
      } else {
        print("_getExpenseById Error: ${response.body}");
      }
    } catch (e) {
      print(e);
    }
  }
}
