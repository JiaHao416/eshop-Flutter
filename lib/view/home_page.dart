// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_app/components/scroll_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 创建 SliverToBoxAdapter 列表
    List<Widget> slivers = [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ListTile(
              title: Text('List 1 - Item $index'),
            );
          },
          childCount: 50,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ListTile(
              title: Text('List 2 - Item $index'),
            );
          },
          childCount: 50,
        ),
      ),
    ];

    // 将 slivers 传递给 ScrollContainer
    return ScrollContainer(
      slivers: slivers,
    );
  }
}
