enum RemindType { interval, multiple, week, cyclic }

final typeValues = RemindTypeEnumValues({
  "interval": RemindType.interval,
  "multiple": RemindType.multiple,
  "weekly": RemindType.week,
  "cycle": RemindType.cyclic,
});

class RemindTypeEnumValues<T> {
  Map<String, T> map;
  RemindTypeEnumValues(this.map);
  Map<T, String> get reverseMap => map.map((k, v) => MapEntry(v, k));
}
