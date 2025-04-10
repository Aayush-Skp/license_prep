import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
// import 'package:license_entrance/common/shared_pref/shared_pref.dart';
// import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/pages/dashboard/dashboard_widget.dart';
import 'package:provider/provider.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        Provider.of<DataProvider>(context, listen: false).fetchData();
      }
    });
    _navigateToMyScreen();
  }

  void _navigateToMyScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    // final mytime = await SharedPref.getTime();
    if (mounted) {
      NavigationService.pushReplacement(page: DashBoardWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white38),
                backgroundColor: Colors.white24,
              ),
            ),
            Image.asset(
              CustomTheme.mainLogo,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
