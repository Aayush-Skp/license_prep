import 'package:flutter/material.dart';
import 'package:license_entrance/app/my_splash_widget.dart';
import 'package:license_entrance/common/route/routes.dart';
import 'package:license_entrance/homepage/homepage.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          builder: (_) => MySplashScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.homepage:
        return MaterialPageRoute(
          builder: (_) => MyHomePage(),
          settings: RouteSettings(name: settings.name),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: RouteSettings(name: settings.name),
        );
    }
  }
}
