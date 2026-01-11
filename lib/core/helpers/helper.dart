import 'package:flutter/material.dart';
import '../constants/const_data.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/theme/responsive_size.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import 'package:reminder/core/storage/app_storage.dart';
import 'package:reminder/appearance/remind/data/models/models.dart';

class Helper {
  static Future<void> showBottomModel({
    required BuildContext ctx,
    Function()? onConfirm,
    required Widget body,
    String title = '',
  }) async {
    await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: white.withOpacity(0.75),
          border: Border.all(
            width: borderWidth,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadVal.r),
        ),
        child: Column(
          spacing: spacingVal,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: title.isEmpty ? 0 : 16),
              child: Text(
                title,
                style: context.subTitleTextStyle.copyWith(
                  color: context.primaryColor,
                ),
              ),
            ),
            body,
            Visibility(
              visible: onConfirm != null,
              child: SimpleAppButton(
                text: 'Confirm',
                borderRadius: borderRadVal.r,
                margin: const EdgeInsets.symmetric(
                  horizontal: cardMarginVal,
                  vertical: 10,
                ),
                onTap: () => onConfirm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showDateTimeModal(
    BuildContext cxt, {
    required Function(DateTime) onTap,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.time,
    DateTime? initial,
    String? title,
    DateTime? minDate,
  }) {
    DateTime val = initial ?? DateTime.now();
    showModalBottomSheet(
      context: cxt,
      builder: (context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(top: verticalPadVal, bottom: bottomPadVal),
        child: Column(
          spacing: spacingVal,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: context.subTitleTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      applyThemeToAll: true,
                      textTheme: CupertinoTextThemeData(
                        textStyle: cxt.subStyle,
                      ),
                      brightness: Theme.of(context).brightness,
                    ),
                    child: CupertinoDatePicker(
                      backgroundColor: white,
                      minimumDate: minDate,
                      initialDateTime: val,
                      mode: mode,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDate) {
                        // print("dattime  $newDate");
                        val = newDate;
                      },
                    ),
                  ),
                  Text(":", style: context.subTitleTextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizantPadVal),
              child: SimpleAppButton(text: "confirm", onTap: () => onTap(val)),
            ),
          ],
        ),
      ),
    );
  }

  // Eng yaqin kelgusi eslatma (vaqti va modeli)
  static RemindModel? get sortRemindByDate {
    final res = _nextReminder(DateTime.now());
    return res.remindTime == null ? null : res.remind;
  }

  static DateTime? get sortRemindTime => _nextReminder(DateTime.now()).remindTime;

  static ({RemindModel? remind, DateTime? remindTime}) _nextReminder(
    DateTime now,
  ) {
    final reminders = AppStorage.reminders
        .where((remind) => remind.remindMe && !remind.isPaused)
        .toList();

    if (reminders.isEmpty) return (remind: null, remindTime: null);

    RemindModel? pickRemind;
    DateTime? pickTime;

    for (final remind in reminders) {
      final nextTime = _nextOccurrence(remind, now);
      if (nextTime == null) continue;
      if (pickTime == null || nextTime.isBefore(pickTime)) {
        pickTime = nextTime;
        pickRemind = remind;
      }
    }

    return (remind: pickRemind, remindTime: pickTime);
  }

  static DateTime? _nextOccurrence(RemindModel remind, DateTime now) {
    if (remind is IntervalRemindModel) {
      return remind.isHourly
          ? _nextHourlyIntervalOccurrence(remind, now)
          : _nextDailyIntervalOccurrence(remind, now);
    }
    if (remind is MultipleRemindModel) {
      return _nextMultipleOccurrence(remind.times, now);
    }
    if (remind is WeeklyRemindModel) {
      return _nextWeeklyOccurrence(remind.days, remind.times, now);
    }
    if (remind is CyclicRemindModel) {
      return _nextCyclicOccurrence(remind, now);
    }
    return null;
  }

  /// isHourly = true: start_date va end_date oralig'ida interval qadam bilan.
  static DateTime? _nextHourlyIntervalOccurrence(
    IntervalRemindModel remind,
    DateTime now,
  ) {
    final DateTime startDay = _onlyDate(remind.startDate);
    final DateTime today = _onlyDate(now);
    final DateTime? endDay =
        remind.endDate != null ? _onlyDate(remind.endDate!) : null;

    final int stepMinutes =
        ((remind.interval > 0 ? remind.interval : 0.5) * 60).round();
    if (stepMinutes <= 0) return null;
    final Duration step = Duration(minutes: stepMinutes);

    final DateTime startTime = _timeOf(remind.startDate);
    final DateTime endTime = _timeOf(remind.endDate ?? remind.startDate);
    if (endTime.isBefore(startTime)) return null;

    final int maxDays = endDay != null
        ? endDay.difference(today).inDays.clamp(0, 3650)
        : 3650;

    for (int offset = 0; offset <= maxDays; offset++) {
      final DateTime date = today.add(Duration(days: offset));
      if (date.isBefore(startDay)) continue;
      if (endDay != null && date.isAfter(endDay)) break;

      final slots = _buildHourlySlots(date, startTime, endTime, step);
      for (final slot in slots) {
        if (offset > 0 || slot.isAfter(now)) return slot;
      }
    }

    return null;
  }

  /// isHourly = false: start_date dan boshlab interval (kunlarda) qadam bilan, times vaqtlari.
  static DateTime? _nextDailyIntervalOccurrence(
    IntervalRemindModel remind,
    DateTime now,
  ) {
    final DateTime startDay = _onlyDate(remind.startDate);
    final DateTime today = _onlyDate(now);
    final times = _timesOf(remind.times);
    if (times.isEmpty) return null;

    final int stepDays = remind.interval.ceil().clamp(1, 3650);
    final int diffDays = today.difference(startDay).inDays;
    int k = diffDays <= 0 ? 0 : (diffDays / stepDays).floor();

    for (int iter = 0; iter <= 3650; iter++, k++) {
      final DateTime date = startDay.add(Duration(days: k * stepDays));
      final bool isToday = date.isAtSameMomentAs(today);

      for (final time in times) {
        final candidate = _combineDateWithTime(date, time);
        if (candidate.isAfter(now)) return candidate;
      }

      if (!isToday && date.isAfter(today)) {
        return _combineDateWithTime(date, times.first);
      }
    }

    return null;
  }

  static DateTime? _nextMultipleOccurrence(
    List<DateTime> times,
    DateTime now,
  ) {
    final sorted = _timesOf(times);
    if (sorted.isEmpty) return null;
    final DateTime today = _onlyDate(now);

    for (final time in sorted) {
      final candidate = _combineDateWithTime(today, time);
      if (candidate.isAfter(now)) return candidate;
    }

    final DateTime tomorrow = today.add(const Duration(days: 1));
    return _combineDateWithTime(tomorrow, sorted.first);
  }

  static DateTime? _nextWeeklyOccurrence(
    List<int> days,
    List<DateTime> times,
    DateTime now,
  ) {
    final sortedTimes = _timesOf(times);
    if (days.isEmpty || sortedTimes.isEmpty) return null;

    final DateTime today = _onlyDate(now);
    final int todayIndex = today.weekday - 1; // 0=Mon

    if (days.contains(todayIndex)) {
      for (final time in sortedTimes) {
        final candidate = _combineDateWithTime(today, time);
        if (candidate.isAfter(now)) return candidate;
      }
    }

    int minDiff = 8;
    for (final day in days) {
      int diff = day - todayIndex;
      if (diff <= 0) diff += 7;
      if (diff < minDiff) minDiff = diff;
    }

    final DateTime targetDate = today.add(Duration(days: minDiff));
    return _combineDateWithTime(targetDate, sortedTimes.first);
  }

  static DateTime? _nextCyclicOccurrence(
    CyclicRemindModel remind,
    DateTime now,
  ) {
    final DateTime today = _onlyDate(now);
    final DateTime startDay = _onlyDate(remind.startDate);
    final times = _timesOf(remind.times);
    if (times.isEmpty) return null;

    const int maxDays = 3650;
    for (int offset = 0; offset <= maxDays; offset++) {
      final DateTime date = today.add(Duration(days: offset));
      if (date.isBefore(startDay)) continue;
      if (!_isCyclicActive(remind, date)) continue;

      for (final time in times) {
        final candidate = _combineDateWithTime(date, time);
        if (offset > 0 || candidate.isAfter(now)) return candidate;
      }
    }

    return null;
  }

  static bool _isCyclicActive(CyclicRemindModel remind, DateTime date) {
    final DateTime start = _onlyDate(remind.startDate);
    if (date.isBefore(start)) return false;
    final int cycle = remind.activeVal + remind.pauseVal;
    if (cycle <= 0) return true;
    final int daysFromStart = date.difference(start).inDays;
    final int pos = daysFromStart % cycle;
    return pos < remind.activeVal;
  }

  static List<DateTime> _buildHourlySlots(
    DateTime date,
    DateTime startTime,
    DateTime endTime,
    Duration step,
  ) {
    final slots = <DateTime>[];
    DateTime cursor = _combineDateWithTime(date, startTime);
    final DateTime end = _combineDateWithTime(date, endTime);

    while (!cursor.isAfter(end)) {
      slots.add(cursor);
      cursor = cursor.add(step);
      if (slots.length > 5000) break; // ehtiyot chorasi
    }
    return slots;
  }

  static List<DateTime> _timesOf(List<DateTime> raw) {
    final list = raw
        .map(
          (dt) => DateTime(
            0,
            1,
            1,
            dt.hour,
            dt.minute,
            dt.second,
            dt.millisecond,
            dt.microsecond,
          ),
        )
        .toList();
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  static DateTime _combineDateWithTime(DateTime date, DateTime time) => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
        time.millisecond,
        time.microsecond,
      );

  static DateTime _onlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime _timeOf(DateTime dt) => DateTime(
        0,
        1,
        1,
        dt.hour,
        dt.minute,
        dt.second,
        dt.millisecond,
        dt.microsecond,
      );
}
