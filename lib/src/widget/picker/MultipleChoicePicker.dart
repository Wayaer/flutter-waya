import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/WayColor.dart';import 'package:flutter_waya/src/constant/WayStyles.dart';import 'package:flutter_waya/src/widget/picker/ListWheel.dart';class MultipleChoicePicker extends StatelessWidget {  //点击事件  final GestureTapCallback cancelTap;  final ValueChanged<int> sureTap;  //文字  final String sureText;  final String cancelText;  final String titleText;  //容器属性  final Color backgroundColor;  final double height;  //字体样式  final TextStyle cancelStyle;  final TextStyle titleStyle;  final TextStyle sureStyle;  ///以下为滚轮属性  //高度  final int initialIndex;  final double itemHeight;  final int itemCount;  final IndexedWidgetBuilder itemBuilder;  final double itemWidth;  // 半径大小,越大则越平面,越小则间距越大  final double diameterRatio;  // 选中item偏移  final double offAxisFraction;  //表示车轮水平偏离中心的程度  范围[0,0.01]  final double perspective;  //放大倍率  final double magnification;  //是否启用放大镜  final bool useMagnifier;  //1或者2  final double squeeze;  final ScrollPhysics physics;  final FixedExtentScrollController controller;  MultipleChoicePicker({    Key key,    String sureText,    String cancelText,    String titleText,    Color backgroundColor,    double height,    TextStyle cancelStyle,    TextStyle titleStyle,    TextStyle sureStyle,    this.cancelTap,    this.sureTap,    this.itemHeight,    this.itemWidth,    this.diameterRatio,    this.offAxisFraction,    this.perspective,    this.magnification,    this.useMagnifier,    this.squeeze,    this.physics,    this.initialIndex,    @required this.itemCount,    @required this.itemBuilder,  })      : this.height = height ?? Tools.getHeight() / 4,  ///文字设置        this.sureText = sureText ?? 'sure',        this.cancelText = cancelText ?? 'cancel',        this.titleText = titleText ?? 'title',  ///样式设置        this.cancelStyle = cancelStyle ?? WayStyles.textStyleBlack70(),        this.titleStyle = titleStyle ?? WayStyles.textStyleBlack70(),        this.sureStyle = sureStyle ?? WayStyles.textStyleBlack70(),        this.backgroundColor = backgroundColor ?? getColors(white),  ///controller        this.controller = FixedExtentScrollController(            initialItem: initialIndex ?? 0),        super(key: key);  @override  Widget build(BuildContext context) {    return CustomFlex(        mainAxisSize: MainAxisSize.min,        height: height,        decoration: BoxDecoration(color: backgroundColor ?? getColors(white)),        padding: EdgeInsets.all(Tools.getWidth(10)),        children: <Widget>[          Row(            mainAxisAlignment: MainAxisAlignment.spaceBetween,            children: <Widget>[              CustomButton(                padding: EdgeInsets.symmetric(                    horizontal: Tools.getWidth(5), vertical: Tools.getWidth(5)),                text: cancelText,                textStyle: cancelStyle,                onTap: cancelTap,              ),              CustomButton(text: titleText, textStyle: titleStyle),              CustomButton(                padding: EdgeInsets.symmetric(                    horizontal: Tools.getWidth(5), vertical: Tools.getWidth(5)),                text: sureText,                textStyle: sureStyle,                onTap: () {                  sureTap(controller.selectedItem ?? 0);                },              )            ],          ),          Expanded(              child: ListWheel(                controller: controller,                itemExtent: itemHeight,                diameterRatio: diameterRatio,                offAxisFraction: offAxisFraction,                perspective: perspective,                magnification: magnification,                useMagnifier: useMagnifier,                squeeze: squeeze,                physics: physics,                itemBuilder: itemBuilder,                itemCount: itemCount, //list.length,              ) //(int index, double pixels) {},          ),        ]);  }}