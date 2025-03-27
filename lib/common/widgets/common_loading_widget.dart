import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 115,
            height: 115,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white38),
              backgroundColor: Colors.white24,
            ),
          ),
          Image.asset(
            CustomTheme.mainLogo,
            width: 75,
            height: 75,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
