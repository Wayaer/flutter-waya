part of 'picker.dart';

class PickerEntry {
  const PickerEntry({required this.itemCount, required this.itemBuilder});

  /// 渲染子组件
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
}

extension ExtensionMultiListWheelPicker on MultiListWheelPicker {
  Future<List<int>?> show({BottomSheetOptions? options}) =>
      popupBottomSheet<List<int>?>(options: options);
}

/// 多列滚轮选择 不联动
class MultiListWheelPicker extends PickerStatelessWidget<List<int>> {
  MultiListWheelPicker({
    super.key,
    required this.entry,
    this.horizontalScroll = false,
    this.addExpanded = true,
    this.onChanged,
    this.height = kPickerDefaultHeight,
    this.width = double.infinity,
    this.value = const [],
    this.itemWidth = kPickerDefaultWidth,
    super.options = const PickerOptions<List<int>>(),
    WheelOptions? wheelOptions,
  }) : super(wheelOptions: wheelOptions ?? GlobalOptions().wheelOptions);

  /// 要渲染的数据
  final List<PickerEntry> entry;

  /// 初始默认显示的位置
  final List<int> value;

  /// 是否可以横向滚动
  /// [horizontalScroll]==true 使用[SingleChildScrollView]创建,[wheelOptions]中的[itemWidth]控制宽度，如果不设置则为[kPickerDefaultWidth]
  /// [horizontalScroll]==false 使用[Row] 创建每个滚动，居中显示
  final bool horizontalScroll;

  /// [horizontalScroll]==false
  final bool addExpanded;

  /// onIndexChanged
  final PickerPositionIndexChanged? onChanged;

  /// height
  final double height;

  /// width
  final double width;

  /// wheel width
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    List<int> position = [...value];
    String lastPosition = '';
    void onChanged() {
      if (position.length > entry.length) {
        position.removeRange(entry.length, position.length);
      }
      if (position.toString() != lastPosition) {
        lastPosition = position.toString();
        this.onChanged?.call(position);
      }
    }

    final multi = Universal(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        width: width,
        isScroll: horizontalScroll,
        height: height,
        children: entry.builderEntry((item) {
          if (entry.length > position.length) position.add(0);
          final value = item.value;
          final location = item.key;
          ListWheel buildWheel([FixedExtentScrollController? controller]) =>
              _PickerListWheel(
                  controller: controller,
                  options: wheelOptions,
                  itemBuilder: value.itemBuilder,
                  itemCount: value.itemCount,
                  onChanged: (int index) {
                    position[location] = index;
                  },
                  onScrollEnd: (_) => onChanged());

          return Universal(
              width: itemWidth,
              expanded: horizontalScroll ? false : addExpanded,
              child: this.value.isEmpty
                  ? buildWheel()
                  : ListWheelState(
                      initialItem: position[item.key],
                      builder: buildWheel,
                      count: value.itemCount));
        }));

    if (options == null) return multi;
    return PickerSubject<List<int>>(
        options: options!, child: multi, confirmTap: () => position);
  }
}

class PickerLinkageEntry<T> {
  const PickerLinkageEntry(
      {required this.value, required this.child, this.children = const []});

  final Widget child;

  final T value;

  final List<PickerLinkageEntry<T>> children;
}

extension ExtensionMultiListWheelLinkagePicker on MultiListWheelLinkagePicker {
  Future<List<int>?> show({BottomSheetOptions? options}) =>
      popupBottomSheet<List<int>?>(options: options);
}

/// 多列滚轮选择 联动
class MultiListWheelLinkagePicker<T> extends PickerStatefulWidget<List<int>> {
  MultiListWheelLinkagePicker({
    super.key,
    required this.entry,
    this.value = const [],
    this.horizontalScroll = false,
    this.addExpanded = true,
    this.onChanged,
    this.onValueChanged,
    this.height = kPickerDefaultHeight,
    this.width = double.infinity,
    this.itemWidth = kPickerDefaultWidth,
    super.options = const PickerOptions<List<int>>(),
    WheelOptions? wheelOptions,
  }) : super(wheelOptions: wheelOptions ?? GlobalOptions().wheelOptions);

  /// 要渲染的数据
  final List<PickerLinkageEntry<T>> entry;

