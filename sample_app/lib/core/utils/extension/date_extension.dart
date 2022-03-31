import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String format({String dateFormat = 'dd MMMM yyyy hh:mm aa'}) {
    return DateFormat(dateFormat).format(this);
  }
}
