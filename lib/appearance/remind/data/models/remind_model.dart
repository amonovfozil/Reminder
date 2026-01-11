// ignore_for_file: avoid_cyclic_imports

import 'package:reminder/appearance/remind/data/models/types/cyclic_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/interval_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/multiple_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/weekly_remind.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';

class RemindModel {
  String id;
  String title;
  String body;
  RemindType? type;
  bool enableAlert;
  bool remindMe;
  bool isPaused;

  RemindModel({
    required this.id,
    this.title = '',
    this.body = '',
    this.type,
    this.enableAlert = true,
    this.remindMe = true,
    this.isPaused = false,
  });

  factory RemindModel.fromJson(Map<String, dynamic> json) {
    final typeStr = json["type"];
    final remindType = typeStr != null ? typeValues.map[typeStr] : null;
    switch (remindType) {
      case RemindType.interval:
        return IntervalRemindModel(
          id: json["id"] ?? '',
          title: json["title"] ?? '',
          body: json["body"] ?? '',
          type: remindType,
          enableAlert: json["enable_alert"] ?? true,
          remindMe: json["remind_me"] ?? true,
          isPaused: json["is_paused"] ?? false,
          isHourly: json["is_hourly"] ?? true,
          enableInterval: json["enable_interval"] ?? false,
          interval: (json["interval"] as num?)?.toDouble() ?? 0.5,
          startDate: _parseDate(json["start_date"]) ?? DateTime.now(),
          endDate: _parseDate(json["end_date"]),
          times: _parseTimes(json["times"]),
        );
      case RemindType.multiple:
        return MultipleRemindModel(
          id: json["id"] ?? '',
          title: json["title"] ?? '',
          body: json["body"] ?? '',
          type: remindType,
          enableAlert: json["enable_alert"] ?? true,
          remindMe: json["remind_me"] ?? true,
          isPaused: json["is_paused"] ?? false,
          amount: json["amount"] ?? 1,
          times: _parseTimes(json["times"]),
        );
      case RemindType.weekly:
        return WeeklyRemindModel(
          id: json["id"] ?? '',
          title: json["title"] ?? '',
          body: json["body"] ?? '',
          type: remindType,
          enableAlert: json["enable_alert"] ?? true,
          remindMe: json["remind_me"] ?? true,
          isPaused: json["is_paused"] ?? false,
          days: _parseIntList(json["days"]),
          times: _parseTimes(json["times"]),
        );
      case RemindType.cyclic:
        return CyclicRemindModel(
          id: json["id"] ?? '',
          title: json["title"] ?? '',
          body: json["body"] ?? '',
          type: remindType,
          enableAlert: json["enable_alert"] ?? true,
          remindMe: json["remind_me"] ?? true,
          isPaused: json["is_paused"] ?? false,
          startDate: _parseDate(json["start_date"]) ?? DateTime.now(),
          activeVal: json["cycle_on"] ?? 0,
          pauseVal: json["cycle_off"] ?? 0,
          enableInterval: json["enable_interval"] ?? 0,
          times: _parseTimes(json["times"]),
        );
      default:
        return RemindModel(
          id: json["id"] ?? '',
          title: json["title"] ?? '',
          body: json["body"] ?? '',
          type: remindType,
          enableAlert: json["enable_alert"] ?? true,
          remindMe: json["remind_me"] ?? true,
          isPaused: json["is_paused"] ?? false,
        );
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "enable_alert": enableAlert,
    "remind_me": remindMe,
    "is_paused": isPaused,
    "type": type?.name,
  };
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}

List<DateTime> _parseTimes(dynamic raw) {
  if (raw is! List) return [];
  return raw.map(_parseDate).whereType<DateTime>().toList();
}

List<int> _parseIntList(dynamic raw) {
  if (raw is! List) return [];
  return raw
      .map((e) {
        if (e is num) return e.toInt();
        if (e is String) return int.tryParse(e);
        return null;
      })
      .whereType<int>()
      .toList();
}
