import 'package:flutter/material.dart';

class ScrollVisibilityController {
  final ScrollController controller;
  bool isVisible = false;
  double containerHeight = 0.0;

  ScrollVisibilityController(this.controller) {
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    isVisible = controller.offset > containerHeight;
  }

  void dispose() {
    controller.removeListener(_scrollListener);
  }
}
