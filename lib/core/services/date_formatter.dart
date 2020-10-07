import 'package:intl/intl.dart';

class DateFormatter{
  static DateFormat _dateFormatSingle = DateFormat("MMMM dd, yyyy \u2022 h:mm a");
  static DateFormat _dateFormatDateOnly = DateFormat("dd MMMM yy");
  static DateFormat _dateFormatBirthDate = DateFormat("yyyy MMMM dd");
  static DateFormat _dateFormatTimeOnly = DateFormat("h:mm:ss a");

  static String toSingle(DateTime dateTime){
    return _dateFormatSingle.format(dateTime);
  }

  static String toDateOnly(DateTime dateTime){
    return _dateFormatDateOnly.format(dateTime);
  }

  static String toBirthDate(DateTime dateTime){
    return _dateFormatBirthDate.format(dateTime);
  }

  static String toTimeOnly(DateTime dateTime){
    return _dateFormatTimeOnly.format(dateTime);
  }
}