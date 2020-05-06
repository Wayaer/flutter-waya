import 'package:flutter/cupertino.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/model/MapModel.dart';import 'package:flutter_waya/src/widget/alert/AlertBase.dart';import 'package:flutter_waya/src/widget/alert/AlertTools.dart';import 'package:flutter_waya/src/widget/picker/DateTimePicker.dart';import 'package:flutter_waya/src/widget/picker/MultipleChoicePicker.dart';class PickerTools {  ///有context 弹窗 使用 官方showCupertinoModalPopup 方法  带动画  ///关闭方法  Navigator pop即可  ///无context 弹窗 使用 自定义弹窗 方法  无动画  ///关闭方法  AlertTools.close() 即可  static void alertDateTimePicker({    BuildContext context,    Color backgroundColor, //背景色    String sureText, //确认按钮文字    String cancelText, //取消按钮文字    String titleText, //头部文字    TextStyle titleStyle, //头部文字样式    TextStyle sureStyle, //确认文字样式    TextStyle cancelStyle, //取消文字样式    TextStyle contentStyle, //选择框内文字样式    TextStyle unitStyle, //单位样式    GestureTapCallback cancelTap, //取消点击事件    ValueChanged<String> sureTap, //确认点击事件    double itemHeight, //单个item的高度    double itemWidth, //单个item的宽度    double height, //整个弹框高度    DateTime startDate, //开始时间    DateTime defaultDate, //默认选中时间    DateTime endDate, //结束时间    bool dual, //补全双位数    bool showUnit, //是否显示单位    DateTimePickerUnit unit, //单位数组    List<DateTimePickerType> pickerType, //时间选择器类型    // 半径大小,越大则越平面,越小则间距越大    double diameterRatio,    // 选中item偏移    double offAxisFraction,    //表示车轮水平偏离中心的程度  范围[0,0.01]    double perspective,    //放大倍率    double magnification,    //是否启用放大镜    bool useMagnifier,    //1或者2    double squeeze,    ScrollPhysics physics,    bool onTapBackClose: false,  }) {    if (context != null) Tools.closeKeyboard(context);    Widget widget = AlertBase(        position: AlertPosition.bottom,        onTap: !onTapBackClose            ? null            : close,        child: DateTimePicker(            diameterRatio: diameterRatio,            offAxisFraction: offAxisFraction,            perspective: perspective,            magnification: magnification,            useMagnifier: useMagnifier,            squeeze: squeeze,            itemHeight: itemHeight,            itemWidth: itemWidth,            height: height,            startDate: startDate,            endDate: endDate,            defaultDate: defaultDate,            dual: dual,            showUnit: showUnit,            unit: unit,            sureText: sureText,            cancelText: cancelText,            titleText: titleText,            backgroundColor: backgroundColor,            titleStyle: titleStyle,            sureStyle: sureStyle,            cancelStyle: cancelStyle,            contentStyle: contentStyle,            unitStyle: unitStyle,            pickerType: pickerType,            cancelTap: cancelTap ?? close,            sureTap: sureTap ?? close));    AlertTools.alertWidget(widget, context: context);  }  static void alertMultipleChoicePicker({    BuildContext context,    int initialIndex, //默认选中    Color backgroundColor, //背景色    String sureText, //确认按钮文字    String cancelText, //取消按钮文字    String titleText, //头部文字    TextStyle titleStyle, //头部文字样式    TextStyle sureStyle, //确认文字样式    TextStyle cancelStyle, //取消文字样式    GestureTapCallback cancelTap, //取消点击事件    ValueChanged<int> sureTap, //确认点击事件    double itemHeight, //单个item的高度    double itemWidth, //单个item的宽度    double height, //整个弹框高度    // 半径大小,越大则越平面,越小则间距越大    double diameterRatio,    // 选中item偏移    double offAxisFraction,    //表示车轮水平偏离中心的程度  范围[0,0.01]    double perspective,    //放大倍率    double magnification,    //是否启用放大镜    bool useMagnifier,    //1或者2    double squeeze,    ScrollPhysics physics,    @required int itemCount,    @required IndexedWidgetBuilder itemBuilder,  }) {    if (context != null) Tools.closeKeyboard(context);    Widget widget = AlertBase(        position: AlertPosition.bottom,        onTap: close,        child: MultipleChoicePicker(            itemCount: itemCount,            itemBuilder: itemBuilder,            diameterRatio: diameterRatio,            offAxisFraction: offAxisFraction,            perspective: perspective,            magnification: magnification,            useMagnifier: useMagnifier,            squeeze: squeeze,            itemHeight: itemHeight,            itemWidth: itemWidth,            height: height,            initialIndex: initialIndex,            sureText: sureText,            cancelText: cancelText,            titleText: titleText,            backgroundColor: backgroundColor,            titleStyle: titleStyle,            sureStyle: sureStyle,            cancelStyle: cancelStyle,            cancelTap: cancelTap ?? close,            sureTap: sureTap ?? close));    AlertTools.alertWidget(widget, context: context);  }  //关闭所有picker  static void close() {    AlertTools.close();  }}