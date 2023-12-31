import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:store_app/env/env.dart';

final formatCurrency =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
String formattedDate(DateTime date) {
  return DateFormat("dd MMMM yyyy").format(date);
}

String dateFormat = 'dd MMM yyyy';
String timeFormat = 'HH:mm:ss';

DateTime now = DateTime.now();

String getCurrentTime() {
  return DateFormat(timeFormat).format(now);
}

String getTodayDate() {
  return DateFormat(dateFormat).format(now);
}

Color primaryColor = const Color(0xFF009D8F);

String apiKey = Env.apiKey;
