import 'package:flutter/material.dart';
import 'package:personal_expenses/logic/models/expense.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/bottom_sheets/add_sheet.dart';
import 'package:personal_expenses/ui/widgets/buttons/default_circle_button.dart';
import 'package:personal_expenses/ui/widgets/nodes/expense_node.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..forward();

  late final Animation<Offset> _transitionOffset =
      Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _gadgetWidth = MediaQuery.of(context).size.width;
    var _gadgetHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _gadgetWidth,
            constraints: const BoxConstraints(
              minHeight: 180,
            ),
            child: Image.asset(
              'assets/images/main_bg.png',
              height: _gadgetHeight * 0.42,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              left: _gadgetWidth * 0.075,
              right: _gadgetWidth * 0.075,
              top: _gadgetHeight * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal Expenses",
                    style: AppTheme.mediumTitle,
                  ),
                  DefaultCircleButton(
                    iconData: Icons.add,
                    action: () => _showAddSheet(context),
                  )
                ],
              )),
          Consumer<ExpensesModel>(builder: (ctx, expense, _) {
            List<Expense> _expenses = expense.getExpenses;
            return Container(
                margin: EdgeInsets.only(
                  top: _gadgetHeight * 0.28,
                  left: _gadgetWidth * 0.075,
                  right: _gadgetWidth * 0.075,
                ),
                child: SlideTransition(
                  position: _transitionOffset,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        height: _gadgetHeight * 0.24,
                        width: _gadgetWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.white,
                            border:
                                Border.all(width: 1, color: AppTheme.lightGray),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.black.withOpacity(0.1),
                                blurRadius: 8,
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total amount: \$${expense.getTotalAmount}",
                              maxLines: 3,
                              style: AppTheme.mediumTitle
                                  .copyWith(fontSize: _gadgetWidth * 0.05),
                            ),
                            FittedBox(
                              child: Text(
                                "Expenses: ${_expenses.length}",
                                style: AppTheme.mediumTitle
                                    .copyWith(fontSize: _gadgetWidth * 0.05),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _expenses.length,
                            itemBuilder: (BuildContext context, idx) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ExpenseNode(
                                  title: _expenses[idx].expenseTitle,
                                  amount: _expenses[idx].amount,
                                  date: _expenses[idx].date,
                                  id: _expenses[idx].id,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ));
          })
        ],
      ),
    );
  }

  _showAddSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const AddSheet();
        });
  }
}
