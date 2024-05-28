// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/util/loading_provider.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  final Widget child;

  const Loading({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, _) {
        if (loadingProvider.isLoading) {
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
