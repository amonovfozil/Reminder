enum AppAction { login, logout, kill }

final getAppActionType = EnumValues({
  "login": AppAction.login,
  "logout": AppAction.logout,
  "kill": AppAction.kill,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;
  EnumValues(this.map);
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
