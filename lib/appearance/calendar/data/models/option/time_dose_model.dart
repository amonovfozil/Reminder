
class TimeDoseModel {
  String id;
  DateTime time;
  String dose;

  TimeDoseModel({
    this.dose = "1",
    required this.time,
    required this.id,
  });
}

enum TimeType {
  daily,
  twiceDaily,
  multipleDaily,
  noReminder,
  interval,
  week,
  cyclic,
}

final typeValues = EnumValues({
  "once_daily": TimeType.daily,
  "twice_daily": TimeType.twiceDaily,
  "multiple_daily": TimeType.multipleDaily,
  "on_demand": TimeType.noReminder,
  "interval": TimeType.interval,
  "week_days": TimeType.week,
  "cycle": TimeType.cyclic,
});

class EnumValues<T> {
  Map<String, T> map;
  EnumValues(this.map);
  Map<T, String> get reverseMap => map.map(
        (k, v) => MapEntry(v, k),
      );
}