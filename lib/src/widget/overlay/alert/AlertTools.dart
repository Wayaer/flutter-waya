import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/widgets.dart';import 'package:flutter_waya/src/constant/constant.dart';showToast(message, {Duration closeDuration}) {  AlertTools.showToast(message.toString(), closeDuration: closeDuration);}class AlertTools {  static Duration _duration = Duration(milliseconds: 1500);  ///设置全局弹窗时间  static void setToastDuration(Duration duration) {    _duration = duration;  }  static void showToast(String message,      {Color backgroundColor,        BoxDecoration boxDecoration,        GestureTapCallback onTap,        TextStyle textStyle,        Duration closeDuration}) {    OverlayTools.show(        AlertBase(            child: Container(              margin: EdgeInsets.symmetric(                  horizontal: ScreenFit.getWidth(0) / 5,                  vertical: ScreenFit.getHeight(0) / 4),              decoration: boxDecoration ??                  BoxDecoration(                      color: getColors(black90),                      borderRadius: BorderRadius.circular(5)),              padding: EdgeInsets.all(ScreenFit.getWidth(10)),              child: Widgets.textDefault(message,                  color: getColors(white), maxLines: 4),            )),        closeDuration: closeDuration ?? _duration);  }  static void close({OverlayElement element}) {    OverlayTools.close(element: element);  }  ///关闭所有  static void closeAll() {    OverlayTools.close();  }  static OverlayElement alertSureCancel({    @required List<Widget> children,    GestureTapCallback sureTap,    GestureTapCallback cancelTap,    String cancelText,    String sureText,    Widget sure,    Widget cancel,    PopupMode popupMode,    Color backgroundColor,    TextStyle cancelTextStyle,    TextStyle sureTextStyle,    double height,    bool isDismissible: true,    EdgeInsetsGeometry padding,    EdgeInsetsGeometry margin,    AlignmentGeometry alignment,    Decoration decoration,    bool animatedOpacity,    bool gaussian,    double width,    bool addMaterial, //是否添加Material Widget 部分组件需要基于Material  }) {    var alert = AlertSureCancel(      backsideTap: () {        if (isDismissible) close();      },      width: width,      popupMode: popupMode,      addMaterial: addMaterial,      animatedOpacity: animatedOpacity,      gaussian: gaussian,      children: children,      sureTap: sureTap ?? close,      cancelTap: cancelTap ?? close,      decoration: decoration,      alignment: alignment,      cancelText: cancelText,      sureText: sureText,      height: height,      cancelTextStyle: cancelTextStyle,      sureTextStyle: sureTextStyle,      sure: sure,      cancel: cancel,      backgroundColor: backgroundColor,      padding: padding,      margin: margin,    );    return OverlayTools.show(alert);  }  static OverlayElement showLoading({    String text,    double value,    bool gaussian,    Color backgroundColor,    Animation<Color> valueColor,    double strokeWidth,    String semanticsLabel,    String semanticsValue,    LoadingType loadingType,    TextStyle textStyle,  }) {    var loading = Loading(      gaussian: gaussian,      text: text,      value: value,      backgroundColor: backgroundColor,      valueColor: valueColor,      strokeWidth: strokeWidth ?? 4.0,      semanticsLabel: semanticsLabel,      semanticsValue: semanticsValue,      loadingType: loadingType ?? LoadingType.circular,      textStyle: textStyle,    );    return OverlayTools.show(loading);  }  static OverlayElement alertWidget({    @required Widget child,    double top,    double left,    double right,    double bottom,    Color color,    GestureTapCallback onTap,    bool addMaterial,  }) {    var widget = AlertBase(      child: child,      top: top,      left: left,      right: right,      bottom: bottom,      color: color,      onTap: onTap ?? () => close(),      addMaterial: addMaterial,    );    return OverlayTools.show(widget);  }}