import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/bottom_sheets/edit_sheet.dart';
import 'package:personal_expenses/ui/widgets/buttons/default_circle_button.dart';
import 'package:provider/provider.dart';

class ExpenseDetailedSheet extends StatelessWidget {
  const ExpenseDetailedSheet({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    String _prettifiedDate =
        DateFormat("dd MMM, yyyy").format(DateTime.parse(expense.date));

    return ListView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        right: MediaQuery.of(context).size.width * 0.075,
        left: MediaQuery.of(context).size.width * 0.075,
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Text(
            expense.expenseTitle,
            style: AppTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Expense Amount",
              style: AppTheme.sixTeen,
            ),
            Text(
              "${expense.amount}\$",
              style: AppTheme.sixTeen,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Date",
              style: AppTheme.sixTeen,
            ),
            Text(
              _prettifiedDate,
              style: AppTheme.sixTeen,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultCircleButton(
                iconData: Icons.edit,
                action: () => _showEditSheet(context),
                isLarge: true,
              ),
              DefaultCircleButton(
                iconData: Icons.delete,
                action: () => _deleteExpense(context),
                isLarge: true,
              ),
            ],
          ),
        )
      ],
    );
  }

  _showEditSheet(context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return EditSheet(expense: expense);
        });
  }

  _deleteExpense(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Expense'),
            content: const Text(
                "With this action you confirm deletion of selected expense."),
            actions: [
              TextButton(
                  onPressed: () => {
                        Provider.of<ExpensesModel>(context, listen: false)
                            .deleteExpense(expense.id)
                            .then((_) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        })
                      },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No"))
            ],
          );
        });
  }
}
