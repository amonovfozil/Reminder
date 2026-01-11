import '../remind_model.dart';
import '../../../../../core/constants/enums/remind_type.dart';

class CyclicRemindModel extends RemindModel {
  DateTime startDate;
  int activeVal;
  int pauseVal;
  int enableInterval;
  List<DateTime> times;

  CyclicRemindModel({
    required super.id,
    required this.times,
    super.title,
    super.body,
    super.type = RemindType.cyclic,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    this.activeVal = 21,
    this.pauseVal = 7,
    required this.startDate,
    this.enableInterval = 0,
  });

  CyclicRemindModel copyWith({
    String? title,
    String? body,
    DateTime? startDate,
    int? activeVal,
    int? pauseVal,
    int? enableInterval,
    List<DateTime>? times,
  }) {
    return CyclicRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      times: times ?? this.times,
      startDate: startDate ?? this.startDate,
      activeVal: activeVal ?? this.activeVal,
      pauseVal: pauseVal ?? this.pauseVal,
      enableInterval: enableInterval ?? this.enableInterval,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    "start_date": startDate.toIso8601String(),
    "cycle_on": activeVal.toInt(),
    "cycle_off": pauseVal.toInt(),
    "times": times.map((time) => time.toIso8601String()).toList(),
  };
}
