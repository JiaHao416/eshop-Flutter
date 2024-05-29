// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/util/loading_provider.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  final Widget child;
  final bool cancellable;

  Loading({required this.child, this.cancellable = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, _) {
        if (loadingProvider.isLoading) {
          return WillPopScope(
            onWillPop: () async => cancellable,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
          // return Container(

          //   color: Colors.black.withOpacity(0.5),
          //   child: Center(
          //     child: Container(
          //       width: 50,
          //       height: 50,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     ),
          //   ),
          // );
        } else {
          return child;
        }
      },
    );
  }
}
