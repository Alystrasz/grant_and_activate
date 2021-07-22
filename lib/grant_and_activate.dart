library grant_and_activate;

import 'dart:io';
import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:grant_and_activate/utils/toast_messages.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';


///
/// Checks both Bluetooth and locations permissions; if a permission is missing,
/// asks user for it.
///
/// Returns false if at least one permission has been denied, true otherwise.
///
/// If the user refused location permission too many times, redirects to the
/// application settings screen.
///
Future<bool> _checkPermissions() async {
  var status = await Permission.bluetooth.status;
  if (!status.isGranted) {
    var result = await Permission.bluetooth.request();
    if (!result.isGranted) {
      return false;
    }
  }

  var locationStatus = await Permission.locationWhenInUse.status;
  if (!locationStatus.isGranted) {
    var result = await Permission.locationWhenInUse.request();
    if (!result.isGranted) {
      showLocationPermissionMissingToast();
      sleep(new Duration(seconds: 2));

      if (!await Permission.locationWhenInUse.shouldShowRequestRationale) {
        openAppSettings();
      }

      return false;
    }
  }

  return true;
}


///
/// Activates Bluetooth and geolocation services, for the location gathering
/// process to work properly.
///
/// For each service, a modal popup will appear and ask the user to activate
/// such service if it's not running; a warning toast message will appear,
/// shall the user not activate it.
///
/// Returns true if both services have been activated, false otherwise.
///
Future<bool> _activateServices() async {
  var bluetoothResult = await BluetoothEnable.enableBluetooth == "true";

  if (!bluetoothResult) {
    showBluetoothServiceNeedsActivationToast();
  }

  Location location = new Location();
  var locationResult = true;
  var locationServiceResult = await location.serviceEnabled();
  if (!locationServiceResult) {
    locationResult = await location.requestService();
    if (!locationResult) {
      showLocationServiceNeedsActivationToast();
    }
  }

  return bluetoothResult && locationResult;
}



///
/// Checks Bluetooth and geolocation permissions, and enables associated
/// services; returns false if a permission has not been granted or a service
/// did not start, true otherwise.
///
/// This is the only endpoint available of this package.
///
Future<bool> checkPermissionsAndActivateServices() async {
  return await _checkPermissions() && await _activateServices();
}