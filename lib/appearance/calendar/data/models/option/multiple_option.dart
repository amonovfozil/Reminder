import 'time_dose_model.dart';

class MultipleOption {
  double value;
  List<TimeDoseModel> times;

  MultipleOption({this.value = 3, required this.times});

  Map<String, dynamic> toJson() => {
    // "start_date": DateTime.now().toIso8601String(),
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

  // factory MultipleOption.fromOrder(TimeDeteilModel time) {
  //   return MultipleOption(
  //       value: time.times.toDouble(),
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
