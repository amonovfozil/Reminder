import '../../../../../core/constants/enums/remind_type.dart';
import 'package:reminder/appearance/remind/data/models/remind_model.dart';

List<String> weekDays = ["mon", "tue", "wed", "thur", "fri", "sat", "sun"];

class WeeklyRemindModel extends RemindModel {
  List<int> days;
  List<DateTime> times;

  WeeklyRemindModel({
    required super.id,
    super.title,
    super.body,
    super.type = RemindType.weekly,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    super.notificationIds,
    required this.days,
    required this.times,
  });

  WeeklyRemindModel copyWith({
    String? title,
    String? body,
    bool? enableAlert,
    bool? remindMe,
    bool? isPaused,
    List<int>? days,
    List<DateTime>? times,
    List<int>? notificationIds,
  }) {
    return WeeklyRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      enableAlert: enableAlert ?? this.enableAlert,
      remindMe: remindMe ?? this.remindMe,
      isPaused: isPaused ?? this.isPaused,
      notificationIds: notificationIds ?? this.notificationIds,
      days: days ?? this.days,
      times: times ?? this.times,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "days": days,
        "times": times.map((time) => time.toIso8601String()).toList(),
      };
}
