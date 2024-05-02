import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../../../managers/api_manager.dart';
import '../../../utilities/api_constants.dart';
import '../../../utilities/application_constants.dart';
import '../../../utilities/helper_functions.dart';
import '../user_data_cell.dart';

class UserDataProvider with ChangeNotifier {
  bool isLoading = false;
  List<UserDataModel> userdatalist = [];

  void loader(bool loaderValue) {
    isLoading = loaderValue;
    notifyListeners();
  }

  userDataApi(BuildContext context) {
    loader(true);
    Map<String, String> body = {};
    Map<String, String> header = {};
    HelperFunctions.getFromPreference("token").then((value) {
      header['userToken'] = value.toString();
      log(jsonEncode(header));
    });

    ApiManager networkCal =
        ApiManager(APIConstants.checkInCheckOutList, body, false, header);
    networkCal.callGetAPI(true).then((response) {
      loader(false);
      if (response['data'] is List) {
        userdatalist.clear();
        List myData = response['data'];
        for (int i = 0; i < myData.length; i++) {
          Map<String, dynamic> obj = myData[i];
          UserDataModel itemdata = UserDataModel.fromJson(obj);
          userdatalist.add(itemdata);
        }
        inspect(userdatalist);
        log(response.toString());
      } else {
        HelperFunctions.showAlert(
            onCancel: () {},
            context: context,
            heading: AppConstants.DIALOG_TITLE,
            description: response['msg'].toString(),
            btnDoneText: "Ok",
            onDone: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
      }
    });
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
