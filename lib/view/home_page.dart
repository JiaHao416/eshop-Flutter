// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_app/components/scroll_container.dart';
import 'package:flutter_app/model/home_components.dart';
import 'package:flutter_app/model/marquee.dart';
import 'package:provider/provider.dart';
import '../viewModle/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel viewModel;
  late List<HomeComponent?> homeComponent = [];
  late List<Marquee>? marquee = [];

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.fetchData().then((_) {
      setState(() {
        homeComponent = viewModel.dataList;
        marquee = homeComponent[1]?.marquees;
        print("dataList : ${homeComponent}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollContainer(
      slivers: [
        if (marquee != null && marquee!.isNotEmpty) _buildHorizontalList(),
        _buildVerticalList(),
      ],
    );
  }

  Widget _buildHorizontalList() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        color: Color(int.parse('0xFFF2F2F2')),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: marquee!.length,
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
              '${marquee![index].text}',
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
