import 'package:flutter/material.dart';import 'package:flutter_waya/flutter_waya.dart';import 'package:flutter_waya/src/constant/colors.dart';import 'package:flutter_waya/src/constant/styles.dart';typedef ValueCallback<int> = void Function(int titleIndex, int valueIndex);class DropdownMenu extends StatefulWidget {  ///头部数组  final List<String> title;  ///每个头部弹出菜单数组， 必须和title长度一样  final List<List<String>> value;  ///点击头部item回调  final ValueChanged<int> titleTap;  ///点击菜单的回调  final ValueCallback<int> valueTap;  final Color color;  final TextStyle titleStyle;  final TextStyle valueStyle;  final double width;  const DropdownMenu(      {Key key,      @required this.title,      @required this.value,      this.titleTap,      this.valueTap,      this.color,      this.titleStyle,      this.valueStyle,      this.width})      : super(key: key);  @override  State<StatefulWidget> createState() {    return DropdownMenuState();  }}class DropdownMenuState extends State<DropdownMenu> {  List<String> title = [];  List<List<String>> value = [];  List<bool> titleState = [];  GlobalKey titleKey = GlobalKey();  double titleY = 0;  @override  void initState() {    super.initState();    Tools.addPostFrameCallback((duration) {      RenderBox box = titleKey.currentContext.findRenderObject();      titleY = box.localToGlobal(Offset.zero).dy + box.size.height;    });  }  changeState(int index) {    setState(() {      titleState[index] = !titleState[index];    });  }  alertValueWidget(int index) {    var valueList = value[index];    List<Widget> children = [];    valueList.map((v) {      children.add(SimpleButton(          text: v,          textStyle: widget.valueStyle ?? WayStyles.textStyleBlack70(),          width: ScreenFit.getWidth(0),          onTap: () {            if (widget.valueTap != null)              widget.valueTap(index, valueList.indexOf(v));            changeState(index);//            OverlayTools.close();          },          alignment: Alignment.center,          decoration: BoxDecoration(              color: getColors(white),              border: Border(bottom: BorderSide(color: getColors(background)))),          padding: EdgeInsets.symmetric(vertical: ScreenFit.getHeight(12))));    }).toList();    Widget alert = AlertBase(        animation: false,        popupMode: PopupMode.top,        onTap: () {          changeState(index);          OverlayTools.close();        },        child: Universal(            color: getColors(black70).withOpacity(0.2),            margin: EdgeInsets.only(top: titleY + ScreenFit.getHeight(2)),            children: children));    OverlayTools.show(alert);  }  @override  Widget build(BuildContext context) {    title = widget.title;    value = widget.value;    if (title.length != value.length) {      return Container();    }    List<Widget> titleRow = [];    title.map((e) {      titleState.add(false);    }).toList();    title.map((text) {      int index = title.indexOf(text);      titleRow.add(Expanded(          child: IconBox(        onTap: () {          if (widget.titleTap != null) widget.titleTap(index);          changeState(index);          alertValueWidget(index);        },        titleStyle: widget.titleStyle,        titleText: text,        reversal: true,        color: widget.color ?? getColors(black70),        size: ScreenFit.getWidth(22),        icon: titleState[index]            ? Icons.keyboard_arrow_up            : Icons.keyboard_arrow_down,      )));    }).toList();    return Universal(      key: titleKey,      width: widget.width,      padding: EdgeInsets.symmetric(vertical: ScreenFit.getWidth(8)),      mainAxisAlignment: MainAxisAlignment.spaceAround,      direction: Axis.horizontal,      color: getColors(white),      children: titleRow,    );  }}