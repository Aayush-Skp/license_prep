import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';

AppBar myAppbar({bool showBackBUtton = true, title}) {
  return AppBar(
    backgroundColor: CustomTheme.appBarColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    centerTitle: true,
    leading:
        showBackBUtton
            ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade400),
              onPressed: () {
                Navigator.of(NavigationService.context).pop();
              },
            )
            : Container(),
    title: Text(
      title ?? '',
      style: Theme.of(NavigationService.context).textTheme.titleMedium,
    ),
  );
}