  /// 是否可以横向滚动
  /// [horizontalScroll]==true 使用[SingleChildScrollView]创建,[wheelOptions]中的[itemWidth]控制宽度，如果不设置则为[kPickerDefaultWidth]
  /// [horizontalScroll]==false 使用[Row] 创建每个滚动，居中显示
  final bool horizontalScroll;

  /// [horizontalScroll]==false 有效
  final bool addExpanded;

  /// 初始默认显示的位置
  final List<int> value;

  /// onChanged
  final PickerPositionIndexChanged? onChanged;

  /// onValueChanged
  final PickerPositionValueChanged<T>? onValueChanged;

  /// height
  final double height;

  /// width
  final double width;

  /// wheel item width
  final double itemWidth;

  @override
  State<MultiListWheelLinkagePicker<T>> createState() =>
      _MultiListWheelLinkagePickerState<T>();
}

class _MultiListWheelLinkagePickerState<T>
    extends ExtendedState<MultiListWheelLinkagePicker<T>> {
  List<PickerLinkageEntry<T>> entry = [];
  List<int> position = [];
  int currentListLength = 0;

  @override
  void initState() {
    super.initState();
    position = [...widget.value];
    entry = widget.entry;
  }

  void calculateListLength(List<PickerLinkageEntry> list, bool isFirst) {
    if (isFirst) currentListLength = 0;
    if (list.isNotEmpty) {
      List<PickerLinkageEntry> subsetList = [];
      if (currentListLength >= position.length) {
        if (position.length > entry.length) {
          position.removeRange(entry.length, position.length);
        } else if (entry.length > position.length) {
          position.add(0);
        }
        subsetList = list.first.children;
      } else if (currentListLength < position.length) {
        final index = position[currentListLength];
        if (list.length > index) {
          subsetList = list[index].children;
        } else {
          subsetList = list.first.children;
        }
      }
      currentListLength += 1;
      calculateListLength(subsetList, false);
    } else {
      while (position.length > currentListLength) {
        position.removeLast();
      }
    }
  }

  List<Widget> get buildWheels {
    calculateListLength(entry, true);
    List<Widget> list = [];
    List<PickerLinkageEntry> currentEntry = entry;
    position.length.generate((index) {
      final itemPosition = position[index];
      if (currentEntry.isNotEmpty) {
        list.add(listStateWheel(location: index, list: currentEntry));
        if (itemPosition < currentEntry.length) {
          currentEntry = currentEntry[itemPosition].children;
        } else {
          currentEntry = currentEntry.last.children;
        }
      }
    });
    return list;
  }

  @override
  void didUpdateWidget(covariant MultiListWheelLinkagePicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    entry = widget.entry;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final multi = Universal(
        width: widget.width,
        height: widget.height,
        direction: Axis.horizontal,
        isScroll: widget.horizontalScroll,
        children: buildWheels.builder((item) => Universal(
            expanded: widget.horizontalScroll ? false : widget.addExpanded,
            width: widget.itemWidth,
            child: Center(child: item))));
    if (widget.options == null) return multi;
    return PickerSubject<List<int>>(
        options: widget.options!, confirmTap: () => position, child: multi);
  }

  String lastPosition = '';

  void onChanged() {
    if (position.length > entry.length) {
      position.removeRange(entry.length, position.length);
    }
    if (position.toString() != lastPosition) {
      lastPosition = position.toString();
      widget.onChanged?.call(position);
      if (widget.onValueChanged != null) {
        List<T> value = [];
        List<PickerLinkageEntry> resultList = entry;
        position.builder((index) {
          if (index < resultList.length) {
            value.add(resultList[index].value);
            resultList = resultList[index].children;
          }
        });
        widget.onValueChanged!(value);
      }
    }
  }

  Widget listStateWheel(
          {required List<PickerLinkageEntry> list, required int location}) =>
      ListWheelState(
          count: list.length,
          initialItem: position[location],
          builder: (_) => _PickerListWheel(
              controller: _,
              onChanged: (int index) {
                position[location] = index;
              },
              onScrollEnd: (int index) async {
                final builder =
                    list.length > index && list[index].children.isNotEmpty;
                if (location != position.length - 1 || builder) {
                  await 50.milliseconds.delayed();
                  setState(() {});
                }
                onChanged();
              },
              itemBuilder: (_, int index) => Center(
                  child: index > list.length
                      ? list.last.child
                      : list[index].child),
              itemCount: list.length,
              options: widget.wheelOptions));
}