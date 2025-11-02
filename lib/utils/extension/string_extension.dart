import '../../core/constants/const_data.dart';
import 'package:flutter_locales/flutter_locales.dart';

extension StringExtensions on String {
  String trParm({required Map<String, String> parm}) {
    var translation = Locales.string(navigatorKey.currentContext!, this);

    parm.forEach((key, value) {
      translation = translation.replaceAll(key, value);
    });

    return translation.contains('\$') ? this : translation;
  }

  String get tr {
    var translation = Locales.string(navigatorKey.currentContext!, this);

    return translation.contains('\$') ? this : translation;
  }

  String get capitalizeFirst =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get capitalizeWords =>
      split(' ').map((e) => e.capitalizeFirst).join(' ');

  String get getFirstName =>
      split(' ').length >= 2 ? split(' ')[1].capitalizeFirst : capitalizeFirst;

  String cleanInvisible() =>
      replaceAll(RegExp(r'[\u200B\u200C\u200D\u2060\u00AD\uFEFF]'), '');
}
