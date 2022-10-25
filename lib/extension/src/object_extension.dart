import 'package:flutter/cupertino.dart';

extension ExtensionT<T> on T {
  /// let是做了操作后返回新的类型
  ReturnType let<ReturnType>(ReturnType Function(T it) operation) {
    return operation(this);
  }

  /// 做了某个操作后还返回本身啊
  T also(void Function(T it) operation) {
    operation(this);
    return this;
  }

  List<T> convertToList() => [this];

  /// Check if the T is null
  bool get isNull => this == null;

  /// Check if the T is not null
  bool get isNotNull => this != null;

  /// 转为 ValueNotifier
  ValueNotifier<T> get notifier => ValueNotifier<T>(this);
}

extension ExtensionBool on bool {
  bool toggle() => !this;
}
