import 'package:flutter/material.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.action,
    this.width,
  }) : super(key: key);
  final String title;
  final VoidCallback action;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.darkCyan,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: action,
          child: Ink(
            child: Container(
              constraints: const BoxConstraints(minWidth: 120),
              height: 37,
              alignment: Alignment.center,
              width: width ?? MediaQuery.of(context).size.width * 0.5,
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
