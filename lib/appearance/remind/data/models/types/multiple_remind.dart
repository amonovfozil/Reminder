import '../../../../../core/constants/enums/remind_type.dart';
import '../remind_model.dart';

class MultipleRemindModel extends RemindModel {
  int amount;
  List<DateTime> times;
  bool enable;

  MultipleRemindModel({
    required super.id,
    super.title,
    required this.times,
    super.body,
    super.type = RemindType.multiple,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    super.notificationIds,
    this.amount = 1,
    this.enable = false,
  });

  MultipleRemindModel copyWith({
    int? amount,
    String? title,
    String? body,
    bool? enableAlert,
    bool? remindMe,
    bool? isPaused,
    List<DateTime>? times,
    bool? enable,
    List<int>? notificationIds,
  }) {
    return MultipleRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      enableAlert: enableAlert ?? this.enableAlert,
      remindMe: remindMe ?? this.remindMe,
      isPaused: isPaused ?? this.isPaused,
      notificationIds: notificationIds ?? this.notificationIds,
      times: times ?? this.times,
      amount: amount ?? this.amount,
      enable: enable ?? this.enable,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    "amount": amount,
    "times": times.map((time) => time.toIso8601String()).toList(),
  };

  // factory MultipleRemindModel.fromOrder(TimeDeteilModel time) {
  //   return MultipleRemindModel(
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
