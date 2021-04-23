import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

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
  List<T> generate<T>(T generator(int index), {bool growable = true}) =>
      List<T>.generate(toInt(), (int index) => generator(index),
          growable: growable);

  String padLeft(int width, [String padding = ' ']) =>
      toString().padLeft(width);

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

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}

/// int 扩展
extension ExtensionInt on int {
  int rightShift32(int n) => ((toInt() & 0xFFFFFFFF) >> n).toSigned(32);

  int leftShift32(int n) => ((toInt() & 0xFFFFFFFF) << n).toSigned(32);
}

/// String 扩展
extension ExtensionString on String {
  int get parseInt => int.parse(this);

  String insert(int index, String element) =>
      '${substring(0, index)}$element${substring(index, length)}';

  double get parseDouble => double.parse(this);

  ///  md5 加密
  String get toMd5 => md5.convert(utf8.encode(this)).toString();

  ///  Base64加密
  String get toEncodeBase64 => base64Encode(utf8.encode(this));

  ///  Base64解密
  String get toDecodeBase64 => String.fromCharCodes(base64Decode(this));

  /// 复制到粘贴板
  Future<void> get toClipboard async =>
      await Clipboard.setData(ClipboardData(text: this));

  /// 验证邮箱
  bool get isEmail =>
      RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$').hasMatch(this);

  /// 手机号验证
  bool get isChinaPhone =>
      RegExp(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$')
          .hasMatch(this);

  ///  utf8ToList
  List<int> get utf8ToList {
    final List<int> words = length.generate((_) => 0);
    for (int i = 0; i < length; i++) {
      words[i >> 2] |= (codeUnitAt(i) & 0xff).toSigned(32) <<
          (24 - (i % 4) * 8).toSigned(32);
    }
    return words;
  }

  /// 进行utf8编码
  List<int> get utf8Encode => utf8.encode(this);

  /// 每隔 x位 加 pattern
  String formatDigitPattern({int digit = 4, String pattern = ' '}) {
    String text = this;
    text = text.replaceAllMapped(
        RegExp('(.{$digit})'), (Match match) => '${match.group(0)}$pattern');
    if (text.endsWith(pattern)) text = text.substring(0, text.length - 1);
    return text;
  }

  /// 每隔 x位 加 pattern, 从末尾开始
  String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse;
    temp = formatDigitPattern(digit: digit, pattern: pattern);
    temp = reverse;
    return temp;
  }

  /// reverse
  String get reverse {
    final String text = this;
    if (isEmpty) return '';
    final StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--)
      sb.writeCharCode(text.codeUnitAt(i));
    return sb.toString();
  }
}

extension ExtensionUint8List on Uint8List {
  List<int> bit32ListFromUInt8List() {
    final Uint8List bytes = this;
    final int additionalLength = bytes.length % 4 > 0 ? 4 : 0;
    final List<int> result =
        (bytes.length ~/ 4 + additionalLength).generate((_) => 0);
    for (int i = 0; i < bytes.length; i++) {
      final int resultIdx = i ~/ 4;
      final int bitShiftAmount = (3 - i % 4).toInt();
      result[resultIdx] |= bytes[i] << bitShiftAmount;
    }
    for (int i = 0; i < result.length; i++) result[i] = result[i] << 24;
    return result;
  }
}

extension ExtensionList<T> on List<T> {
  String? get base64Encode {
    if (T != int) return null;
    return base64.encode(this as List<int>);
  }

  String? get utf8Decode {
    if (T != int) return null;
    return utf8.decode(this as List<int>);
  }

  Uint8List? get uInt8ListFrom32BitList {
    if (T != int) return null;
    final List<int> bit32 = this as List<int>;
    final Uint8List result = Uint8List(bit32.length * 4);
    for (int i = 0; i < bit32.length; i++) {
      for (int j = 0; j < 4; j++) result[i * 4 + j] = bit32[i] >> (j * 8);
    }
    return result;
  }

  /// List<int> toUtf8
  String? get toUtf8 {
    if (T != int) return null;
    final List<int?> words = this as List<int>;
    final int sigBytes = words.length;
    final List<int> chars = sigBytes.generate((int i) {
      if (words[i >> 2] == null) words[i >> 2] = 0;
      final int bite =
          ((words[i >> 2]!).toSigned(32) >> (24 - (i % 4) * 8)) & 0xff;
      return bite;
    });
    return String.fromCharCodes(chars);
  }

  /// list.map.toList()
  List<E> builder<E>(E Function(T) builder) =>
      map<E>((T e) => builder(e)).toList();

  List<T> generate<T>(T generator(int index), {bool growable = true}) =>
      length.generate<T>((int index) => generator(index), growable: growable);

  /// list.asMap().entries.map.toList()
  List<E> builderEntry<E>(E Function(MapEntry<int, T>) builder) =>
      asMap().entries.map((MapEntry<int, T> entry) => builder(entry)).toList();

  /// 添加子元素 并返回 新数组
  List<T> addT(T value, {bool isAdd = true}) {
    if (isAdd) add(value);
    return this;
  }

  /// 添加数组 并返回 新数组
  List<T> addAllT(List<T> iterable, {bool isAdd = true}) {
    if (isAdd) addAll(iterable);
    return this;
  }

  /// 插入子元素 并返回 新数组
  List<T> insertT(int index, T value, {bool isInsert = true}) {
    if (isInsert) insert(index, value);
    return this;
  }

