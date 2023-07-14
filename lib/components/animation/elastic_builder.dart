import 'package:flutter/material.dart';
import 'package:flutter_waya/flutter_waya.dart';

typedef ElasticBuilderCallback = Widget Function(BuildContext context,
    Function elasticUp, Function elastic, Function elasticDown);

/// 弹性按钮
class ElasticBuilder extends StatefulWidget {
  const ElasticBuilder(
      {super.key,
      this.withOpacity = false,
      this.alignment = Alignment.center,
      this.scale = 0.93,
      required this.builder,
      this.duration = const Duration(milliseconds: 100)})
      : assert(scale <= 1.0);

  final bool withOpacity;

  /// Use this value to determine the alignment of the animation.
  final Alignment alignment;

  /// Choose a value between 0.0 and 1.0.
  final double scale;

  final Duration duration;
  final ElasticBuilderCallback builder;

  @override
  State<ElasticBuilder> createState() => _ElasticBuilderState();
}

class _ElasticBuilderState extends ExtendedState<ElasticBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initController();
    initAnimation();
  }

  void initController() {
    controller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        reverseDuration: widget.duration,
        duration: widget.duration);
    controller.value = 1;
  }

  void initAnimation() {
    animation = Tween<double>(begin: widget.scale, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }

  void elasticDown() {
    controller.value = 0;
  }

  Future<void> elastic([Duration? duration]) async {
    controller.value = 0;
    await (duration ?? widget.duration).delayed();
    controller.value = 1;
  }

  void elasticUp() {
    controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant ElasticBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration ||
        widget.scale != oldWidget.scale) {
      controller.dispose();
      initController();
      initAnimation();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final scale = Transform.scale(
            scale: animation.value,
            alignment: widget.alignment,
            child: widget.builder(context, elasticUp, elastic, elasticDown));
        return widget.withOpacity
            ? Opacity(
                opacity: animation.value.clamp(0.5, 1.0).toDouble(),
                child: scale)
            : scale;
      });

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}