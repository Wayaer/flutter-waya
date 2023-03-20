import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_waya/flutter_waya.dart';

/// num 扩展
extension ExtensionNum on num {
  T max<T extends num>(T value) => math.max(this as T, value);

  T min<T extends num>(T value) => math.min(this as T, value);

  double get cos => math.cos(this);

  double get tan => math.tan(this);

  double get acos => math.acos(this);

  double get asin => math.asin(this);

  double get sqrt => math.sqrt(this);

  double get exp => math.exp(this);

  double get log => math.log(this);

  double atan2(num value) => math.atan2(this, value);

  /// 复制到粘贴板
  Future<void> get toClipboard async =>
      await Clipboard.setData(ClipboardData(text: toString()));

  /// 创建指定长度的List
  List<T> generate<T>(T Function(int index) generator,
          {bool growable = true}) =>
      List<T>.generate(toInt(), (int index) => generator(index),
          growable: growable);

  String padLeft(int width, [String padding = ' ']) =>
      toString().padLeft(width, padding);

  /// num 长
  int get length => toString().length;

  /// 微秒时间戳转换 DateTime
  DateTime? fromMicrosecondsSinceEpoch({bool isUtc = false}) {
    num n = this;
    if (n is! int) n = n.toInt();
    if (n.toString().length != 16) return null;
    return DateTime.fromMicrosecondsSinceEpoch(n, isUtc: isUtc);
  }

  /// 毫秒时间戳转换 DateTime
  DateTime? fromMillisecondsSinceEpoch({bool isUtc = false}) {
    num n = this;
    if (n is! int) n = n.toInt();
    if (n.toString().length != 13) return null;
    return DateTime.fromMillisecondsSinceEpoch(n, isUtc: isUtc);
  }

  /// [element] 无论是 int 还是 double  返回 num 自己的类型
  /// [element] 是String  返回 String 类型
  dynamic insert(int index, dynamic element) {
    if (element is! num && element is! String) return this;
    if (element is String) {
      return toString().insert(index, element);
    } else {
      final String data =
          toString().insert(index, (element as num).toInt().toString());
      if (this is int) return num.parse(data).toInt();
      if (this is double) return num.parse(data).toDouble();
    }
    return this;
  }

  /// 是否包含 [other]
  bool contains(Pattern other, [int startIndex = 0]) =>
      toString().contains(other);

  /// 微秒
  Duration get microseconds => Duration(microseconds: round());

  /// 毫秒
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  /// 秒
  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  /// 分
  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  /// 时
  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  /// 天
  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());

  /// int 字节转 k MB GB
  String toFileSize() {
    num size = this;
    if (size < 1024) {
      return '${size}B';
    } else if (size >= 1024 && size < pow(1024, 2)) {
      size = (size / 10.24).round();
      return '${size / 100}KB';
    } else if (size >= pow(1024, 2) && size < pow(1024, 3)) {
      size = (size / (pow(1024, 2) * 0.01)).round();
      return '${size / 100}MB';
    } else if (size >= pow(1024, 3) && size < pow(1024, 4)) {
      size = (size / (pow(1024, 3) * 0.01)).round();
      return '${size / 100}GB';
    }
    return size.toString();
  }

  /// 数字转中文 简繁体
  String toChineseNumbers({bool isSimplify = true, bool isWeek = false}) {
    switch (toInt()) {
      case 0:
        return isSimplify ? '〇' : '零';
      case 1:
        return isSimplify ? '一' : '壹';
      case 2:
        return isSimplify ? '二' : '贰';
      case 3:
        return isSimplify ? '三' : '叁';
      case 4:
        return isSimplify ? '四' : '肆';
      case 5:
        return isSimplify ? '五' : '伍';
      case 6:
        return isSimplify ? '六' : '陆';
      case 7:
        return isSimplify
            ? isWeek
                ? '日'
                : '七'
            : '柒';
      case 8:
        return isSimplify ? '八' : '捌';
      case 9:
        return isSimplify ? '九' : '玖';
      case 10:
        return isSimplify ? '十' : '拾';
    }
    return toString();
  }

  /// Returns if the number is even
  bool get isEven => this % 2 == 0;

  /// Returns if the number is odd
  bool get isOdd => this % 2 != 0;

  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  ///Converts the number into a [SizedBox] with the width as that number.
  Widget get widthBox => SizedBox(width: toDouble());

  ///Converts the number into a [SizedBox] with the height as that number.
  Widget get heightBox => SizedBox(height: toDouble());

  ///Converts the number into a [SizedBox] with the width & height as that number.
  Widget get squareBox => SizedBox(height: toDouble(), width: toDouble());
}

/// int 扩展
extension ExtensionInt on int {
  /// b KB MB GB TB PB
  String toStorageUnit([int round = 2]) {
    int divider = 1024;
    if (this < divider) {
      return '$this B';
    }
    if (this < divider * divider && this % divider == 0) {
      return '${(this / divider).toStringAsFixed(0)} KB';
    }

    if (this < divider * divider) {
      return '${(this / divider).toStringAsFixed(round)} KB';
    }

    if (this < divider * divider * divider && this % (divider * divider) == 0) {
      return '${(this / (divider * divider)).toStringAsFixed(0)} MB';
    }

    if (this < divider * divider * divider) {
      return '${(this / divider / divider).toStringAsFixed(round)} MB';
    }

    if (this < divider * divider * divider * divider &&
        this % (divider * divider * divider) == 0) {
      return '${(this / (divider * divider * divider)).toStringAsFixed(0)} GB';
    }

    if (this < divider * divider * divider * divider) {
      return '${(this / divider / divider / divider).toStringAsFixed(round)} GB';
    }

    if (this < divider * divider * divider * divider * divider &&
        this % (divider / divider / divider / divider) == 0) {
      num r = this / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} TB';
    }
    if (this < divider * divider * divider * divider * divider) {
      num r = this / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} TB';
    }
    if (this < divider * divider * divider * divider * divider * divider &&
        this % (divider / divider / divider / divider / divider) == 0) {
      num r = this / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} PB';
    } else {
      num r = this / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} PB';
    }
  }
}
