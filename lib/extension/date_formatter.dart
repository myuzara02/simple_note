import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toSunda() {
    var formatter = DateFormat("dd, MMM yyyy HH:mm");
    return formatter.format(this);
  }
}
