import 'package:intl/intl.dart';

getDateString(DateTime? start) {
  if (start != null) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(start);
  } else {
    return null;
  }
}
