// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_app/components/scroll_container.dart';
import 'package:provider/provider.dart';

import '../viewModle/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollContainer(
      slivers: [
        _buildHorizontalList(),
        _buildVerticalList(),
      ],
    );
  }

  Widget _buildHorizontalList() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return _buildGridItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              'Grid Item $index',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ),
        Container(
          width: 1,
          color: Color(int.parse('0xFF459B2C')),
          margin: EdgeInsets.only(top: 2, bottom: 2),
        ),
      ],
    );
  }

  Widget _buildVerticalList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            title: Text('Vertical List - Item $index'),
          );
        },
        childCount: 50,
      ),
    );
  }
}
