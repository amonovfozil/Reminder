import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:reminder/appearance/remind/data/models/remind_model.dart';
import 'package:reminder/appearance/remind/data/models/types/multiple_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/weekly_remind.dart';
import 'package:reminder/core/helpers/helper.dart';
import 'package:reminder/core/storage/app_storage.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  LocalNotificationsService._();

  static final LocalNotificationsService instance = LocalNotificationsService._();

  static const String _nextIdKey = 'next_notification_id';

  static const String _channelId = 'reminders';
  static const String _channelName = 'Reminders';
  static const String _channelDescription = 'Scheduled reminders';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    if (kIsWeb) {
      _initialized = true;
      return;
    }

    tzdata.initializeTimeZones();
    await _configureLocalTimeZone();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
      macOS: darwinInit,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        // Keep default behavior for now. Payload contains reminder id.
      },
    );

    _initialized = true;

    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    if (kIsWeb) return;

    final android =
        _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await android?.requestNotificationsPermission();

    final ios =
        _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);

    final macos =
        _plugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >();
    await macos?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _plugin.cancelAll();
  }

  Future<void> cancelByIds(Iterable<int> ids) async {
    if (kIsWeb) return;
    for (final id in ids) {
      await _plugin.cancel(id);
    }
  }

  Future<void> cancelForReminder(RemindModel remind) async {
    await cancelByIds(remind.notificationIds);
  }

  /// Cancels [previous] notification IDs and schedules fresh ones for [remind].
  ///
  /// Returns IDs of scheduled notifications.
  Future<List<int>> rescheduleReminder(
    RemindModel remind, {
    RemindModel? previous,
    int maxOneOffCount = 10,
  }) async {
    await init();

    final previousIds = previous?.notificationIds ?? remind.notificationIds;
    if (previousIds.isNotEmpty) {
      await cancelByIds(previousIds);
    }

    if (!AppStorage.noteStatus || !remind.remindMe || remind.isPaused) {
      return const <int>[];
    }

    try {
      return await _schedule(remind, maxOneOffCount: maxOneOffCount);
    } catch (e, st) {
      log('Failed to schedule reminder notifications: $e', stackTrace: st);
      return const <int>[];
    }
  }

  Future<List<int>> _schedule(
    RemindModel remind, {
    required int maxOneOffCount,
  }) async {
    final now = DateTime.now();

    if (remind is WeeklyRemindModel) {
      final days = List<int>.from(remind.days)..sort();
      final times = List<DateTime>.from(remind.times)
        ..sort((a, b) => _timeOfDayCompare(a, b));

      final count = days.length * times.length;
      if (count <= 0) return const <int>[];

      final ids = await _allocateIds(count);
      var idx = 0;

      for (final dayIndex in days) {
        for (final time in times) {
          final scheduled = _nextWeekly(now, dayIndex: dayIndex, time: time);
          await _plugin.zonedSchedule(
            ids[idx++],
            _safeTitle(remind.title),
            remind.body,
            scheduled,
            _details(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
            payload: remind.id,
          );
        }
      }

      return ids;
    }

    if (remind is MultipleRemindModel) {
      final times = List<DateTime>.from(remind.times)
        ..sort((a, b) => _timeOfDayCompare(a, b));

      if (times.isEmpty) return const <int>[];
      final ids = await _allocateIds(times.length);

      for (var i = 0; i < times.length; i++) {
        final scheduled = _nextDaily(now, time: times[i]);
        await _plugin.zonedSchedule(
          ids[i],
          _safeTitle(remind.title),
          remind.body,
          scheduled,
          _details(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: remind.id,
        );
      }

      return ids;
    }

    final occurrences = Helper.nextOccurrences(
      remind,
      from: now,
      count: maxOneOffCount,
    );
    if (occurrences.isEmpty) return const <int>[];

    final ids = await _allocateIds(occurrences.length);
    for (var i = 0; i < occurrences.length; i++) {
      await _plugin.zonedSchedule(
        ids[i],
        _safeTitle(remind.title),
        remind.body,
        tz.TZDateTime.from(occurrences[i], tz.local),
        _details(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: remind.id,
      );
    }

    return ids;
  }

  NotificationDetails _details() {
    const android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
    );

    const darwin = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    return const NotificationDetails(android: android, iOS: darwin);
  }

  String _safeTitle(String title) => title.trim().isEmpty ? 'Reminder' : title;

  Future<void> _configureLocalTimeZone() async {
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (e, st) {
      log('Failed to configure local timezone: $e', stackTrace: st);
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  Future<List<int>> _allocateIds(int count) async {
    if (count <= 0) return const <int>[];

    final current = (AppStorage.box.read(_nextIdKey) as int?) ?? 1;
    final ids = List<int>.generate(count, (i) => current + i);
    await AppStorage.box.write(_nextIdKey, current + count);
    return ids;
  }

  tz.TZDateTime _nextDaily(DateTime now, {required DateTime time}) {
    final localNow = tz.TZDateTime.from(now, tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      localNow.year,
      localNow.month,
      localNow.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond,
      time.microsecond,
    );

    if (!scheduled.isAfter(localNow)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextWeekly(
    DateTime now, {
    required int dayIndex,
    required DateTime time,
  }) {
    final localNow = tz.TZDateTime.from(now, tz.local);
    final targetWeekday = (dayIndex.clamp(0, 6)) + 1; // 1=Mon..7=Sun

    var scheduled = tz.TZDateTime(
      tz.local,
      localNow.year,
      localNow.month,
      localNow.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond,
      time.microsecond,
    );

    var diff = targetWeekday - scheduled.weekday;
    if (diff < 0) diff += 7;
    scheduled = scheduled.add(Duration(days: diff));

    if (!scheduled.isAfter(localNow)) {
      scheduled = scheduled.add(const Duration(days: 7));
    }
    return scheduled;
  }

  int _timeOfDayCompare(DateTime a, DateTime b) {
    final ah = a.hour;
    final bh = b.hour;
    if (ah != bh) return ah.compareTo(bh);
    final am = a.minute;
    final bm = b.minute;
    if (am != bm) return am.compareTo(bm);
    final as = a.second;
    final bs = b.second;
    if (as != bs) return as.compareTo(bs);
    return a.microsecond.compareTo(b.microsecond);
  }
}
