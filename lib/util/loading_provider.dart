// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/foundation.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
    if (_isLoading) {
      Future.delayed(Duration(seconds: 1), () {
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
