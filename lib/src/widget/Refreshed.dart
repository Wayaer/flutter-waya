import 'package:flutter/cupertino.dart';import 'package:flutter/gestures.dart';import 'package:flutter_waya/src/utils/Event.dart';import 'package:flutter_waya/waya.dart';class Refreshed extends StatefulWidget {  //可不传controller，  //若想关闭刷新组件可以通过发送消息  //sendMessage(RefreshCompletedType.refresh);  final RefreshController controller;  VoidCallback onRefresh;  VoidCallback onLoading;  VoidCallback onTwoLevel;  Widget child;  bool enablePullDown;  bool enablePullUp;  bool enableTwoLevel;  final Widget header;  final Widget footer;  final OnOffsetChange onOffsetChange;  final Axis scrollDirection;  final bool reverse;  final ScrollController scrollController;  final bool primary;  final ScrollPhysics physics;  final double cacheExtent;  final int semanticChildCount;  final DragStartBehavior dragStartBehavior;  final TextStyle footerTextStyle;  Refreshed({Key key, this.child, this.onTwoLevel, this.enablePullDown, this.onLoading, this.enablePullUp,    this.onRefresh, this.header, this.footer, this.controller, this.onOffsetChange, this.scrollDirection,    this.reverse, this.scrollController, this.primary, this.physics, this.cacheExtent, this.semanticChildCount,    this.dragStartBehavior, this.footerTextStyle}) :super (key: key);  @override  State<StatefulWidget> createState() {    return RefreshedState();  }}class RefreshedState extends State<Refreshed> {  RefreshController controller;  @override  void initState() {    super.initState();    controller = widget.controller ?? RefreshController(initialRefresh: false);    if (widget.controller == null) {      WidgetsBinding.instance.addPostFrameCallback((callback) {        messageListen((data) {          if (data == null) return;          if (data != null && data is RefreshCompletedType) {            switch (data) {              case RefreshCompletedType.refresh:                controller.refreshCompleted();                break;              case RefreshCompletedType.refreshFailed:                controller.refreshFailed();                break;              case RefreshCompletedType.refreshToIdle:                controller.refreshToIdle();                break;              case RefreshCompletedType.onLoading:                controller.loadComplete();                break;              case RefreshCompletedType.loadFailed:                controller.loadFailed();                break;              case RefreshCompletedType.loadNoData:                controller.loadNoData();                break;              case RefreshCompletedType.twoLevel:                controller.twoLevelComplete();                break;            }          }        });      });    }  }  @override  Widget build(BuildContext context) {    return Refresh(      controller: controller,      enablePullUp: widget.enablePullUp,      enablePullDown: widget.enablePullDown,      enableTwoLevel: widget.enableTwoLevel,      onLoading: widget.onLoading,      onRefresh: widget.onRefresh,      header: widget.header,      footer: widget.footer,      child: widget.child,      onTwoLevel: widget.onTwoLevel,      onOffsetChange: widget.onOffsetChange,      dragStartBehavior: widget.dragStartBehavior,      primary: widget.primary,      cacheExtent: widget.cacheExtent,      semanticChildCount: widget.semanticChildCount,      reverse: widget.reverse,      physics: widget.physics,      scrollDirection: widget.scrollDirection,      scrollController: widget.scrollController,      footerTextStyle: widget.footerTextStyle,    );  }}