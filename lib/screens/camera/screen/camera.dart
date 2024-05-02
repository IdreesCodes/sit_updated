import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../home/provider/homescreen_provider.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      Provider.of<CheckoutProvider>(context, listen: false)
          .controller!
          .pauseCamera();
    }
    Provider.of<CheckoutProvider>(context, listen: false)
        .controller!
        .resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // var homeprovider = Provider.of<CheckoutProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel,
                size: size.height * 0.05,
                color: Colors.white,
              ),
            ),
          ),
          // Expanded(flex: 4, child: _buildQrView(context)),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       if (result != null)
          //         Text(
          //           'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
          //           style: TextStyle(
          //             fontSize: size.height * 0.02,
          //           ),
          //         )
          //       else
          //         const Text('Scan a code'),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       margin: const EdgeInsets.all(8),
          //       child: ElevatedButton(
          //           onPressed: () async {
          //             await controller?.toggleFlash();
          //             setState(() {});
          //           },
          //           child: FutureBuilder(
          //             future: controller?.getFlashStatus(),
          //             builder: (context, snapshot) {
          //               return Text('Flash: ${snapshot.data}');
          //             },
          //           )),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.all(8),
          //       child: ElevatedButton(
          //           onPressed: () async {
          //             await controller?.flipCamera();
          //             setState(() {});
          //           },
          //           child: FutureBuilder(
          //             future: controller?.getCameraInfo(),
          //             builder: (context, snapshot) {
          //               if (snapshot.data != null) {
          //                 return Text(
          //                     'Camera facing ${describeEnum(snapshot.data!)}');
          //               } else {
          //                 return const Text('loading');
          //               }
          //             },
          //           )),
          //     )
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       margin: const EdgeInsets.all(8),
          //       child: ElevatedButton(
          //         onPressed: () async {
          //           await controller?.pauseCamera();
          //         },
          //         child:
          //             const Text('pause', style: TextStyle(fontSize: 20)),
          //       ),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.all(8),
          //       child: ElevatedButton(
          //         onPressed: () async {
          //           await controller?.resumeCamera();
          //         },
          //         child: const Text('resume',
          //             style: TextStyle(fontSize: 20)),
          //       ),
          //     )
          //   ],
          // ),
          //         ],
          //       ),
          //     )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? size.height * 0.35
        : size.height * 0.45;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: Provider.of<CheckoutProvider>(context, listen: false).qrKey,
      onQRViewCreated: (controller) {
        Provider.of<CheckoutProvider>(context, listen: false)
            .onQRViewCreated(controller, context);
      },
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: size.width * 0.02,
          borderLength: size.height * 0.1,
          borderWidth: size.width * 0.02,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) =>
          Provider.of<CheckoutProvider>(context, listen: false)
              .onPermissionSet(context, ctrl, p),
    );
  }
}
