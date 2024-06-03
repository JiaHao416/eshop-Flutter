import 'package:flutter_app/base/base_view_model.dart';
import '../model/home_components.dart';
import '../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  List<HomeComponent?> dataList = [];
  final ApiService apiService;

  HomeViewModel(this.apiService);

  Future<void> fetchData() async {
    try {
      var response = await apiService.homepage(version: '2');
      if (response.success ?? false) {
        addData(response.data ?? []);
      } else {
        // print('Error: ${response.errorMessage}');
      }
    } catch (error) {
      // print("error : ${error}");
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
  void addData(List<HomeComponent?> data) {
    dataList.addAll(data);
    notifyListeners();
  }
}
