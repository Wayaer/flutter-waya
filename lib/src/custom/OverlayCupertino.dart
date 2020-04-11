import 'package:flutter/cupertino.dart';import 'package:flutter_localizations/flutter_localizations.dart';import 'package:flutter_waya/src/custom/OverlayBase.dart';import 'package:flutter_waya/src/utils/BaseNavigatorUtils.dart';class OverlayCupertino extends StatelessWidget {  final TextDirection textDirection;  final Iterable<Locale> supportedLocales;  final Locale locale;  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;  final List<NavigatorObserver> navigatorObservers;  final Map<String, WidgetBuilder> routes;  final String title;  final bool showPerformanceOverlay;  final bool checkerboardRasterCacheImages;  final bool checkerboardOffscreenLayers;  final bool showSemanticsDebugger;  final bool debugShowCheckedModeBanner;  final GlobalKey<NavigatorState> navigatorKey;  final Widget home;  final CupertinoThemeData theme;  final String initialRoute;  final RouteFactory onGenerateRoute;  final RouteFactory onUnknownRoute;  final TransitionBuilder builder;  final GenerateAppTitle onGenerateTitle;  final Color color;  final LocaleListResolutionCallback localeListResolutionCallback;  final LocaleResolutionCallback localeResolutionCallback;  OverlayCupertino({    Key key,    TextDirection textDirection,    Iterable<Locale> supportedLocales,    Locale locale,    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,    List<NavigatorObserver> navigatorObservers,    Map<String, WidgetBuilder> routes,    String title,    bool showPerformanceOverlay,    bool checkerboardRasterCacheImages,    bool checkerboardOffscreenLayers,    bool showSemanticsDebugger,    bool debugShowCheckedModeBanner,    this.navigatorKey,    this.home,    this.theme,    this.initialRoute,    this.onGenerateRoute,    this.onUnknownRoute,    this.builder,    this.onGenerateTitle,    this.color,    this.localeListResolutionCallback,    this.localeResolutionCallback,  })  : this.showPerformanceOverlay = showPerformanceOverlay ?? false,        this.checkerboardRasterCacheImages = checkerboardRasterCacheImages ?? false,        this.checkerboardOffscreenLayers = checkerboardOffscreenLayers ?? false,        this.showSemanticsDebugger = showSemanticsDebugger ?? false,        this.debugShowCheckedModeBanner = debugShowCheckedModeBanner ?? true,        this.title = title ?? "",        this.routes = routes ?? const <String, WidgetBuilder>{},        this.textDirection = textDirection ?? TextDirection.ltr,        this.navigatorObservers = navigatorObservers ?? [BaseNavigatorUtils.getInstance()],        this.locale = locale ?? const Locale('zh'),        this.supportedLocales = supportedLocales ?? [const Locale('zh', 'CH')],        this.localizationsDelegates =            localizationsDelegates ?? [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],        super(key: key);  @override  Widget build(BuildContext context) {    return OverlayBase(        textDirection: textDirection,        child: CupertinoApp(          navigatorKey: navigatorKey,          home: home,          theme: theme,          routes: routes,          initialRoute: initialRoute,          onGenerateRoute: onGenerateRoute,          onUnknownRoute: onUnknownRoute,          navigatorObservers: navigatorObservers,          builder: builder,          title: title,          onGenerateTitle: onGenerateTitle,          color: color,          locale: locale,          localizationsDelegates: localizationsDelegates,          localeListResolutionCallback: localeListResolutionCallback,          localeResolutionCallback: localeResolutionCallback,          supportedLocales: supportedLocales,          showPerformanceOverlay: showPerformanceOverlay,          checkerboardRasterCacheImages: checkerboardRasterCacheImages,          checkerboardOffscreenLayers: checkerboardOffscreenLayers,          showSemanticsDebugger: showSemanticsDebugger,          debugShowCheckedModeBanner: debugShowCheckedModeBanner,        ));  }}