import 'dart:collection';import 'package:flutter/material.dart';LinkedHashMap<OverlayBase, BuildContext> baseContext = LinkedHashMap();class OverlayBase extends StatelessWidget {  final Widget child;  final TextDirection textDirection;  OverlayBase({Key key, this.child, TextDirection textDirection})      : this.textDirection = textDirection ?? TextDirection.ltr,        super(key: key);  @override  Widget build(BuildContext context) {    return Directionality(      textDirection: textDirection,      child: Overlay(        initialEntries: [          OverlayEntry(            builder: (ctx) {              baseContext[this] = ctx;              return child;            },          ),        ],      ),    );  }}