import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class OfflinePage extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String message;
  const OfflinePage({
    super.key,
    required this.onRefresh,
    this.message = "Server Offline😔!",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: size.height,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 24 : size.width * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 80, color: Colors.grey),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CustomTheme.primaryText.withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: CustomTheme.primaryText,
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => onRefresh(),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Pull down to refresh",
                style: TextStyle(
                  color: CustomTheme.primaryText.withAlpha(200),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
