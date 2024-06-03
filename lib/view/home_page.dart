// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/scroll_container.dart';
import 'package:flutter_app/model/home_components.dart';
import 'package:flutter_app/model/marquee.dart';
import 'package:flutter_app/util/color.dart';
import 'package:provider/provider.dart';
import '../viewModle/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel viewModel;
  late List<HomeComponent?> homeComponent = [];
  late List<MarqueeResponse>? marquee = [];
  late ScrollController _scrollController =
      ScrollController(); // 添加ScrollController
  Timer? _timer;
  final double itemWidth = 150.0; // 设置每个项的宽度

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
    _scrollController = ScrollController(); // 初始化ScrollController
    _autoScroll(); // 启动自动滚动
  }

  void _autoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          double targetPosition =
              _scrollController.position.pixels + 10; // 每次滚动1像素
          _scrollController.animateTo(
            targetPosition,
            duration: Duration(milliseconds: 100), // 每次滚动的时间
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
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
        height: 30,
        color: hexToColor("#F2F2F2"),
        child: ListView.builder(
          controller: _scrollController,
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
              style: TextStyle(
                  fontSize: 12, color: hexToColor(marquee![index].textColour)),
            ),
          ),
        ),
        Container(
          width: 1,
          color: hexToColor("#459B2C"),
          margin: EdgeInsets.only(top: 5, bottom: 5),
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
