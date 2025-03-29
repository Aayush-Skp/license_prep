import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class AppButtons extends StatelessWidget {
  final VoidCallback onClicked;
  final String title;
  final Color? backgroundColor;
  final Color? buttonColor;
  const AppButtons({
    super.key,
    required this.title,
    required this.onClicked,
    this.backgroundColor = CustomTheme.secondaryColor,
    this.buttonColor = CustomTheme.primaryText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(title, style: TextStyle(color: buttonColor)),
    );
  }
}
