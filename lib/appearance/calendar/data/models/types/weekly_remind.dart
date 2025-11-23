import '../../../../../core/constants/enums/remind_type.dart';
import 'package:reminder/appearance/calendar/data/models/remind_model.dart';

List<String> weekDays = ["mon", "tue", "wed", "thur", "fri", "sat", "sun"];

class WeeklyRemindModel extends RemindModel {
  List<int> days;

  WeeklyRemindModel({
    required super.id,
    super.title,
    super.body,
    super.type = RemindType.weekly,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    required this.days,

  });

  WeeklyRemindModel copyWith({
    int? amount,
    String? title,
    String? body,
    List<int>? days,
  }) {
    return WeeklyRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toJson() => {"amount": days, "type": type?.name};
}
