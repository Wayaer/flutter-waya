## 10.0.1

* `AutomaticKeepAliveWrapperState` renamed to `AutomaticKeepAliveClientMixinState`
* `AutomaticKeepAliveWrapper` renamed to `AutomaticKeepAliveClientWrapper`

## 10.0.0

* Migrate to 3.27.0

## 9.10.1

* Remove `CounterAnimation`, add `AnimationCounter.down()`、`AnimationCounter.up()`
* Remove `CountDown`, add `Counter.down()`、`Counter.up()`

## 9.9.0

* Added `CarouselSlider`
* Changed `FlProgress` to `FlLinearProgress` and made modifications to the parameters

## 9.8.0

* Add some callbacks for `CountDown()` and remove `CountDownType` enumeration
* Add `onStartTiming` `onStarts` `onEnds` callback method for `CountDown()`
* Change the `onTap` of `SendVerificationCode()` to `onSendTap`
* Change the `onStateChanged` of `SendVerificationCode()` to `onChanged`

## 9.7.1

* Added `AutomaticKeepAliveWrapper` and `AutomaticKeepAliveWrapperState`
* Modify `DecoratorEntry` to `DecoratorPendant`,and adds the `maintainSize` property to determine
  whether to maintain the size
* Modify `DecoratorPositioned` to `DecoratorPendantPosition`
* Added `BoxDecorative` to `DecoratorBox` and `DecoratorBoxState`
* Modify `.toDecoratorEntry()` to `.toDecoratorPendant()`
* Remove the `needKeyBoard` and `focusNode` from `PINTextField`
* Change the `controller` of `PINTextField` to mandatory
* Hide `contextMenuBuilder` and `enableInteractiveSelection` for `PINTextField`
* Modify some parameters of `ExpansionTiles` `PopupMenuButtonRotateBuilder` `ToggleRotate`, please
  refer to Example

## 9.6.0

* Remove the `DropdownMenusButton` component, please use the `MultiPopupMenuButton` component
* Remove the `DropdownMenuButton` component, please use the `PopupMenuButtonRotateBuilder` component
* Added `FlPopupMenuButton`, which can display more content than `PopupMenuButton` without lagging
* Added `showFlMenu`, which can display more content than `showMenu` without lagging

## 9.5.2

* export `SystemUiOverlayStyleLight`、`SystemUiOverlayStyleDark`

## 9.5.1

* Removed `fl_extended`

## 9.3.1

* Change the `SendSMS` to `SendVerificationCode`
* Change the `PinBox` to `PINTextField`
* Change the `PinTextFieldBuilderConfig` to `PINTextFieldBuilderConfig`
* Update `fl_extended`

## 9.1.4

* Removed `AnchorScrollBuilder`
* Add `Shimmery`

## 9.1.3

* Add `FlipCardController` to `FlipCard()`

## 9.1.2

* Change `Badge` to `FlBadge` to avoid conflicts with flutter packets
* Fixed conflicts between `DropdownMenusButton` and official packages

## 9.1.1

* Refactor the `DropdownMenuButton` and `DropdownMenusButton`
* Update `fl_extended`

## 9.0.1

