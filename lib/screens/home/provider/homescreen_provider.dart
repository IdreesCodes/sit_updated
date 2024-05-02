import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../managers/api_manager.dart';
import '../../../utilities/api_constants.dart';
import '../../../utilities/application_constants.dart';
import '../../../utilities/color_constants.dart';
import '../../../utilities/helper_functions.dart';

class CheckoutProvider with ChangeNotifier {
  var lastname = '';
  var firstname = '';
  bool isLoading = false;
  Location location = Location();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  getGeoLocationPosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void loader(bool loaderValue) {
    isLoading = loaderValue;
    notifyListeners();
  }

  callCheckinApi(BuildContext context, String action) {
    String lat = "";
    String lng = "";
    loader(true);
    location.getLocation().then((value) {
      lat = value.latitude.toString();
      lng = value.longitude.toString();

      HelperFunctions.getFromPreference('userId').then((userId) {
        DateTime now = DateTime.now();
        DateTime date = DateTime(now.year, now.month, now.day, now.hour,
            now.minute, now.second, now.second);
        Map<String, String> body = {};
        body['DateTime'] = date.toString();
        body['user_id'] = userId;
        body['lat'] = lat;
        body['lng'] = lng;
        body['action'] = action;
        //body['checkInTime'] = date.toString();

        log(jsonEncode(body));
        Map<String, String> header = {};
        HelperFunctions.getFromPreference("token").then((value) {
          header['userToken'] = value.toString();
          log(jsonEncode(header));
        });

        ApiManager networkCal =
            ApiManager(APIConstants.checkInCheckOut, body, false, header);
        print(APIConstants.baseURL + APIConstants.checkInCheckOut);

        networkCal.callPostAPI(true).then((response) {
          print('Back from api');

          loader(false);

          if (response['status'] != null) {
            if (response['status'] == 'fail') {
              HelperFunctions.showAlert(
                isDissmissOnTapAround: false,
                onCancel: () {
                  Navigator.of(context).pop();
                },
                context: context,
                heading: AppConstants.DIALOG_TITLE,
                description: response["msg"],
                // widget: Text(

                //   style: const TextStyle(
                //     color: ColorConstants.primary,
                //   ),
                // ),
                btnDoneText: "Ok",
                onDone: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            } else {
              // Navigator.of(context).pop();

              HelperFunctions.showAlert(
                isDissmissOnTapAround: false,
                // onCancel: () {
                //   Navigator.of(context).pop();
                // },
                context: context,
                heading: AppConstants.DIALOG_TITLE,
                description: response["msg"] + " Successfully",
                btnDoneText: "Ok",
                onDone: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            }
          }
        });
      });
    }
    );
  }

  //   Widget buildQrView(BuildContext context) {
  //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
  //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
  //           MediaQuery.of(context).size.height < 400)
  //       ? 300.0
  //       : 400.0;
  //   // To ensure the Scanner view is properly sizes after rotation
  //   // we need to listen for Flutter SizeChanged notification and update controller
  //   return QRView(
  //     key: qrKey,
  //     onQRViewCreated: _onQRViewCreated(controller!, context),
  //     overlay: QrScannerOverlayShape(
  //         borderColor: Colors.blue,
  //         borderRadius: 10,
  //         borderLength: 30,
  //         borderWidth: 10,
  //         cutOutSize: scanArea),
  //     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
  //   );
  // }

  void onQRViewCreated(QRViewController viewController, BuildContext context) {
    inspect(viewController);
    controller = viewController;
    notifyListeners();
    // controller.scannedDataStream.first;
    controller!.scannedDataStream.listen(
      (scanData) {
        result = scanData;
        notifyListeners();
        print(
          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
        );
        controller!.pauseCamera();
        Provider.of<CheckoutProvider>(context, listen: false)
            .callCheckinApi(context, result!.code.toString());
        print("done ..........");
      },
      // onDone: () {

      // },
    );
    notifyListeners();
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
    notifyListeners();
  }

  void getInfo() {
    HelperFunctions.getFromPreference('firstName').then((firstnameValue) {
      firstname = firstnameValue;
      HelperFunctions.getFromPreference('lastName').then((lastnameValue) {
        lastname = lastnameValue;
        notifyListeners();
      });
    });
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
