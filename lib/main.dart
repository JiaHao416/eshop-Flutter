// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/components/splash.dart';
import 'package:flutter_app/util/loading_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadingProvider(),
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
