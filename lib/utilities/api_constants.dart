import 'package:intl/intl.dart';

class APIConstants {
  // Base URL of Application
  static final DateFormat apiDateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  static String baseURL = 'https://schuja.com/SIT/';

  //Urls for API's
  static const loginUrl = "apis/v1/account/userLogin";
  static const checkInCheckOut = "apis/v1/account/checkInCheckOut";
  static const checkInCheckOutList = "apis/v1/account/checkInCheckOutList";
}
