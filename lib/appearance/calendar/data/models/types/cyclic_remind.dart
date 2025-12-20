import '../remind_model.dart';
import '../../../../../core/constants/enums/remind_type.dart';

class CyclicRemindModel extends RemindModel {
  DateTime startDate;
  int activeVal;
  int pauseVal;
  int enableInterval;

  CyclicRemindModel({
    required super.id,
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
  }) {
    return CyclicRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      startDate: startDate ?? this.startDate,
      activeVal: activeVal ?? this.activeVal,
      pauseVal: pauseVal ?? this.pauseVal,
      enableInterval: enableInterval ?? this.enableInterval,
    );
  }

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "cycle_on": activeVal.toInt(),
    "cycle_off": pauseVal.toInt(),
  };
}
