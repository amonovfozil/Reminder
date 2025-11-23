import '../../../../../core/constants/enums/remind_type.dart';
import 'package:reminder/appearance/calendar/data/models/remind_model.dart';

class IntervalRemindModel extends RemindModel {
  bool isHourly;
  bool enableInterval;
  double interval;
  DateTime? startDate;
  DateTime? endDate;
  List<DateTime> times;

  IntervalRemindModel({
    required super.id,
    super.title,
    required this.times,
    super.body,
    super.type = RemindType.interval,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    this.isHourly = true,
    this.enableInterval = false,
    this.interval = 0.5,
    this.startDate,
    this.endDate,
  });

  IntervalRemindModel copyWith({
    bool? isHourly,
    bool? enableInterval,
    double? interval,
    DateTime? startDate,
    DateTime? endDate,
    String? title,
    String? body,
    List<DateTime>? times,
  }) {
    return IntervalRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      times: times ?? this.times,
      isHourly: isHourly ?? this.isHourly,
      enableInterval: enableInterval ?? this.enableInterval,
      interval: interval ?? this.interval,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() => {
    "start_date": startDate?.toIso8601String(),
    "end_date": startDate?.toIso8601String(),
  };

  // factory IntervalRemindModel.fromOrder(TimeDeteilModel time) {
  //   return IntervalRemindModel(
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
