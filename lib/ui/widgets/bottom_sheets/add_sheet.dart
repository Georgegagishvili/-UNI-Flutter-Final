import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/buttons/secondary_button.dart';
import 'package:personal_expenses/ui/widgets/text_fields/default_textfield.dart';
import 'package:provider/provider.dart';

class _AddSheetState extends State<AddSheet> {
  late TextEditingController _idController;
  late TextEditingController _amountController;
  late TextEditingController _titleController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _amountController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.075,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          children: [
            DefaultTextField(
              controller: _idController,
              textInputType: TextInputType.number,
              hint: "Please enter expense ID",
            ),
            DefaultTextField(
              controller: _amountController,
              hint: "Please enter expense amount",
            ),
            DefaultTextField(
              controller: _titleController,
              hint: "Please enter expense title",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? DateFormat("dd MMM, yyyy").format(_selectedDate!)
                        : "Pick Date",
                    style: AppTheme.sixTeen,
                  ),
                  SecondaryButton(
                    title: 'Pick Date',
                    action: () => _showDatePicker(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SecondaryButton(
                title: 'ADD',
                action: () => _addExpense(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDatePicker() async {
    FocusManager.instance.primaryFocus!.unfocus();
    DateTime? _date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(2032),
      firstDate: DateTime(2001),
    );
    setState(() {
      _selectedDate = _date;
    });
  }

  _addExpense() {
    if (_selectedDate == null ||
        _idController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _amountController.text.isEmpty) {
      Flushbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(12),
        title: "Error occurred!",
        message: "Please fill empty fields",
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    } else {
      Provider.of<ExpensesModel>(context, listen: false)
          .addExpense(Expense(
              id: int.parse(_idController.text),
              expenseTitle: _titleController.text,
              date: _selectedDate.toString(),
              amount: int.parse(_amountController.text)))
          .then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}

class AddSheet extends StatefulWidget {
  const AddSheet({Key? key}) : super(key: key);

  @override
  State<AddSheet> createState() => _AddSheetState();
}
