import 'package:flutter/material.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.title,
    required this.action,
    this.width,
    this.alignment,
  }) : super(key: key);
  final String title;
  final VoidCallback action;
  final double? width;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerRight,
      child: SizedBox(
        width: width ?? 151,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.darkTeal,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: action,
            child: Ink(
              child: Container(
                constraints: const BoxConstraints(minWidth: 130),
                height: 41,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: AppTheme.sixTeen.copyWith(
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
