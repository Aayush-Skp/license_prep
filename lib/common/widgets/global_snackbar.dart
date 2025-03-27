import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';

class GlobalSnackbar {
  static void show(
    String message, {
    Color backgroundColor = CustomTheme.secondaryColor,
    Color textColor = CustomTheme.primaryText,
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
              style: TextStyle(color: textColor, fontSize: 16),
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

  static void showCustomDialog({
    required String title,
    required String content,
    String actionText = 'OK',
  }) {
    final context = NavigationService.context;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  actionText.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 6,
          ),
    );
  }
}
