import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/way.dart';class MultipleChoicePicker extends StatelessWidget {  MultipleChoicePicker({    Key key,    Color color,    double height,    this.cancelTap,    this.sureTap,    this.itemHeight,    this.itemWidth,    this.diameterRatio,    this.offAxisFraction,    this.perspective,    this.magnification,    this.useMagnifier,    this.squeeze,    this.physics,    this.initialIndex,    @required this.itemCount,    @required this.itemBuilder,    Widget sure,    Widget cancel,    Widget title,    this.titleBottom,  })  : height = height ?? ConstConstant.pickerHeight,        sure = sure ?? WayWidgets.textDefault('sure'),        title = title ?? WayWidgets.textDefault('title'),        cancel = cancel ?? WayWidgets.textDefault('cancel'),        color = color ?? getColors(white),        controller = FixedExtentScrollController(initialItem: initialIndex ?? 0),        super(key: key);  ///点击事件  final GestureTapCallback cancelTap;  final ValueChanged<int> sureTap;  ///[title]底部内容  final Widget titleBottom;  final Widget sure;  final Widget cancel;  final Widget title;  final Color color;  final double height;  ///以下为ListWheel属性  final int initialIndex;  final double itemHeight;  final int itemCount;  final IndexedWidgetBuilder itemBuilder;  final double itemWidth;  /// 半径大小,越大则越平面,越小则间距越大  final double diameterRatio;  /// 选中item偏移  final double offAxisFraction;  ///表示ListWheel水平偏离中心的程度  范围[0,0.01]  final double perspective;  ///放大倍率  final double magnification;  ///是否启用放大镜  final bool useMagnifier;  ///1或者2  final double squeeze;  final ScrollPhysics physics;  final FixedExtentScrollController controller;  @override  Widget build(BuildContext context) {    final List<Widget> children = <Widget>[];    children.add(Universal(        direction: Axis.horizontal,        padding: const EdgeInsets.all(10),        mainAxisAlignment: MainAxisAlignment.spaceBetween,        children: <Widget>[          Universal(child: cancel, onTap: cancelTap),          Universal(child: title),          Universal(              child: sure,              onTap: () {                if (sureTap != null) sureTap(controller.selectedItem ?? 0);              })        ]));    if (titleBottom != null) children.add(titleBottom);    children.add(Expanded(        child: ListWheel(            controller: controller,            itemExtent: itemHeight,            diameterRatio: diameterRatio,            offAxisFraction: offAxisFraction,            perspective: perspective,            magnification: magnification,            useMagnifier: useMagnifier,            squeeze: squeeze,            physics: physics,            itemBuilder: itemBuilder,            itemCount: itemCount)));    return Universal(        mainAxisSize: MainAxisSize.min,        height: height,        decoration: BoxDecoration(color: color ?? getColors(white)),        children: children);  }}