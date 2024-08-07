import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_waya/src/extended_state.dart';

part 'carousel_controller.dart';

typedef CarouselSliderIndexedWidgetBuilder = Widget Function(
    BuildContext context, int index, int realIndex);

class CarouselSlider extends StatefulWidget {
  const CarouselSlider.items({
    super.key,
    required this.items,
    this.options = const CarouselSliderOptions(),
    this.disableGesture,
    this.controller,
  })  : itemBuilder = null,
        itemCount = items != null ? items.length : 0;

  /// The on demand item builder constructor
  const CarouselSlider.builder(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      this.options = const CarouselSliderOptions(),
      this.controller,
      this.disableGesture})
      : items = null;

  /// [CarouselOptions] to create a [CarouselState] with
  final CarouselSliderOptions options;

  final bool? disableGesture;

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget>? items;

  /// The widget item builder that will be used to build item on demand
  /// The third argument is the PageView's real index, can be used to cooperate
  /// with Hero.
  final CarouselSliderIndexedWidgetBuilder? itemBuilder;

  /// A [MapController], used to control the map.
  final CarouselSliderController? controller;

  final int? itemCount;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends ExtendedState<CarouselSlider>
    with TickerProviderStateMixin {
  late CarouselSliderController controller;

  Timer? timer;

  CarouselSliderOptions get options => widget.options;

  CarouselState? carouselState;

  PageController? pageController;

  /// mode is related to why the page is being changed
  CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

  @override
  void initState() {
    controller = widget.controller ?? CarouselSliderController();
    super.initState();
    carouselState = CarouselState(options, clearTimer, resumeTimer, changeMode);
    carouselState!.itemCount = widget.itemCount;
    controller.state = carouselState;
    carouselState!.initialPage = widget.options.initialPage;
    carouselState!.realPage = options.enableInfiniteScroll
        ? carouselState!.realPage + carouselState!.initialPage
        : carouselState!.initialPage;
    handleAutoPlay();
    pageController = PageController(
        viewportFraction: options.viewportFraction,
        initialPage: carouselState!.realPage);
    carouselState!.pageController = pageController;
  }

  void changeMode(CarouselPageChangedReason mode) {
    this.mode = mode;
  }

  @override
  void didUpdateWidget(CarouselSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    carouselState!.options = options;
    carouselState!.itemCount = widget.itemCount;
    carouselState!.pageController = pageController = PageController(
        viewportFraction: options.viewportFraction,
        initialPage: carouselState!.realPage);
    controller.state = carouselState;
    handleAutoPlay();
  }

  Timer? getTimer() {
    return widget.options.autoPlay
        ? Timer.periodic(widget.options.autoPlayInterval, (_) {
            if (!mounted) {
              clearTimer();
              return;
            }
            final route = ModalRoute.of(context);
            if (route?.isCurrent == false) {
              return;
            }

            CarouselPageChangedReason previousReason = mode;
            changeMode(CarouselPageChangedReason.timed);
            int nextPage = carouselState!.pageController!.page!.round() + 1;
            int itemCount = widget.itemCount ?? widget.items!.length;

            if (nextPage >= itemCount &&
                widget.options.enableInfiniteScroll == false) {
              if (widget.options.pauseAutoPlayInFiniteScroll) {
                clearTimer();
                return;
              }
              nextPage = 0;
            }

            carouselState!.pageController!
                .animateToPage(nextPage,
                    duration: widget.options.autoPlayAnimationDuration,
                    curve: widget.options.autoPlayCurve)
                .then((_) => changeMode(previousReason));
          })
        : null;
  }

  void clearTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void resumeTimer() {
    timer ??= getTimer();
  }

  void handleAutoPlay() {
    bool autoPlayEnabled = widget.options.autoPlay;

    if (autoPlayEnabled && timer != null) return;

    clearTimer();
    if (autoPlayEnabled) {
      resumeTimer();
    }
  }

  Widget getGestureWrapper(Widget child) {
    Widget wrapper;
    if (widget.options.height != null) {
      wrapper = SizedBox(height: widget.options.height, child: child);
    } else {
      wrapper =
          AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);
    }

    if (true == widget.disableGesture) {
      return NotificationListener(
          onNotification: (Notification notification) {
            if (widget.options.onScrolled != null &&
                notification is ScrollUpdateNotification) {
              widget.options.onScrolled!(carouselState!.pageController!.page);
            }
            return false;
          },
          child: wrapper);
    }

    return RawGestureDetector(
        behavior: HitTestBehavior.opaque,
        gestures: {
          PanGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
                  () => PanGestureRecognizer(),
                  (PanGestureRecognizer instance) {
            instance.onStart = (_) {
              onStart();
            };
            instance.onDown = (_) {
              onPanDown();
            };
            instance.onEnd = (_) {
              onPanUp();
            };
            instance.onCancel = () {
              onPanUp();
            };
          })
        },
        child: NotificationListener(
            onNotification: (Notification notification) {
              if (widget.options.onScrolled != null &&
                  notification is ScrollUpdateNotification) {
                widget.options.onScrolled!(carouselState!.pageController!.page);
              }
              return false;
            },
            child: wrapper));
  }

  Widget getCenterWrapper(Widget child) {
    if (widget.options.disableCenter) {
      return child;
    }
    return Center(child: child);
  }

  Widget getEnlargeWrapper(Widget? child,
      {double? width,
      double? height,
      double? scale,
      required double itemOffset}) {
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.height) {
      return SizedBox(width: width, height: height, child: child);
    }
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.zoom) {
      late Alignment alignment;
      final bool horizontal = options.scrollDirection == Axis.horizontal;
      if (itemOffset > 0) {
        alignment = horizontal ? Alignment.centerRight : Alignment.bottomCenter;
      } else {
        alignment = horizontal ? Alignment.centerLeft : Alignment.topCenter;
      }
      return Transform.scale(scale: scale!, alignment: alignment, child: child);
    }
    return Transform.scale(
        scale: scale!,
        child: SizedBox(width: width, height: height, child: child));
  }

  void onStart() {
    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanDown() {
    if (widget.options.pauseAutoPlayOnTouch) {
      clearTimer();
    }

    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanUp() {
    if (widget.options.pauseAutoPlayOnTouch) {
      resumeTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    clearTimer();
  }

  @override
  Widget build(BuildContext context) {
    return getGestureWrapper(PageView.builder(
        padEnds: widget.options.padEnds,
        scrollBehavior: ScrollConfiguration.of(context)
            .copyWith(scrollbars: false, overscroll: false, dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        clipBehavior: widget.options.clipBehavior,
        physics: widget.options.scrollPhysics,
        scrollDirection: widget.options.scrollDirection,
        pageSnapping: widget.options.pageSnapping,
        controller: carouselState!.pageController,
        reverse: widget.options.reverse,
        itemCount:
            widget.options.enableInfiniteScroll ? null : widget.itemCount,
        key: widget.options.pageViewKey,
        onPageChanged: (int index) {
          int currentPage = _getRealIndex(index + carouselState!.initialPage,
              carouselState!.realPage, widget.itemCount);
          if (widget.options.onPageChanged != null) {
            widget.options.onPageChanged!(currentPage, mode);
          }
        },
        itemBuilder: (BuildContext context, int idx) {
          final int index = _getRealIndex(idx + carouselState!.initialPage,
              carouselState!.realPage, widget.itemCount);
          return AnimatedBuilder(
              animation: carouselState!.pageController!,
              child: (widget.items != null)
                  ? (widget.items!.isNotEmpty
                      ? widget.items![index]
                      : Container())
                  : widget.itemBuilder!(context, index, idx),
              builder: (BuildContext context, child) {
                double distortionValue = 1.0;
                // if `enlargeCenterPage` is true, we must calculate the carousel item's height
                // to display the visual effect
                double itemOffset = 0;
                if (widget.options.enlargeCenterPage != null &&
                    widget.options.enlargeCenterPage == true) {
                  // pageController.page can only be accessed after the first build,
                  // so in the first build we calculate the item offset manually
                  var position = carouselState?.pageController?.position;
                  if (position != null &&
                      position.hasPixels &&
                      position.hasContentDimensions) {
                    var page = carouselState?.pageController?.page;
                    if (page != null) {
                      itemOffset = page - idx;
                    }
                  } else {
                    BuildContext storageContext = carouselState!
                        .pageController!.position.context.storageContext;
                    final double? previousSavedPosition =
                        PageStorage.of(storageContext).readState(storageContext)
                            as double?;
                    if (previousSavedPosition != null) {
                      itemOffset = previousSavedPosition - idx.toDouble();
                    } else {
                      itemOffset =
                          carouselState!.realPage.toDouble() - idx.toDouble();
                    }
                  }

                  final double enlargeFactor =
                      options.enlargeFactor.clamp(0.0, 1.0);
                  final num distortionRatio =
                      (1 - (itemOffset.abs() * enlargeFactor)).clamp(0.0, 1.0);
                  distortionValue =
                      Curves.easeOut.transform(distortionRatio as double);
                }

                final double height = widget.options.height ??
                    MediaQuery.of(context).size.width *
                        (1 / widget.options.aspectRatio);

                if (widget.options.scrollDirection == Axis.horizontal) {
                  return getCenterWrapper(getEnlargeWrapper(child,
                      height: distortionValue * height,
                      scale: distortionValue,
                      itemOffset: itemOffset));
                } else {
                  return getCenterWrapper(getEnlargeWrapper(child,
                      width:
                          distortionValue * MediaQuery.of(context).size.width,
                      scale: distortionValue,
                      itemOffset: itemOffset));
                }
              });
        }));
  }
}