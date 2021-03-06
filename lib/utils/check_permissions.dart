import 'dart:io';

import 'package:grant_and_activate/utils/classes.dart';
import 'package:permission_handler/permission_handler.dart';

///
/// Checks permissions; if a permission is missing, asks user for it.
/// Returns false if permission has been denied, true otherwise.
///
/// If the user refused location permission too many times, redirects to the
/// application settings screen.
///
Future<bool> checkPermissions(Feature feature) async {
  switch (feature) {
    case Feature.Bluetooth:
      var status = await Permission.bluetooth.status;
      if (!status.isGranted) {
        var result = await Permission.bluetooth.request();
        if (!result.isGranted) {
          return false;
        }
      }
      break;

    case Feature.BluetoothConnect:
      var status = await Permission.bluetoothConnect.request();
      if (!status.isGranted) {
        var result = await Permission.bluetoothConnect.request();
        if (!result.isGranted) return false;
      }
      break;

    case Feature.BluetoothScan:
      var status = await Permission.bluetoothScan.request();
      if (!status.isGranted) {
        var result = await Permission.bluetoothScan.request();
        if (!result.isGranted) return false;
      }
      break;

    case Feature.Location:
      var locationStatus = await Permission.location.status;
      if (!locationStatus.isGranted) {
        var result = await Permission.location.request();
        if (!result.isGranted) {
          if (Platform.isAndroid &&
              !await Permission.location.shouldShowRequestRationale) {
            openAppSettings();
          }

          return false;
        }
      }
      break;

    case Feature.LocationAlways:
      var locationStatus = await Permission.locationAlways.status;
      if (!locationStatus.isGranted) {
        var result = await Permission.locationAlways.request();
        if (!result.isGranted) {
          if (Platform.isAndroid &&
              !await Permission.locationAlways.shouldShowRequestRationale) {
            openAppSettings();
          }

          return false;
        }
      }
      break;

    case Feature.LocationWhenInUse:
      var locationStatus = await Permission.locationWhenInUse.status;
      if (!locationStatus.isGranted) {
        var result = await Permission.locationWhenInUse.request();
        if (!result.isGranted) {
          if (Platform.isAndroid &&
              !await Permission.locationWhenInUse.shouldShowRequestRationale) {
            openAppSettings();
          }

          return false;
        }
      }
      break;

    default:
      throw new UnimplementedError(
          "Cannot check permissions with this feature.");
  }

  return true;
}
