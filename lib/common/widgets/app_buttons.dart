import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class AppButtons extends StatelessWidget {
  final VoidCallback onClicked;
  final String title;
  final Color? backgroundColor;
  final Color? buttonColor;
  final double? minHeight;
  final double? minWidth;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  const AppButtons({
    super.key,
    required this.title,
    required this.onClicked,
    this.backgroundColor = CustomTheme.secondaryColor,
    this.buttonColor = CustomTheme.primaryText,
    this.minHeight = 36,
    this.minWidth = 64,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        minimumSize: Size(minWidth ?? 64, minHeight ?? 36),
      ),
      child: Text(title, style: textStyle ?? TextStyle(color: buttonColor)),
    );
  }
}
