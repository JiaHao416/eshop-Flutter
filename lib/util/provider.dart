// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/util/loading_provider.dart';

import '../viewModle/home_page_view_model.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  AppProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel(ApiService())),
      ],
      child: child,
    );
  }
}
