import 'dart:async';

import 'package:flutter/services.dart';

class Identifier {
  static const MethodChannel _channel = MethodChannel('identifier');

  static Future<String> get getUniqueDeviceIdentifier async {
    final String version = await _channel.invokeMethod('getUniqueDeviceIdentifier');
    return version;
  }
}
