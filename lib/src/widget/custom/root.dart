import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_waya/flutter_waya.dart';
import 'package:flutter_waya/src/widget/custom/delegate/chinese_cupertino_localizations.dart';

GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

class OverlayMaterial extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  ///导航键
  final Widget home;

  ///主页
  final String initialRoute;

  ///初始路由
  final RouteFactory onGenerateRoute;

  ///生成路由
  final RouteFactory onUnknownRoute;

  ///未知路由
  final TransitionBuilder builder;

  ///建造者
  final LocaleListResolutionCallback localeListResolutionCallback;

  ///区域分辨回调
  final LocaleResolutionCallback localeResolutionCallback;
  final GenerateAppTitle onGenerateTitle;

  ///生成标题
  final ThemeData theme;

  ///主题
  final ThemeData darkTheme;
  final Color color;

  ///颜色
  final Map<String, WidgetBuilder> routes;

  ///路由
  final List<NavigatorObserver> navigatorObservers;

  ///导航观察器
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  ///本地化委托
  final String title;

  ///标题
  final ThemeMode themeMode;
  final Locale locale;

  ///地点
  final Iterable<Locale> supportedLocales;

  ///支持区域
  final bool showPerformanceOverlay;

  ///显示性能叠加
  final bool checkerboardRasterCacheImages;

  ///棋盘格光栅缓存图像
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;

  ///显示语义调试器
  final bool debugShowCheckedModeBanner;

  ///调试显示检查模式横幅
  final bool debugShowMaterialGrid;
  final TextDirection textDirection;

  OverlayMaterial({
    Key key,
    TextDirection textDirection,
    Map<String, WidgetBuilder> routes,
    String title,
    List<NavigatorObserver> navigatorObservers,
    ThemeMode themeMode,
    Locale locale,
    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    Iterable<Locale> supportedLocales,
    bool debugShowMaterialGrid,
    bool showPerformanceOverlay,
    bool checkerboardRasterCacheImages,
    bool checkerboardOffscreenLayers,
    bool showSemanticsDebugger,
    bool debugShowCheckedModeBanner,
    this.navigatorKey,
    this.home,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
  })  : this.debugShowMaterialGrid = debugShowMaterialGrid ?? false,
        this.showPerformanceOverlay = showPerformanceOverlay ?? false,
        this.checkerboardRasterCacheImages = checkerboardRasterCacheImages ?? false,
        this.checkerboardOffscreenLayers = checkerboardOffscreenLayers ?? false,
        this.showSemanticsDebugger = showSemanticsDebugger ?? false,
        this.debugShowCheckedModeBanner = debugShowCheckedModeBanner ?? false,
        this.themeMode = themeMode ?? ThemeMode.system,
        this.title = title ?? "",
        this.routes = routes = const <String, WidgetBuilder>{},
        this.textDirection = textDirection ?? TextDirection.ltr,
        this.navigatorObservers = navigatorObservers ?? [NavigatorTools.getInstance()],
        this.locale = locale ?? Locale('zh'),
        this.supportedLocales = supportedLocales ?? [Locale('zh', 'CH')],
        this.localizationsDelegates = localizationsDelegates ??
            [
              ///解决ios 长按输入框报错
              ChineseCupertinoLocalizations.delegate,
              CustomLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navigatorKey != null) _navigatorKey = navigatorKey;
    return OverlayBase(
      textDirection: textDirection,
      child: MaterialApp(
        home: home,
        navigatorObservers: navigatorObservers,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        navigatorKey: _navigatorKey,
        routes: routes,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        builder: builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        color: color,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        debugShowMaterialGrid: debugShowMaterialGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      ),
    );
  }
}

class OverlayCupertino extends StatelessWidget {
  final TextDirection textDirection;
  final Iterable<Locale> supportedLocales;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final List<NavigatorObserver> navigatorObservers;
  final Map<String, WidgetBuilder> routes;
  final String title;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget home;
  final CupertinoThemeData theme;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final TransitionBuilder builder;
  final GenerateAppTitle onGenerateTitle;
  final Color color;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;

  OverlayCupertino({
    Key key,
    TextDirection textDirection,
    Iterable<Locale> supportedLocales,
    Locale locale,
    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    List<NavigatorObserver> navigatorObservers,
    Map<String, WidgetBuilder> routes,
    String title,
    bool showPerformanceOverlay,
    bool checkerboardRasterCacheImages,
    bool checkerboardOffscreenLayers,
    bool showSemanticsDebugger,
    bool debugShowCheckedModeBanner,
    this.navigatorKey,
    this.home,
    this.theme,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.onGenerateTitle,
    this.color,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
  })  : this.showPerformanceOverlay = showPerformanceOverlay ?? false,
        this.checkerboardRasterCacheImages = checkerboardRasterCacheImages ?? false,
        this.checkerboardOffscreenLayers = checkerboardOffscreenLayers ?? false,
        this.showSemanticsDebugger = showSemanticsDebugger ?? false,
        this.debugShowCheckedModeBanner = debugShowCheckedModeBanner ?? true,
        this.title = title ?? "",
        this.routes = routes ?? const <String, WidgetBuilder>{},
        this.textDirection = textDirection ?? TextDirection.ltr,
        this.navigatorObservers = navigatorObservers ?? [NavigatorTools.getInstance()],
        this.locale = locale ?? const Locale('zh'),
        this.supportedLocales = supportedLocales ?? [const Locale('zh', 'CH')],
        this.localizationsDelegates =
            localizationsDelegates ?? [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navigatorKey != null) _navigatorKey = navigatorKey;
    return OverlayBase(
        textDirection: textDirection,
        child: CupertinoApp(
          navigatorKey: _navigatorKey,
          home: home,
          theme: theme,
          routes: routes,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          navigatorObservers: navigatorObservers,
          builder: builder,
          title: title,
          onGenerateTitle: onGenerateTitle,
          color: color,
          locale: locale,
          localizationsDelegates: localizationsDelegates,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        ));
  }
}
