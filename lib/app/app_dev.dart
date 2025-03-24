import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
import 'package:license_entrance/common/route/routes.dart';
import 'package:license_entrance/common/route/routes_generator.dart';

class AppDev extends StatelessWidget {
  const AppDev({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: MaterialApp(
        locale: const Locale('en', 'US'),
        navigatorKey: NavigationService.navigatorKey,
        // supportedLocales: context.supportedLocales,
        // localizationsDelegates: ,
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.lightTheme,
        themeMode: ThemeMode.system,
        title: "License Prep",
        initialRoute: Routes.root,
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
