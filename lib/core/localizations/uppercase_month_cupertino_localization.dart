import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

/// Cupertino localizations wrapper that forces month names to uppercase so
/// `CupertinoDatePickerMode.date` shows capitalized months.
class UpperCaseMonthCupertinoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const UpperCaseMonthCupertinoDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    final base = await GlobalCupertinoLocalizations.delegate.load(locale);
    return _UpperCaseMonthCupertinoLocalizations(base);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) => false;
}

class _UpperCaseMonthCupertinoLocalizations implements CupertinoLocalizations {
  _UpperCaseMonthCupertinoLocalizations(this._base);

  final CupertinoLocalizations _base;
  String _cap(String value) =>
      intl.toBeginningOfSentenceCase(value) ?? value.toUpperCase();

  @override
  String datePickerYear(int yearIndex) => _base.datePickerYear(yearIndex);

  @override
  String datePickerMonth(int monthIndex) =>
      _cap(_base.datePickerMonth(monthIndex));

  @override
  String datePickerStandaloneMonth(int monthIndex) =>
      _cap(_base.datePickerStandaloneMonth(monthIndex));

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) =>
      _base.datePickerDayOfMonth(dayIndex, weekDay);

  @override
  String datePickerMediumDate(DateTime date) =>
      _base.datePickerMediumDate(date);

  @override
  String datePickerHour(int hour) => _base.datePickerHour(hour);

  @override
  String? datePickerHourSemanticsLabel(int hour) =>
      _base.datePickerHourSemanticsLabel(hour);

  @override
  String datePickerMinute(int minute) => _base.datePickerMinute(minute);

  @override
  String? datePickerMinuteSemanticsLabel(int minute) =>
      _base.datePickerMinuteSemanticsLabel(minute);

  @override
  DatePickerDateOrder get datePickerDateOrder => _base.datePickerDateOrder;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      _base.datePickerDateTimeOrder;

  @override
  String get anteMeridiemAbbreviation => _base.anteMeridiemAbbreviation;

  @override
  String get postMeridiemAbbreviation => _base.postMeridiemAbbreviation;

  @override
  String get todayLabel => _base.todayLabel;

  @override
  String get alertDialogLabel => _base.alertDialogLabel;

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) =>
      _base.tabSemanticsLabel(tabIndex: tabIndex, tabCount: tabCount);

  @override
  String timerPickerHour(int hour) => _base.timerPickerHour(hour);

  @override
  String timerPickerMinute(int minute) => _base.timerPickerMinute(minute);

  @override
  String timerPickerSecond(int second) => _base.timerPickerSecond(second);

  @override
  String? timerPickerHourLabel(int hour) => _base.timerPickerHourLabel(hour);

  @override
  List<String> get timerPickerHourLabels => _base.timerPickerHourLabels;

  @override
  String? timerPickerMinuteLabel(int minute) =>
      _base.timerPickerMinuteLabel(minute);

  @override
  List<String> get timerPickerMinuteLabels => _base.timerPickerMinuteLabels;

  @override
  String? timerPickerSecondLabel(int second) =>
      _base.timerPickerSecondLabel(second);

  @override
  List<String> get timerPickerSecondLabels => _base.timerPickerSecondLabels;

  @override
  String get cutButtonLabel => _base.cutButtonLabel;

  @override
  String get copyButtonLabel => _base.copyButtonLabel;

  @override
  String get pasteButtonLabel => _base.pasteButtonLabel;

  @override
  String get clearButtonLabel => _base.clearButtonLabel;

  @override
  String get noSpellCheckReplacementsLabel =>
      _base.noSpellCheckReplacementsLabel;

  @override
  String get selectAllButtonLabel => _base.selectAllButtonLabel;

  @override
  String get lookUpButtonLabel => _base.lookUpButtonLabel;

  @override
  String get searchWebButtonLabel => _base.searchWebButtonLabel;

  @override
  String get shareButtonLabel => _base.shareButtonLabel;

  @override
  String get searchTextFieldPlaceholderLabel =>
      _base.searchTextFieldPlaceholderLabel;

  @override
  String get modalBarrierDismissLabel => _base.modalBarrierDismissLabel;

  @override
  String get menuDismissLabel => _base.menuDismissLabel;

  @override
  String get cancelButtonLabel => _base.cancelButtonLabel;

  @override
  String get backButtonLabel => _base.backButtonLabel;

  @override
  String get expansionTileExpandedHint => _base.expansionTileExpandedHint;

  @override
  String get expansionTileCollapsedHint => _base.expansionTileCollapsedHint;

  @override
  String get expansionTileExpandedTapHint => _base.expansionTileExpandedTapHint;

  @override
  String get expansionTileCollapsedTapHint =>
      _base.expansionTileCollapsedTapHint;

  @override
  String get expandedHint => _base.expandedHint;

  @override
  String get collapsedHint => _base.collapsedHint;
}
