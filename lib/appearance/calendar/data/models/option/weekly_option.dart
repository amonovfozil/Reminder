import 'time_dose_model.dart';

List<String> weekDays = ["mon", "tue", "wed", "thur", "fri", "sat", "sun"];

class WeeklyOption {
  List<TimeDoseModel> times;
  List<int> days;

  WeeklyOption({required this.times, required this.days});

  Map<String, dynamic> toJson() => {
    // "start_date": DateTime.now().toIso8601String(),
    "week_days": days.map((index) => weekDays[index]).join(','),
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

  // factory WeeklyOption.fromOrder(TimeDeteilModel time) {
  //   return WeeklyOption(
  //       days: time.weekDays
  //           .split(',')
  //           .map((index) => weekDays.indexOf(index))
  //           .toList(),
  //       times: List.from(
  //         time.items.map(
  //           (e) => TimeDoseModel(
  //             time: DateTime.parse(
  //                 "${time.startDate.toIso8601String().split('T').first}T${e.time}"),
  //             id: e.id.toString(),
  //             dose: e.dose.toString(),
  //           ),
  //         ),
  //       ));
  // }
}
