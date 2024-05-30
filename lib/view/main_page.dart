// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/components/bottom_navigation.dart';
import 'package:flutter_app/view/favorite_page.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/view/profile_page.dart';
import '../base/base_view.dart';
import '../components/loading.dart';

class MainPage extends BasePage {
  const MainPage({required BuildContext context, super.key})
      : super(context: context);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends BasePageState<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      loadingProvider.toggleLoading();
    });
  }

  Future<void> _onRefresh() async {
    // 模擬延遲，如實現真實的刷新功能，請在此處進行數據加載
    await Future.delayed(Duration(seconds: 2));
    // 刷新完成後調用 setState 或者其他刷新頁面內容的方法
    setState(() {
      // 這裡可以添加刷新後的邏輯
    });
  }

  Widget fragmentView() {
    switch (_selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return FavoritePage();
      case 2:
        return Profile();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            title: Text('AppBar'),
            backgroundColor: Colors.white,
            elevation: 0, // 设置为0，这样AppBar本身不会有阴影
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            backgroundColor: Colors.white,
            child: fragmentView(),
          ),
          LoadingDialog()
        ],
      ),
      bottomNavigationBar: BottomNavigationView(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
