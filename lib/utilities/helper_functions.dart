import 'dart:io';



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<void> saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }

  static Future<bool> clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static BoxShadow shadowEffectForFields(BuildContext context) {
    return const BoxShadow(
        offset: Offset(0, 2),
        spreadRadius: 1,
        blurRadius: 10,
        color: Colors.black38);
  }

  static checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true; //connected to mobile data
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true; // connected to a wifi network.
    } else {
      return false;
    }
  }

  static showAlert({
    required BuildContext context,
    String heading = "",
    // String headingString = "",
    String description = "",
    String btnDoneText = "",
    String btnCancelText = "",
    String imageurl = "",
    double headingsize = 0.0,
    // bool isMessage = false,
    bool isDissmissOnTapAround = true,
    VoidCallback? onDone,
    VoidCallback? onCancel,
  }) {
    Widget doneButton = btnDoneText == ""
        ? Container()
        : Expanded(
            child: GestureDetector(
              onTap: () {
                if (onDone != null) {
                  onDone();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.0155),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  //  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                ),
                child: Text(
                  btnDoneText,
                  style: TextStyle(
                    color: Colors.white,
                    // fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );

    Widget cancelButton = btnCancelText == ""
        ? Container()
        : Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                onCancel!();
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.0155),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                ),
                child: Text(
                  btnCancelText,
                  style: TextStyle(
                    color: Colors.blue,
                    // fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );

    showDialog(
      barrierDismissible: isDissmissOnTapAround,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => isDissmissOnTapAround,
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.04),
              ),
            ),
            content: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.04,
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.05),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    imageurl == ""
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.04),
                            child: Image.asset(
                              imageurl,
                              height: MediaQuery.of(context).size.width * 0.14,
                              width: MediaQuery.of(context).size.width * 0.14,
                            ),
                          ),
                    heading == ""
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03),
                            child: Text(
                              heading,
                              // HelperFunctions().getTranslated(heading, context),
                              style: TextStyle(
                                  fontSize: headingsize == 0.0
                                      ? MediaQuery.of(context).size.width *
                                          0.055
                                      : headingsize,
                                  color: Colors.blue,
                                  fontWeight: headingsize == 0.0
                                      ? FontWeight.w600
                                      : FontWeight.w300),
                              textAlign: TextAlign.center,
                            )),
                    description == ""
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05),
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.038,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: btnCancelText == ""
                              ? MediaQuery.of(context).size.width * 0.04
                              : 0.0),
                      child: Row(
                        children: [
                          cancelButton,
                          doneButton,
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  static bool isValidPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static isNumber(dynamic value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final number = num.tryParse(value);

    if (number == null) {
      return false;
    }

    return true;
  }
}

// class ShowCustomAlert extends StatelessWidget {
//   final String header;
//   final Widget widget;
//   final Widget cancelButton;
//   final Widget doneButton;
//   final String btnDoneText;
//   final String btnCancelText;

//   const ShowCustomAlert({
//     Key? key,
//     required this.header,
//     required this.widget,
//     required this.cancelButton,
//     required this.doneButton,
//     required this.btnDoneText,
//     required this.btnCancelText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var platform = Theme.of(context).platform;

//     return platform == TargetPlatform.iOS
//         ? CupertinoAlertDialog(
//             title: Text(
//               header,
//               style: const TextStyle(color: Colors.blue),
//             ),
//             content: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: widget,
//             ),
//             actions: <Widget>[
//               btnCancelText == "" ? Container() : cancelButton,
//               btnDoneText == "" ? Container() : doneButton,
//             ],
//           )
//         : AlertDialog(
//             insetPadding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.04),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(MediaQuery.of(context).size.width * 0.02),
//               ),
//             ),
//             title: Container(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).size.width * 0.03,
//               ),
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(width: 0.1),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     header,
//                     style: const TextStyle(color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//             content: widget,
//             actions: <Widget>[
//               btnCancelText == "" ? Container() : cancelButton,
//               btnDoneText == "" ? Container() : doneButton,
//             ],
//           );
//   }
//}
