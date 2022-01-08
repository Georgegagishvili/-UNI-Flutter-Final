import 'package:flutter/material.dart';
import 'package:personal_expenses/ui/theme/app_theme.dart';

class DefaultCircleButton extends StatelessWidget {
  const DefaultCircleButton({
    Key? key,
    required this.iconData,
    required this.action,
    this.isLarge = false,
  }) : super(key: key);

  final VoidCallback action;
  final IconData iconData;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          splashColor: AppTheme.gray,
          onTap: action,
          child: Ink(
            color: AppTheme.darkTeal,
            child: CircleAvatar(
              radius: isLarge? 36 : 19,
              backgroundColor: Colors.transparent,
              child: Icon(
                iconData,
                color: AppTheme.white,
                size: isLarge? 36 : 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
