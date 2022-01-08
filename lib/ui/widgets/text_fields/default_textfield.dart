import 'package:flutter/material.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.controller,
    this.hint = '',
    this.borderColor = AppTheme.gray,
    this.enabled = true,
    this.textInputType = TextInputType.text,
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final Color borderColor;
  final bool enabled;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: enabled ? borderColor : borderColor.withOpacity(0.6),
          width: 2,
        ))),
        child: TextField(
          enabled: enabled,
          controller: controller,
          style: AppTheme.sixTeen.copyWith(
            color: AppTheme.black.withOpacity(enabled ? 0.9 : 0.4),
            fontWeight: FontWeight.w700,
          ),
          keyboardType: textInputType,
          decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 5,
                bottom: 5,
              ),
              border: InputBorder.none,
              isDense: true,
              hintStyle: AppTheme.sixTeen.copyWith(
                color: AppTheme.lightGray.withOpacity(0.7),
              )),
        ),
      ),
    );
  }
}
