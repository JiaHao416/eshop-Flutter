// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../util/scroll_controller.dart';

class ScrollContainer extends StatefulWidget {
  final List<Widget> slivers;

  const ScrollContainer({
    required this.slivers,
  });

  @override
  _ScrollContainerState createState() => _ScrollContainerState();
}

class _ScrollContainerState extends State<ScrollContainer> {
  final ScrollController _controller = ScrollController();
  late ScrollVisibilityController _scrollVisibilityController;
  double _containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollVisibilityController = ScrollVisibilityController(_controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scrollVisibilityController.containerHeight = _containerHeight;
      });
    });
    _controller.addListener(_updateVisibility);
  }

  void _updateVisibility() {
    final visibility =
        _controller.offset > _scrollVisibilityController.containerHeight;
    setState(() {
      _scrollVisibilityController.isVisible = visibility;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateVisibility);
    _scrollVisibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          _containerHeight = constraints.maxHeight;
          _scrollVisibilityController.containerHeight = _containerHeight;
          return CustomScrollView(
            controller: _controller,
            slivers: widget.slivers, // 使用外部传递的slivers参数
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: _scrollVisibilityController.isVisible,
        child: FloatingActionButton(
          onPressed: () {
            _controller.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
