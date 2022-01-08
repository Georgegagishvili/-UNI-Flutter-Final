import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/buttons/secondary_button.dart';
import 'package:personal_expenses/ui/widgets/text_fields/default_textfield.dart';
import 'package:provider/provider.dart';

class _EditSheetState extends State<EditSheet> {
  late TextEditingController _idController;
  late TextEditingController _amountController;
  late TextEditingController _titleController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.expense.id.toString());
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _titleController = TextEditingController(text: widget.expense.expenseTitle);
    _selectedDate = DateTime.parse(widget.expense.date);
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
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.075,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          children: [
            DefaultTextField(
              controller: _idController,
              enabled: false,
              borderColor: AppTheme.white,
            ),
            DefaultTextField(
              controller: _amountController,
              hint: "Please enter expense amount",
              textInputType: TextInputType.number,
              borderColor: AppTheme.white,
            ),
            DefaultTextField(
              controller: _titleController,
              hint: "Please enter expense title",
              borderColor: AppTheme.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd MMM, yyyy").format(_selectedDate),
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
              child:
                  SecondaryButton(title: 'EDIT', action: () => _editExpense()),
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
      _selectedDate = _date!;
    });
  }

  _editExpense() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
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
          .editExpense(Expense(
              id: widget.expense.id,
              expenseTitle: _titleController.text,
              date: _selectedDate.toString(),
              amount: int.parse(_amountController.text)))
          .then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}

class EditSheet extends StatefulWidget {
  const EditSheet({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final Expense expense;

  @override
  State<EditSheet> createState() => _EditSheetState();
}
