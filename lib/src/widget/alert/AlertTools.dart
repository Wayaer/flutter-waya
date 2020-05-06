import 'package:flutter/cupertino.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/common/CommonWidget.dart';import 'package:flutter_waya/src/constant/WayColor.dart';import 'package:flutter_waya/src/widget/custom/OverlayBase.dart';showToast(message, {Duration closeDuration}) {  AlertTools.showToast(message.toString(), closeDuration: closeDuration);}showToastWidget(Widget widget, {Duration closeDuration}) {  AlertTools.showToastWidget(widget, closeDuration: closeDuration);}class AlertTools {  static BuildContext _buildContext = baseContext?.values?.first ?? null;  static OverlayEntry _entry;  static Duration _duration;  static BuildContext _privateContext;  /// 自定义弹窗  /// 无context 为底部弹出  static OverlayEntry alertWidget(Widget widget,      {BuildContext context, Duration closeDuration}) {    if (context == null) {      if (_buildContext == null) return null;      _entry = OverlayEntry(builder: (_buildContext) => widget);      Overlay.of(_buildContext).insert(_entry);      if (closeDuration != null) {        Future.delayed(closeDuration).then((value) {          _entry.remove();        });      }      return _entry;    } else {      _privateContext = context;      showCupertinoDialog(          context: context, builder: (BuildContext context) => widget);      if (closeDuration != null) {        Future.delayed(closeDuration).then((value) {          NavigatorTools.getInstance().pop();        });      }      return null;    }  }  ///自定义Toast  static void showToastWidget(Widget widget, {Duration closeDuration}) {    if (_buildContext == null) return;    OverlayEntry overlayEntry = OverlayEntry(builder: (context) => widget);    Overlay.of(_buildContext).insert(overlayEntry);    Future.delayed(closeDuration ?? (_duration ?? Duration(milliseconds: 1500)))        .then((value) {      overlayEntry.remove();    });  }  ///设置全局弹窗时间  static void setToastDuration(Duration duration) {    _duration = duration;  }  static void showToast(String message,      {Color backgroundColor,        BoxDecoration boxDecoration,        GestureTapCallback onTap,        TextStyle textStyle,        Duration closeDuration}) {    AlertTools.showToastWidget(        AlertBase(            backgroundColor: backgroundColor ?? getColors(transparent),            onTap: onTap ?? () {},            child: Container(              margin: EdgeInsets.symmetric(horizontal: Tools.getWidth() / 5,                  vertical: Tools.getHeight() / 4),              decoration:              boxDecoration ?? BoxDecoration(color: getColors(black90),                  borderRadius: BorderRadius.circular(5)),              padding: EdgeInsets.all(Tools.getWidth(10)),              child: CommonWidget.textDefault(message, color: getColors(white)),            )),        closeDuration: closeDuration);  }  static void close() {    if (_privateContext == null) {      Overlay.of(_buildContext);      if (_entry != null) _entry.remove();    } else {      NavigatorTools.getInstance().pop();    }    _privateContext = null;  }  static OverlayEntry alertSureCancel(Widget widget, {    BuildContext context,    GestureTapCallback sureTap,    GestureTapCallback cancelTap,    String cancelText,    String sureText,    Widget sure,    Widget cancel,    Color backgroundColor,    TextStyle cancelTextStyle,    TextStyle sureTextStyle,    double height,    bool onTapBackClose: true,    EdgeInsetsGeometry padding,    AlertPosition position,    EdgeInsetsGeometry margin,    Decoration decoration,  }) {    var alert = AlertSureCancel(      backsideTap: () {        if (onTapBackClose) close();      },      content: widget,      sureTap: sureTap ?? close,      cancelTap: cancelTap ?? close,      decoration: decoration,      margin: margin,      position: position,      cancelText: cancelText,      sureText: sureText,      height: height,      cancelTextStyle: cancelTextStyle,      sureTextStyle: sureTextStyle,      sure: sure,      cancel: cancel,      backgroundColor: backgroundColor,      padding: padding,    );    return AlertTools.alertWidget(alert, context: context);  }  static OverlayEntry showLoading({    String text,    double value,    Color backgroundColor,    Animation<Color> valueColor,    double strokeWidth,    String semanticsLabel,    String semanticsValue,    LoadingType loadingType,    TextStyle textStyle,    BuildContext context,  }) {    var loading = Loading(      text: text,      value: value,      backgroundColor: backgroundColor,      valueColor: valueColor,      strokeWidth: strokeWidth ?? 4.0,      semanticsLabel: semanticsLabel,      semanticsValue: semanticsValue,      loadingType: loadingType ?? LoadingType.circular,      textStyle: textStyle,    );    return AlertTools.alertWidget(loading, context: context);  }}