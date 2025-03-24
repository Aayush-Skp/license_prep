import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
import 'package:license_entrance/homepage/homepage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMyScreen();
  }

  void _navigateToMyScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      NavigationService.pushReplacement(page: MyHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      body: Center(
        child: Image.asset(
          CustomTheme.mainLogo,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
