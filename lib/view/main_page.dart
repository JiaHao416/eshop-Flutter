// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/components/bottom_navigation.dart';
import 'package:flutter_app/view/favorite_page.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/view/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text('AppBarLayout'),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: fragmentView(),
      ),
      bottomNavigationBar: BottomNavigationView(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
