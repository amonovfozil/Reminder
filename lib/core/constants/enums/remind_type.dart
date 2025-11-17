enum RemindType {
  daily,
  twiceDaily,
  multipleDaily,
  noReminder,
  interval,
  week,
  cyclic,
}

final typeValues = RemindTypeEnumValues({
  "once_daily": RemindType.daily,
  "twice_daily": RemindType.twiceDaily,
  "multiple_daily": RemindType.multipleDaily,
  "on_demand": RemindType.noReminder,
  "interval": RemindType.interval,
  "week_days": RemindType.week,
  "cycle": RemindType.cyclic,
});

class RemindTypeEnumValues<T> {
  Map<String, T> map;
  RemindTypeEnumValues(this.map);
  Map<T, String> get reverseMap => map.map((k, v) => MapEntry(v, k));
}
