import 'package:flutter/material.dart';
import 'package:license_entrance/app/app_dev.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/pages/homescreen/provider/home_screem_provider.dart';
import 'package:license_entrance/utility/extension.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(context.dataProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AppDev());
  }
}
