enum ServiceStatus { active, prevention, soon }

class ServiceSettingModel {
  int id;
  ServiceStatus clock;
  ServiceStatus remind;

  ServiceSettingModel({
    required this.id,
    required this.clock,
    required this.remind,
  });

  factory ServiceSettingModel.fromJson(Map<String, dynamic> json) =>
      ServiceSettingModel(
        id: json["id"] ?? 0,
        clock: _parseServiceStatus(json["withdraw"] ?? 2),
        remind: _parseServiceStatus(json["add_card"] ?? 2),
      );

  Map<String, dynamic> toJson() => {"id": id, "clock": clock, "remind": remind};
}

ServiceStatus _parseServiceStatus(int status) {
  switch (status) {
    case 0:
      return ServiceStatus.soon;
    case 1:
      return ServiceStatus.prevention;
    default:
      return ServiceStatus.active;
  }
}
