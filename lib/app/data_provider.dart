import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:license_entrance/common/models/response_model.dart';
import 'package:license_entrance/services/http_services.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  Response? responseModel;
  bool isLoading = false;
  String? errorMessage;

  // DataProvider() {}

  Future<List<Datum>> fetchData({
    int pageNumber = 1,
    required BuildContext context,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final jsonMap = await service.get(
        endpointUrl: 'api/questions/page/$pageNumber',
      );
      if (jsonMap.containsKey('error')) {
        errorMessage = jsonMap['error'];
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage!)));
          print(errorMessage);
        }
        return [];
      } else {
        responseModel = responseFromJson(json.encode(jsonMap));
        if (responseModel!.status == 'success') {
          return responseModel!.data;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(responseModel!.message)));
            return [];
          }
        }
        return [];
      }
    } catch (e) {
      errorMessage = e.toString();
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
