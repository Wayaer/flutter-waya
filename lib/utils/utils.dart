import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

export 'src/ali_oss.dart';
export 'src/des/des.dart';
export 'src/des/des_engine.dart';
export 'src/des/permuted.dart';
export 'src/dio.dart';
export 'src/event.dart';
export 'src/screen_fit.dart';

void logDebug(dynamic msg) => debugPrint(msg.toString());

void log(dynamic msg) {
  if (!kDebugMode) return;
  final String message = msg.toString();
  debugPrint(
      '┌------------------------------------------------------------------------------');
  if (!kDebugMode) return;
  const int _limitLength = 800;
  if (message.length < _limitLength) {
    debugPrint('$msg');
  } else {
    final StringBuffer outStr = StringBuffer();
    for (int index = 0; index < message.length; index++) {
      outStr.write(message[index]);
      if (index % _limitLength == 0 && index != 0) {
        debugPrint(outStr.toString());
        outStr.clear();
        final int lastIndex = index + 1;
        if (message.length - lastIndex < _limitLength) {
          final String remainderStr =
              message.substring(lastIndex, message.length);
          debugPrint(remainderStr);
          break;
        }
      }
    }
  }
  debugPrint(
      '└------------------------------------------------------------------------------');
}

WidgetsBinding? widgetsBinding = WidgetsBinding.instance;
SchedulerBinding? schedulerBinding = SchedulerBinding.instance;

void addPostFrameCallback(FrameCallback duration) =>
    widgetsBinding?.addPostFrameCallback(duration);

void addObserver(WidgetsBindingObserver observer) =>
    widgetsBinding?.addObserver(observer);

void removeObserver(WidgetsBindingObserver observer) =>
    widgetsBinding?.removeObserver(observer);

void addPersistentFrameCallback(FrameCallback duration) =>
    widgetsBinding?.addPersistentFrameCallback(duration);

void addTimingsCallback(TimingsCallback callback) =>
    widgetsBinding?.addTimingsCallback(callback);
