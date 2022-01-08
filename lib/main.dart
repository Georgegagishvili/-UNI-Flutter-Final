import 'package:flutter/material.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/pages/login.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ExpensesModel(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.getThemeData(),
          home: const LoginPage()),
    );
  }
}
