import 'package:reminder/core/constants/enums/remind_type.dart';

class RemindModel {
  String id;
  String title;
  String body;
  RemindType? type;
  bool enableAlert;
  bool remindMe;
  bool isPaused;

  RemindModel({
    required this.id,
    this.title = '',
    this.body = '',
    this.type,
    this.enableAlert = true,
    this.remindMe = true,
    this.isPaused = false,
  });

  // RemindModel copyWithh({
  //   String? title,
  //   String? body,
  //   RemindType? type,
  //   bool? enableAlert,
  //   bool? remindMe,
  //   bool? isPaused,
  // }) {
  //   return RemindModel(
  //     id: id,
  //     title: title ?? this.title,
  //     body: body ?? this.body,
  //     type: type ?? this.type,
  //     enableAlert: enableAlert ?? this.enableAlert,
  //     remindMe: remindMe ?? this.remindMe,
  //     isPaused: isPaused ?? this.isPaused,
  //   );
  // }
}
