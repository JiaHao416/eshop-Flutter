import 'package:flutter/material.dart';

class ScrollVisibilityController extends StatefulWidget {
  final Widget child;

  const ScrollVisibilityController({Key? key, required this.child})
      : super(key: key);

  @override
  _ScrollVisibilityControllerState createState() =>
      _ScrollVisibilityControllerState();
}

class _ScrollVisibilityControllerState
    extends State<ScrollVisibilityController> {
  final ScrollController _controller = ScrollController();
  bool _isVisible = false;
  double _containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final double scrollPosition = _controller.position.pixels;
    setState(() {
      _isVisible = scrollPosition > _containerHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _containerHeight = constraints.maxHeight;
        return Stack(
          children: [
            widget.child,
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: _isVisible
                  ? FloatingActionButton(
                      onPressed: () {
                        // Scroll to the top when FAB is pressed
                        _controller.animateTo(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_upward),
                    )
                  : SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
