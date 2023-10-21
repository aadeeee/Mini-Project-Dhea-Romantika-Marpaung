import 'package:intl/intl.dart';

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