* Split core extension to [fl_extended](https://pub.dev/packages/fl_extended) package
* Modify all `GlobalWayUI()` to `FlExtended()`

## 8.7.2

* Add a typedef dart file,Contains all callback methods from 0 to 4
* Migrate to 3.19.0
* Change the `AnimationStyle` of `FlAnimation` to `FlAnimationStyle` to avoid conflict with the
  official `AnimationStyle`

## 8.6.5

* Fixed `firstOrNull` and `lastOrNull` exceptions
* Added the `AutoCollapsingBuilder` component,Automatically collapse your own components as the
  scrollview scrolls,And add examples

## 8.6.4

* Add an extension for `TextEditingController`

## 8.6.3

* Update `easy_refresh`

## 8.6.2

* Change the `customIcon` of Toast to `icon`
* Add `buildText` for `ToastOptions`
* Change the `$T.toast()` to `$T.showToast()`

## 8.6.1

* Migrate to 3.16.0
* Remove `ExtendedWillPopScope`, please use `ExtendedPopScope`

## 8.5.0

* Remove `SpinKit`

## 8.4.0

* Upgrading lint
* Fix web build inaccessible
* Limit dart minsdk to 3.0.0

## 8.3.0

* Add `Wrapper` and add examples
* Remove the `ExtendedSliverAppBar`，`ExtendedFlexibleSpaceBar`，`ExtendedScrollView`
* Add `ExtendedSliverPersistentHeader`,`ExtendedSliverPersistentHeaderDelegate`

## 8.2.0

* Migrated `ExtendedDio`, `LoggerInterceptor`，`DebuggerInterceptor`, `CookiesInterceptor`,
  and `JsonParse` to [fl_dio](https://pub.dev/packages/fl_dio)
* Removes the `crypto` dependency, so the `toMd5` method is invalid
* Print log '$value.log()'

## 8.1.1

* The `let` and `also` functions increase the judgment to be non-empty
* `GlobalOptions` renamed `GlobalWayUI`
* `expandedNull` renamed `expanded`

## 8.0.3

* Update `dio` and `flutter_staggered_grid_view`
* Remove `flutter_localizations` from dependencies

## 8.0.1

* Fix `DateTimePicker` issue
* Delete `showUnit`, `unitStyle`,`contentStyle`, and add `itemBuilder` to DateTimePicker
* Add `builder` to DateTimePickerUnit
* Add a new component, `DatePicker`
* Add a new component, `XSwitch`
* Remove `horizontalScroll` and `addExpanded`, add `isScrollable`, in `MultiListWheelLinkagePicker`
  and `MultiListWheelPicker` and related components
* Change the `PickerEntry` to a `PickerItem`
* Change the `PickerLinkageEntry` to a `PickerLinkageItem`
* Removes all Picker `options` initial parameters, which need to be added by yourself
* Use `ChangedBuilder` instead of `CheckboxState` and `SwitchState`
* Change the `CountAnimationType` to `CountAnimationStyle`
* Change `SingleListPicker`'s `listBuilder` to `builder`
* Change `CounterAnimation`'s `countBuilder` to `builder`
* Change `BubbleButton`'s `bubbleBuilder` to `builder`
* `Toast` Adds animation effect
* Remove `ExtendedWidgetsApp`
* `ExtendedScaffold` removed and `ExtendedWillPopScope` added, see `exmaple/lib/main.dart`

## 7.5.2

* Update dio
* Remove `ExtendedDioOptions`
* Remove `ExtensionOptions`

## 7.3.1

* Removed `AutoScrollEntry`
* Example Change the `stateBuilder` of `SendSMS` to `builder`
* Example Change the `stateBuilder` of `CheckBox` to `builder`
* Fixed a `CheckBox` refresh issue
* The way `SwitchState` and `CheckboxState` are built has been changed , the `builder` must be used
* Remove `CupertinoSwitchState` , use `SwitchState`

## 7.2.0

* Fix the `AnchorScrollController` jump problem
* To remove `SimpleButton`, use `Universal`
* To remove `ElasticButton`, use `ElasticBuilder`
* Remove `card` `inkwell` `shrink` and `gaussian` from `Universal`

## 7.1.0

* Add `FlipCard()`
* Updated the `easy_refresh` package
* Modify `RefreshConfig`

## 7.0.0

* Compatible with 3.10.0
* Removes the method associated with `MediaQueryData.fromWindow(ui.window)`, but can be obtained
  from context
* `ListWheel` added `onSelectedItemChanged` callback,
* Removes the `onChanged` callback for `WheelOptions()`
* `PickerWheelOptions` removed. Please use `WheelOptions`
* `WheelOptions` added `WheelOptions.cupertino()` and `WheelOptions.custom()`

## 6.1.0

* Change the `MultiColumnPicker()` to `MultiListWheelPicker()`
* Change the `MultiColumnLinkagePicker()` to `MultiListWheelLinkagePicker()`
* Change the `SingleColumnPicker()` to `SingleListWheelPicker()`
* Add `CupertinoListWheelScrollView()` in `CupertinoPicker` inheritance

## 6.0.1

* Add `ExtendedState` to replace the `State`
* Update `dio@5.1.1`

## 6.0.0

* Added the value argument for `PickerLinkageEntry`, so `MultiColumnLinkagePicker` gets
  the `onValueChanged` method
* `AreaPicker` removed. Use `MultiColumnLinkagePicker`, as shown in the `MultiColumnLinkagePicker`
  component in the example, In `example/lib/module/picker/area.dart` The regional data in the dart
* Rewrite `TabBarBox()` and `TabBarMerge()`
* Added the `MultiListLinkagePicker()` and added the example
* `ScrollList.waterfall()` and `ScrollList.separator()` removed , Use `ScrollList.builder()`.
* Remove the `SliverWaterfallFlow()`,`SliverListGrid` adds the `gridStyle` parameter
* Modify `ListWheel()` and `ListWheelState()`
* Split des engine to [des_engine](https://pub.dev/packages/des_engine)

## 5.3.2

* Fixed some issues with `DateTimePicker` and `AreaPicker`

## 5.3.1

* Create `WayIcons`
* Optimized the toast style icon

## 5.3.0

* Modified
  the `AreaPicker()` `DateTimePicker()` `MultiColumnPicker()` `MultiColumnLinkagePicker()`
  `SingleListPicker()` `SingleColumnPicker()`
  ,Added width and height and onChanged attributes for them,And you can remove the header component
  by setting options to null,
* Add examples for the above components

## 5.2.0

* Change the `Indicator()` to `FlIndicator()`
* Change the `Wave()` to `FlAnimationWave()`
* Change the `Progress()` to `FlProgress()`
* Refactoring the `DropdownMenus()`

## 5.1.1

* Add `RatingStars()`

## 5.1.0

* Fixed `CustomPicker` issues
* Change the `confirmTap` in `PickerOptions` to `verifyConfirm`
* Change the `cancelTap` in `PickerOptions` to `verifyCancel`
* Change the `filteredUrls` to `filteredApi`

## 5.0.0

* Updated dio to 5.0.0
* Fixed an issue with duplicate setting of contentType

## 4.0.0

* Compatible with Flutter 3.7.0
* Remove `GestureLock()`
* Modify `LiquidProgress()` to `LiquidProgressIndicator()`
* Modify `FlSwiper.builder()` to `FlSwiper()`
* Change the name of the `FlSwiperPagination()` component

## 3.5.2+2

* Fixed an issue with ineffective `backgroundColor` for `ExpansionTiles()`
* Add extension methods for `Options`
* Add `contentPadding` to the `PickerOptions()`

## 3.5.1

* `ExtendedDio` Adds more methods

## 3.5.0+1

* Refactor `Toast()` using `Toast().show()`, or `ToastStyle.show()`、`${value}.toast()`
* Refactor `Loading()` using `Loading().show()`
* Remove `showDateTimePicker()` and use `DateTimePicker().show()`
* Remove `showAreaPicker()` and use `AreaPicker().show()`
* Remove `showSingleColumnPicker()` and use `SingleColumnPicker().show()`
* Remove `showMultiColumnPicker()` and use `MultiColumnPicker().show()`
* Remove `showMultiColumnLinkagePicker()` and use `MultiColumnLinkagePicker().show()`
* Remove `showSingleListPicker()` and use `SingleListPicker().show()`
* Remove `showDialogPopup()` and use `$Widget().popupDialog()`
* Add `$Widget().popupCupertinoDialog()`、`$Widget().popupMaterialDialog()`
* Remove `showBottomPopup()` and use `$Widget().popupBottomSheet()`
* Remove `showCupertinoBottomPopup()` and use `$Widget().popupCupertinoModal()`
* Add `ExtensionWidgetMethod` extension to the `Widget`,You can use `$Widget().push()`
  、`$Widget().pushReplacement()`、`$Widget().pushAndRemoveUntil()``$Widget().showOverlay()`
  、`$Widget().showLoading()`、`$Widget().showLoading()`,
* Add `ExtensionNavigatorStateContext` extension to the `BuildContext`,You can use most of
  Navigator's methods
* Add `ExtensionFocusScopeContext` extension to the `BuildContext`,You can use most of
  FocusScopeNode's methods
* Change the `setLogDottedLine()` to `setLogCrossLine()`

## 3.3.2+5

* Add `ExtensionFutureFunction()`
* Add the merge method for some Options

## 3.3.2

* Change the original `ExtendedFutureBuilder()` to `CustomFutureBuilder()`
* Added new `ExtendedFutureBuilder()` extension for `FutureBuilder()`
* Added  `ExtendedStreamBuilder()` extension for `StreamBuilder()`

## 3.3.1

* Fixed bugs in the `DebuggerInterceptor()`

## 3.3.0+9

* Add device preview for example
* Add `ColorExtension`、`IterableExtension`
* Change `checkNullOrEmpty` to `isEmptyOrNull`
* Add `constraints` for `ModalWindowsOptions()`

## 3.3.0+6

* Fix known issues with `ExtendedScrollView()`
* Add `convertToList()` for Type T

## 3.3.0+3

* Add `DecoratorBoxState()` and Example
* Change `WidgetPendant()` to `DecoratorBox()`

## 3.2.1+1

* Repair the `EasyRefreshed` problem

## 3.2.1

* Change `ListStateWheel()` to `ListWheelState()`

## 3.2.0

* Add `RefreshControllers()`
* Add `ExtensionT`

## 3.1.0+1

* Add `CookiesInterceptor()` `DebuggerInterceptor()` `LoggerInterceptor()`
* Modify the incorrect naming

## 3.0.1+2

* Fixed an issue with `ExtendedScrollView()` calling `didUpdateWidget` during the lifecycle
* Add `builderScrollView` to `ExtendedScrollView()` to customize your own `ScrollView`

## 3.0.1+1

* Add `onStateChanged` for `SendSMS()`
* Refactoring `RText()` and `BText()`
* Add `BText.rich()`

## 3.0.0+2

* Compatible with Flutter 3.3.0

## 2.3.2

* Some code has been updated
* Add `CupertinoSwitchState()`

## 2.3.1

* Add `SwitchState()` and `CheckboxState()`
* All Carousel names are changed to FlSwiper

## 2.2.0

* Compatible with flutter 3.0.0

## 1.21.3+1

* Add global Settings `LoadingOptions()`
* `PinBox()` adds a custom build `TextField()`

## 1.21.2

* Optimize loading toast and all related `ExtendedOverlayEntry()`
* Limit loading and toast to only one

## 1.21.1+1

* Fix `JsonParse` bug
* Refactoring `ExtendedDio()`

## 1.20.6

* Fixed issues with `scaffoldWillPop`
* Add the `AnchorScrollBuilder()` component,And fix known problems, and it works perfectly

## 1.20.2

* New `ExtendedStatefulBuilder`
* New `ListStateWheel` Fixed some display index anomalies caused by builds
* Add some lifecycle methods to `ValueListenBuilder` `ValueBuilder` `ExtendedFutureBuilder`
* Fixed the `MultiColumnLinkagePicker` bug

## 1.20.0

* Add `AnchorScrollBuilder()`,You can use it to specify the index whether it be a `ListView` or
  `GridView`, whether `SliverChildBuilderDelegate()` structure, or `SliverChildListDelegate()` can
  be competent for it,And
  add [example](https://github.com/Wayaer/flutter_waya/tree/main/example/lib/module/anchor_scroll_builder_page.dart)
* Add the `getDaysForRange()` extension method for `DateTime`

## 1.19.1

* Add some extension
  methods `toChineseNumbers()` `getWidgetRectGlobalToLocal()` `getWidgetRectLocalToGlobal()`
  `checkNullOrEmpty()`
* Remove `RipplePageRoute()`
* Fixed some popover bugs

## 1.19.0

* Change `MultipleChoicePicker` to `SingleColumnPicker`
* Change `showMultipleChoicePicker()` to `showSingleColumnPicker`
* Add `MultiColumnPicker` and `MultiColumnLinkagePicker`
* Add `showMultiColumnPicker()` and `showMultiColumnLinkagePicker()`
* All have been added
  with [examples](https://github.com/Wayaer/flutter_waya/tree/main/example/lib/module/popup_windows_page.dart)

## 1.18.5

* Fix bugs

## 1.18.3

* `ExpansionTiles` add `child` and add example
* Refactoring log tool
* Add `getBoxShadow()`
* `JsonParse` adds long-press replication

## 1.18.1

* Delete useless parameters
* Refactoring `ExtendedDio` initialization

## 1.17.5

* `LoggerInterceptor` adds `forbidPrintUrl`, which specifies that part of the URL is not logged

## 1.17.1

* Add a waterfall flow function to the `ScrollList`

## 1.16.8

* Fix some bugs

## 1.16.7

* Add `systemOverlayStyle` for `ExtendedScaffold()`
* Fix some bugs about `Toast` and `ModalWindowsOptions()`

## 1.16.2

* Add `ExtendedOverlay()`,
* Modify `showDialogSureCancel()` to `showDoubleChooseWindows()`,
* Modify `PopupFromType` to `PopupFromStyle`,
* Modify `PopupSureCancel()` to `PopupDoubleChooseWindows()`,
* Remove `setToastDuration()` `setGlobalPushMode()` `setAllToastIgnoringBackground()` methods,
  please use the `GlobalWayUI()` set up some global properties
* Modify `ExtendedOptions()` to `ExtendedDioOptions()`
* Modify `PopupOptions()` to `PopupModalWindows()`, add `options`, use `ModalWindowsOptions()`
* Modify `ToastType` to `ToastStyle`, `toastType` to style, add `options` in `showToast()` method
* Remove the default background color for `showBottomPopup`
* Add positioned for `showToast` and Add the global `setToastPositioned()`
* Modify all `widgetMode` to `pushStyle` and Change all `WidgetMode` to `RoutePushStyle`
* Add the `GlobalWayUI()` class to set
  all `ToastOptions` `WheelOptions` `BottomSheetOptions` `DialogOptions` `PickerWheelOptions`
  `ModalWindowsOptions`
  configuration information
* After modifying `showToast`, you may need to modify some of your own code
* Add `ExtendedOverlay`

## 1.16.0

* Support the theme
* Add an example of an extension
* Fix some bugs
* Split out `WheelOptions` in `ListWheel`
* `PickerWheel` changed to `PickerWheelOptions`
* `Universal` add `SafeArea`

## 1.15.10

* Add `ExtendedFutureBuilder`
* Fixed some bugs

## 1.15.7

* Fix bug for `showCustomPicker`
* Remove `height` for `PickerOptions`
* Fix bug for `DialogOptions`

## 1.15.5

* Add `enabled` for `PinBox`
* Add `needKeyBoard` for `PinBox`
* Add `onTap` for `PinBox`
* Add `BottomSheetOptions` for `showBottomPopup`
* Add `DialogOptions` for `showDialogPopup`

## 1.15.1

* Fix bug for `showDialogPopup`

## 1.15.0

* Remove `showSimpleDialog`,`showSimpleCupertinoDialog`
* Remove `showBottomPagePopup` ，please use `showBottomPopup`
* Modify `showCupertinoBottomPagePopup` to `showCupertinoBottomPopup`
* Fix bug on `modal` for `DropdownMenu` `Universal` add `systemOverlayStyle`,modify status bar color
* Add `statusBarStyle` for `ExtensionWidget`

## 1.13.2

* Remove `setStatusBarLight()`
* Add `SystemUiOverlayStyleDark()` and `SystemUiOverlayStyleLight()`

## 1.13.1

* Modify `showDateTimePicker` to return `DateTime`
* Modify the initialization method of `DateTimePickerUnit`
* Fix bug for `DateTimePicker`
* Add `showCustomPicker`
* Remove the `sureIndexTap` parameter in `PickerOptions`,
* Restructured `DropdownMenu` and `CheckBox`

## 1.13.0

* Add `CountDown` and remove `CountDownSkip`
* Restructured `SendSMS`
* Restructured example

## 1.12.1

* Add `ExtendedDio` `ExtendedOptions` `LoggerInterceptor`

## 1.11.8

* Fix buf for `Progress`
* Fix bug for `DateTimePicker` `PinBox` add `spaces`,and remove `width` `boxSpacing`

## 1.11.3

* Fix some bug

## 1.11.2

* DioTools add `useLog`
* Add `ExtensionFunction` including debounce function and throttle function

## 1.11.1

* Remove `DottedLine`
* Add `DottedLinePainter`

## 1.11.0

* Change `PopupBase` to ` PopupModalWindows`
* Change `GlobalWidgetsApp` to `ExtendedWidgetsApp`
* Change `OverlayScaffold` to `ExtendedScaffold`
* Change `SliverAutoAppBar` to `ExtendedSliverAppBar`
* Change `PickerSub` to `PickerOptions` and change pickerSub to options , change pickerWheel to
  wheel
* Change `FlexibleSpaceAutoBar` to `ExtendedFlexibleSpaceBar`
* Change `SliverAutoPersistentHeader` to `ExtendedSliverPersistentHeader`
* Change `ScrollViewAuto` to `ExtendedScrollView`
* Change `OverlayEntryAuto` to `ExtendedOverlayEntry`
* Add `onDispose` and `onUpdate` on `ValueListenBuilder`
* Add `didUpdateWidget` on `ValueBuilder`

## 1.10.5

* Change `RichTextSpan` to `RText`
* Change `BasisText` to `BText`
* Change `BasisTextStyle` to `BTextStyle`
* Remove `InputField`
* Add `WidgetPendant` for all widgets, add header, footer, extraPrefix , extraSuffix, prefix,
  suffix. you can use it with `CupertinoTextField` or `TextField`
* Add `inputTextTypeToTextInputFormatter()`

## 1.10.3

* Optimize import
* `OverlayEntryAuto` add `removeEntry()`,When autoOff is true, the `ExtendedScaffold`
  call `onWillPop` will filter the
  `OverlayEntryAuto`

## 1.10.1

* Fix the `remove` error of `Eventbus` when the project supports null-safety

## 1.10.0

* Optimize the return data of network request error
* Fix the cancel network request bug and return the error message

## 1.9.17

* Fix `PinBox` bugs
* ShowToast add `ignoring`
* Add `setAllToastIgnoringBackground()`,if it is true, the background responds to the click event

## 1.9.15

* ` PopupModalWindows` add onWillPop and filter for `WillPopScope` And `BackdropFilter`

## 1.9.13

* `Universal` add useSingleChildScrollView property，The default is true, If useSingleChildScrollView
  is false, the scrolling component will be created using `Scrollview`
* `Universal` add `Wrap`,
* `Universal` adds `StatefulBuilder`、`Builder` and `LayoutBuilder`，and uses them through builder
  properties
* Fix bugs for `TabBarMerge`
* Fix `ListWheel` controller auto destroy problem

## 1.9.12

* Fix bug for popBack
* LogTools add `RequestOptions`
* Add example for `ScrollViewAuto.nested`

## 1.9.11

* `Universal` add `ImageFilter`
* Split `ScrollList`
* Add `RefreshScrollView`
* Add `SliverListGrid`

## 1.9.10

* Add `ValueListenBuilder` and Example
* `ValueBuilder` add BuildContext for builder and add Example
* `ScrollList` add `Header` and `Footer`

## 1.9.9

* Fix bug

## 1.9.7

* Modify the method of obtaining the OverlayState

## 1.9.6

* Add `EasyRefreshType`

## 1.9.5

* Fix bugs
* Add doc

## 1.9.3

* Fix bugs for `des`

## 1.9.2

* Change `HintDot` to `Badge`
* Add `DropdownMenuButton.material`

## 1.9.1

* Remove `DropdownMenuButton` constraints.

## 1.9.0

* Update `dio` to 4.0.0
* Fix bugs

## 1.8.7

* Add `DropdownMenuButton`
* Add example
* Add scaffoldMessengerKey for `MaterialApp`
* Add showSnackBar

## 1.8.6

* Optimization is not an `http-200` state return parameter

## 1.8.5

* Repair `ScrollList.separated` bug

## 1.8.3

* Global optimization refresh

## 1.8.0

* Replace refresh component

## 1.7.5

* Add ExpansionTiles example and fix bug

## 1.7.2

* Update flutter 2.0

## 1.6.0

* Add `Progress.circular` `Progress.linear`
* ExtensionString add insert void
* Add `BasisText`  `BasisTextStyle`
* Modify `RichSpan` to `RichTextSpan`
* Modify `sendMessage(RefreshCompletedType.refresh)`
  to `sendRefreshType(RefreshCompletedType.refresh)`
* Remove Ts
* Remove `FlSwiper.pageView`
* ShowToast add async callback

## 1.5.0

* Change Tools to Ts.
* Change GlobalMaterial to ExtendedWidgetsApp.
* Modify push and pop
* Add Universal tagging
* Fix ExtendedWidgetsApp did not return MaterialApp
* Modify styles.dart
* Universal add Refreshed
* Add des encode and decode
* Remove `NestedScroll`
* Add `ScrollViewAuto` `SliverAutoPersistentHeader` `SliverAutoAppBar`
* Universal add`StatefulWidgetBuilder` `SizedBox`
* Picker add `PickerTitle` `PickerWheel`
* DateTimePicker add Start end range
* Add ScrollConfiguration
* Add extension
* `push` `pushReplacement` `pushAndRemoveUntil`remove widget , push(Widget())

## 1.3.10

* Fix `ListWheel` The method 'call' was called on null.
* Remove `ListWheel` dispose().

## 1.3.9

* Remove Overflow for Universal

## 1.3.7

* Simplifying some component parameters 【 PopupDoubleChooseWindows， PopupModalWindows】
* Modify utils partial method name

## 1.3.3

* Add showCupertinoBottomPagePopup

## 1.3.2

* Remove some widget
* Format code

## 1.2.1

* Refactoring all file names and classes
* Optimize overlay `toast loading`
* The pop method moves out of the context parameter.
* Change of route jump can directly call `push() pushReplacement() pushAndRemoveUntil() pop()`.

## 1.1.1

* Optimization class file

## 1.1.0

* Split some tool classes
* Add some components `GifControl` `DropdownMenu` `Universal`

## 1.0.4

* Split TabBarWidget
* Optimize part of the code
* New components

## 1.0.3

* Optimize time selector (simplified parameter)
* Optimize overlay stack
* To fix the problem that overlay cannot be closed by clicking the return button (overlay scaffold
  is required)
* Add hero component

## 1.0.2

* Fix download upload method catch exception failed to return

## 1.0.0

* Release of official version

## 0.0.1

* Initialize the package