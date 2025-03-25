import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';

class GlobalSnackbar {
  static void show(
    String message, {
    Color backgroundColor = CustomTheme.secondaryColor,
  }) {
    final context = NavigationService.context;

    if (context.mounted) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              message,
              style: TextStyle(color: CustomTheme.primaryText, fontSize: 16),
            ),
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
          elevation: 8,
        ),
      );
    }
  }
}
