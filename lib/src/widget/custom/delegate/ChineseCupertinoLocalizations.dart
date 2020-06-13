import 'package:flutter/cupertino.dart';import 'package:flutter/foundation.dart';import 'package:flutter/material.dart';import 'package:flutter_localizations/flutter_localizations.dart';class ChineseCupertinoLocalizations implements CupertinoLocalizations {  final materialDelegate = GlobalMaterialLocalizations.delegate;  final widgetsDelegate = GlobalWidgetsLocalizations.delegate;  final local = const Locale('zh');  ChineseCupertinoLocalizations(this._languageCode)      : assert(_languageCode != null);  final String _languageCode;  MaterialLocalizations ml;  final Map<String, Map<String, String>> _dict = <String, Map<String, String>>{    'en': <String, String>{      'alert': 'Alert',      'copy': 'Copy',      'paste': 'Paste',      'cut': 'Cut',      'selectAll': 'Select all',      'today': 'today'    },    'zh': <String, String>{      'alert': '警告',      'copy': '复制',      'paste': '粘贴',      'cut': '剪切',      'selectAll': '选择全部',      'today': '今天'    }  };  String _get(String key) {    return _dict[_languageCode][key];  }  @override  String get todayLabel => _get("today");  Future init() async {    ml = await materialDelegate.load(local);    print(ml.pasteButtonLabel);  }  @override  String get alertDialogLabel => ml.alertDialogLabel;  @override  String get anteMeridiemAbbreviation => ml.anteMeridiemAbbreviation;  @override  String get copyButtonLabel => ml.copyButtonLabel;  @override  String get cutButtonLabel => ml.cutButtonLabel;  @override  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;  @override  DatePickerDateTimeOrder get datePickerDateTimeOrder =>      DatePickerDateTimeOrder.date_time_dayPeriod;  @override  String datePickerDayOfMonth(int dayIndex) {    return dayIndex.toString();  }  @override  String datePickerHour(int hour) {    return hour.toString().padLeft(2, "0");  }  @override  String datePickerHourSemanticsLabel(int hour) {    return "$hour" + "时";  }  @override  String datePickerMediumDate(DateTime date) {    return ml.formatMediumDate(date);  }  @override  String datePickerMinute(int minute) {    return minute.toString().padLeft(2, '0');  }  @override  String datePickerMinuteSemanticsLabel(int minute) {    return "$minute" + "分";  }  @override  String datePickerMonth(int monthIndex) {    return "$monthIndex";  }  @override  String datePickerYear(int yearIndex) {    return yearIndex.toString();  }  @override  String get pasteButtonLabel => ml.pasteButtonLabel;  @override  String get postMeridiemAbbreviation => ml.postMeridiemAbbreviation;  @override  String get selectAllButtonLabel => ml.selectAllButtonLabel;  @override  String timerPickerHour(int hour) {    return hour.toString().padLeft(2, "0");  }  @override  String timerPickerHourLabel(int hour) {    return "$hour".toString().padLeft(2, "0") + "时";  }  @override  String timerPickerMinute(int minute) {    return minute.toString().padLeft(2, "0");  }  @override  String timerPickerMinuteLabel(int minute) {    return minute.toString().padLeft(2, "0") + "分";  }  @override  String timerPickerSecond(int second) {    return second.toString().padLeft(2, "0");  }  @override  String timerPickerSecondLabel(int second) {    return second.toString().padLeft(2, "0") + "秒";  }  static const LocalizationsDelegate<CupertinoLocalizations> delegate =  _ChineseDelegate();  static Future<CupertinoLocalizations> load(Locale locale) async {    var delegate = ChineseCupertinoLocalizations(locale.languageCode);    await delegate.init();    return SynchronousFuture<CupertinoLocalizations>(delegate);  }}class _ChineseDelegate extends LocalizationsDelegate<CupertinoLocalizations> {  const _ChineseDelegate();  @override  bool isSupported(Locale locale) {    return locale.languageCode == 'zh';  }  @override  Future<CupertinoLocalizations> load(Locale locale) {    return ChineseCupertinoLocalizations.load(locale);  }  @override  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) {    return false;  }}