import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:license_entrance/common/models/response_model.dart';
import 'package:license_entrance/common/navigation/navigation_service.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';
import 'package:license_entrance/services/http_services.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();
  Response? responseModel;
  bool isLoading = false;
  bool isOffline = false;
  String? errorMessage;
  int currentPageNo = 1;
  final context = NavigationService.context;

  Future<List<Datum>> fetchData() async {
    isLoading = true;
    isOffline = false;
    errorMessage = null;
    currentPageNo = await SharedPref.getPageNumber();
    notifyListeners();
    try {
      log('-----------Fetching the page number $currentPageNo----------');
      final jsonMap = await service
          .get(endpointUrl: 'api/questions/page/$currentPageNo')
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException("Connection timeout");
            },
          );
      if (jsonMap.containsKey('error')) {
        errorMessage = "There is no Pages left!";
        if (context.mounted) {
          isOffline = true;
          GlobalSnackbar.show("Connection Problem!");
        }
        return [];
      } else {
        responseModel = responseFromJson(json.encode(jsonMap));
        if (responseModel!.status == 'success') {
          return responseModel!.data;
        } else {
          if (responseModel!.status == 'failure') {
            return [];
          }
          if (context.mounted) {
            GlobalSnackbar.show(responseModel!.message);
            return [];
          }
        }
        return [];
      }
    } on TimeoutException {
      isOffline = true;
      errorMessage = "Server is not responding. Please try again later.";
      GlobalSnackbar.show(errorMessage ?? 'Server Down!');
      return [];
    } on SocketException {
      isOffline = true;
      errorMessage = "No internet connection. Please check your network.";
      if (context.mounted) {
        GlobalSnackbar.show(errorMessage!);
      }
      return [];
    } catch (e) {
      isOffline = true;
      errorMessage = e.toString();
      GlobalSnackbar.show(errorMessage ?? 'Error Occured!');
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
