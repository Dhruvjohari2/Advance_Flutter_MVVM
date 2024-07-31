import 'dart:io';

import 'package:advance_mvvm/domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + "" + build.model;
      identifier = build.id;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      // return
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name +""+build.model;
      identifier =  build.identifierForVendor!;
      version = build.systemVersion;
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
    // return
  }
  return DeviceInfo(name, identifier, version);
}
