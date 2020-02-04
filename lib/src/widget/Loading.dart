import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/WayColor.dart';class Loading extends Dialog {  String text;  final double value;  final Color backgroundColor;  final Animation<Color> valueColor;  final double strokeWidth;  final String semanticsLabel;  final String semanticsValue;  final LoadingType loadingType;  TextStyle textStyle;  Loading({    this.value,    this.textStyle,    this.backgroundColor,    this.valueColor,    this.strokeWidth: 4.0,    this.semanticsLabel,    this.semanticsValue,    this.loadingType: LoadingType.Circular,    this.text: '加载中...',  }) {    if (textStyle == null)      textStyle = TextStyle(          color: getColors(black), fontSize: 14, fontWeight: FontWeight.w600);  }  @override  Widget build(BuildContext context) {    return AlertBase(      onTap: () {},      child: Container(        padding: EdgeInsets.all(BaseUtils.getWidth(20)),        decoration: BoxDecoration(          color: backgroundColor ?? getColors(white),          borderRadius: BorderRadius.circular(8.0),        ),        child: Column(          mainAxisAlignment: MainAxisAlignment.spaceBetween,          crossAxisAlignment: CrossAxisAlignment.center,          mainAxisSize: MainAxisSize.min,          children: <Widget>[            Offstage(              offstage: loadingType != LoadingType.Circular,              child: CircularProgressIndicator(                value: value,                backgroundColor: backgroundColor,                valueColor: valueColor,                strokeWidth: strokeWidth,                semanticsLabel: semanticsLabel,                semanticsValue: semanticsValue,              ),            ),            Offstage(              offstage: loadingType != LoadingType.Linear,              child: LinearProgressIndicator(                value: value,                backgroundColor: backgroundColor,                valueColor: valueColor,                semanticsLabel: semanticsLabel,                semanticsValue: semanticsValue,              ),            ),            Offstage(              offstage: loadingType != LoadingType.Refresh,              child: RefreshProgressIndicator(                value: value,                backgroundColor: backgroundColor,                valueColor: valueColor,                strokeWidth: strokeWidth,                semanticsLabel: semanticsLabel,                semanticsValue: semanticsValue,              ),            ),            Container(              height: BaseUtils.getHeight(20),              width: BaseUtils.getWidth(100),            ),            Text(              text,              style: textStyle,            )          ],        ),      ),    );  }}