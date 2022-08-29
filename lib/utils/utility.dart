import 'package:contactsassignment/constant/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

extension DateFormatter on String? {
  String convertDate({format = "d'th' MMM yyyy"}) {
    try {
      if (this == null) return "";
      DateTime dateTime =
          this is DateTime ? this as DateTime : DateTime.parse(this!);
      format =
          format.toString().replaceAll("th", getDayOfMonthSuffix(dateTime.day));
      return DateFormat(format).format(dateTime);
    } catch (error) {
      return this!;
    }
  }

  String getInitials() => this!.isNotEmpty
      ? this!.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}

void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: appBarColor,
      textColor: white,
      fontSize: 16.0);
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
