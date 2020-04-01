import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_waya/waya.dart';

typedef WheelChangedListener = Function(int newIndex);

class ListWheel extends StatefulWidget {
  /// 每个Item的高度,固定的
  double itemExtent;

  /// 条目构造器
  final IndexedWidgetBuilder itemBuilder;

  /// 条目数量
  final int itemCount;

  /// 半径大小,越大则越平面,越小则间距越大
  double diameterRatio;

  /// 选中item偏移
  double offAxisFraction;

  ///表示车轮水平偏离中心的程度  范围[0,0.01]
  double perspective;

  /// 初始选中的Item
  int initialIndex;

  /// 回调监听
  final WheelChangedListener onItemSelected;

  /// ///放大倍率
  double magnification;

  ///是否启用放大镜
  bool useMagnifier;

  ///1或者2
  double squeeze;

  ///
  ScrollPhysics physics;

  FixedExtentScrollController controller;

  ListWheel({
    @required this.itemBuilder,
    @required this.itemCount,
    this.itemExtent,
    this.diameterRatio,
    this.offAxisFraction,
    this.initialIndex,
    this.controller,
    this.onItemSelected, this.perspective, this.magnification, this.useMagnifier, this.squeeze, this.physics,
  }) {
    if (diameterRatio == null) diameterRatio = 1;
    if (offAxisFraction == null) offAxisFraction = 0;
    if (initialIndex == null) initialIndex = 0;
    if (perspective == null) perspective = 0.01;
    if (magnification == null) magnification = 1.5;
    if (useMagnifier == null) useMagnifier = true;
    if (squeeze == null) squeeze = 1;
    if (itemExtent == null) itemExtent = BaseUtils.getHeight(12);
    if (physics == null) physics = FixedExtentScrollPhysics();
    if (controller == null) controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  ListWheelState createState() => ListWheelState();
}

class ListWheelState extends State<ListWheel> {
  FixedExtentScrollController controller;

  void animateToItem(int index) {
    if (controller != null && controller.hasClients) {
      if (widget.onItemSelected != null && widget.itemCount > 0) {
        if (index == null || index < 0) {
          index = 0;
        } else if (index > this.widget.itemCount - 1) {
          index = this.widget.itemCount - 1;
        }
        controller.animateToItem(index,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    if (widget.controller != null &&
        widget.initialIndex > widget.controller.initialItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animateToItem(widget.initialIndex);
      });
    }
  }

  @override
  void didUpdateWidget(ListWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        animateToItem(widget.initialIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollEndNotification>(
        onNotification: onNotification,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: widget.itemExtent,
          physics: widget.physics,
          diameterRatio: widget.diameterRatio,
          onSelectedItemChanged: (_) {},
          offAxisFraction: widget.offAxisFraction,
          perspective: widget.perspective,
          useMagnifier: widget.useMagnifier,
          squeeze: widget.squeeze,
          magnification: widget.magnification,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: widget.itemBuilder,
            childCount: widget.itemCount,
          ),
        ),
      );

  bool onNotification(ScrollEndNotification notification) {
    //   滚动结束的监听事件
    if (notification is ScrollEndNotification && widget.onItemSelected != null) {
      var pixels = notification.metrics.pixels;
      var newIndex = (pixels / widget.itemExtent).round();
      widget.onItemSelected(newIndex);
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
