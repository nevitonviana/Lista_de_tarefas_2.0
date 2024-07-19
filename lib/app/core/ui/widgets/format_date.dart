import 'package:intl/intl.dart';

class FormatDate {
  FormatDate._();

  static dateFormat(String date) {
    final format = DateFormat('dd/MM/y');
    try {
      return format.format(DateTime.parse(date));
    } catch (e) {
      return format.format(DateTime.now());
    }
  }
}
