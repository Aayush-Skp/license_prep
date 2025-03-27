import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class OfflinePage extends StatelessWidget {
  final Future<void> Function() onRefresh;
  const OfflinePage({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(
              "Server Offline😔!",
              style: TextStyle(color: CustomTheme.primaryText, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
