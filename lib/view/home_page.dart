// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = _controller.position.pixels > _containerHeight;
      });
    });
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  double _containerHeight = 0.0;

  void _scrollListener() {
    setState(() {
      _isVisible = _controller.offset > _containerHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          _containerHeight = constraints.maxHeight;
          return Container(
            color: Colors.grey[200],
            child: ListView.builder(
              controller: _controller,
              itemCount: 50,
              itemExtent: 50,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: _isVisible
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
          : null,
    );
  }
}
