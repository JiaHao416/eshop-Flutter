import 'package:flutter_app/viewModle/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  List<String> dataList = [];

  // 添加数据的方法
  void addData(String data) {
    dataList.add(data);
    notifyListeners();
  }
}
