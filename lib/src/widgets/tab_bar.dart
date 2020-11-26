import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_waya/flutter_waya.dart';
import 'package:flutter_waya/src/constant/way.dart';

class TabBarMerge extends StatelessWidget {
  const TabBarMerge({
    Key key,
    @required this.tabBar,
    @required this.controller,
    bool reverse,
    double viewHeight,
    ScrollPhysics physics,
    this.width,
    this.among,
    this.header,
    this.footer,
    this.tabView,
    this.margin,
    this.padding,
    this.decoration,
    this.constraints,
  })  : viewHeight = viewHeight ?? 0,
        reverse = reverse ?? false,
        physics = physics ?? const NeverScrollableScrollPhysics(),
        super(key: key);

  ///建议传 TabBarBox
  final Widget tabBar;

  ///头部
  final Widget header;

  ///tabBar和tabBarView中间层
  final Widget among;

  ///底部
  final Widget footer;

  ///控制器
  final TabController controller;

  ///作用于tabView
  final List<Widget> tabView;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final BoxConstraints constraints;
  final double width;
  final ScrollPhysics physics;
  final double viewHeight;

  ///[tabBar],[tabView] 反转
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (header != null) children.add(header);
    children.add(reverse ? (tabViewWidget() ?? tabBar) : tabBar);
    if (among != null) children.add(among);
    if (tabView != null) children.add(reverse ? tabBar : tabViewWidget());
    if (footer != null) children.add(footer);
    return Column(children: children);
  }

  Widget tabViewWidget() => Universal(
      isScroll: viewHeight == 0,
      margin: margin,
      padding: padding,
      decoration: decoration,
      constraints: constraints,
      width: width,
      child: TabBarView(
          physics: physics, controller: controller, children: tabView));
}

class TabBarBox extends StatelessWidget {
  const TabBarBox({
    Key key,
    EdgeInsetsGeometry indicatorPadding,
    TabBarLevelPosition levelPosition,
    @required this.controller,
    @required this.tabs,
    this.labelPadding,
    this.isScrollable,
    this.alignment,
    this.tabBarLevel,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicatorSize,
    this.selectedLabelStyle,
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

  ///作用于label
  final EdgeInsetsGeometry labelPadding;

  ///作用于指示器
  final EdgeInsetsGeometry indicatorPadding;

  ///指示器高度
  final double indicatorWeight;
  final TabBarIndicatorSize indicatorSize;

  ///tabBar 指示器
  final Decoration indicator;

  final List<Widget> tabs;

  ///true 最小宽度，false充满最大宽度
  final bool isScrollable;

  ///tabBar 位置
  final TabBarLevelPosition levelPosition;

  ///选中与未选中的指示器和字体样式和颜色，
  final Color selectedLabelColor;
  final Color unselectedLabelColor;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;

  ///tabBar 水平左边或者右边的Widget 添加标签
  final Widget tabBarLevel;

  ///作用于整个tabBar
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;
  final Decoration decoration;

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
        decoration: decoration,
        children: children,
        child: tabBarLevel == null ? tabBarWidget() : null);
  }

  Widget tabBarWidget() => TabBar(
        controller: controller,
        labelPadding: labelPadding,
        tabs: tabs,
        isScrollable: isScrollable ?? true,
        indicator: indicator,
        labelColor: selectedLabelColor ?? getColors(blue),
        unselectedLabelColor: unselectedLabelColor ?? getColors(background),
        indicatorColor: selectedLabelColor ?? getColors(blue),
        indicatorWeight: indicatorWeight ?? getWidth(1),
        indicatorPadding: indicatorPadding,
        labelStyle:
            selectedLabelStyle ?? WayStyles.textStyleBlack70(fontSize: 13),
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
