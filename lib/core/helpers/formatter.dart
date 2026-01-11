import 'package:intl/intl.dart';
import '../storage/app_storage.dart';

class Formatter {
  static String noteDateFormat(DateTime date) =>
      DateFormat('dd.MM.yyyy    HH:mm').format(date);
  static String timeFormat(DateTime date) => DateFormat.Hm().format(date);
  static String dayMonthBy(DateTime date, {String atribut = '-'}) => DateFormat(
    "dd${atribut}MMM${atribut}yyyy",
    AppStorage.appLocale,
  ).format(date);
  static String monthYear(DateTime date) =>
      DateFormat("MMMM, yyyy", AppStorage.appLocale).format(date);

  // static MaskTextInputFormatter dateInputFormatter = MaskTextInputFormatter(
  //   mask: '##/##/####',
  //   filter: {"#": RegExp(r'[0-9]')},
  //   type: MaskAutoCompletionType.lazy,
  // );

  // static MaskTextInputFormatter phoneMaskInputFormatter =
  //     MaskTextInputFormatter(
  //       mask: '(##) ### ## ##',
  //       filter: {"#": RegExp(r'[0-9]')},
  //       type: MaskAutoCompletionType.lazy,
  //     );

  // static StringMask phoneWithCodeTextFormat = StringMask('+000 (00) 000 00 00');
}
