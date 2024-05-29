import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget child; // 子部件

  BasePage({required this.child}); // 构造函数

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child, // 渲染子部件
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