  /// 插入数组 并返回 新数组
  List<T> insertAllT(int index, List<T> iterable, {bool isInsert = true}) {
    if (isInsert) insertAll(index, iterable);
    return this;
  }

  /// 替换指定区域 返回 新数组
  List<T> replaceRangeT(int start, int end, Iterable<T> replacement,
      {bool isReplace = true}) {
    if (isReplace) replaceRange(start, end, replacement);
    return this;
  }
}

extension ExtensionMap<K, V> on Map<K, V> {
  List<K> keysList({bool growable = true}) => keys.toList(growable: growable);

  List<V> valuesList({bool growable = true}) =>
      values.toList(growable: growable);

  List<E> builderEntry<E>(E Function(MapEntry<K, V>) builder) =>
      entries.map((MapEntry<K, V> entry) => builder(entry)).toList();

  /// addAll map 并返回 新map
  Map<K, V> addAllT(Map<K, V> iterable, {bool isAdd = true}) {
    if (isAdd) addAll(iterable);
    return this;
  }

  /// update map 并返回 新map
  Map<K, V> updateAllT(V update(K key, V value), {bool isUpdate = true}) {
    if (isUpdate) updateAll(update);
    return this;
  }

  /// update map 并返回 新map
  Map<K, V> updateT(K key, V update(V value),
      {V ifAbsent()?, bool isUpdate = true}) {
    if (isUpdate) this.update(key, update, ifAbsent: ifAbsent);
    return this;
  }
}

enum DateTimeDist {
  ///  2020-01-01 00:00:00
  yearSecond,

  ///  2020-01-01 00:00
  yearMinute,

  ///  2020-01-01 00
  yearHour,

  ///  2020-01-01
  yearDay,

  ///  01-01 00:00:00
  monthSecond,

  ///  01-01 00:00
  monthMinute,

  ///  01-01 00
  monthHour,

  ///  01-01
  monthDay,

  ///  01 00:00:00
  daySecond,

  ///  01 00:00
  dayMinute,

  ///  01 00
  dayHour,

  ///  00:00:00
  hourSecond,

  ///  00:00
  hourMinute,
}

/// DateTime 扩展
extension ExtensionDateTime on DateTime {
  String format([DateTimeDist? dateType, bool padLeft = true]) {
    final DateTime date = this;
    dateType ??= DateTimeDist.yearSecond;
    final String year = date.year.toString();
    final String month =
        padLeft ? date.month.padLeft(2, '0') : date.month.toString();
    final String day = padLeft ? date.day.padLeft(2, '0') : date.day.toString();
    final String hour =
        padLeft ? date.hour.padLeft(2, '0') : date.hour.toString();
    final String minute =
        padLeft ? date.minute.padLeft(2, '0') : date.minute.toString();
    final String second =
        padLeft ? date.second.padLeft(2, '0') : date.second.toString();
    switch (dateType) {
      case DateTimeDist.yearSecond:
        return '$year-$month-$day $hour:$minute:$second';
      case DateTimeDist.yearMinute:
        return '$year-$month-$day $hour:$minute';
      case DateTimeDist.yearHour:
        return '$year-$month-$day $hour';
      case DateTimeDist.yearDay:
        return '$year-$month-$day';
      case DateTimeDist.monthSecond:
        return '$month-$day $hour:$minute:$second';
      case DateTimeDist.monthMinute:
        return '$month-$day $hour:$minute';
      case DateTimeDist.monthHour:
        return '$month-$day $hour';
      case DateTimeDist.monthDay:
        return '$month-$day';
      case DateTimeDist.daySecond:
        return '$day $hour:$minute:$second';
      case DateTimeDist.dayMinute:
        return '$day $hour:$minute';
      case DateTimeDist.dayHour:
        return '$day $hour';
      case DateTimeDist.hourSecond:
        return '$hour:$minute:$second';
      case DateTimeDist.hourMinute:
        return '$hour:$minute';
    }
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  bool get isLeapYearByYear =>
      year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
}

extension DurationExtension on Duration {
  ///   final _delay = 3.seconds;
  ///   print('+ wait $_delay');
  ///   await _delay.delayed();
  ///   print('- finish wait $_delay');
  ///   print('+ callback in 700ms');
  Future<T> delayed<T>([FutureOr<T> callback()?]) =>
      Future<T>.delayed(this, callback);

  /// 时间工具
  Timer timer([Function? function]) {
    late Timer timer;
    timer = Timer(this, () {
      if (function != null) function.call();
      timer.cancel();
    });
    return timer;
  }

  /// 需要手动释放timer
  Timer timerPeriodic(void callback(Timer timer)) =>
      Timer.periodic(this, (Timer time) => callback(time));

  /// 防抖函数
  /// 最后一次触发结束的一段时间之后，再去执行
  void debounce(Function function) => timer(() => function.call());

  /// 节流函数
  void throttle(Function function,
      {String? throttleId,
      Duration duration = const Duration(seconds: 1),
      Map<String, int>? startTime,
      Function? continueClick}) {
    throttleId ??= 'DeFaultThrottleId';
    startTime ??= <String, int>{throttleId: 0};
    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - (startTime[throttleId] ?? 0) > duration.inMilliseconds) {
      function.call();
      startTime[throttleId] = DateTime.now().millisecondsSinceEpoch;
    } else {
      continueClick?.call();
    }
  }
}
