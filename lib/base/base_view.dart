// base_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/loading_provider.dart';

abstract class BasePage extends StatefulWidget {
  final BuildContext context;
  const BasePage({required this.context, super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  late LoadingProvider loadingProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadingProvider =
        Provider.of<LoadingProvider>(widget.context, listen: false);
  }

  @override
  void initState() {
    super.initState();
  }
}
