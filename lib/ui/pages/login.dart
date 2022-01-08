import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/logic/providers/expenses_model.dart';
import 'package:personal_expenses/ui/pages/home.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';
import 'package:personal_expenses/ui/widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 4,
          ),
          children: [
            Align(
              child: Image.asset(
                'assets/logo/app_logo.png',
                width: MediaQuery.of(context).size.width / 2.5,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.25,
                  vertical: 20),
              height: 37,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: AppTheme.darkCyan,
                      border: InputBorder.none,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PrimaryButton(
                title: "LOGIN",
                action: () => _onLogin(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onLogin() {
    if (_usernameController.text.isEmpty) {
      Flushbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(12),
        title: "Error occurred!",
        message: "Please enter your name",
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    } else {
      Provider.of<ExpensesModel>(context, listen: false).getAndSetExpenses();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const HomePage()),
          (route) => false);
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
