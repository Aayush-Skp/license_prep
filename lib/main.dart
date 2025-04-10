import 'dart:async';

import 'package:flutter/material.dart';
import 'package:license_entrance/app/app_dev.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/common/util/log.dart';
import 'package:license_entrance/pages/homescreen/provider/home_screem_provider.dart';
import 'package:license_entrance/utility/extension.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => DataProvider()),
            ChangeNotifierProvider(
              create: (context) => HomeScreenProvider(context.dataProvider),
            ),
          ],
          child: const AppDev(),
        ),
      );
    },
    (e, s) {
      Log.e(e);
      Log.d(s);
    },
  );
}
