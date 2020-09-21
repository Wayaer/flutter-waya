import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/widgets.dart';class MultipleChoicePicker extends StatelessWidget {  ///点击事件  final GestureTapCallback cancelTap;  final ValueChanged<int> sureTap;  ///title底部内容  final Widget titleBottom;  ///容器属性  final Color color;  final double height;  final Widget sure;  final Widget cancel;  final Widget title;  ///以下为ListWheel属性  ///高度  final int initialIndex;  final double itemHeight;  final int itemCount;  final IndexedWidgetBuilder itemBuilder;  final double itemWidth;  /// 半径大小,越大则越平面,越小则间距越大  final double diameterRatio;  /// 选中item偏移  final double offAxisFraction;  ///表示ListWheel水平偏离中心的程度  范围[0,0.01]  final double perspective;  ///放大倍率  final double magnification;  ///是否启用放大镜  final bool useMagnifier;  ///1或者2  final double squeeze;  final ScrollPhysics physics;  final FixedExtentScrollController controller;  MultipleChoicePicker({    Key key,    Color color,    double height,    this.cancelTap,    this.sureTap,    this.itemHeight,    this.itemWidth,    this.diameterRatio,    this.offAxisFraction,    this.perspective,    this.magnification,    this.useMagnifier,    this.squeeze,    this.physics,    this.initialIndex,    @required this.itemCount,    @required this.itemBuilder,    this.sure,    this.cancel,    this.title,    this.titleBottom,  })  : this.height = height ?? ScreenFit.getHeight(0) / 4,        this.color = color ?? getColors(white),        this.controller = FixedExtentScrollController(initialItem: initialIndex ?? 0),        super(key: key);  @override  Widget build(BuildContext context) {    List<Widget> children = [];    children.add(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[      Universal(child: cancel ?? Widgets.textDefault('cancel'), onTap: cancelTap),      Universal(child: title),      Universal(          child: sure ?? Widgets.textDefault('sure'),          onTap: () {            if (sureTap != null) sureTap(controller.selectedItem ?? 0);          })    ]));    if (titleBottom != null) children.add(titleBottom);    children.add(Expanded(        child: ListWheel(      controller: controller,      itemExtent: itemHeight,      diameterRatio: diameterRatio,      offAxisFraction: offAxisFraction,      perspective: perspective,      magnification: magnification,      useMagnifier: useMagnifier,      squeeze: squeeze,      physics: physics,      itemBuilder: itemBuilder,      itemCount: itemCount,    )));    return Universal(        mainAxisSize: MainAxisSize.min,        height: height,        decoration: BoxDecoration(color: color ?? getColors(white)),        padding: EdgeInsets.all(ScreenFit.getWidth(10)),        children: children);  }}