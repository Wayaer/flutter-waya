import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/WayColor.dart';class HintPoint extends StatelessWidget {  final Widget child;  final Widget pointChild;  final double width;  final double height;  final GestureTapCallback onTap;  final EdgeInsetsGeometry margin;  final EdgeInsetsGeometry pointPadding;  final Color pointColor;  final double pointSize;  final bool hide;  final double top;  final double right;  final double bottom;  final double left;  const HintPoint(      {Key key,      @required this.child,      this.pointPadding,      this.width,      this.height,      this.onTap,      this.margin,      this.pointColor,      this.top,      this.right,      this.bottom,      this.left,      this.pointSize,      bool hide,      this.pointChild})      : this.hide = hide ?? false,        super(key: key);  @override  Widget build(BuildContext context) {    if (hide) {      return child;    }    return Universal(      onTap: onTap,      margin: margin,      width: width,      height: height,      child: Stack(        children: <Widget>[          child,          Positioned(              right: right,              top: top,              bottom: bottom,              left: left,              child: Container(                child: pointChild,                padding: pointPadding,                width: pointChild == null                    ? (pointSize ?? Tools.getWidth(4))                    : null,                height: pointChild == null                    ? (pointSize ?? Tools.getWidth(4))                    : null,                decoration: BoxDecoration(                    color: pointColor ?? getColors(red),                    shape: BoxShape.circle),              ))        ],      ),    );  }}