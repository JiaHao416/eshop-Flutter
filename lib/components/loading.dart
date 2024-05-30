// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/util/loading_provider.dart';
import 'package:provider/provider.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, _) {
        if (loadingProvider.isLoading) {
          Future.microtask(() => _showLoadingDialog(context));
        } else {
          Future.microtask(() => _hideLoadingDialog(context));
        }
        return SizedBox.shrink();
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _hideLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
