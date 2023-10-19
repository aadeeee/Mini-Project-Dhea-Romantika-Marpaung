import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0
      );
String formattedDate(DateTime date) {
  return DateFormat("dd MMMM yyyy").format(date);
}
