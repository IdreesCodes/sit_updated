import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../managers/api_manager.dart';
import '../../../utilities/api_constants.dart';
import '../../../utilities/application_constants.dart';
import '../../../utilities/color_constants.dart';
import '../../../utilities/helper_functions.dart';
import '../../home/screen/home_screen.dart';

class LoginProvider with ChangeNotifier {
  loginAction(BuildContext context, String userName, String password) {
    if (userName == '') {
      HelperFunctions.showAlert(
        onCancel: () {
          Navigator.of(context).pop();
        },
        context: context,
        heading: AppConstants.DIALOG_TITLE,
        description: "Username should not be empty",
        btnDoneText: "Ok",
        onDone: () {
          Navigator.of(context).pop();
        },
      );
    } else if (password == '') {
      HelperFunctions.showAlert(
          onCancel: () {
            Navigator.of(context).pop();
          },
          context: context,
          heading: AppConstants.DIALOG_TITLE,
          description: "Password should not be empty",
          btnDoneText: "Ok",
          onDone: () {
            Navigator.of(context).pop();
          });
    } else {
      callLoginApi(context, userName, password);
    }
  }

  moveToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  bool isLoading = false;

  void loader(bool loaderValue) {
    isLoading = loaderValue;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  callLoginApi(BuildContext context, String userName, String password) {
    loader(true);
    Map<String, String> body = {};
    body['user_name'] = userName;
    body['password'] = password;

    log(jsonEncode(body));

    Map<String, String> header = {};
    FocusScope.of(context).requestFocus(FocusNode());

    ApiManager networkCal =
        ApiManager(APIConstants.loginUrl, body, false, header);
    print(APIConstants.baseURL + APIConstants.loginUrl);

    networkCal.callPostAPI(true).then((response) {
      print('Back from api');

      loader(false);
      print(response.toString());
      if (response['status'] != null) {
        if (response['status'] == 'fail') {
          HelperFunctions.showAlert(
            // onCancel: () {
            //   //  Navigator.of(context).pop();
            // },
            context: context,
            heading: AppConstants.DIALOG_TITLE,
            //btnCancelText: "Cancel",
            description: response["msg"],
            // Text(

            //   style: const TextStyle(
            //     color: ColorConstants.primary,
            //   ),
            // ),
            btnDoneText: "Ok",
            onDone: () {
              Navigator.of(context).pop();
            },
          );
        } else {
          if (response['data'] != null) {
            print("save in prefff");
            HelperFunctions.saveInPreference('username', userName);
            HelperFunctions.saveInPreference('password', password);
            HelperFunctions.saveInPreference(
                'firstName', response['data']['first_name']);
            HelperFunctions.saveInPreference(
                'lastName', response['data']['last_name']);
            HelperFunctions.saveInPreference(
                'userId', response['data']['user_id']);
            HelperFunctions.saveInPreference('token', response['token']);
            HelperFunctions.saveInPreference("isLogin", "1");

            print("next screen");
            moveToHome(context);
          }
        }
      }
    });
  }
}
