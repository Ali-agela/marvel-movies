import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel/services/api.dart';

class BaseProvider with ChangeNotifier {
  Api api = Api();

  bool isLoading = true;
  bool isFaild = false;

  setIsLoading(bool loading) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = loading;
      notifyListeners();
    });
  }

  setIsFaild(bool loading) {
    isFaild = loading;
    notifyListeners();
  }
}
