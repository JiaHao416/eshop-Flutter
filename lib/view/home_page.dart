// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/marquees.dart';
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

class _IntegralCurve extends Curve {
  /// Delta for integrating.
  static double delta = 0.01;

  _IntegralCurve._(this.original, this.integral, this._values);

  /// The original curve that was integrated.
  final Curve original;

  /// The integral value.
  final double integral;

  /// Cached cumulative values of the integral.
  final Map<double, double> _values;

  /// The constructor that takes the [original] curve.
  factory _IntegralCurve(Curve original) {
    double integral = 0.0;
    final values = Map<double, double>();

    for (double t = 0.0; t <= 1.0; t += delta) {
      integral += original.transform(t) * delta;
      values[t] = integral;
    }
    values[1.0] = integral;

    // Normalize.
    for (final double t in values.keys) values[t] = values[t]! / integral;

    return _IntegralCurve._(original, integral, values);
  }

  /// Transforms a value to the normalized integrated value of the [original]
  /// curve.
  double transform(double t) {
    if (t < 0) return 0.0;
    for (final key in _values.keys) if (key > t) return _values[key]!;
    return 1.0;
  }
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel viewModel;
  late List<HomeComponent?> homeComponent = [];
  late List<MarqueeResponse>? marquee = [];
  late ScrollController _scrollController =
      ScrollController(); // 添加ScrollController
  Timer? _timer;
  final double itemWidth = 150.0; // 设置每个项的宽度
  bool _running = false;
  bool _isOnPause = false;
  late double _startPosition; // At the start, before accelerating.
  int _roundCounter = 0;
  late double
      _accelerationTarget; // After accelerating, before moving linearly.
  late double _linearTarget; // After moving linearly, before decelerating.
  late double _decelerationTarget; // After decelerating.
  Duration? _linearDuration;
  late Duration _totalDuration;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    _scrollController = ScrollController(); // 初始化ScrollController
    viewModel.fetchData().then((_) {
      setState(() {
        homeComponent = viewModel.dataList;
        marquee = homeComponent[1]?.marquees;
        print("dataList : ${homeComponent}");
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        print("scroll");
        _autoScroll();
      });
    });
  }

  void _initialize(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox listViewBox = context.findRenderObject() as RenderBox;
      double listViewWidth = listViewBox.size.width;
      // 现在可以使用 listViewWidth 了
      final totalLength = listViewWidth + 20.0;
      final accelerationLength = _IntegralCurve(Curves.linear).integral *
          50.0 *
          Duration.zero.inMilliseconds /
          1000.0;
      final decelerationLength = _IntegralCurve(Curves.linear).integral *
          50.0 *
          Duration.zero.inMilliseconds /
          1000.0;
      final linearLength =
          (totalLength - accelerationLength.abs() - decelerationLength.abs()) *
              (50.0 > 0 ? 1 : -1);

      // Calculate scroll positions at various scrolling phases.
      _startPosition = 0.00;
      _accelerationTarget = _startPosition + accelerationLength;
      _linearTarget = _accelerationTarget + linearLength;
      _decelerationTarget = _linearTarget + decelerationLength;

      // Calculate durations for the phases.
      _totalDuration = Duration.zero +
          Duration.zero +
          Duration(milliseconds: (linearLength / 50.0 * 1000).toInt());
      _linearDuration = _totalDuration - Duration.zero - Duration.zero;

      assert(
        _totalDuration > Duration.zero,
        "With the given values, the total duration for one round would be "
        "negative. As time travel isn't invented yet, this shouldn't happen.",
      );
      assert(
        _linearDuration! >= Duration.zero,
        "Acceleration and deceleration phase overlap. To fix this, try a "
        "combination of these approaches:\n"
        "* Make the text longer, so there's more room to animate within.\n"
        "* Shorten the accelerationDuration or decelerationDuration.\n"
        "* Decrease the velocity, so the duration to animate within is longer.\n",
      );
    });
    // Calculate lengths (amount of pixels that each phase needs).
  }

  void _autoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_running) {
        _running = true;
        if (_scrollController.hasClients) {
          double currentPosition = _scrollController.position.pixels;
          double maxScrollExtent = _scrollController.position.maxScrollExtent;

          // 检查当前位置是否超出最大滚动范围
          if (currentPosition >= maxScrollExtent) {
            // 当前位置超出最大滚动范围，执行滚动回到第一个项目
            _scrollController.jumpTo(_startPosition);
          } else {
            // 当前位置未超出最大滚动范围，继续执行自动滚动逻辑
            _scrollController.jumpTo(_startPosition);
            await Future<void>.delayed(Duration.zero);
            Future.doWhile(_scroll);
          }
        }
      }
    });

    //   if (_scrollController.hasClients) {
    //     if (_scrollController.position.pixels >=
    //         _scrollController.position.maxScrollExtent) {
    //       _scrollController.jumpTo(0);
    //     } else {
    //       double targetPosition =
    //           _scrollController.position.pixels + 10; // 每次滚动1像素
    //       _scrollController.animateTo(
    //         targetPosition,
    //         duration: Duration(milliseconds: 100), // 每次滚动的时间
    //         curve: Curves.linear,
    //       );
    //     }
    //   }
  }

  Future<bool> _scroll() async {
    await _makeRoundTrip();

    return _running && _scrollController.hasClients;
  }

  /// Causes the controller to scroll one round.
  Future<void> _makeRoundTrip() async {
    // Reset the controller, then accelerate, move linearly and decelerate.
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_startPosition);
    if (!_running) return;

    await _accelerate();
    if (!_running) return;

    await _moveLinearly();
    if (!_running) return;

    await _decelerate();

    _roundCounter++;

    if (!_running || !mounted) return;
  }

  // Methods that animate the controller.
  Future<void> _accelerate() async {
    await _animateTo(
      _accelerationTarget,
      Duration.zero,
      Curves.linear,
    );
  }

  Future<void> _moveLinearly() async {
    await _animateTo(_linearTarget, _linearDuration, Curves.linear);
  }

  Future<void> _decelerate() async {
    await _animateTo(
      _decelerationTarget,
      Duration.zero,
      Curves.linear,
    );
  }

  /// Helping method that either animates to the given target position or jumps
  /// right to it if the duration is Duration.zero.
  Future<void> _animateTo(
    double? target,
    Duration? duration,
    Curve curve,
  ) async {
    if (!_scrollController.hasClients) return;
    if (duration! > Duration.zero) {
      await _scrollController.animateTo(target!,
          duration: duration, curve: curve);
    } else {
      _scrollController.jumpTo(target!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _running = false;

    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
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
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print('Clicked on horizontal item $index');
                // 处理点击事件
              },
              child: _buildGridItem(index),
            );
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
