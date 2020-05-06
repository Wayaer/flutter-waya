log(message) {
  LogTools.d(message);
}

class LogTools {
  static var _separator = "=";
  static var _split = "$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator";
  static var _title = "Yl-Log";
  static var _isDebug = true;
  static int _limitLength = 800;
  static String _startLine = "$_split$_title$_split";

  static void init({String title, bool isDebug, int limitLength}) {
    _title = title;
    _isDebug = isDebug;
    _limitLength = limitLength ??= limitLength;
    _startLine = "$_split$_title$_split";
    var endLineStr = StringBuffer();
    var cnCharReg = RegExp("[\u4e00-\u9fa5]");
    for (int i = 0; i < _startLine.length; i++) {
      if (cnCharReg.stringMatch(_startLine[i]) != null) {
        endLineStr.write(_separator);
      }
      endLineStr.write(_separator);
    }
  }

  //仅Debug模式可见
  static void d(dynamic obj) {
    if (_isDebug) {
      log(obj.toString());
    }
  }

  static void v(dynamic obj) {
    log(obj.toString());
  }

  static void log(String msg) {
    if (msg.length < _limitLength) {
      print(msg);
    } else {
      segmentationLog(msg);
    }
  }

  static void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }
}
