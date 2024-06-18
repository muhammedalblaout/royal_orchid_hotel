import 'package:intl/intl.dart';

String FormateDate(DateTime dateTime){
  return DateFormat("yyy MMM d , hh:mm").format(dateTime);
}