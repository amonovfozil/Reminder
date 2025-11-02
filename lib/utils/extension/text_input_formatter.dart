import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:reminder/utils/extension/string_extension.dart';

class PayCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String sample = "XXXX-XXXX-XXXX-XXXX";
    String seperator = "-";
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == seperator) {
          return TextEditingValue(
            text:
                "${oldValue.text}$seperator${newValue.text.substring(newValue.text.length - 1)}",
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat = NumberFormat("#,###", "ru");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (newText.isEmpty) return newValue.copyWith(text: '');

    String formattedText =
        "${_numberFormat.format(int.parse(newText))} ${'sum'.tr}";

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length - " ${'sum'.tr}".length,
      ),
    );
  }
}

class MoneyInputWithOutCurrencyFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat = NumberFormat("#,###", "ru");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (newText.isEmpty) return newValue.copyWith(text: '');

    String formattedText = _numberFormat.format(int.parse(newText));

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CapitalizeFirstFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.capitalizeFirst,
      // text: capitalizeAllWordsInFullSentence(newValue.text),
      selection: newValue.selection,
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class ThousandsFormatter extends TextInputFormatter {
  ThousandsFormatter({this.maxDigits = 9, this.separator = ' '});

  final int maxDigits;
  final String separator;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1) Faqat raqamlarni olish va cheklash
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > maxDigits) {
      digits = digits.substring(0, maxDigits);
    }

    // 2) Yangi matnga o‘tishdan oldin kursor oldidagi raqamlar soni
    final int digitCaretPos = _countDigits(
      newValue.text.substring(
        0,
        newValue.selection.baseOffset.clamp(0, newValue.text.length),
      ),
    ).clamp(0, digits.length);

    // 3) Formatlash: o‘ngdan 3 tadan ajratish
    final String formatted = _formatFromRight(digits);

    // 4) Kursorni raqamlar bo‘yicha to‘g‘ri joyga qo‘yish
    final int caret = _offsetForDigitIndex(formatted, digitCaretPos);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: caret),
      composing: TextRange.empty,
    );
  }

  String _formatFromRight(String digits) {
    if (digits.isEmpty) return '';
    final buf = StringBuffer();
    int cnt = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      buf.write(digits[i]);
      cnt++;
      if (cnt % 3 == 0 && i != 0) buf.write(separator);
    }
    return buf.toString().split('').reversed.join();
  }

  int _offsetForDigitIndex(String formatted, int digitIndex) {
    if (digitIndex <= 0) return 0;
    int seen = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (_isDigit(formatted.codeUnitAt(i))) {
        seen++;
        if (seen == digitIndex) return i + 1; // shu raqamdan keyin
      }
    }
    return formatted.length;
  }

  int _countDigits(String s) {
    int c = 0;
    for (final r in s.runes) {
      if (_isDigit(r)) c++;
    }
    return c;
  }

  bool _isDigit(int r) => r >= 48 && r <= 57; // '0'..'9'
}
