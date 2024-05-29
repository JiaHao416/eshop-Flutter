import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isShowLoading = false;
  String _errorMessage = "";

  bool get isShowLoading => _isShowLoading;
  String get errorMessage => _errorMessage;

  void setIsShowLoading(bool value) {
    _isShowLoading = value;
    notifyListeners();
  }

  void setIsShowError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
}
