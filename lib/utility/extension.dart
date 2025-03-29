import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/pages/homescreen/provider/home_screem_provider.dart';
import 'package:provider/provider.dart';

extension Providers on BuildContext {
  DataProvider get dataProvider =>
      Provider.of<DataProvider>(this, listen: false);
  HomeScreenProvider get homeScreenProvider =>
      Provider.of<HomeScreenProvider>(this, listen: false);
}
