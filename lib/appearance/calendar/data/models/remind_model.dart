import 'option/time_dose_model.dart';

abstract class RemindModel {
  String id;
  String title;
  String body;
  TimeType? type;
  bool enableAlert;
  bool remindMe;
  bool isPaused;

  RemindModel({
    required this.id,
    required this.title,
    this.body = '',
    this.type,

    this.enableAlert = true,
    this.remindMe = true,
    this.isPaused = false,
  });
}
