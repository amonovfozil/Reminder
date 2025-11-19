import '../../../../../core/constants/enums/remind_type.dart';
import '../remind_model.dart';

class MultipleRemindModel extends RemindModel {
  int amount;
  List<DateTime> times;

  MultipleRemindModel({
    required super.id,
    super.title,
    required this.times,
    super.body,
    super.type = RemindType.multiple,
    super.enableAlert,
    super.remindMe,
    super.isPaused,
    this.amount = 1,
  });

  MultipleRemindModel copyWith({
    int? amount,
    String? title,
    String? body,
    List<DateTime>? times,
  }) {
    return MultipleRemindModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      times: times ?? this.times,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() => {"amount": amount, "type": type?.name};

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
