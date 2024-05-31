// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/components/splash.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/util/loading_provider.dart';
import 'package:provider/provider.dart';

import 'viewModle/home_page_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(ApiService())), // 提供 HomeViewModel
        // 添加其他 Provider...
      ],
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
