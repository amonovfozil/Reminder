
class OnceDaily {
  DateTime time;
  String dose;

  OnceDaily({
    this.dose = "1",
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        "start_date": (time.isBefore(DateTime.now())
                ? DateTime.now().add(const Duration(days: 1))
                : DateTime.now())
            .toIso8601String(),
        "times": 1,
        "items": [
          {
            'time': time.toIso8601String().split('T').last.toString(),
            'doze': dose,
          }
        ]
      };

  // factory OnceDaily.fromOrder(TimeDeteilModel time) {
  //   return OnceDaily(
  //       dose: time.items.first.dose.toString(),
  //       time: DateTime.parse(
  //           "${time.startDate.toIso8601String().split('T').first}T${time.items.first.time}"));
  // }
}

class TwiceDaily {
  DateTime time;
  String dose;
  DateTime time_2;
  String dose_2;

  TwiceDaily({
    this.dose = "1",
    required this.time,
    this.dose_2 = "1",
    required this.time_2,
  });

  Map<String, dynamic> toJson() => {
        "start_date": DateTime.now().toIso8601String(),
        "times": 2,
        "items": [
          {
            'time': time.toIso8601String().split('T').last.toString(),
            'doze': dose,
          },
          {
            'time': time_2.toIso8601String().split('T').last.toString(),
            'doze': dose_2,
          }
        ]
      };
  // factory TwiceDaily.fromOrder(TimeDeteilModel time) {
  //   return TwiceDaily(
  //       dose: time.items.first.dose.toString(),
  //       time: DateTime.parse(
  //           "${time.startDate.toIso8601String().split('T').first}T${time.items.first.time}"),
  //       dose_2: time.items.last.dose.toString(),
  //       time_2: DateTime.parse(
  //           "${time.startDate.toIso8601String().split('T').first}T${time.items.last.time}"));
  // }
}
