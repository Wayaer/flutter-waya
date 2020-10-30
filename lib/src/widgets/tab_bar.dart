import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_waya/flutter_waya.dart';
import 'package:flutter_waya/src/constant/way.dart';

class TabBarMerge extends StatelessWidget {
  const TabBarMerge({
    Key key,
    this.among,
    this.physics,
    this.header,
    this.footer,
    double viewHeight,
    @required this.tabBar,
    this.tabBarView,
    @required this.controller,
    this.margin,
    this.padding,
    this.decoration,
    this.constraints,
    this.width,
  })  : viewHeight = viewHeight ?? 0,
        super(key: key);

  ///最好传入 TabBarBox
  final Widget tabBar;

  ///tabBar和tabBarView中间层
  final Widget among;

  ///最顶部
  final Widget header;

  ///最底部
  final Widget footer;
  final ScrollPhysics physics;
  final List<Widget> tabBarView;
  final double viewHeight;
  final TabController controller;

  ///以下属性主要针对 tabBarView
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final BoxConstraints constraints;
  final double width;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (header != null) children.add(header);
    children.add(tabBar);
    if (among != null) children.add(among);
    if (tabBarView != null) children.add(tabBarViewWidget());
    if (footer != null) children.add(footer);
    return Column(children: children);
  }

  Widget tabBarViewWidget() => viewHeight == 0
      ? Expanded(
          child: Container(
              margin: margin,
              padding: padding,
              decoration: decoration,
              constraints: constraints,
              width: width,
              child: TabBarView(controller: controller, children: tabBarView)))
      : Container(
          margin: margin,
          padding: padding,
          decoration: decoration,
          constraints: constraints,
          width: width,
          height: viewHeight,
          child: TabBarView(controller: controller, children: tabBarView));
}

class TabBarBox extends StatelessWidget {
  const TabBarBox({
    Key key,
    EdgeInsetsGeometry indicatorPadding,
    TabBarLevelPosition levelPosition,
    this.border,
    @required this.controller,
    this.labelPadding,
    @required this.tabBar,
    this.isScrollable,
    this.alignment,
    this.tabBarLevel,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorSize,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorWeight,
    this.indicator,
    this.margin,
    this.padding,
    this.height,
    this.decoration,
    this.width,
  })  : levelPosition = levelPosition ?? TabBarLevelPosition.right,
        indicatorPadding = indicatorPadding ?? EdgeInsets.zero,
        super(key: key);
  final TabController controller;
  final EdgeInsetsGeometry labelPadding;
  final List<Widget> tabBar;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;
  final Decoration decoration;
  final EdgeInsetsGeometry indicatorPadding;

  ///true 最小宽度，false充满最大宽度
  final bool isScrollable;

  ///tabBar 位置
  final TabBarLevelPosition levelPosition;

  final TabBarIndicatorSize indicatorSize;

  ///选中与未选中的指示器和字体样式和颜色，
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;

  ///指示器高度
  final double indicatorWeight;

  ///tabBar 水平左边或者右边的Widget
  final Widget tabBarLevel;

  final Decoration indicator; //tabBar 指示器
  final AlignmentGeometry alignment;
  final BoxBorder border;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (tabBarLevel != null) {
      switch (levelPosition) {
        case TabBarLevelPosition.right:
          children.add(Expanded(child: tabBarWidget()));
          children.add(tabBarLevel);
          break;
        case TabBarLevelPosition.left:
          children.add(tabBarLevel);
          children.add(Expanded(child: tabBarWidget()));
          break;
      }
    }
    return Universal(
        height: height,
        margin: margin,
        padding: padding,
        width: width,
        alignment: alignment,
        direction: Axis.horizontal,
        decoration: decoration ?? BoxDecoration(border: border),
        children: children,
        child: tabBarLevel == null ? tabBarWidget() : null);
  }

  Widget tabBarWidget() => TabBar(
        controller: controller,
        labelPadding: labelPadding,
        tabs: tabBar,
        isScrollable: isScrollable ?? true,
        indicator: indicator,
        labelColor: labelColor ?? getColors(blue),
        unselectedLabelColor: unselectedLabelColor ?? getColors(background),
        indicatorColor: labelColor ?? getColors(blue),
        indicatorWeight: indicatorWeight ?? getWidth(1),
        indicatorPadding: indicatorPadding,
        labelStyle: labelStyle ?? WayStyles.textStyleBlack70(fontSize: 13),
        unselectedLabelStyle: unselectedLabelStyle,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.label,
      );
}

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage(
      {Key key,
      this.arguments,
      this.defaultTabIndex,
      this.pageList,
      @required this.navigationBarItem})
      : assert(navigationBarItem != null),
        super(key: key);

  final Map<String, Object> arguments;
  final List<BottomNavigationBarItem> navigationBarItem;
  final List<Widget> pageList;
  final int defaultTabIndex;

  @override
  _TabNavigationPageState createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {
  int tabIndex = 0;
  Widget currentPage;
  List<Widget> pageList = <Widget>[];

  @override
  void initState() {
    super.initState();
    pageList = widget.pageList;
    currentPage = pageList[widget.defaultTabIndex ?? tabIndex];
  }

  @override
  Widget build(BuildContext context) => OverlayScaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: getColors(blue),
          unselectedItemColor: getColors(background),
          backgroundColor: getColors(white),
          items: widget.navigationBarItem ??
              <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: barIcon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: barIcon(Icons.add_circle), label: 'center'),
                BottomNavigationBarItem(
                    icon: barIcon(Icons.account_circle), label: 'mine'),
              ],

          /// 超过5个页面，需加上此行，不然会无法显示颜色
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => setState(() {
            tabIndex = index;
            currentPage = pageList[tabIndex];
          }),
          currentIndex: tabIndex,
        ),
      );

  Widget barIcon(IconData icons) => Icon(icons, size: getWidth(24));
}