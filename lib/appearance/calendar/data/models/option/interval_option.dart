import 'time_dose_model.dart';

class IntervalOption {
  bool isHourly;
  double value;
  DateTime? startDate;
  DateTime? endDate;
  String dose;
  List<TimeDoseModel> times;

  IntervalOption({
    this.isHourly = true,
    this.value = 0.5,
    this.dose = "1",
    this.startDate,
    this.endDate,
    required this.times,
  });

  Map<String, dynamic> toJson() => {
        "start_date": startDate?.toIso8601String(),
        "end_date": startDate?.toIso8601String(),
        if (startDate != null)
          "interval_start_time":
              startDate!.toIso8601String().split('T').last.toString(),
        if (endDate != null)
          "interval_end_time": (endDate!.add(const Duration(days: 30)))
              .toIso8601String()
              .split('T')
              .last
              .toString(),
        "times": times.length,
        "interval": isHourly ? 'hours' : 'days',
        if (isHourly) "interval_dose": dose,
        "interval_amount": value,
        if (!isHourly)
          "items": times
              .map((elm) => {
                    'time':
                        elm.time.toIso8601String().split('T').last.toString(),
                    'doze': elm.dose,
                  })
              .toList()
      };

  // factory IntervalOption.fromOrder(TimeDeteilModel time) {
  //   return IntervalOption(
  //       dose: time.interval == 'hours'
  //           ? time.timeDose.toString()
  //           : time.items.first.dose.toString(),
  //       startDate: time.startDate,
  //       endDate: time.endDate,
  //       isHourly: time.interval == 'hours',
  //       value: time.intervalAmaunt,
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
