// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';

class ScrollVisibilityController {
  final ScrollController controller;
  bool isVisible = false;
  double containerHeight = 0.0;

  ScrollVisibilityController(this.controller) {
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    final visibility = controller.offset > containerHeight;
    isVisible = visibility;
  }

  void dispose() {
    controller.removeListener(_scrollListener);
  }
}
