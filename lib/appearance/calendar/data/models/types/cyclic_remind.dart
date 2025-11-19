import 'package:reminder/appearance/calendar/data/models/remind_model.dart';

class CyclicRemindModel extends RemindModel {
  DateTime startDate;
  double activeVal;
  double pauseVal;

  CyclicRemindModel({
    required super.id,
    required super.title,
    required super.body,
    required super.type,
    required super.enableAlert,
    required super.remindMe,
    required super.isPaused,
    required this.startDate,
    this.activeVal = 10,
    this.pauseVal = 5,
  });

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "cycle_on": activeVal.toInt(),
    "cycle_off": pauseVal.toInt(),
  };
}
