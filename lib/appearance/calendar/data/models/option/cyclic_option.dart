import 'package:reminder/appearance/calendar/data/models/remind_model.dart';
import 'time_dose_model.dart';

class CyclicRemindModel extends RemindModel {
  List<TimeDoseModel> times;
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
    required this.times,
    required this.startDate,
    this.activeVal = 10,
    this.pauseVal = 5,
  });

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "cycle_on": activeVal.toInt(),
    "cycle_off": pauseVal.toInt(),
    "times": times.length,
    "items": times
        .map(
          (elm) => {
            'time': elm.time.toIso8601String().split('T').last.toString(),
            'doze': elm.dose,
          },
        )
        .toList(),
  };
}
