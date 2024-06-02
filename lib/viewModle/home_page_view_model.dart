import 'package:flutter_app/base/base_view_model.dart';
import '../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  List<String> dataList = [];
  final ApiService apiService;

  HomeViewModel(this.apiService);

  void fetchData() async {
    try {
      var response = (await apiService.homepage(version: '2'));
      // if (response.success ?? false) {
      print("response: ${response}");
      //   notifyListeners();
      // } else {
      // print('Error: ${response.errorMessage}');
      // }
    } catch (error) {
      print("error : ${error}");
    }
  }

  // void login() async {
  //   try {
  //     var data = await apiService.login(LoginRequest(username: 'example', password: 'password'));
  //     print('Token: ${data.token}, User ID: ${data.userId}');
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  // 添加数据的方法
  void addData(String data) {
    dataList.add(data);
    notifyListeners();
  }
}
